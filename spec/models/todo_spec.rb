require 'spec_helper'

describe Todo do
  describe "#name_only?" do
    it "returns true if the description is nil" do
      todo = Todo.new(name: "cook dinner")
      todo.should be_name_only
    end

    it "returns true if the description is an empty string" do
      todo = Todo.new(name: "cook dinner", description: "")
      todo.should be_name_only
    end

    it "returns false if the description is a non empty string" do
      todo = Todo.new(name: "cook dinner", description: "Potatoes!!")
      todo.should_not be_name_only
    end
  end
end
