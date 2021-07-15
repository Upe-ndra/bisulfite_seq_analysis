#!/bin/bash -e 

#SBATCH --nodes 1 
#SBATCH --cpus-per-task 1 
#SBATCH --ntasks 10 
#SBATCH --partition=large,bigmem 
#SBATCH --job-name fastqc
#SBATCH --mem=1G 
#SBATCH --time=01:00:00 
#SBATCH --account=uoo02752 
#SBATCH --output=%x_%j.out 
#SBATCH --error=%x_%j.err 
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=bhaup057@student.otago.ac.nz 
#SBATCH --hint=nomultithread

mkdir fastqc_raw
module load FastQC
fastqc *.fastq -o ./fastqc_raw
