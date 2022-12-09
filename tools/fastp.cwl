class: CommandLineTool
cwlVersion: v1.2
  
label: fastp

hints:
    DockerRequirement:
        dockerPull: nanozoo/fastp


baseCommand: [fastp, --detect_adapter_for_pe]

arguments:
    - prefix: -o
      valueFrom: $(inputs.read_1.nameroot).fastp.fq
    - prefix: -O
      valueFrom: $(inputs.read_2.nameroot).fastp.fq


inputs:
    read_1:
        type: File
        inputBinding:
            position: 11
            prefix: '-i'
    read_2:
        type: File
        inputBinding:
            position: 12
            prefix: '-I'           


outputs:
    trimmed_read_1:
        type: File
        outputBinding:
          glob: $(inputs.read_1.nameroot).fastp.fq
    trimmed_read_2:
        type: File
        outputBinding:
          glob: $(inputs.read_2.nameroot).fastp.fq  
