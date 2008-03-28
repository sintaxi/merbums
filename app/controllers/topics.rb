class Topics < Application
  # provides :xml, :yaml, :js
  
  before :login_required, :exclude => [:index, :show]
  before :find_forum
  
  def find_forum
    @forum ||= Forum.find_by_param(params[:forum_id])
  end
  
  def index
    @topics = @forum.topics.find(:all)
    display @topics
  end

  def show
    @topic = Topic.find_by_param(params[:id])
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
      flash[:notice] = @topic.name + " created successfully"
      redirect url(:forum_topic, { :forum_id => @forum, :id => @topic })
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @topic = Topic.find_by_param(params[:id])
    raise NotFound unless @topic
    render
  end

  def update
    @topic = Topic.find_by_param(params[:id])
    raise NotFound unless @topic
    if @topic.update_attributes(params[:topic])
      flash[:notice] = @topic.name + " updated successfully"
      redirect url(:forum_topic_posts,:topic_id => @topic)
    else
      raise BadRequest
    end
  end

  def destroy
    @topic = Topic.find_by_param(params[:id])
    raise NotFound unless @topic
    if @topic.destroy
      redirect url(:topics)
    else
      raise BadRequest
    end
  end
  
end
