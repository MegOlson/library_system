# Library System

## Program that stores books and patron data to be accessed by admins and patrons and allows patrons to check out and return books.

## Specifications

* Program creates instance of book with Book class when given title and author.
  * Example Input: "Emma", "Jane Austen"
  * Example Output: "Emma", "Jane Austen"
* Program saves each book and details to database.
  * Example Input: book.save()
  * Example Output: [book]
* Program returns list of books.
  * Example Input: Book.all()
  * Example Output: [book1, book2]
* Program creates instance of Patron with Patron class when given name and dob.
  * Example Input: "Suzie", "2004-04-20"
  * Example Output: "Suzie", "2004-04-20"
* Program saves each patron and details to database.
  * Example Input: patron.save()
  * Example Output: [patron]
* Program returns list of patrons.
  * Example Input: Patron.all()
  * Example Output: [patron1, patron2]
* Program allows user to search for book by author within database.
  * Example Input: book.search(:author)
  * Example Output: [book1, book2, book3]
* Program allows user to search book by title within database.
  * Example Input: book.search(:title)
  * Example Output: [book1]
* Program allows user to check out a book from library and moves book from book table to checkout table.
  * Example Input: book.check_out()
  * Example Output: checkout_table = [book1]
* Program allows user to view book checkout history.
  * Example Input: checkout.view_history()
  * Example Output: [book1, book2, book3]
* Program allows user to see when their checked out book is due.
  * Example Input: checkout.view()
  * Example Output: [book3, 2017-10-20]
* Program allows user to see list of overdue books.
  * Example Input: checkout.overdue()
  * Example Output: [book1, book2, book3]
