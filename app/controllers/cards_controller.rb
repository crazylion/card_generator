class CardsController < ApplicationController
  # GET /cards
  # GET /cards.xml
  include AuthenticatedSystem

  before_filter :login_required,:only=>[:new,:create,:edit,:update,:destroy,:add_comment]
  before_filter :find_card,:except=>[:new,:create,:same_author_required,:index]
  before_filter :same_author_required,:only=>[:edit,:update,:destroy]

  def find_card
    @card = Card.find(params[:id])
  end
  
  def same_author_required
     if current_user.id == @card.user_id
     else
       flash[:notice]="需要是原作者"
       redirect_to :back
     end
  end
  

  def index
    @cards = Card.find(:all,:order=>"created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cards }
    end
  end


  def add_comment
    # @card = Card.find(params[:id])
    comment = Comment.new
    comment.comment =  params[:comment]
    comment.user_id = current_user.id
    @card.comments << comment
    flash[:notice]="新增迴響成功"
    redirect_to :back
  end

  # GET /cards/1
  # GET /cards/1.xml
  def show
    

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @card }
      format.pdf {
        @page_size=params["page_size"]
        @page_layout = params["page_layout"]
        prawnto :prawn => { :left_margin=>0,:right_margin=>0,:bottom_margin=>0,:top_margin=>0,:page_size=>params["page_size"],:page_layout=>params["layout"].to_sym }
        # @iconv = Iconv.new('acsii', 'utf-8') 
        # @desc =@iconv.iconv(@card.desc)
        @desc = @card.desc
        @font_size = params["font_size"].to_i
        render :layout => false
        }
    end
  end

  # GET /cards/new
  # GET /cards/new.xml
  def new
    @card = Card.new
    @card.category_id=params[:category_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @card }
    end
  end

  # GET /cards/1/edit
  def edit
    # @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.xml
  def create
    @card = Card.new(params[:card])
    @card.user_id = current_user.id
    respond_to do |format|
      if @card.save
        flash[:notice] = 'Card was successfully created.'
        format.html { redirect_to(@card.category) }
        format.xml  { render :xml => @card, :status => :created, :location => @card }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.xml
  def update
    # @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        flash[:notice] = 'Card was successfully updated.'
        format.html { redirect_to(@card) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xmll => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.xml
  def destroy
    # @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
