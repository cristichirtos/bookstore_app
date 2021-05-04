BOOTSTRAP = false

if BOOTSTRAP 
  User.delete_all
  Book.delete_all 
  Role.delete_all 
  Role.create(name: :employee)
  Role.create(name: :admin)
end
