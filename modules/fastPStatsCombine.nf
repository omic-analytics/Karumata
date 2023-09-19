// Combine the extracted fastP statistics
// of each sample into a single csv file

process fastPStatsCombine {
	container 'ufuomababatunde/biopython:v1.2.0'


	
	publishDir (
	path: "${params.out_dir}/01_fastP/",
	mode: 'copy',
	overwrite: 'true'
	)

	//errorStrategy 'ignore'
	
	input:
	path(csv)

	output:
	path("combinedFastPStats.csv")


	script:
	"""
	combineFastPStats.py \
	$csv \
	--out combinedFastPStats.csv

	"""
}
