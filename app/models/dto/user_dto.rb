class UserDTO
  attr_accessor :username, :password, :password_confirmation, :admin
  def initialize(params)
    @username = params[:username] 
    @password = params[:password] 
    @password_confirmation = params[:password_confirmation]
    @admin = params[:admin]
  end
end
