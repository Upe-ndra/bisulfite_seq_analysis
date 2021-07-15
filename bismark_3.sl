!/bin/bash -e 

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

bismark_methylation_extractor -p --comprehensive --gzip --bedGraph \
Upendra-1_S1_L001_R1_trim_bismark_bt2_pe.bam \
Upendra-2_S2_L001_R1_trim_bismark_bt2_pe.bam \
Upendra-3_S3_L001_R1_trim_bismark_bt2_pe.bam \
Upendra-4_S4_L001_R1_trim_bismark_bt2_pe.bam
