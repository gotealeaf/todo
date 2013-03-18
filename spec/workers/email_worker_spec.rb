require 'spec_helper'

describe EmailWorker do
  it "sends out an email to the user" do
    user = Fabricate(:user)
    todo = Fabricate(:todo)
    EmailWorker.perform(user.id, todo.id)
    ActionMailer::Base.deliveries.should_not be_empty
    ActionMailer::Base.deliveries.last.to.should == ''
    ActionMailer::Base.deliveries.last.body.should == ''
  end
end
