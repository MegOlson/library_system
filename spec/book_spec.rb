require 'spec_helper'

describe("Book") do
  let(:book) {Book.new({:id => nil, :title => "Emma", :author => "Jane Austen"})}
  it("creates instance of book with Book class when given name and specialty") do
    expect(Book.title).to eq ("Emma")
  end
  
end
