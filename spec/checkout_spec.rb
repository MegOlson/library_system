require 'spec_helper'

describe("Checkout") do
  let(:checkout) {Checkout.new({:id => nil, :due_date => "2017-04-20", :book_id => 1, :patron_id => 1})}
  it("creates instance of checkout with Checkout class when given id and due date") do
    expect(checkout.due_date).to eq ("2017-04-20")
  end

  describe(".all") do
    it("is empty at first") do
      expect(Checkout.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("saves each checkout and details to database") do
      checkout.save()
      expect(Checkout.all()).to(eq([checkout]))
    end
  end

  describe("#==") do
  it("is the same checkout if they have the same name and doctor id") do
    checkout1 = Checkout.new({:id => nil, :due_date => "2017-04-20", :book_id => nil, :patron_id => nil})
    checkout2 = Checkout.new({:id => nil, :due_date => "2017-04-20", :book_id => nil, :patron_id => nil})
    expect(checkout1).to(eq(checkout2))
    end
  end
  describe(".list_of_books") do
    it("returns list of checkouted books") do
      book1 = Book.new({:title => "Emma", :author => "Jane Eyre", :id => 1})
      book1.save

      book2 = Book.new({:title => "Emma", :author => "Jane Eyre", :id => 2})
      book2.save
      checkout1 = Checkout.new({:id => nil, :due_date => "2017-04-20", :book_id => 1, :patron_id => 1})
      checkout1.save
      checkout2 = Checkout.new({:id => nil, :due_date => "2017-04-20", :book_id => 2, :patron_id => 2})
      checkout2.save
      expect(Checkout.list_of_books).to eq([checkout1, checkout2])
    end

    end

end
