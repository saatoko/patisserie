class RecipesController < ApplicationController
  before_action :recipe_post, except: :index
  before_action :set_recipe, except: [:index, :new, :create, :show, :edit, :update, :category_children]
  # before_action :set_categories, only: [:new, :create, :edit, :update]
  # before_action :set_category, except: [:index, :new, :create, :show, :edit, :update]
  
  def index
    # @recipes = Recipe.includes(:recipe_images, :recipe_ingredients, :recipe_videos, :categories).order('created_at DESC')

    # urlにcategory_id(params)がある場合
    if params[:category_id]
      # Categoryのデータベースのテーブルから一致するidを取得
      @category = Category.find(params[:category_id])
        
      # category_idと紐づく投稿を取得
      @recipes = @category.recipes.order('created_at DESC').all
    else
      # 投稿すべてを取得
      @recipes = Recipe.includes(:recipe_images, :recipe_ingredients, :recipe_videos, :categories).order('created_at DESC')
    end
   
  end

  def new
    @recipe = Recipe.new

    #has_manyまたはhas_and_belongs_to_manyに使用されるassociation.buildメソッド
    @recipe.recipe_images.build
    @recipe.recipe_ingredients.build

    #has_oneまたはbelongs_toの関連付けをする際、build_接頭辞を関連付けのbuildに使用
    @recipe.build_recipe_video
    @recipe.build_category

    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
   end
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def category_children  
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end
  

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to recipes_path
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path
  end

  # def select_category
  #   @category = Category.new
  #   respond_to do |format|
  #     format.js do
  #       @category = Category.find(params[:category_id])
  #     end
  #   end
  # end

  private
  def recipe_params
    params.require(:recipe).permit(
      :name, 
      # :genre_id, 
      :difficulty_id, 
      :servers, 
      :cookingtime, 
      :restingtime, 
      :bakingtime, 
      :bakingtemperature, 
      :instruments, 
      :cookingpoint, 
      :method, 
      :category_id,
      recipe_ingredients_attributes: [:id, :ingredients, :quantity, :_destroy], 
      recipe_images_attributes: [:image, :_destroy], 
      recipe_videos_attributes: [:video, :_destroy],
      categories_attributes: [:id, :name, :ancestry, :_destroy])
      .merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_post
    redirect_to action: :index unless user_signed_in?
  end

  # def set_categories
  #   # @categories = Category.eager_load(children: :children).where(ancestry: nil)  
  #   # @categories = Category.all
  #   @parent_categories = Category.roots
  #   @default_child_categories = @parent_categories.first.children
  # end

end

