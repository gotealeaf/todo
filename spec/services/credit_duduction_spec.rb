require 'spec_helper'

describe CreditDuduction do
  describe "#deduct_credit" do
    context "the user is a premium user" do
      let(:user) { double("user", premium?: true) }
      let(;credit) { Credit.new(user) }
      it "deducts one credit" do

        credit.should 


        CreditDuduction.new(user).deduct_credit
      end
    end
    context "the user is a normal user" do
      it "deducts two credits"
    end

    context "credit is depleted"
    context "credit is low balance"
    context "credit balance is normal"
  end
end
