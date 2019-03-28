require 'json'
require 'spec_helper'

describe Lita::Handlers::Pugbomb, lita_handler: true do
  it { is_expected.to route_command("pug me").to :pug }
  it { is_expected.to route_command("pug bomb").to :bomb }
  it { is_expected.to route_command("pugbomb").to :bomb }
  it { is_expected.to route_command("pug bomb 10").to :bomb }
  it { is_expected.to route_command("how many pugs are there").to :count }

  describe "#pug" do
    let(:pug) { '{"pug": "http://26.media.tumblr.com/tumblr_lomvroWFOE1qaa50yo1_500.jpg"}' }
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://pugme.herokuapp.com/random").and_return(double("Faraday::Response", status: 200, body: pug))
    end

    it "replies with a single pug" do
      send_command("pug me")
      expect(replies.last).to include("http://26.media.tumblr.com/tumblr_lomvroWFOE1qaa50yo1_500.jpg")
    end
  end

  describe "#bomb" do
    let(:bomb) { '{"pugs": ["http://28.media.tumblr.com/tumblr_ltef3eghZ71qb08qmo1_500.jpg","http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg"]}' }
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://pugme.herokuapp.com/bomb", count: "2").and_return(double("Faraday::Response", status: 200, body: bomb))
    end

    it "replies with n pugs" do
      expect {
        send_command("pug bomb 2")
      }.to change{replies.count}.by(2)
      expect(replies.last).to include("http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg")
      expect(replies[-2]).to include("http://28.media.tumblr.com/tumblr_ltef3eghZ71qb08qmo1_500.jpg")
    end
  end

  describe "#bomb with limit" do
    let(:bomb) do
      {
        pugs: [
          "http://28.media.tumblr.com/tumblr_ltef3eghZ71qb08qmo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg"
        ]
      }.to_json
    end

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://pugme.herokuapp.com/bomb", count: "5").and_return(double("Faraday::Response", status: 200, body: bomb))
      stub_const('ENV', { 'MAX_PUGS' => '5' })
    end

    it "replies with enviroment variable quantity" do
      expect {
        send_command("pug bomb 10")
      }.to change{replies.count}.by(5)
    end
  end

  describe "#bomb without limit" do
    let(:bomb) do
      {
        pugs: [
          "http://28.media.tumblr.com/tumblr_ltef3eghZ71qb08qmo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg",
          "http://28.media.tumblr.com/tumblr_lk5h7hIRFf1qi4pifo1_500.jpg"
        ]
      }.to_json
    end

    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://pugme.herokuapp.com/bomb", count: "10").and_return(double("Faraday::Response", status: 200, body: bomb))
      stub_const('ENV', { 'MAX_PUGS' => nil })
    end

    it "replies with n pugs" do
      expect {
        send_command("pug bomb 10")
      }.to change{replies.count}.by(10)
    end
  end

  describe "#count" do
    let(:count) { '{"pug_count": 298}' }
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with("http://pugme.herokuapp.com/count").and_return(double("Faraday::Response", status: 200, body: count))
    end

    it "replies with the current pug count" do
      send_command("how many pugs are there")
      expect(replies.last).to include("There are 298 pugs")
    end
  end
end
