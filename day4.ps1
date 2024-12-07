

$matrix = @"
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"@


$matrix = Get-Content .\input_day4.txt

# Search forward and backward on each line
# Search up and down in each row
# Search diagonal up and down

# Instead of adapting to search directions. Search from left to right only. But rotate the matrix by 90 before each search. 

#[search] -> 123  741  987  369  123 
#            456  852  654  258  456
#            789  963  321  147  789


$q = $matrix -split "\r\n",""

$buffer1 = New-Object system.collections.arraylist
$buffer2 = New-Object System.Collections.ArrayList

foreach ($i in $matrix) {

  [void]$buffer1.Add($i.tochararray())
  [void]$buffer2.Add($i.tochararray())
}

$matches = 0

[char[]]$search = "XMAS"

for ($i=0; $i -lt $buffer1.count ; $i++) {
 for ($j=0; $j -lt $buffer1.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($buffer1[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}

[array]::Reverse($search)

for ($i=0; $i -lt $buffer1.count ; $i++) {
 for ($j=0; $j -lt $buffer1.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($buffer1[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}
[array]::Reverse($search)


# Transpose the array and reverse each row to get a 90 degree rotation, then search
for ($i=0; $i -lt $buffer1.count ; $i++) {
 for ($j=0; $j -lt $buffer1.count ; $j++) {
   
   $buffer2[$j][$i] = $buffer1[$i][$j]

 }
}

for ($i=0; $i -lt $buffer1.count ; $i++) {
   [array]::Reverse($buffer2[$i])
}

for ($i=0; $i -lt $buffer2.count ; $i++) {
 for ($j=0; $j -lt $buffer2.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($buffer2[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}

[array]::Reverse($search)
for ($i=0; $i -lt $buffer2.count ; $i++) {
 for ($j=0; $j -lt $buffer2.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($buffer2[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}
[array]::Reverse($search)


# Diagonal search
# Get the diagonals starting in the bottom left and working to top right

[int]$n = $buffer1.count -1  

$rows = $buffer1.count
$cols = $buffer1.count

$diaglist = New-Object system.collections.arraylist


while ($n -gt -($buffer1.count)) {    
    
    [string]$line=""

    #Set starting point, either moving up to 0, or to right of 0.
    if ($n -ge 0) {  [int]$r=$n;  [int]$c=0}
    if ($n -lt 0) {  [int]$r=0;  [int]$c=[math]::abs($n)}
    
    while ([int]$r -lt $rows -and $c -lt $cols) {
     $line+= $buffer1[$r][$c]

     $r+=1
     $c+=1

     }
     [void]$diaglist.add($line)
     $n-=1
}

for ($i=0; $i -lt $diaglist.count ; $i++) {
 for ($j=0; $j -lt $diaglist.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($diaglist[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}


[array]::Reverse($search)
for ($i=0; $i -lt $diaglist.count ; $i++) {
 for ($j=0; $j -lt $diaglist.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($diaglist[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}
[array]::Reverse($search)

# diagonal search on matrix rotated 90.

[int]$n = $buffer2.count -1  

$rows = $buffer2.count
$cols = $buffer2.count

$diaglist = New-Object system.collections.arraylist


while ($n -gt -($buffer2.count)) {    
    
    [string]$line=""

    #Set starting point, either moving up to 0, or to right of 0.
    if ($n -ge 0) {  [int]$r=$n;  [int]$c=0}
    if ($n -lt 0) {  [int]$r=0;  [int]$c=[math]::abs($n)}
    
    while ([int]$r -lt $rows -and $c -lt $cols) {
     $line+= $buffer2[$r][$c]

     $r+=1
     $c+=1

     }
     [void]$diaglist.add($line)
     $n-=1
}


for ($i=0; $i -lt $diaglist.count ; $i++) {
 for ($j=0; $j -lt $diaglist.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($diaglist[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}


[array]::Reverse($search)
for ($i=0; $i -lt $diaglist.count ; $i++) {
 for ($j=0; $j -lt $diaglist.count ; $j++) {

    [bool]$bfound = $true
    0..3 | %{if ($diaglist[$i][$j + $_] -eq $search[$_]){ $bfound = $bfound -and $true}else{$bfound = $bfound -and $false} }
    if ($bfound) {write-host $i $j; $matches+=1;}
  }
}
[array]::Reverse($search)

#2323 too low
