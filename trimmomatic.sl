#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 6
#SBATCH --partition=bigmem,large
#SBATCH --job-name EW.BS.trim1
#SBATCH --mem=5G
#SBATCH --time=00:30:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

mkdir trim
mkdir unpaired

module load Trimmomatic/0.38-Java-1.8.0_144
for f in $(<names)
do
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.38.jar PE -threads 6 \
"${f}_R1_001.fastq" "${f}_R2_001.fastq" \
"trim/${f}_R1_trim.fastq" "unpaired/${f}_R1_unpaired.fastq" \
"trim/${f}_R2_trim.fastq" "unpaired/${f}_R2_unpaired.fastq" \
ILLUMINACLIP:TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 HEADCROP:10 MINLEN:35
done
