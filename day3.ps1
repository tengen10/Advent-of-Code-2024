# Advent of Code 
# Day 3 : https://adventofcode.com/2024/day/3
# Date : 12/3/2024
# Completion: 



$data = get-content .\input_day3.txt

$data = $data -join ""

# Part 1 
# Remove all strings that are not mul(x,y)
# Use Boyer-Moore algorithm to find the patterns. 
# Switched to using RegEx

$pattern = "(mul\(\d{1,3},\d{1,3}\))";

$matches = [regex]::Matches($data,$pattern)

$sumofproducts = 0

foreach ($m in $matches){
  $pattern = "[mul()]"
  $newval = [regex]::Replace($m.value,$pattern,"")

  [int[]]$set = $newval -split ","
  $product = 1

  foreach ($s in $set) {
   $product *= $s
  }

  $sumofproducts += $product

}

Write-host "Sum of products: " $sumofproducts



# Part 2
# Remove all strings that are not mul(x,y) or do() or don't()
# Use Boyer-Moore algorithm to find the patterns. 
# Switched to using RegEx

$pattern = "(mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\))";

$matches = [regex]::Matches($data,$pattern)

[int]$sumofproducts = 0

[bool]$enabled = $true

foreach ($m in $matches){

  if ($m.Value -eq "do()") { $enabled = $true }
  if ($m.Value -eq "don't()") { $enabled = $false }
  

  if ($m.value -like "mul*" -and $enabled) {
   $pattern = "[mul()]"
   $newval = [regex]::Replace($m.value,$pattern,"")

    [int[]]$set = $newval -split ","
    $product = 1

    foreach ($s in $set) {
      $product *= $s
      }
     write-host $product 
    $sumofproducts += $product
   }
}


Write-host "Sum of products: " $sumofproducts

# 140063820 too high
# 76911921
