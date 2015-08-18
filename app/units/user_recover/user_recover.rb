module UserRecover
  include Chanko::Unit

  scope(:controller) do
    function(:recover) do
      @user = User.find(params[:id])
      @user.unit.recover
      redirect_to users_path
    end
  end

  scope(:view) do
    function(:recover_link) do
      render '/recover_link', user: user if user.persisted? && user.deleted_at
    end
  end

  models do
    expand(:User) do
      def recover
        update_attributes(deleted_at: nil)
      end
    end
  end

  helpers do
    def link_to_recover(user)
      link_to 'Recover', recover_user_path(user), method: :patch
    end
  end
end
