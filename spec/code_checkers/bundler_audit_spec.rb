feature 'Bundler audit' do
  require 'bundler/audit/cli'

  it 'founds no vulns in bundle' do
    result = `bundle audit`
    code = `echo $?`.squish

    expect(code).to eq '0'
  end
end
