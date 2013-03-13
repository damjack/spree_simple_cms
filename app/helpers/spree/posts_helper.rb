module Spree
  module PostsHelper
    
    def preview_content(post, limit = 300)
      raw(truncate(strip_tags(post.body.strip).strip,:length => limit))
    end

    def post_date(post)
      post.published_at.strftime("%d/%m/%d %H:%M")
    end

    def tag_link(tag)
      link_to(tag.name, posts_path + "?tag=#{tag.name}")
    end

  end
end