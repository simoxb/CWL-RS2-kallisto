class: CommandLineTool
cwlVersion: v1.2

label: merge_quant

hints:
    DockerRequirement:
        dockerPull: amancevice/pandas
        
baseCommand: [python]

arguments:
    - position: 1
      valueFrom: $(inputs.basedir.path)/bin/merge_quant.py

inputs:
    basedir: 
        type: Directory
    quant_files:
        type: File[]
        inputBinding: 
            position: 2
        
outputs: 
    merged_quant_result:
        type: File
        outputBinding:
            glob: "merged_quant.tsv"
