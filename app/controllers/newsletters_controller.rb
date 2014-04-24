class NewslettersController < AnoNewsletter::ApplicationController

  before_action :set_newsletter, only: [:edit, :update, :destroy]
  before_filter :authorize_resource, except: [:index]

  # GET /newsletters
  def index
    @newsletters = ano_newsletter_current_user ? Newsletter.order(released_at: :desc) : Newsletter.archive
    @current_newsletter = @newsletters.first
  end

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
  end

  # POST /newsletters
  def create
    @newsletter = Newsletter.new(newsletter_params)

    if @newsletter.save
      redirect_to ano_newsleter.newsletters_url, notice: 'Newsletter was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /newsletters/1
  def update
    if @newsletter.update(newsletter_params)
      redirect_to ano_newsleter.newsletters_url, notice: 'Newsletter was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /newsletters/1
  def destroy
    @newsletter.destroy
    redirect_to ano_newsleter.newsletters_url, notice: 'Newsletter was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def newsletter_params
      params.require(:newsletter).permit(:released_at, :title, :description, :asset)
    end

    def authorize_resource
      model = (@media || Newsletter)
      @authorization_adapter.try(:authorize, params[:action], model)
    end
end
