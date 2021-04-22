module VisitDetails
    class VisitDetailsPresenter < ::ApplicationPresenter
      def props
        {
          current_user_name: current_user.full_name,
          # current_user_id: current_user.id,
          current_user_role: current_user.role
        } 
      end
    end
  end
  