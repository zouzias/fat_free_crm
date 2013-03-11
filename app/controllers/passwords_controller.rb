# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class PasswordsController < Devise::PasswordsController

  respond_to :html
  append_view_path 'app/views/devise'

#  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]
#  before_filter :require_no_user
#
#  #----------------------------------------------------------------------------
#  def new
#    # <-- render new.html.haml
#  end
#
#  #----------------------------------------------------------------------------
#  def create
#    @user = User.find_by_email(params[:email])
#    if @user
#      @user.deliver_password_reset_instructions!
#      flash[:notice] = t(:msg_pwd_instructions_sent)
#      redirect_to root_url
#    else
#      flash[:notice] = t(:msg_email_not_found)
#      redirect_to :action => :new
#    end
#  end

    def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])
#      @user.deliver_password_reset_instructions!

    if resource.errors.empty?
      flash[:notice] = t(:msg_pwd_instructions_sent)
#      set_flash_message(:notice, :send_instructions) if is_navigational_format?
      redirect_to root_url
      # respond_with resource, :location => new_session_path(resource_name)
    else

      # Redirect to custom page instead of displaying errors
      # redirect_to my_custom_page_path
      Rails.logger.info(resource.errors.inspect)
      flash[:notice] = t(:msg_email_not_found)
      redirect_to root_url

      # respond_with_navigational(resource){ render_with_scope :new }

    end
  end

  #
#  #----------------------------------------------------------------------------
#  def edit
#    # <-- render edit.html.haml
#  end
#
#  #----------------------------------------------------------------------------
#  def update
#    if empty_password?
#      flash[:notice] = t(:msg_enter_new_password)
#      render :edit
#    elsif @user.update_attributes(params[:user])
#      flash[:notice] = t(:msg_password_updated)
#      redirect_to profile_url
#    else
#      render :edit
#    end
#  end
#
#  #----------------------------------------------------------------------------
#  private
#  def load_user_using_perishable_token
#    @user = User.find_using_perishable_token(params[:id])
#    unless @user
#      flash[:notice] = <<-EOS
#        Sorry, we could not locate your user profile. Try to copy and paste the URL
#        from your email into your browser or restart the reset password process.
#      EOS
#      redirect_to root_url
#    end
#  end
#
#  #----------------------------------------------------------------------------
#  def empty_password?
#    (params[:user][:password] == params[:user][:password_confirmation]) &&
#    (params[:user][:password] =~ /^\s*$/)
#  end
end
