process sierra {
	cpus 1
	container 'ufuomababatunde/sierralocal:1.3.0'

	tag "Creating JSON file for $sample"
	
	publishDir (
	path: "${params.out_dir}/04_sierra/",
	mode: 'copy',
	overwrite: 'true'
	)



	input:
	tuple val(sample), path(fasta)

	output:
	tuple val(sample), path('consensus*.json'), optional: true, emit: json

	script:
	"""



	if [ -s $fasta ]; then
		# The file is not-empty.
		sierralocal $fasta \
		-o tmp.json \
		-xml ${params.sierraXML}

		checkJSON.py --json tmp.json --sample ${sample}
	
	else
		echo "Skipping since there is no consensus sequence"
	fi


	"""
}