class: CommandLineTool
cwlVersion: v1.2

label: splitFastq

baseCommand: [bash]

arguments:
    - position: 1
      valueFrom: $(inputs.basedir.path)/bin/splitFastq.sh

inputs:
    basedir: 
        type: Directory
        inputBinding: 
            position: 2
    read_1: 
        type: File
        inputBinding:
            position: 3
    read_2:
        type: File
        inputBinding:
            position: 4
    split:
        type: int
        inputBinding:
            position: 5
            
outputs: 
    splitted_reads_1:
        type: File[]
        outputBinding:
            glob: "*$(inputs.read_1.nameroot)*"
    splitted_reads_2:
        type: File[]
        outputBinding:
            glob: "*$(inputs.read_2.nameroot)*"
