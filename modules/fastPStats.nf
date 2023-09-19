// Extract fastP statistics before and after filtering
// and save into a single csv file per sample.

process fastPStats {
	container 'ufuomababatunde/biopython:v1.2.0'

	tag "Extracting from $sample"

	
	//errorStrategy 'ignore'
	
	input:
	tuple val(sample), path(json)

	output:
	path("*.csv"), emit: stats


	script:
	"""
	extractFastpStats.py \
	--json $json \
	--sample ${sample} \
	--out ${sample}.csv

	"""
}
