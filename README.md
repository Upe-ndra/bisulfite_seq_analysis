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


