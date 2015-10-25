module FloatNumber

  def is_number?(string)
    true if Float(string) rescue false
  end

end