class Attachments < Application
  # provides :xml, :yaml, :js

  def index
    @attachments = Attachment.find(:all)
    display @attachments
  end

  def show
    @attachment = Attachment.find_by_id(params[:id])
    raise NotFound unless @attachment
    display @attachment
  end

  def new
    only_provides :html
    @attachment = Attachment.new(params[:attachment])
    render
  end

  def create
    @attachment = Attachment.new(params[:attachment])
    if @attachment.save
      redirect url(:attachment, @attachment)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @attachment = Attachment.find_by_id(params[:id])
    raise NotFound unless @attachment
    render
  end

  def update
    @attachment = Attachment.find_by_id(params[:id])
    raise NotFound unless @attachment
    if @attachment.update_attributes(params[:attachment])
      redirect url(:attachment, @attachment)
    else
      raise BadRequest
    end
  end

  def destroy
    @attachment = Attachment.find_by_id(params[:id])
    raise NotFound unless @attachment
    if @attachment.destroy
      redirect url(:attachments)
    else
      raise BadRequest
    end
  end

end
