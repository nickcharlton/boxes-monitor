require File.expand_path '../spec_helper.rb', __dir__

RSpec.describe Tool do
  it 'has a valid factory' do
    expect(create(:tool)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:tool, name: nil)).to be_invalid
  end

  it 'can have many versions' do
    tool = create(:tool)
    version = create(:version)
    tool.versions = [version]

    expect(tool.versions).to eq([version])
  end
end
