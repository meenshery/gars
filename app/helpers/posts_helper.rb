module PostsHelper
  def admin_post_cover_source(post)
    if post.cover.attached? && post.cover.blob.persisted?
      url_for(post.cover)
    elsif post.cover_filename.present?
      filename = post.cover_filename.strip
      filename += ".webp" if File.extname(filename).blank?

      image_path("posts/#{filename}")
    end
  end
end