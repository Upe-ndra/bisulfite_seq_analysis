# Bisulfite_seq_analysis

1. Quality control
First thing after you receive your Bisulfite seq data is to check the quality.
We will use fastqc to do that.

[Script](fastqc.sl)

We will run trimmomatic for to trim off adapters and poor quality reads
To run trimmomatic in loop lets create a text file `names` with list of names of all fastq files (just partial names).
For example my fastq files are named as:
```
Upendra-1_S1_L001_R1_001.fastq
Upendra-1_S1_L001_R2_001.fastq
Upendra-2_S2_L001_R1_001.fastq
Upendra-2_S2_L001_R2_001.fastq
Upendra-3_S3_L001_R1_001.fastq
Upendra-3_S3_L001_R2_001.fastq
Upendra-4_S4_L001_R1_001.fastq
Upendra-4_S4_L001_R2_001.fastq
```
So my text file `names` will be as below
```
Upendra-1_S1_L001
Upendra-1_S1_L001
Upendra-2_S2_L001
Upendra-2_S2_L001
Upendra-3_S3_L001
Upendra-3_S3_L001
Upendra-4_S4_L001
Upendra-4_S4_L001
```

Now we can run this [Script](trimmomatic.sl)

After trimmomatic, we will go into `trim` folder and run [fastqc](fastqc.sl) again to see how has our data improved after trimmomatic.
If we are happy with the quality of our data then we will process further if not we may need to change some trimming parameters.

However running only trimmomatic with all the available illumina adapters did not remove all the adapters, especially from one file.
So I tried trimgalore where I also find easy to trim the 3' end of the sequences. However, this also left data with contaminants like `TruSeq Adapter, Index 11` ` Illumina PCR Primer Index 12` and etc. as over represented sequences. So, I tried trimmomatic to remove adapters and used trimgalore to chop 5' and 3' ends and it also remove adapters escaped after trimmomatic. Scripts I used for this process are as below
1. trimmomatic
```
#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 6
#SBATCH --partition=bigmem,large
#SBATCH --job-name Nem.bisulfite
#SBATCH --mem=50G
#SBATCH --time=02:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

mkdir trim
mkdir unpaired

module load Trimmomatic/0.39-Java-1.8.0_144

for f in $(<names)
do
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar PE -phred33 -threads 6 \
"${f}_R1_001.fastq" "${f}_R2_001.fastq" \
"trim/${f}_R1_trim.fastq" "unpaired/${f}_R1_unpaired.fastq" \
"trim/${f}_R2_trim.fastq" "unpaired/${f}_R2_unpaired.fastq" \
ILLUMINACLIP:illumina-all-PE.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:20
```
2.trimgalore
```
#!/bin/bash -e

#SBATCH --nodes 1
#SBATCH --cpus-per-task 1
#SBATCH --ntasks 4
#SBATCH --partition=large
#SBATCH --job-name Nem.trimgalore
#SBATCH --mem=50G
#SBATCH --time=02:00:00
#SBATCH --account=uoo02752
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=bhaup057@student.otago.ac.nz
#SBATCH --hint=nomultithread

module load TrimGalore/0.6.4-gimkl-2018b


for f in $(<names)
do
trim_galore --clip_R1 9 --clip_R2 9 --three_prime_clip_R1 15 --three_prime_clip_R2 15 --paired --fastqc "${f}_R1_trim.fastq" "${f}_R2_trim.fastq"
done
```

## Running Bismark

Next step is to prepare genome using bismark, for this we need to place the genome assembly in a folder lets say `genome`
and run a job to prepare genome assembly for bismark
[Script](bismark_1.sl)

Next run bismark for each pair of pairend reads with this [Script](bismark_2.sl). while running this script flag `--pbat` can significantly improve the alignment rate, as our library were processed using PBAT method.

Next is to run bismark methylation extractor: [Script](bismark_3.sl)

Now time to create report, for this we can just load the module and run `bismark2report` on the directory where all our bismark processing files are located. no need to run it as slurm job as it will only take 10-15 seconds to complete. there are some options to use with this command you can just flag `--help` to learn, for now we will just run `bismark2report` without any options and we will get html reports for each sample.

We can also run `bismark2summary` command without any options in the same directory to summarize the multiple reports into one.
