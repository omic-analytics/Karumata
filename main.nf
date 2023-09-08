// enable dsl2
nextflow.enable.dsl=2


// import modules
include {fastP} from './modules/fastP.nf'
include {kraken} from './modules/kraken.nf'
include {hydra} from './modules/hydra.nf'
include {sierra} from './modules/sierra.nf'
include {report} from './modules/report.nf'

workflow {


	Channel
		.fromFilePairs(params.reads, flat:true)
		.ifEmpty{error "Cannot find any reads matching: ${params.reads}"}
		.set{ch_sample}
		

	main:
		//ch_sample.view()
		fastP(ch_sample)
		//kraken(fastP.out.trimmed, params.krakenDB)
		hydra(fastP.out.trimmed)
		sierra(hydra.out.consensus)
		report(sierra.out.json, params.reportPDF)
		//report(sierra.out.json)

}



