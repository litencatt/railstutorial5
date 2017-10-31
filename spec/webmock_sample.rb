require 'rails_helper'

describe "" do
  before do
    stub_request(:get, "http://www.example.com").to_return(
      body:  'hello',
      status: 200
    )

    stub_request(:get, "http://www.google.co.jp").to_return(
      body:  'hello',
      status: 200
    )
  end

  it 'Stubed return' do
    res = Net::HTTP.get("www.example.com", "/")
    expect(res).to eq 'hello'
  end

  it 'Allow net connect' do
    WebMock.allow_net_connect!
    res = Net::HTTP.get("www.yahoo.co.jp", "/")
    expect(res).not_to eq 'hello'
  end

  it do
    WebMock.enable!
    res = Net::HTTP.get("www.google.co.jp", "/")
    expect(res).to eq 'hello'

    WebMock.disable!
    res = Net::HTTP.get("www.google.co.jp", "/")
    expect(res).not_to eq 'hello'
  end
end
