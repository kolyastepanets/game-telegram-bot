feature 'Rubocop' do
  require 'rubocop'

  it 'founds no rubocop offenses' do
    cop = RuboCop::CLI.new
    args = [Rails.root.to_s]

    expect(cop.run(args)).to eq 0
  end
end
