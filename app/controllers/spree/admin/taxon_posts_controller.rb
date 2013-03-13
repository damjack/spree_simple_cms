module Spree
  module Admin
    class TaxonPostsController < Spree::Admin::BaseController

      respond_to :html, :json, :js

      def search
        if params[:ids]
          @taxons = Spree::TaxonPost.where(:id => params[:ids].split(','))
        else
          @taxons = Spree::TaxonPost.limit(20).search(:name_cont => params[:q]).result
        end
      end

      def create
        @taxonomy_post = TaxonomyPost.find(params[:taxonomy_post_id])
        @taxon_post = @taxonomy_post.taxon_posts.build(params[:taxon_post])
        if @taxon_post.save
          respond_with(@taxon_post) do |format|
            format.json {render :json => @taxon_post.to_json }
          end
        else
          flash[:error] = t('errors.messages.could_not_create_taxon_post')
          respond_with(@taxon_post) do |format|
            format.html { redirect_to @taxonomy_post ? edit_admin_taxonomy_post_url(@taxonomy_post) : admin_taxonomy_posts_url }
          end
        end
      end

      def edit
        @taxonomy_post = TaxonomyPost.find(params[:taxonomy_post_id])
        @taxon_post = @taxonomy_post.taxon_posts.find(params[:id])
        @permalink_part = @taxon_post.permalink.split("/").last

        respond_with(:admin, @taxon)
      end

      def update
        @taxonomy_post = TaxonomyPost.find(params[:taxonomy_id])
        @taxon_post = @taxonomy_post.taxon_posts.find(params[:id])
        parent_id = params[:taxon_post][:parent_id]
        new_position = params[:taxon_post][:position]

        if parent_id || new_position #taxon is being moved
          new_parent = parent_id.nil? ? @taxon_post.parent : TaxonPost.find(parent_id.to_i)
          new_position = new_position.nil? ? -1 : new_position.to_i

          # Bellow is a very complicated way of finding where in nested set we
          # should actually move the taxon to achieve sane results,
          # JS is giving us the desired position, which was awesome for previous setup,
          # but now it's quite complicated to find where we should put it as we have
          # to differenciate between moving to the same branch, up down and into
          # first position.
          new_siblings = new_parent.children
          if new_position <= 0 && new_siblings.empty?
            @taxon_post.move_to_child_of(new_parent)
          elsif new_parent.id != @taxon.parent_id
            if new_position == 0
              @taxon_post.move_to_left_of(new_siblings.first)
            else
              @taxon_post.move_to_right_of(new_siblings[new_position-1])
            end
          elsif new_position < new_siblings.index(@taxon_post)
            @taxon_post.move_to_left_of(new_siblings[new_position]) # we move up
          else
            @taxon_post.move_to_right_of(new_siblings[new_position-1]) # we move down
          end
          # Reset legacy position, if any extensions still rely on it
          new_parent.children.reload.each{|t| t.update_column(:position, t.position)}

          if parent_id
            @taxon_post.reload
            @taxon_post.set_permalink
            @taxon_post.save!
            @update_children = true
          end
        end

        if params.key? "permalink_part"
          parent_permalink = @taxon_post.permalink.split("/")[0...-1].join("/")
          parent_permalink += "/" unless parent_permalink.blank?
          params[:taxon_post][:permalink] = parent_permalink + params[:permalink_part]
        end
        #check if we need to rename child taxons if parent name or permalink changes
        @update_children = true if params[:taxon_post][:name] != @taxon_post.name || params[:taxon_post][:permalink] != @taxon.permalink

        if @taxon_post.update_attributes(params[:taxon_post])
          flash[:success] = flash_message_for(@taxon_post, :successfully_updated)
        end

        #rename child taxons
        if @update_children
          @taxon_post.descendants.each do |taxon|
            taxon.reload
            taxon.set_permalink
            taxon.save!
          end
        end

        respond_with(@taxon_post) do |format|
          format.html {redirect_to edit_admin_taxonomy_post_url(@taxonomy_post) }
          format.json {render :json => @taxon_post.to_json }
        end
      end

      def destroy
        @taxon_post = TaxonPost.find(params[:id])
        @taxon_post.destroy
        respond_with(@taxon_post) { |format| format.json { render :json => '' } }
      end
      
    end
  end
end