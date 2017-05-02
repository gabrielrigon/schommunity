class ProfilesController < InheritedResources::Base
  # ---- layout ----

  layout 'admin'

  # ---- devise ----

  before_filter :authenticate_user!
  load_and_authorize_resource class: :user_profile

  # ---- methods ----

  def resource
    @user ||= current_user
  end

  # ---- actions ----

  def edit
    resource.build_address if resource.address.blank?
  end

  def update
    if resource.update_attributes(user_parameters)
      redirect_to profile_path, notice: 'Perfil atualizado com sucesso'
    else
      render :edit
    end
  end

  private

  def user_parameters
    params.require(:user)
          .permit(:avatar, :first_name, :last_name, :phone, :gender_id, :email,
                  student_attributes: [:number],
                  address_attributes: [:street, :number, :complement, :district,
                                       :city_id, :state_id, :zipcode])
  end
end
