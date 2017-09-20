class Checkout
  attr_reader(:id, :due_date, :book_id, :patron_id)
  def initialize(attributes)
    @id = attributes.fetch(:id)
    @due_date = attributes.fetch(:due_date)
    @book_id = attributes.fetch(:book_id)
    @patron_id = attributes.fetch(:patron_id)
  end

  def self.all
    total_checkouts = DB.exec("SELECT * from checkout;")
    checkouts = []
    total_checkouts.each do |checkout|
      id = checkout.fetch("id").to_i
      due_date = checkout.fetch("due_date")
      book_id = checkout.fetch("book_id").to_i
      patron_id = checkout.fetch("patron_id").to_i
      checkouts.push(Checkout.new({:id => id, :due_date => due_date, :book_id => book_id, :patron_id => patron_id}))
    end
    checkouts
  end

  def save
    # if @id
    #   DB.exec("UPDATE checkout SET due_date = '#{@due_date}' WHERE id = #{@id}")
    # else
      result = DB.exec("INSERT INTO checkout (due_date, book_id, patron_id) VALUES ('#{@due_date}', #{@book_id}, #{@patron_id}) RETURNING id;")
      @id = result.first().fetch("id").to_i
    # end
  end

  def ==(another_checkout)
      self.due_date().==(another_checkout.due_date()).&(self.id().==(another_checkout.id()))
  end

  def self.find(id)
    book_result = DB.exec("SELECT * FROM checkout WHERE id = #{id};")
    results = []
    book_result.each do |result|
      id = result.fetch("id").to_i
      due_date = result.fetch("due_date")
      book_id = result.fetch("book_id").to_i
      patron_id = result.fetch("patron_id").to_i
      results.push(Checkout.new({:id => id, :due_date => due_date, :book_id => book_id, :patron_id => patron_id}))
    end
    results
  end

  def self.find_by_book(book_id)
    book_result = DB.exec("SELECT * FROM checkout WHERE book_id = #{book_id};")
    results = []
    book_result.each do |result|
      id = result.fetch("id").to_i
      due_date = result.fetch("due_date")
      book_id = result.fetch("book_id").to_i
      patron_id = result.fetch("patron_id").to_i
      results.push(Checkout.new({:id => id, :due_date => due_date, :book_id => book_id, :patron_id => patron_id}))
    end
    results
  end

  def self.overdue
    today = Date.today.to_s
    results = DB.exec("SELECT * from checkout WHERE due_date <= '#{today}';")
    list = []
    results.each do |result|
      id = result.fetch("id").to_i
      due_date = result.fetch("due_date")
      book_id = result.fetch("book_id").to_i
      patron_id = result.fetch("patron_id").to_i
      list.push(Checkout.new({:id => id, :due_date => due_date, :book_id => book_id, :patron_id => patron_id}))
    end
    list
  end

  def delete
    DB.exec("DELETE FROM checkout WHERE id = #{@id};")
  end

end
