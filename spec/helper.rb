require 'rspec'
require 'vcr'
require 'webmock/rspec'
require 'star_charter'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock

  c.filter_sensitive_data("<OCTOKIT_ACCESS_TOKEN>") do
    ENV['OCTOKIT_ACCESS_TOKEN']
  end

  c.default_cassette_options = {
    :serialize_with => :json,
    :decode_compressed_response => true,
    :record => :once
  }

  c.before_record do |interaction|
    interaction.response.body.force_encoding('utf-8')
  end
end

