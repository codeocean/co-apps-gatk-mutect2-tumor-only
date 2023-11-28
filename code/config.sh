#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
else
  echo "args:"
  for i in $*; do 
    echo $i 
  done
  echo ""
fi

# Reference Files
reference_file=$(get_fasta_file --dir ../data)
reference_count=$(echo $reference_file | wc -w)

# Reference Index
reference_index=$(find -L ../data -name "*.fai")
index_count=$(echo $reference_index | wc -w)

# Alignment Files
alignment_files=$(find -L ../data -name "*.bam")
alignment_count=$(echo $alignment_files | wc -w)

# GATK Mutect2

num_thread=$(get_cpu_count)