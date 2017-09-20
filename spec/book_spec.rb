require 'spec_helper'

describe("Book") do
  let(:book) {Book.new({:id => nil, :title => "Emma", :author => "Jane Austen"})}
  it("creates instance of book with Book class when given name and specialty") do
    expect(book.title).to eq ("Emma")
  end
  describe(".all") do
    it("is empty at first") do
      expect(Book.all()).to eq([])
    end
  end
  describe("#save") do
    it("saves each book and details to database") do
      book.save()
      expect(Book.all()).to(eq([book]))
    end
  end
  describe("#==") do
    it("is the same book if they have the same title, author, and id") do
      book1 = Book.new({:title => "Emma", :author => "Jane Eyre", :id => nil})
      book2 = Book.new({:title => "Emma", :author => "Jane Eyre", :id => nil})
      expect(book1).to(eq(book2))
    end
  end
end
