class BlogController < CmsController
  def index
    @page_index = params[:page_index].to_i
    @posts = @obj.latest_posts(10, @page_index)

    respond_to do |format|
      format.html
      format.atom
    end
  end
end
