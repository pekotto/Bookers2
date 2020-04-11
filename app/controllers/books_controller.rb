class BooksController < ApplicationController

	before_action :ensure_correct_book, only: [:edit, :update]

  def show
	  @book = Book.find(params[:id])
	  @new_book = Book.new
	  @user = @book.user
  end

  def index
	  @book = Book.new
  	@books = Book.all
  end

  def create
    @books = Book.all
	  @book = Book.new(book_params)
	  @book.user_id = current_user.id
  	if @book.save
  		redirect_to @book, notice: "successfully created book!"
  	else
  		render :index
  	end
  end

	def edit
		@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else
  		render :edit
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def ensure_correct_book
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end

end