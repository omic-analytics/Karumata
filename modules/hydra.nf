// Run hydra alignment and detection of drug resistance mutation
// Run samtools depth to determine the mean depth of coverage etc.
// Rename the headers and the output files themselves.

process hydra {
	container 'ufuomababatunde/quasitools:v1.0.0'

	tag "Doing magic on $sample"

	
	publishDir (
	path: "${params.out_dir}/02_hydra/",
	pattern: "*.consensus.fasta",
	mode: 'copy',
	overwrite: 'true'
	)

	//errorStrategy 'ignore'
	
	input:
	tuple val(sample), path(fastq_1), path(fastq_2)

	output:
	//path("${sample}/*")
	tuple val(sample), path("*.consensus.fasta"), emit: consensus
	tuple val(sample), path("*.hydraFilter.csv"), emit: stats
	tuple val(sample), path("*.coverage.csv"), emit: coverage
	tuple val(sample), path("*.bam"), optional: true, emit: bam
	tuple val(sample), path("*.bam.bai"), optional: true, emit: bambai
	path("*_drugResistanceMutation.csv"), emit: drugResistance


	script:
	"""
	quasitools hydra ${fastq_1} ${fastq_2} \
	--generate_consensus \
	--reporting_threshold ${params.hydraReportThreshold} \
	--min_read_qual ${params.hydraMinReadQuality} \
	--consensus_pct ${params.hydraConsensusPercent} \
	--length_cutoff ${params.hydraMinReadLength} \
	--score_cutoff ${params.hydraMinScoreCutoff} \
	--min_variant_qual ${params.hydraMinVariantQuality} \
	--min_dp ${params.hydraMinVariantDepth} \
	--min_ac ${params.hydraMinAlleleCount} \
	--min_freq ${params.hydraMinVariantFrequency} \
	--id ${sample} \
	--output_dir ${sample}

	cp ${sample}/consensus.fasta ${sample}.consensus.fasta

	sed "s/hxb2_pol/${sample}/g" ${sample}/dr_report.csv > ${sample}_drugResistanceMutation.csv
	sed -i 's/Chromosome/Sample/g' ${sample}_drugResistanceMutation.csv

	extractHydraStats.py \
	--in ${sample}/stats.txt \
	--sample ${sample} \
	--out ${sample}.hydraFilter.csv


	samtools coverage -H \
	${sample}/align.bam > ${sample}.coverage.csv

	sed -i 's/\t/,/g' ${sample}.coverage.csv
	sed -i "s/hxb2_pol/${sample}/g" ${sample}.coverage.csv
	sed -i '1 i\\Sample,StartPosition,EndPosition,NumberOfReads,NumberOfBasesCoveredAcrossGenome,PercentCoverage,MeanDepthCoverage,MeanBaseQuality,MeanMappingQuality' ${sample}.coverage.csv
	
	"""
}
