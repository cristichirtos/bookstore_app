class UserService
  def register(userDTO)
    user = User.new(username: userDTO.username, password: userDTO.password, password_confirmation: userDTO.password_confirmation)
    if userDTO.admin.nil? || userDTO.admin == 'no'
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
    user.update(params) ? user : nil
  end

  def delete_by_id(id)
    user = User.find(id)
    user.destroy 
  end
end
