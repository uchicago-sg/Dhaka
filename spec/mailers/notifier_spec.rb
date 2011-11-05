require "spec_helper"

describe Notifier do
  describe "renew" do
    let(:mail) { Notifier.renew }

    it "renders the headers" do
      mail.subject.should eq("Renew")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
