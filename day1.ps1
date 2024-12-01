# Advent of Code 
# Day 1 : https://adventofcode.com/2024/day/1
# Date : 12/1/2024
# Completion: ~30 minutes

# Part 1 & 2


$group1 = new-object "system.collections.arraylist"

$group2 = new-object "system.collections.arraylist"

$list = Get-Content .\input.txt

foreach ($i in $list) {

    $row = $i -split "\s+"

    $group1.Add([int]$row[0])
    $group2.Add([int]$row[1])
}


# Part 1
# Since each group has the same number of elements, sort each group and find the distance.

$group1.sort()
$group2.sort()

[int]$sum=0

for ($i=0; $i -lt $group1.Count; $i++) {

$sum += [math]::abs($group1[$i] - $group2[$i])


}

write-host "Total distance between A and B:" $sum


# Part 2
# Count the number of times each occurs to calculate similarity score
[int]$sum=0

for ($i=0; $i -lt $group1.Count; $i++) {
 for ($j=0; $j -lt $group2.Count; $j++) {
  
  [int]$count =0
  if ($group2[$j] -eq $group1[$i]) {
    $count += 1
    }
    $sum += ($count*$group1[$i])
 }
}

write-host "Similarity score: " $sum







    $group1.Add([int]$row[0])
    $group2.Add([int]$row[0])
}



$sum += $i
if ($i -eq '') {
    [void]$groups.add($sum)
    $sum = 0
    }
}


# Part 1 solution
$groups | Sort-Object -Descending | Select-Object -First 1 

# Part 2 solution
$groups | sort-object -Descending | Select-Object -First 3 | Measure-Object -Sum
