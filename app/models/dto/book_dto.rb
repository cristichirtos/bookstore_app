class BookDTO
  attr_accessor :title, :author, :genre, :description, :publisher, :publishing_date, :quantity, :price, :google_books_id
  def initialize(params)
    @title = params[:title] 
    @author = params[:author] 
    @genre = params[:genre]
    @description = params[:description]
    @publisher = params[:publisher]
    @publishing_date = params[:publishing_date]
    @quantity = params[:quantity]
    @price = params[:price]
    @google_books_id = params[:google_books_id]
  end

  def attributes 
    {
      title: @title,
      author: @author,
      genre: @genre,
      description: @description,
      publisher: @publisher,
      publishing_date: @publishing_date,
      quantity: @quantity,
      price: @price
    }
  end
end
