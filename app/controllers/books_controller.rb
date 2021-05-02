class BooksController < ApplicationController
  def show
  end

  def index
    @books = Book.all
  end
end
