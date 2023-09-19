process hydraStats {
	container 'ufuomababatunde/biopython:v1.2.0'

	tag "Extracting from $sample"

	
	publishDir (
	path: "${params.out_dir}/03_hydra/",
	mode: 'copy',
	overwrite: 'true'
	)

	//errorStrategy 'ignore'
	
	input:
	tuple val(sample), path(hydra)
	tuple val(sample), path(coverage)

	output:
	path("*.hydraFilterAlignment.csv"), emit: stats

	script:
	"""
	concatenateHydraResults.py \
	--hydra $hydra \
	--coverage $coverage \
	--out ${sample}.hydraFilterAlignment.csv
	"""

}
