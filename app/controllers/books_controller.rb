class BooksController < ApplicationController
  include BooksHelper

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end

  def search
  end

  def new 
    query_title = params[:query][:title]
    if query_title.blank?
      flash.now[:danger] = 'Please add a title.'
      render 'search'
    else
      @book = Book.new
      @result_books = search_google_books(query_title)
    end
  end 

  def create
    @book = Book.new(book_params)
    add_attributes_to_book(@book, params[:book][:google_book]) if params[:book][:google_book]
    if @book.save 
      flash[:success] = 'Book added successfuly!'
      redirect_to home_path 
    else
      render 'new'
    end
  end 

  private 

    def book_params
      params.require(:book).permit(:title, :author, :genre, :publishing_date, :quantity, :price, :description, :publisher)
    end
end
