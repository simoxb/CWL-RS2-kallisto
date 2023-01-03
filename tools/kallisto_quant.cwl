class: CommandLineTool
cwlVersion: v1.2
  
label: kallisto_quant

hints:
    DockerRequirement:
        dockerPull: zlskidmore/kallisto

baseCommand: [bash]

arguments:
    - position: 1
      valueFrom: $(inputs.basedir.path)/bin/kallisto_quant.sh

inputs:
    basedir:
        type: Directory
    index: 
        type: File
        inputBinding:
            position: 2
    gtf:
        type: File
        inputBinding:
            position: 3
    strandedness: 
        type: string
        inputBinding: 
            position: 4
    read_1:
        type: File
        inputBinding:
            position: 5
    read_2: 
        type: File
        inputBinding:
            position: 6
       
outputs:
    quant_files:
        type: File
        outputBinding:
          glob: "*.tsv"     
    bam:
        type: File
        outputBinding:
          glob: "*.bam"     
