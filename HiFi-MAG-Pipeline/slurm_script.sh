#!/usr/bin/env bash
# DESCRIPTION: Wrapper script for running HiFi-MAG-Pipeline workflow

#-----------------------------------------------------------
# Run the following to run this script:
#   mamba activate snakemake7
#   srun -A chsi -p chsi -c10 --mem 20G ./mmlong2-lite.sh 
#-----------------------------------------------------------


set -eo pipefail
set -u


NUM_THREADS=24
MEM_MB=60000


snakemake \
    --slurm --default-resources slurm_account=chsi slurm_partition=chsi mem_mb=${MEM_MB} cpus_per_task=${NUM_THREADS} --jobs 36 \
    --latency-wait 60 \
    --use-conda \
    --nolock \
    --jobname "{rule}.{wildcards}.{jobid}" \
    --snakefile Snakefile-hifimags.smk \
    --configfile configs/Sample-Config.yaml \
    --rerun-incomplete

#    workdir=$WORKDIR \
#    --use-singularity \
#    --singularity-args "--bind ${FASTQ_DIR},${DB_DIR}" \
#    --cores ${SLURM_CPUS_PER_TASK} \

# sing=$sing  
exit 0
