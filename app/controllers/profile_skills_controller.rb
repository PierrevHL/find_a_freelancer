class ProfileSkillsController < ApplicationController

  def update
    @profile_skill = ProfileSkill.find(params[:id])
    if @profile_skill.update(profile_skill_params)
      redirect_to profile_path(@profile_skill.profile)
    else
      render :new
    end
  end

  def destroy
    @profile_skill = ProfileSkill.find(params[:id])
    @profile_skill.destroy
    redirect_to profile_path(@profile_skill.profile)
  end

private

  def profile_skill_params
    params.require(:profile_skill).permit(:rate)
  end
end
