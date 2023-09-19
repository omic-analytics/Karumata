// Combine the drug resistance mutations
// detected by hydra

process resistanceMutationCombine {
	container 'ufuomababatunde/biopython:v1.2.0'


	
	publishDir (
	path: "${params.out_dir}/02_hydra/",
	mode: 'copy',
	overwrite: 'true'
	)

	//errorStrategy 'ignore'
	
	input:
	path(csv)

	output:
	path("combinedResistanceMutation.csv")


	script:
	"""
	combineResistanceMutation.py \
	$csv \
	--out combinedResistanceMutation.csv

	"""
}
