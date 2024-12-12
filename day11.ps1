# AOC Day 11
# https://adventofcode.com/2024/day/11




#$data = "125 17"

$data = "92 0 286041 8034 34394 795 8 2051489"

$temp = $data -split " "


# Part 1  
$buffer = new-object System.Collections.ArrayList
$myqueue = new-object System.Collections.queue

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

  if ($num -eq 0) {$myqueue.Enqueue(1) }

  elseif ($Length % 2 -eq 0 ) { 
  
    $midpoint = $length / 2
    $left = $number.Substring(0,($midpoint))
    $right =$number.Substring($midpoint)
    #write-host $buffer

    $lval = [convert]::ToInt64($left)
    $rval = [convert]::toint64($right)

    $myqueue.Enqueue($lval)
    $myqueue.Enqueue($rval)

    } else  {
    $num2 = $num * 2024
    $myqueue.Enqueue($num2)
  }
}

#$new = $myqueue.ToArray()
#[array]::Reverse($new)

#$new -join ","
$total = $myqueue.count

$buffer.Clear()

while ($myqueue.count -gt 0) { [void]$buffer.Add($myqueue.Dequeue()) }

$blinks +=1
write-host $blinks
}

write-host $total