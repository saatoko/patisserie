class RecipesController < ApplicationController
  before_action :recipe_post, except: :index
  before_action :set_recipe, except: [:index, :new, :create, :show, :edit, :update, :category_children]
  before_action :set_categories

  def index
    # urlにcategory_id(params)がある場合
    # if params[:category_id].present? then
    if params[:category_id].present? || params[:category_id].blank? then
      
      # Categoryのデータベースのテーブルから一致するidを取得
      # @category = Category.find(params[:category_id])
      # @category = recipe.category
      # @category = Category.find_by(id: params[:id])
      # category_idと紐づく投稿を取得
      # @recipes = Category.all.includes(:recipes)
      # @category = Category.find(params[:id])
      # @recipes = @category.recipes.order('created_at DESC').all #問題
      # @recipes = Recipe.where(id: params[:category_id]).order(created_at: :desc)
      # @recipes = Recipe.@category{"params[:category_id]"}.order(created_at: :desc)
      # @recipes = Recipe.find_by_category_id(params[:category_id])
      # @recipes = Recipe.all
      # @categories = @recipes.category.order('created_at DESC')
      # # category_idと紐づく投稿を取得
      # @recipes = @category.recipes.order(created_at: :desc).all
      # @recipes = @category.order('created_at DESC').all

      @category = Recipe.where(category_id: params[:category_id])
      @yougashis = []
      Recipe.where(category_id: [4,5,6,7,8,9,10,11,12,13,14,15,16,17]).each do |yougashi|
        @yougashis << [yougashi]
      end
      @wagashis = []
      Recipe.where(category_id: [18,19,20,21]).each do |wagashi|
        @wagashis << [wagashi]
      end
      @others = []
      Recipe.where(category_id: [22,23]).each do |other|
        @others << [other]
      end

      @recipes = Recipe.includes(:recipe_images, :recipe_ingredients, :categories).order('created_at DESC').limit(20)
      # binding.pry

      # if @recipes || @yougashis || @wagashis || @others.present?
      #   flash.now[:alert] = '#{@recipes.category.name}のレシピがあります'
      #   render :index
      # else
      #   flash.now[:alert] = 'カテゴリーに当てはまるレシピがありません'
      #   render :index
      # end

      if @category.present?
        flash.now[:alert] = 'カテゴリーに当てはまるのレシピがあります'
        render :index
      else
        flash.now[:alert] = 'カテゴリーに当てはまるレシピがありません'
        render :index
      end

      

    # # ビデオがある場合
    # elsif params[:recipe_videos_attributes].present? then
    #   # カテゴリーなし投稿の全てを取得
    #   @recipes = Recipe.includes(:recipe_images, :recipe_ingredients, :recipe_videos, :categories).order('created_at DESC')
    #   # flash.now[:alert] = 'テスト'
    #   render :index
      

    # カテゴリーもビデオもない場合
    else
      # カテゴリー、ビデオなし投稿のすべてを取得
      @recipes = Recipe.includes(:recipe_images, :recipe_ingredients, :categories).order('created_at DESC').limit(20)
      flash.now[:alert] = 'レシピ一覧表示になります'
      render :index
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
    @recipe = Recipe.find(params[:id])
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
      categories_attributes: [:id, :name, :ancestry, :_destroy])
      .merge(user_id: current_user.id)
  end

  def category_params
    params.require(:category).permit(:name, :ancestry)
  end


  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_post
    redirect_to action: :index unless user_signed_in?
  end

  def set_categories
    @categories = Category.where(params[:id])
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

