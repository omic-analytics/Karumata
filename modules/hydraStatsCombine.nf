process hydraStatsCombine {
	container 'ufuomababatunde/biopython:v1.2.0'


	
	publishDir (
	path: "${params.out_dir}/03_hydra/",
	mode: 'copy',
	overwrite: 'true'
	)

	//errorStrategy 'ignore'
	
	input:
	path(csv)

	output:
	path("combinedHydraStats.csv")


	script:
	"""
	combineHydraStats.py \
	$csv \
	--out combinedHydraStats.csv

	
	"""

}
