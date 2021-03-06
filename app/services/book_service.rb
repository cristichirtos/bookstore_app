require 'uri'
require 'net/http'
require 'json'

class BookService
  include SessionsHelper

  MAX_RESULTS = 5

  def create(bookDTO)
    book = Book.new(bookDTO.attributes)
    add_attributes_to_book(book, bookDTO.google_books_id) if bookDTO.google_books_id

    book.save
    book
  end

  def find_by_id(id)
    Book.find(id)
  end

  def find_all 
    Book.all 
  end

  def search_query(query)
    Book.where("lower(title) LIKE '%#{query}%' OR lower(author) LIKE '%#{query}%' OR lower(genre) LIKE '%#{query.downcase}%'")
  end

  def search_google_books(query)
    book_data = get_result_from_http("https://www.googleapis.com/books/v1/volumes?q=#{query}&maxResults=#{MAX_RESULTS}&key=#{ENV['BOOKS_API_KEY']}")
    book_data['totalItems'] == 0 ? nil : book_data['items']
  end

  def update_by_id(id, params)
    book = Book.find(id)
    book.update(params)
    book
  end

  def sell_by_id(id)
    book = Book.find(id)
    book.update(quantity: book.quantity - 1)
    book
  end

  def delete_by_id(id)
    book = Book.find(id)
    book.destroy 
  end

  def update_image(book, url)
    book.update(image_url: url)
  end

  def books_for_report()
    books = Book.where(quantity: 0)
  end

  private

    def add_attributes_to_book(book, google_book_id)
      book_data = get_result_from_http("https://www.googleapis.com/books/v1/volumes/#{google_book_id}?key=#{ENV['BOOKS_API_KEY']}")
      book.title = book_data['volumeInfo']['title'] if book.title.blank?
      book.author = book_data['volumeInfo']['authors'][0] if book.author.blank? && book_data['volumeInfo']['authors']
      book.author = '-' if book.author.blank?
      book.description = book_data['volumeInfo']['description'] if book.description.blank?
      book.publisher = book_data['volumeInfo']['publisher'] if book.publisher.blank?
      book.publishing_date = book_data['volumeInfo']['publishedDate'] if book.publishing_date.nil?
      book.image_url = book_data['volumeInfo']['imageLinks']['thumbnail']
    end

    def get_result_from_http(uri)
      result = Net::HTTP.get_response(URI(uri))
      JSON.parse(result.body)
    end
end
