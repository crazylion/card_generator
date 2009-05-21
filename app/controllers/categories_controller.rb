class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  include AuthenticatedSystem
  before_filter :login_required,:only=>[:new,:create,:edit,:update,:destroy,:add_comment]
  before_filter :find_category,:except=>[:get_status,:new,:create,:same_author_required,:index]
  before_filter :same_author_required,:only=>[:edit,:update,:destroy]
  before_filter :get_status,:only=>[:index,:show]
  
  def get_status
    @lastest_cards = Card.find(:all,:order=>"created_at desc",:limit=>5)
    @lastest_categories = Category.find(:all,:order=>"created_at desc",:limit=>5)
  end
  
  def find_category
    @category = Category.find(params[:id])
  end
  
  def same_author_required
     if current_user.id == @category.user_id
     else
       flash[:notice]="需要是原作者"
       redirect_to :back
     end
  end
  
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end


  def comments_feed
    @comments = Comment.find(:all,:conditions=>"commentable_type='Card'",:joins=>"left join Cards on category_id=#{@category.id}",:order=>"comments.created_at desc")
    respond_to do |format|
      format.atom
    end
  end


  # GET /categories/1
  # GET /categories/1.xml
  def show

    @cards = []
    if params["tagname"]
      @cards = Card.tagged_with(params["tagname"], :on => :tags).paginate :page=>params[:page]||1
    else
      if request.format.html?
        @cards = @category.cards.paginate :page=>params[:page]||1
      else
        @cards = @category.cards
      end
    end
    @tags = @category.cards.tag_counts
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
      format.pdf  {
        @page_size=params["page_size"]
        prawnto :prawn => { :left_margin=>0,:right_margin=>0,:bottom_margin=>0,:top_margin=>0,:page_size=>params["page_size"],:page_layout=>params["layout"].to_sym }
        # @iconv = Iconv.new('acsii', 'utf-8') 
        # @desc =@iconv.iconv(@card.desc)
        @font_size = params["font_size"].to_i
        render :layout => false
        
        
      }
      format.atom
    end
  end


  def add_comment
    # category = Category.find(params[:id])
    comment = Comment.new
    comment.comment =  params[:comment]
    comment.user_id = current_user.id
    @category.comments << comment
    flash[:notice]="新增迴響成功"
    redirect_to :back
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    # @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])
    @category.user_id = current_user.id
    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(@category) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    # @category = Category.find(params[:id])
    @category.user_id=current_user.id
    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    # @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to("/") }
      format.xml  { head :ok }
    end
  end
end
