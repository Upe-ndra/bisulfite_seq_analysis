#!/bin/bash -e 

#SBATCH --nodes 1 
#SBATCH --cpus-per-task 1 
#SBATCH --ntasks 10 
#SBATCH --partition=large,bigmem 
#SBATCH --job-name bismark
#SBATCH --mem=30G 
#SBATCH --time=01:00:00 
#SBATCH --account=uoo02752 
#SBATCH --output=%x_%j.out 
#SBATCH --error=%x_%j.err 
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=bhaup057@student.otago.ac.nz 
#SBATCH --hint=nomultithread

module load Bismark/0.22.3-gimkl-2018b
module load Bowtie2/2.4.1-GCC-9.2.0
module load Python/3.9.5-gimkl-2020a
module load SAMtools/1.12-GCC-9.2.0

bismark --bowtie2 -n 1 /nesi/nobackup/uoo02752/earwig/earwig_bisulfite/trim/genome \
-1 Upendra-1_S1_L001_R1_trim.fastq -2 Upendra-1_S1_L001_R2_trim.fastq --pbat

bismark --bowtie2 -n 1 /nesi/nobackup/uoo02752/earwig/earwig_bisulfite/trim/genome \
-1 Upendra-2_S2_L001_R1_trim.fastq -2 Upendra-2_S2_L001_R2_trim.fastq --pbat

bismark --bowtie2 -n 1 /nesi/nobackup/uoo02752/earwig/earwig_bisulfite/trim/genome \
-1 Upendra-3_S3_L001_R1_trim.fastq -2 Upendra-3_S3_L001_R2_trim.fastq --pbat

bismark --bowtie2 -n 1 /nesi/nobackup/uoo02752/earwig/earwig_bisulfite/trim/genome \
-1 Upendra-4_S4_L001_R1_trim.fastq -2 Upendra-4_S4_L001_R2_trim.fastq --pbat
