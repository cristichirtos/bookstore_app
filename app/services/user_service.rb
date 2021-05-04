class UserService
  def register(user_dto)
    user = User.new(username: user_dto.username, password: user_dto.password, password_confirmation: user_dto.password_confirmation)
    if user_dto.admin.nil? || user_dto.admin == 'no'
      user.roles << Role.find_by(name: :employee)
    else 
      user.roles << Role.find_by(name: :admin)
    end
    user.save
    user
  end

  def find_all 
    User.all 
  end

  def find_by_id(id)
    User.find(id)
  end

  def update_by_id(id, params)
    user = User.find(id)
    user.update(params)
    user
  end

  def delete_by_id(id)
    user = User.find(id)
    user.destroy 
  end
end
