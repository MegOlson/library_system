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
  describe("#search_by_author") do
    it("search books by author") do
      book1 = Book.new({:title => "Emma", :author => "Jane Austen", :id => nil})
      book2 = Book.new({:title => "Pride and Prejudice", :author => "Jane Austen", :id => nil})
      book1.save()
      book2.save()
      expect(Book.search_by_author("Jane Austen")).to eq([book1.title, book2.title])
    end
  end
  describe("#search_by_title") do
    it("search books by title") do
      book1 = Book.new({:title => "Emma", :author => "Jane Austen", :id => nil})
      book2 = Book.new({:title => "Pride and Prejudice", :author => "Jane Austen", :id => nil})
      book1.save()
      book2.save()
      expect(Book.search_by_title("Emma")).to eq([book1.title])
    end
  end
end
