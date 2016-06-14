class CommentPolicy < ApplicationPolicy

  def update?
    owner? and !@time_to_edit.past?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

end
