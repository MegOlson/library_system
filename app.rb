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

get('/checkouts') do
  erb(:checkouts)
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

get('/:user/patrons/:id') do
  id = params[:id].to_i
  @user = params[:user]
  @patron = Patron.find(id).first
  erb(:patron)
end

get('/:user/books/:id') do
  id = params[:id].to_i
  @user = params[:user]
  @book = Book.find(id).first
  erb(:book)
end

patch('/:patron_id/:book_id/checkout') do
  patron_id = params[:patron_id].to_i
  book_id = params[:book_id].to_i
  due_date = params[:due_date]
  book = Book.find(book_id).first
  
  book.checkout(patron_id, due_date)
  redirect "#{patron_id}/books/#{book_id}"
end

get('/librarian/patrons/:id/edit') do
  id = params[:id].to_i
  @patron = Patron.find(id).first
  erb(:edit_patron)
end

patch('/patrons/:id') do
  id = params[:id].to_i
  patron = Patron.find(id).first
  patron.name = params['name']
  patron.bithday = params['birthday']
  patron.save
  redirect "/librarian/patrons/#{patron.id}"
end

delete('/librarian/patrons/:id') do
  id = params[:id].to_i
  patron = Patron.find(id).first
  patron.delete
  redirect "/librarian/patrons"
end

delete('/librarian/books/:id') do
  id = params[:id].to_i
  book = Book.find(id).first
  book.delete
  redirect "/librarian/books"
end
