class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end
    #ログイン中にできない動作
    def only_logged_in
        if @current_user
            flash[:notice] ="すでにログインをしています"
            redirect_to("/posts/index")
        end
    end
    #ログイン状態の時のみにできる動作
    def not_only_logge_in
        if @current_user == nil
            flash[:notice] ="ログインが必要です"
            redirect_to("/users/login")
        end 
    end
end
