class: Workflow
cwlVersion: v1.2

requirements:
  ScatterFeatureRequirement: {}

inputs:
    read_1: File
    read_2: File
    gtf: File
    ref_cdna: File
    transcriptome: File
    basedir: Directory
    split: int
    
steps:
  fastp:
    run: ./tools/fastp.cwl
    in:
      read_1: read_1
      read_2: read_2
    out: [ trimmed_read_1, trimmed_read_2 ]
    
  check_strandedness:
    run: ./tools/check_strandedness.cwl
    in:
      read_1: read_1
      read_2: read_2
      gtf: gtf
      ref_cdna: ref_cdna
      basedir: basedir
    out: [ strandedness ]
  
  splitFastq:
    run: ./tools/splitFastq.cwl
    in:
      basedir: basedir
      read_1: fastp/trimmed_read_1
      read_2: fastp/trimmed_read_2
      split: split
    out: [ splitted_reads_1, splitted_reads_2 ]
  
  kallisto_index:
    run: ./tools/kallisto_index.cwl
    in: 
      transcriptome: transcriptome
    out: [ index ]
    
  kallisto_quant:
    run: ./tools/kallisto_quant.cwl
    scatter: [read_1, read_2]
    scatterMethod: dotproduct
    in:
      basedir: basedir
      index: kallisto_index/index
      gtf: gtf
      strandedness: check_strandedness/strandedness
      read_1: splitFastq/splitted_reads_1
      read_2: splitFastq/splitted_reads_2   
    out: [ quant_files, bam ]
  
  merge_quant:
    run: ./tools/merge_quant.cwl
    in:
      basedir: basedir
      quant_files: kallisto_quant/quant_files
    out: [merged_quant_result]
    
outputs:
  trimmed_read_1:
    type: File
    outputSource: fastp/trimmed_read_1
  trimmed_read_2:
    type: File
    outputSource: fastp/trimmed_read_2
  merged_quant:
    type: File
    outputSource: merge_quant/merged_quant_result
