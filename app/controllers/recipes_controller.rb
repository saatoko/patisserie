class RecipesController < ApplicationController
  before_action :recipe_post, except: :index
  before_action :set_recipe, except: [:index, :new, :create, :show, :edit, :update, :category_children]
  before_action :set_categories

  def index
    if params[:category_id].present? then
    # if params[:category_id].present?
      # Categoryのデータベースのテーブルから一致するidを取得
      @category = Category.where(id: params[:category_id]).order(created_at: :desc) 
      # category_idと紐づく投稿を取得
      @recipes = Recipe.all.where(category_id: @category).includes(:recipe_images, :recipe_ingredients, :category, :recipe_video).order('created_at DESC').limit(20) || @recipes = Recipe.all.where(category_id: @category).includes(:recipe_images, :recipe_ingredients, :category).order('created_at DESC').limit(20)

      @YOUGASHI = Category.find(1)
      @YOUGASHIS = @YOUGASHI.children
      @yougashis =  Recipe.all.where(category_id: @YOUGASHIS).includes(:recipe_images, :recipe_ingredients, :category, :recipe_video).order('created_at DESC').limit(20) || @yougashi = Recipe.all.where(category_id: @YOUGASHIS).includes(:recipe_images, :recipe_ingredients, :category).order('created_at DESC').limit(20)

      @WAGASHI = Category.find(2)
      @WAGASHIS = @WAGASHI.children
      @wagashis =  Recipe.all.where(category_id: @WAGASHIS).includes(:recipe_images, :recipe_ingredients, :category, :recipe_video).order('created_at DESC').limit(20) || @wagashis = Recipe.all.where(category_id: @WAGASHIS).includes(:recipe_images, :recipe_ingredients, :category).order('created_at DESC').limit(20)

      @OTHER = Category.find(3)
      @OTHERS = @OTHER.children
      @others =  Recipe.all.where(category_id: @OTHERS).includes(:recipe_images, :recipe_ingredients, :category, :recipe_video).order('created_at DESC').limit(20) || @others = Recipe.all.where(category_id: @OTHERS).includes(:recipe_images, :recipe_ingredients, :category).order('created_at DESC').limit(20)

      # @yougashis = @recipes.where(category_id: [4,5,6,7,8,9,10,11,12,13,14,15,16,17])
      # @wagashis = @recipes.where(category_id: [18,19,20,21])
      # @others = @recipes.where(category_id: [22,23])
      @main_categories = Category.eager_load(:children).where(ancestry: nil)
      if @recipes.present?
        flash.now[:alert] = 'カテゴリーのレシピがあります'
      # elsif @yougashis.present?
      #   flash.now[:alert] = '洋菓子のレシピになります'
      # elsif @wagashis.present?
      #   flash.now[:alert] = '和菓子のレシピになります'
      # elsif @others.present?
      #   flash.now[:alert] = 'その他のレシピになります'
      else
        flash.now[:alert] = "カテゴリーのレシピが投稿されていません"
      end
     
    else
    # elsif params[:category_id].blank?
      @recipes = Recipe.all.includes(:recipe_images, :recipe_ingredients, :category, :recipe_video).order('created_at DESC').limit(20) || @recipes = Recipe.all.includes(:recipe_images, :recipe_ingredients, :category).order('created_at DESC').limit(20)
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
      flash.now[:alert] = 'レシピを投稿しました'
      redirect_to recipes_path
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end
  
  def show
    # @category = Category.find(params[:id])
  end

  def edit
    @parents = Category.where(ancestry:nil)
    # 編集する商品を選択
    # @recipe = Recipe.find(params[:id])
    # 登録されている商品の孫カテゴリーのレコードを取得
    @selected_child_category = @recipe.category
    # 子カテゴリー選択肢用の配列作成
    @category_children_array = [{id: "---", name: "---"}]
    Category.find("#{@selected_child_category.id}").siblings.each do |child|
      children_hash = {id: "#{child.id}", name: "#{child.name}"}
      @category_children_array << children_hash
    end
    # 選択されている親カテゴリーのレコードを取得
    @selected_parent_category = @selected_child_category.parent
    # 親カテゴリー選択肢用の配列作成
    @category_parents_array = [{id: "---", name: "---"}]
    Category.find("#{@selected_parent_category.id}").siblings.each do |parent|
      parent_hash = {id: "#{parent.id}", name: "#{parent.name}"}
      @category_parents_array << parent_hash
    end
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
      categories_attributes: [:ids[], :name, :ancestry, :_destroy])
      .merge(user_id: current_user.id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
    
  end

  def recipe_post
    redirect_to action: :index unless user_signed_in?
  end

  def set_categories
    # @categories = Recipe.where(category_id: params[:category_id])
    # @categories = Category.where(params[:id])
    @category_children1 = Category.where(ancestry: 1)
    @category_children2 = Category.where(ancestry: 2)
    @category_children3 = Category.where(ancestry: 3)
  end

  # def set_categories
  #   # @categories = Category.eager_load(children: :children).where(ancestry: nil)  
  #   # @categories = Category.all
  #   @parent_categories = Category.roots
  #   @default_child_categories = @parent_categories.first.children
  # end

end

