require 'spec_helper'

describe Lita::Handlers::Dogebomb, lita_handler: true do
  it { is_expected.to route_command("doge me").to :doge }
  it { is_expected.to route_command("doge bomb").to :bomb }
  it { is_expected.to route_command("dogebomb").to :bomb }
  it { is_expected.to route_command("doge bomb 10").to :bomb }
  it { is_expected.to route_command("how many doges are there").to :count }

  describe "#doge" do
    let(:doge) { '{"doge": "http://i.imgur.com/nF8DtvV.jpg"}' }
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://dogeme.rowanmanning.com/random").and_return(double("Faraday::Response", status: 200, body: doge))
    end

    it "replies with a single doge" do
      send_command("doge me")
      expect(replies.last).to include("http://i.imgur.com/nF8DtvV.jpg")
    end
  end

  describe "#bomb" do
    let(:bomb) { '{"doges": ["https://pbs.twimg.com/media/BdTWMskCEAAQ5b7.jpg", "http://i.imgur.com/1uBYSzq.jpg"]}' }
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://dogeme.rowanmanning.com/bomb", count: "2").and_return(double("Faraday::Response", status: 200, body: bomb))
    end

    it "replies with n doges" do
      expect {
        send_command("doge bomb 2")
      }.to change{replies.count}.by(2)
      expect(replies.last).to include("http://i.imgur.com/1uBYSzq.jpg")
      expect(replies[-2]).to include("https://pbs.twimg.com/media/BdTWMskCEAAQ5b7.jpg")
    end
  end

  describe "#count" do
    let(:count) { '{"doge_count": 82}' }
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://dogeme.rowanmanning.com/count").and_return(double("Faraday::Response", status: 200, body: count))
    end

    it "replies with the current doge count" do
      send_command("how many doges are there")
      expect(replies.last).to include("There are 82 doges")
    end
  end
end
