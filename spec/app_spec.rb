require File.expand_path 'spec_helper.rb', __dir__

describe 'app' do
  it 'has a working home page' do
    get '/'

    expect(last_response.status).to eq(200)
  end
end
