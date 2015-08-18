module UserDeletion
  include Chanko::Unit

  scope(:view) do
    function(:delete_link) do
      render '/delete_link', user: user if user.persisted?
    end
  end

  scope(:controller) do
    function(:destroy) do
      user = User.find(params[:id])
      user.unit.soft_delete
      redirect_to users_path
    end

    function(:index) do
      @active_users = User.unit.active
      @inactive_users = User.unit.inactive
    end
  end

  models do
    expand(:User) do
      scope :active, -> { where(deleted_at: nil) }
      scope :inactive, -> { where.not(deleted_at: nil) }
 
      def soft_delete
        update_attributes(deleted_at: Time.zone.now)
      end
    end
  end

  helpers do
    def link_to_deletion(user)
      link_to 'Delete', user, method: :delete
    end
  end
end
