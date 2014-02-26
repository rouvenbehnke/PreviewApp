class NullUser
  attr_reader :id

  def logged_in?
    false
  end

  def admin?
    false
  end
end
