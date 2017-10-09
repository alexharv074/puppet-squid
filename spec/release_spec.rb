require 'spec_helper'
require 'json'

version = JSON.parse(File.read('metadata.json'))['version']

describe 'Release-related checks' do
  it 'Version in metadata.json should match a tag' do
    expect(%x{git tag -l | tail -1}.chomp).to eq version
  end

  it 'Third line of CHANGELOG.md should mention the version' do
    expect(%x{sed -n 3p CHANGELOG.md}).to match /#{version}/
  end
end
