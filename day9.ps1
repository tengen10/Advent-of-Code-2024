# Day 9
# https://adventofcode.com/2024/day/9



# Part 1

# Use a queue to store each fileid and free space
# Convert that to an ArrayList
# Find each first free space and take the fileid from the end and move it.

#$data = "2333133121414131402"

$data = Get-Content .\day9_input.ps1

#append 0 to last position to reduce check at end
$data += "0"

$disk = new-object System.Collections.Queue

$fileid = 0

for($block = 0 ; $block -lt $data.Length ; $block+=2) {

  $used = [int32][char]::GetNumericValue($data[$block])
  #write-host $used
  
  for ($i = 0; $i -lt $used; $i++) {$disk.Enqueue($fileid) }
    
  $space = [int32][char]::GetNumericValue($data[$block+1])
  for ($j = 0; $j -lt $space; $j++) {$disk.Enqueue(".") }
  
  $fileid+=1
}

$array = $disk.ToArray()

$arrayList = New-Object System.Collections.ArrayList

foreach ($element in $array) {
  [void]$arrayList.Add($element)
}


# fill in spaces at beginning with elements from the ends

$firstfree = $arraylist.IndexOf(".")

for ($j = ($arraylist.Count-1) ; $j -gt $firstfree; $j--) {
  
  $firstfree = $arraylist.IndexOf(".")

  if ($arraylist[$j] -ne "." -and $j -gt $firstfree) {$arraylist[$firstfree] = $arraylist[$j]; $arraylist[$j] ="."}
  #$arraylist -join ""
}


$sum = 0 
for ($j=0; $j -lt $arraylist.count; $j++) {

  if ($arraylist[$j] -ne "." ) {$product = $arraylist[$j] * $j; $sum += $product}
  #$arraylist -join ""
}

write-host "Checksum: $sum"

# ans 1: 24914453918645 too high
# ans 2: 6446899523367

