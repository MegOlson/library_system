require 'spec_helper'

describe("Checkout") do
  let(:checkout) {Checkout.new({:id => nil, :due_date => "2017-09-29", :book_id => 1, :patron_id => 1})}
  it("creates instance of checkout with Checkout class when given id and due date") do
    expect(checkout.due_date).to eq ("2017-09-29")
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

  describe ".find" do
   it "finds checkouts by its id" do
     checkout.save
     checkout2 = Checkout.new({:id => 1, :due_date => "2017-04-20", :book_id => 1, :patron_id => 2})
     checkout2.save
     expect(Checkout.find(checkout.id)).to eq [checkout]
     end
   end

   describe ".find_by_book" do
    it "finds checkouts by book" do
      checkout.save
      expect(Checkout.find_by_book(1)).to eq [checkout]
    end
  end
  describe ".overdue" do
    it "returns a list of all overdue checkouts" do
      checkout.save
      overdue_checkout = Checkout.new({:id => 1, :due_date => "2017-09-19", :book_id => 1, :patron_id => 2})
      overdue_checkout.save
      expect(Checkout.overdue).to eq [overdue_checkout]
    end
  end

  describe ("#delete") do
    it("will delete checkout from database") do
      checkout.save
      checkout.delete
      expect(Checkout.all).to eq ([])
    end
  end

  describe("#due_date_calc") do
    it("calculates due date") do
      expect(checkout.due_date_calc).to eq("2017-10-11")
    end
  end
end
