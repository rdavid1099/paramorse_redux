require './lib/parallel_encoder'
require './lib/parallel_decoder'

parallel_encoder = ParaMorse::ParallelEncoder.new
parallel_decoder = ParaMorse::ParallelDecoder.new

parallel_encoder.encode_from_file('obama_speech', 4, 'obama_speech_encoded')

parallel_decoder.decode_from_files(4, 'obama_speech_encoded', 'obama_speech_decoded')
