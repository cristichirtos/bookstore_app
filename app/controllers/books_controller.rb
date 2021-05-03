class BooksController < ApplicationController
  include BooksHelper

  before_action :set_book, only: [:show, :edit, :sell, :update, :destroy]

  def show
  end

  def index
    @books = Book.all
  end

  def search
    @query = params[:query][:query_text]
    @books = Book.where("lower(title) LIKE '%#{@query}%' OR lower(author) LIKE '%#{@query}%' OR lower(genre) LIKE '%#{@query.downcase}%'")
  end

  def search_books_api
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
    set_temp_book_url(@book.image_url) unless @book.image_url.nil?
    @book.image_url ||= get_temp_book_url
    if @book.save 
      flash[:success] = 'Book added successfuly!'
      redirect_to home_path 
    else
      render 'new'
    end
  end 

  def edit
  end

  def sell
    if @book.update(quantity: @book.quantity - 1)
      flash.now[:success] = 'Book sold!'
    else 
      @book.reload
      flash.now[:danger] = 'Book is out of stock.'
    end
    render 'show'
  end

  def update
    if @book.update(book_params)
      flash[:success] = 'Book updated successfully!'
      redirect_to @book 
    else
      render 'edit'
    end
  end

  def destroy 
    @book.destroy 
    flash[:success] = 'Book deleted successfully!'
    redirect_to home_path
  end

  private 

    def book_params
      params.require(:book).permit(:title, :author, :genre, :publishing_date, :quantity, :price, :description, :publisher)
    end

    def set_book 
      @book = Book.find(params[:id])
    end
end
