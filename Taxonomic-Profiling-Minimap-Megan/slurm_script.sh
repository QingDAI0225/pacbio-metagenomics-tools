#!/usr/bin/env bash
# DESCRIPTION: Wrapper script for running taxonomic-profiling-minimap-megan workflow

#-----------------------------------------------------------
# Run the following to run this script:
#   mamba activate snakemake7
#   sbatch -A chsi -p chsi -c10 --mem 20G slurm_script.sh
#-----------------------------------------------------------

set -eo pipefail
set -u

NUM_THREADS=24
MEM_MB=120000


snakemake \
    --slurm --default-resources slurm_account=graneklab slurm_partition=chsi mem_mb=${MEM_MB} cpus_per_task=${NUM_THREADS} --jobs 36 \
    --latency-wait 60 \
    --use-conda \
    --nolock \
    --jobname "{rule}.{wildcards}.{jobid}" \
    --snakefile Snakefile-minimap-megan \
    --configfile configs/Sample-Config.yaml \
    --rerun-incomplete

#    workdir=$WORKDIR \
#    --use-singularity \
#    --singularity-args "--bind ${FASTQ_DIR},${DB_DIR}" \
#    --cores ${SLURM_CPUS_PER_TASK} \

# sing=$sing  
exit 0
