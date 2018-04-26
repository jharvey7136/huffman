require 'spec_helper'

describe MyHuffman do
  before :each do
    s = "String to get encoded"
    @myhuffman1 = MyHuffman.new s
  end

describe "#new" do
  it "takes a string parameter and returns a MyHuffman object" do
    expect(@myhuffman1).to be_an_instance_of MyHuffman
  end
end

describe "#encode_string" do  
end


end
