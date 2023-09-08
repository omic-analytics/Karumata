# Karumata
 HIV pipeline


<img src="https://github.com/omic-analytics/Karumata/blob/main/assets/karumata_Illumina.jpg" width="700">

## How to run
Assume that the fastq files have the following names:
```
113B_S9_L001_R1_001.fastq
113B_S9_L001_R1_001.fastq
```
and they are in the `dataSet_Illumina_HIV` directory, use the following command.

```
nextflow run Karumata \
--reads "$PWD/dataSet_Illumina_HIV/*_{R1,R2}_001.fastq" \
--out_dir result 
```



<details>
<summary>File name Patterns</summary>
<br>

For files with the following pattern, use `*_{1,2}.fastq`
```
SRR18513032_1.fastq
SRR18513032_2.fastq
```

For files with the following pattern, use `*_{R1,R2}.fastq`
```
SRR18513032_R1.fastq
SRR18513032_R2.fastq
```
</details>


## To verify results
Create `codfreq` files from raw `fastq` files using [codfreq](https://github.com/hivdb/codfreq).
> [!IMPORTANT]
> An error may be encountered in the codfreq's `fastp v0.23.4`. <br>
> `ERROR: sequence and quality have different length`