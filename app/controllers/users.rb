class Users < Application
  provides :xml
  
  skip_before :login_required
  
  def index
    @users = User.find(:all)
    display @users
  end
  
  def new
    only_provides :html
    @user = User.new(params[:user] || {})
    display @user
  end
  
  def create
    cookies.delete :auth_token
    
    @user = User.new(params[:user])
    @user.admin = true if User.find(:all).empty?
    if @user.save
      self.current_user = @user
      redirect_back_or_default('/')
    else
      render :new
    end
  end
  
end