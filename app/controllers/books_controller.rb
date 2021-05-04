require_relative '../services/book_service'
require_relative '../models/dto/book_dto'

class BooksController < ApplicationController
  before_action :set_service

  def show
    @book = @book_service.find_by_id(params[:id])
  end

  def index
    @books = @book_service.find_all
  end

  def search
    @query = params[:query][:query_text]
    @books = @book_service.search_query(@query)
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
      @result_books = @book_service.search_google_books(query_title)
    end
  end 

  def create
    bookDTO = BookDTO.new(book_params)
    @book = @book_service.create(bookDTO)
    set_temp_book_url(@book.image_url) unless @book.image_url.nil?
    if @book.errors.empty?
      @book_service.update_image(@book, get_temp_book_url) if @book.image_url.nil?
      flash[:success] = 'Book added successfuly!'
      redirect_to home_path 
    else
      render 'new'
    end
  end 

  def edit
    @book = @book_service.find_by_id(params[:id])
  end

  def sell
    @book = @book_service.find_by_id(params[:id])
    if @book.update(quantity: @book.quantity - 1)
      flash.now[:success] = 'Book sold!'
    else 
      @book.reload
      flash.now[:danger] = 'Book is out of stock.'
    end
    render 'show'
  end

  def update
    @book = @book_service.update_by_id(params[:id], book_params)
    unless @book.nil?
      flash[:success] = 'Book updated successfully!'
      redirect_to @book 
    else
      render 'edit'
    end
  end

  def destroy 
    @book_service.delete_by_id(params[:id]) 
    flash[:success] = 'Book deleted successfully!'
    redirect_to home_path
  end

  private 

    def book_params
      params.require(:book).permit(:title, :author, :genre, :publishing_date, :quantity, :price, :description, :publisher, :google_books_id)
    end

    def set_service 
      @book_service = BookService.new
    end
end
