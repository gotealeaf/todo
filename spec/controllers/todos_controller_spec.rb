require 'spec_helper'

describe TodosController do

  let(:alice) { Fabricate(:user) }
  before { set_current_user(alice) }

  describe "GET index" do
    it "sets the @todos variable" do
      cook = Todo.create(name: "cook")
      sleep = Todo.create(name: "sleep")

      get :index
      assigns(:todos).should == [cook, sleep]
    end

    it "renders the index template" do
      get :index
      response.should render_template :index
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end
  end

  describe "GET new" do
    it "sets the @todo variable" do
      get :new
      assigns(:todo).should be_new_record
      assigns(:todo).should be_instance_of(Todo)
    end
    it "renders the new template" do
      get :new
      response.should render_template :new
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it "creates the todo record when the input is valid" do
      post :create, todo: {name: "cook", description: "I like cooking!" }
      Todo.first.name.should == "cook"
      Todo.first.description.should == "I like cooking!"
    end

    it "redirects to the root path when the input is valid" do
      post :create, todo: {name: "cook", description: "I like cooking!" }
      response.should redirect_to root_path
    end

    it "delegates to CreditDeduction to deduct credit" do
      credit_deduction = double("credit deduction")
      CreditDeduction.stub(:new).with(alice).and_return(credit_deduction)
      credit_deduction.should_receive(:deduct_credit)
      post :create, todo: {name: "cook", description: "I like cooking!" }

    end

    it "does not create a todo when the input is invalid" do
      post :create, todo: {description: "I like cooking!" }
      Todo.count.should == 0
    end

    it "renders the new template when the input is invalid" do
      post :create, todo: {description: "I like cooking!" }
      response.should render_template :new
    end

    it "does not create tags without inline locations" do
      post :create, todo: {name: "cook"}
      Tag.count.should == 0
    end

    it "does not create tags with at in a word without inline locations" do
      post :create, todo: {name: "eat an apple"}
      Tag.count.should == 0
    end

    it "creates a tag with upcase AT" do
      post :create, todo: {name: "shop AT the Apple Store"}
      Tag.all.map(&:name).should == ["location:the Apple Store"]
    end

    context "email sending" do
      it "sends out the email"  do
        post :create, todo: {name: "shop AT the Apple Store"}
        EmailWorker.jobs.size.should == 1
      end
    end

    context "with inline locations" do
      it "creates a tag with one location" do
        post :create, todo: {name: "cook AT home"}
        Tag.all.map(&:name).should == ['location:home']
      end

      it "creates two tags with two locations" do
        post :create, todo: {name: "cook AT home and work"}
        Tag.all.map(&:name).should == ['location:home', 'location:work']
      end

      it "creates multiple tags with four locations" do
        post :create, todo: {name: "cook AT home, work, school and library"}
        Tag.all.map(&:name).should == ['location:home', 'location:work', 'location:school', 'location:library']
      end

      it_behaves_like "require_sign_in" do
        let(:action) { post :create, todo: {name: 'something'}}
      end
    end
  end
end
