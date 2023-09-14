process fastPStatsCombine {
	container 'ufuomababatunde/biopython:v1.2.0'

	tag "Collecting samples"

	
	publishDir (
	path: "${params.out_dir}/01_fastP/",
	mode: 'copy',
	overwrite: 'true'
	)

	//errorStrategy 'ignore'
	
	input:
	path(csv)

	output:
	path("combined.csv")


	script:
	"""
	combineFastpStats.py \
	$csv

	
	"""

}
