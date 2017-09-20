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
    result = DB.exec("INSERT INTO checkout (due_date, book_id, patron_id) VALUES ('#{@due_date}', #{@book_id}, #{@patron_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(another_checkout)
      self.due_date().==(another_checkout.due_date()).&(self.id().==(another_checkout.id()))
  end

  def self.list_of_books
    book_list = []
    result = DB.exec("SELECT * FROM books WHERE id = ('#{self.book_id}'); ")
    result.each do |book|
      id = book.fetch("id").to_i
      title = book.fetch("title")
      author = book.fetch("author")
      book_list.push(Book.new({:id => id, :title => title, :author => author}))
    end
    book_list
  end

end
