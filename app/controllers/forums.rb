class Forums < Application
  # provides :xml, :yaml, :js
  before :login_required, :exclude => [:index, :show]
  
  def index
    @forums = Forum.find(:all)
    display @forums
  end

  def show
    @forum = Forum.find_by_id(params[:id], :include => :topics)
    raise NotFound unless @forum
    display @forum
  end

  def new
    only_provides :html
    @forum = Forum.new(params[:forum])
    render
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      redirect url(:forum, @forum)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @forum = Forum.find_by_id(params[:id])
    raise NotFound unless @forum
    render
  end

  def update
    @forum = Forum.find_by_id(params[:id])
    raise NotFound unless @forum
    if @forum.update_attributes(params[:forum])
      redirect url(:forum, @forum)
    else
      raise BadRequest
    end
  end

  def destroy
    @forum = Forum.find_by_id(params[:id])
    raise NotFound unless @forum
    if @forum.destroy
      redirect url(:forums)
    else
      raise BadRequest
    end
  end
  
end
