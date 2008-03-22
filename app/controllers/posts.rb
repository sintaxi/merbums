class Posts < Application
  # provides :xml, :yaml, :js
  before :login_required, :exclude => [:index, :show]
  before :find_forum_and_topic
  
  def find_forum_and_topic
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
  end
  
  def index
    @posts = Post.find(:all)
    display @posts
  end

  def show
    @post = Post.find_by_id(params[:id])
    raise NotFound unless @post
    display @post
  end

  def new
    only_provides :html
    @post = Post.new(params[:post])
    render
  end

  def create
    @post = Post.new(params[:post].merge({:user => current_user,:forum => @forum,:topic => @topic}))
    if @post.save
      redirect url(:forum_topic, @topic)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @post = Post.find_by_id(params[:id])
    raise NotFound unless @post
    render
  end

  def update
    @post = Post.find_by_id(params[:id])
    raise NotFound unless @post
    if @post.update_attributes(params[:post])
      redirect url(:post, @post)
    else
      raise BadRequest
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    raise NotFound unless @post
    if @post.destroy
      redirect url(:posts)
    else
      raise BadRequest
    end
  end
  
end
