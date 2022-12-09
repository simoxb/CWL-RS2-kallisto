length=$(wc -l < $2)
length=$((length / 4))
s=$(echo $4)
z=$((length / s))
splitby=$((${z} + 1))
a=$(basename $2)
b=$(basename $3)
$1/bin/splitFastq -i $2 -n ${splitby} -o $a
$1/bin/splitFastq -i $3 -n ${splitby} -o $b
