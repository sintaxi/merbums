class Topics < Application
  # provides :xml, :yaml, :js
  
  before :login_required, :exclude => [:index, :show]
  before :find_forum
  
  def find_forum
    @forum ||= Forum.find(params[:forum_id])
  end
  
  def index
    @topics = Topic.find(:all)
    display @topics
  end

  def show
    @topic = Topic.find_by_id(params[:id])
    @post = Post.new
    raise NotFound unless @topic
    display @topic
  end

  def new
    only_provides :html
    @topic = Topic.new(params[:topic])
    render
  end

  def create
    @topic = @forum.topics.new(params[:topic].merge(:user => current_user))
    if @topic.save
      redirect url(:forum_topic, @topic)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @topic = Topic.find_by_id(params[:id])
    raise NotFound unless @topic
    render
  end

  def update
    @topic = Topic.find_by_id(params[:id])
    raise NotFound unless @topic
    if @topic.update_attributes(params[:topic])
      redirect url(:topic, @topic)
    else
      raise BadRequest
    end
  end

  def destroy
    @topic = Topic.find_by_id(params[:id])
    raise NotFound unless @topic
    if @topic.destroy
      redirect url(:topics)
    else
      raise BadRequest
    end
  end
  
end
