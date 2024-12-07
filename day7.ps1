# Advent of Code 
# Day 7 : https://adventofcode.com/2024/day/7
# Date : 12/7/2024


$data = @"
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"@

$data = get-content .\input_day7.txt

$table = $data -split "\r\n"


# Part 1
# Number of different equations is 2^(operands-1)


$total = 0 
$hashmap = @{}

for ($r=0; $r -lt $table.Count; $r++){


 $test = $table[$r] -split ":"

 $hashmap.add($test[0],$false)

 $numbers = $test[1].trim() -split " " 

 $spacecount = ($test[1].trim() -split '\s+' | Measure-Object -Line).Lines - 1
 
 $chars = "+*"

 $operators = new-object system.collections.stack
 $numberstack = new-object system.collections.stack

# Iterate through all possible combinations of operators
for ($i = 0; $i -lt [Math]::Pow($chars.Length, $spacecount); $i++) {

 $operators.Clear()
 $numberstack.Clear() 
 
 for ($n = $numbers.Length - 1; $n -ge 0; $n--) {  $numberstack.Push($numbers[$n]) }

  for ($j = 0; $j -lt $spacecount; $j++) {
    $index = [Math]::Floor(($i / [Math]::Pow($chars.length, $j)) % $chars.Length)
    #write-host $index
    $combination += $chars[$index]
    $operators.Push($chars[$index])

  }
  # Evaluate each formula


  for ($k=0; $k -lt $numbers.Length ; $k++) { $operands.Push($numbers[$k])}

 
 while ($operators.count -gt 0) {   
    $symbol = $operators.pop()
   
    $n1 = [int64]$numberstack.pop()
    $n2 = [int64]$numberstack.pop()

     switch ($symbol) {
    '+' { $numberStack.Push($n1 + $n2) }
    '*' { $numberStack.Push($n1 * $n2) }
    }

 
  }
    $result = $numberstack.pop()
    if ($result -eq $test[0]) {Write-host "Match $test $operators"; $hashmap.($test[0]) = $true}  else {}
}
}

$hashmap
$trueKeys = $hashmap.Keys | Where-Object { $hashmap[$_] -eq $true }

$truekeys | measure-object -sum



