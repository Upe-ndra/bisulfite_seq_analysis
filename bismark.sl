#!/bin/bash -e 

#SBATCH --nodes 1 
#SBATCH --cpus-per-task 1 
#SBATCH --ntasks 10 
#SBATCH --partition=large,bigmem 
#SBATCH --job-name bismark
#SBATCH --mem=50G 
#SBATCH --time=10:00:00 
#SBATCH --account=uoo02752 
#SBATCH --output=%x_%j.out 
#SBATCH --error=%x_%j.err 
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=bhaup057@student.otago.ac.nz 
#SBATCH --hint=nomultithread

module load Bismark/0.22.3-gimkl-2018b
module load Bowtie2/2.4.1-GCC-9.2.0
module load Python/3.9.5-gimkl-2020a

bismark_genome_preparation \
--path_to_aligner /scale_wlg_persistent/filesets/opt_nesi/CS400_centos7_bdw/Bowtie2/2.4.1-GCC-9.2.0/bin/ \
--verbose /nesi/nobackup/uoo02752/earwig/earwig_bisulfite/trim/genome
