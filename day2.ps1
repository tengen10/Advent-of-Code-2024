# Advent of Code 
# Day 2 : https://adventofcode.com/2024/day/2
# Date : 12/2/2024
# Completion: 


<#
$sample = @"
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"@

$data = $sample -split "\r\n"
#>

$data = get-content .\input_day2.txt

# Part 1 

[int]$reports = 0

foreach ($line in $data) {

  [int[]]$row = $line -split "\s+"
  [int]$direction = [math]::Sign($row[0] - $row[1])
  [int]$prevdirection = $direction
  $score = 0

  for ($i=0; $i-lt $row.count-1; $i++) {
    $v = $row[$i] - $row[$i+1]
    $direction = [math]::Sign($v)
    #write-host $row[$i] - $row[$i+1] $direction $prevdirection $v
    if (($direction -eq $prevdirection) -and ([math]::Abs($v) -ge 1 -and [math]::abs($v) -le 3)) {
     $score += 1
    } 

    $prevdirection = $direction
  
  }
  #write-host $score
  if ($score -eq $row.count - 1) { $row -join ","; $reports+=1}
}

Write-Host "Reports: " $reports



# Part 2 

# Get the original number of SAFE reports
# Create a list of UNSAFE reports and then work on those.

[int]$reports = 0

$newlist = New-Object System.Collections.ArrayList
  

foreach ($line in $data) {

  # initalize the direction and score

  [int[]]$row = $line -split "\s+"

  [int]$direction = [math]::Sign($row[0] - $row[1])
  [int]$prevdirection = $direction
  $score = 0
  $badscore = 0

  for ($i=0; $i-lt $row.count-1; $i++) {
    $v = $row[$i] - $row[$i+1]
    $direction = [math]::Sign($v)

    if (($direction -eq $prevdirection) -and ([math]::Abs($v) -ge 1 -and [math]::abs($v) -le 3)) {
     $score += 1
    } 

    $prevdirection = $direction
  
  }
  #write-host $score
  if ($score -eq $row.Count - 1) { $row -join ","; $reports+=1}
  else {
    $newlist.add($row)
  }
}

Write-Host "Reports: " $reports

function isValid([system.collections.arraylist]$arraylist1) {

  [int]$direction = [math]::Sign($arraylist1[0] - $arraylist1[1])
  [int]$prevdirection = $direction
  $score = 0

  for ($i=0; $i-lt $arraylist1.count-1; $i++) {
    $v = $arraylist1[$i] - $arraylist1[$i+1]
    $direction = [math]::Sign($v)

    if (($direction -eq $prevdirection) -and ([math]::Abs($v) -ge 1 -and [math]::abs($v) -le 3)) {
     $score += 1
    } 

    $prevdirection = $direction
  
  }
  #write-host $score
  if ($score -eq $arraylist1.Count - 1) { return $true} 
  else { return $false}
}


[bool[]]$results=@()
[int]$reports2 = 0

foreach ($i in $newlist) {

 $results = @()

 for ($x=0;$x -lt $i.count; $x++) {
   
   $nl2 = New-Object "system.collections.arraylist"

   for ($y=0;$y -lt $i.count; $y++) {

     if ($y -ne $x) { [void]$nl2.add($i[$y]) } 
  
  }
  $nl2 -join ","
  $results += isValid($nl2)
 
 }
 write-host ($i -join ",") 
 if ($results -contains $true) { $reports2 +=1}
}

Write-Host "Second chance reports: " $reports2

write-host "Total reports" $($reports + $reports2)