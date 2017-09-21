require "sinatra"
require "sinatra/reloader"
also_reload "lib/**/*.rb"
require "pg"
require "./lib/book"
require "./lib/patron"
require "./lib/checkout"
require "pry"

DB = PG.connect({:dbname => 'library_system_test'})

get('/') do
  erb(:index)
end

get('/librarian') do
  erb(:librarian)
end

get('/librarian/patrons') do
  @patrons = Patron.all
  erb(:librarian_patron)
end

get('/library') do
  @books = Book.all
  erb(:library)
end

get('/librarian/books') do
  @user = "librarian"
  @books = Book.all
  erb(:books)
end

get('/patron/books') do
  @user = "patron"
  @books = Book.all
  erb(:library)
end

get ('/books/:book_id') do
  @book = Book.find(params.fetch(:book_id).to_i())
  erb(:success)
end

get('/patrons') do
  erb(:patrons)
end

get('/patron/add') do
  erb(:add_patron)
end

get('/book/add') do
  erb (:add_book)
end

post('/patron/add') do
  name = params.fetch("name")
  birthday = params.fetch("birthday")
  patron2 = Patron.new({:id => nil, :name => name, :birthday => birthday})
  patron2.save
  redirect "/librarian/patrons"
end

post('/book/add') do
  book_title = params.fetch("title")
  book_author = params.fetch("author")
  book2 = Book.new({:id => nil, :title => book_title, :author => book_author, :checked_in => nil})
  book2.save
  redirect "/librarian/books"
end


# get('/librarian/overdue')
# @overdue = C
# end
