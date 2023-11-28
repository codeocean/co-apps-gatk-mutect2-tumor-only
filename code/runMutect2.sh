#!/usr/bin/env bash

set -ex

source ./config.sh

export PATH=$PATH:/opt/gatk-4.4.0.0/

if [ "$reference_count" -eq 1 ] && [ "$alignment_count" -gt 0 ];
then

    cp $reference_file ../scratch
    cp $reference_index ../scratch

    echo "Number of References : $reference_count"
    echo "Number of Alignment Files Found : $alignment_count"

    for file in $alignment_files;
    do

        prefix=$(basename -s .bam $file)
        reference_prefix=$(basename -s .fa $reference_file)

        mkdir -p ../results/${prefix}

        # Creating Dictionary
        samtools dict \
        -o ../scratch/${reference_prefix}.dict \
        $reference_file

        # Modifiying
        samtools addreplacerg \
        -r '@RG\tID:'"$prefix"'\tSM:'"$prefix"'' \
        -o ../scratch/${prefix}.bam \
        $file 

        # Indexing
        samtools index \
        --threads $num_thread \
        -o ../scratch/${prefix}.bam.bai \
        ../scratch/${prefix}.bam 

        # Step 1. Run Mutect2 in tumor-only mode for each normal sample.
        gatk Mutect2 \
        -R ../scratch/${reference_prefix}.fa \
        -max-mnp-distance 0 \
        --native-pair-hmm-threads $num_thread \
        -I ../scratch/${prefix}.bam \
        -O ../results/../results/${prefix}/${prefix}.vcf.gz
 
    done

else
    echo "Found more than 1 reference or 0 alignment files (.bam)"
fi