module Admin
  class PostsController < BaseController
    before_action :set_post, only: %i[edit update destroy]

    def index
      authorize! :manage, Post

      @categories = Post
        .where.not(category: [nil, ""])
        .distinct
        .order(:category)
        .pluck(:category)

      @authors = User.joins(:posts).distinct.order(:username)

      @posts = Post.with_attached_cover.order(created_at: :desc)

      filter_by_category
      filter_by_status
      filter_by_author
      filter_by_search
    end

    def new
      @post = Post.new(status: "draft")
      @post.user = current_user

      authorize! :manage, @post
    end

    def create
      @post = Post.new(post_params)
      @post.user = current_user

      authorize! :manage, @post

      update_published_at(@post)

      if @post.save
        redirect_to admin_posts_path, notice: "Пост создан"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize! :manage, @post
    end

    def update
      authorize! :manage, @post

      @post.assign_attributes(post_params)
      update_published_at(@post)

      if @post.save
        redirect_to admin_posts_path, notice: "Пост сохранён", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize! :manage, @post

      @post.destroy!

      redirect_to admin_posts_path, notice: "Пост удалён", status: :see_other
    end

    private

    def filter_by_category
      return if params[:category].blank?

      @posts = @posts.where(category: params[:category])
    end

    def filter_by_status
      return if params[:status].blank?

      @posts = @posts.where(status: params[:status])
    end

    def filter_by_author
      return if params[:author_id].blank?

      @posts = @posts.where(user_id: params[:author_id])
    end

    def filter_by_search
      query = params[:query].to_s.strip.downcase

      return if query.blank?

      matching_ids = []

      Post.pluck(:id, :title).each do |id, title|
        matching_ids << id if title.downcase.include?(query)
      end

      @posts = @posts.where(id: matching_ids)
    end

    def set_post
      @post = Post.with_attached_cover.find(params[:id])
    end

    def post_params
      params.expect(post: [:title, :body, :status, :category, :cover])
    end

    def update_published_at(post)
      if post.status == "published"
        post.published_at ||= Time.current
      else
        post.published_at = nil
      end
    end
  end
end