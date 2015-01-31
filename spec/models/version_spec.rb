require File.expand_path '../spec_helper.rb', __dir__

RSpec.describe Version do
  it 'has a valid factory' do
    expect(create(:version)).to be_valid
  end

  it 'is invalid without a version' do
    expect(build(:version, version: nil)).to be_invalid
  end

  it 'is associated with a tool' do
    version = create(:version)

    expect(version.tool).to be_an_instance_of Tool
  end

  it 'is sortable by most recent' do
    create(:version, version: '12.04')
    trusty = create(:version, version: '14.04')

    expect(Version.latest).to eq(trusty)
  end
end
