# AOC Day 11
# https://adventofcode.com/2024/day/11




#$data = "125 17"

$data = "92 0 286041 8034 34394 795 8 2051489"

$temp = $data -split " "


# Part 1  
$buffer = new-object System.Collections.ArrayList
$mystack = new-object System.Collections.Stack

for ($x = 0; $x -lt $temp.count; $x++) {

 [void]$buffer.Add([int64]::Parse($temp[$x]))
}


$blinks = 1
$blinkcount =75
while ($blinks -le $blinkcount) {


for ($i=0; $i -lt $buffer.count; $i++) {
  
  $number = $buffer[$i].ToString()
  $length = $number.length
  $num = [convert]::ToInt64($number)

  if ($num -eq 0) {$mystack.Push(1) }

  elseif ($Length % 2 -eq 0 ) { 
  
    $midpoint = $length / 2
    $left = $number.Substring(0,($midpoint))
    $right =$number.Substring($midpoint)
    #write-host $buffer

    $lval = [convert]::ToInt64($left)
    $rval = [convert]::toint64($right)

    $mystack.push($lval)
    $mystack.push($rval)

    } else  {
    $num2 = $num * 2024
    $mystack.push($num2)
  }
}

$new = $mystack.toarray()
[array]::Reverse($new)

#$new -join ","
$total = $new.count

$mystack.clear()

$buffer.Clear()

foreach ($n in $new) { [void]$buffer.Add($n) }

$blinks +=1
}

write-host $total