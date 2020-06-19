class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  # Check if the current user has permission to change the host
  def change_host?
    user.is_host?(record)
  end
end