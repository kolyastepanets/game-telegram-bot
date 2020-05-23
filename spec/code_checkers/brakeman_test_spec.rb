feature 'Brakeman' do
  require 'brakeman'

  it 'founds no brakeman errors or warnings' do
    result = Brakeman.run Rails.root.to_s

    expect(result.errors).to eq []
    expect(result.warnings).to eq []
  end
end
