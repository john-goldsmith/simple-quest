class String

  def titleize
    self.dup.split.map(&:capitalize).join(" ")
  end

end