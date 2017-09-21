require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
describe("allow user to click on librarian's Place and see welcome page", {:type => :feature}) do
  it('allows a user to click a list to see the tasks and details for it') do
    visit('/')
    click_link("Librarian's Place")
    expect(page).to have_content('Welcome Librarians!')
  end

  it('allows a user to click Add new Book and get form') do
    visit('/librarian/books')
    click_link("Add a Book")
    expect(page).to have_content('Title:')
  end

  it('allows a user to fill the form ') do
    visit('/book/add')
    fill_in('title', :with =>'harry potter')
    fill_in('author', :with =>'j.k')
    click_button('Add Book')
    expect(page).to have_content('harry potter')
  end
end
