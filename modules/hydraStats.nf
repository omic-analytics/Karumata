// Extract the filtering statistics from hydra and
// the depth of coverage then combine into a csv file

process hydraStats {
	container 'ufuomababatunde/biopython:v1.2.0'

	tag "Extracting from $sample"

	
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
