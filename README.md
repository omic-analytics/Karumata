# Karumata
 HIV pipeline


<img src="https://github.com/omic-analytics/Karumata/blob/main/assets/karumata_Illumina.jpg" width="700">

## How to run
Assume that the fastq files are in the `dataSet_Illumina_HIV` directory and you intend to put the results in the directory named `result`.

```
nextflow run Karumata \
--reads dataSet_Illumina_HIV \
--out_dir result 
```


## To verify results
[Stanford University HIV Drug Resistance Database](https://hivdb.stanford.edu/) will be used after creating [codfreq](https://github.com/hivdb/codfreq) files from the `raw fastq files`.

> [!WARNING]
> An error may be encountered in codfreq's `fastp v0.23.4`. <br>
> `ERROR: sequence and quality have different length` <br>

1. Install [Docker Engine](https://docs.docker.com/get-docker/).

2. Install the modified version of `codfreq` (i.e., a docker image with the older `fastp v0.20.1`).

	```
	sudo curl -sL https://raw.githubusercontent.com/omic-analytics/Karumata/main/assets/modified_fastq2codfreq -o /usr/local/bin/fastq2codfreq

	sudo chmod +x /usr/local/bin/fastq2codfreq
	```

3. Download the HIV-1 alignment profile.
	```
	wget https://raw.githubusercontent.com/omic-analytics/Karumata/main/assets/HIV1.json
	```
4. Create `codfreq` files from raw `fastq` files using [codfreq](https://github.com/hivdb/codfreq).

	```
	fastq2codfreq -r ./path/to/HIV1.json -d ./fastq_4codefreq/
	```
5. Upload the codfreq files to [Stanford HIVdb](https://hivdb.stanford.edu/hivdb/by-reads/).

