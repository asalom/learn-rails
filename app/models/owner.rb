class Owner

  def name
    name = 'Alex Salom'
  end

  def birthdate
    birthdate = Date.new(1987, 1, 16)
  end

  def countdown
    today = Date.today
    birthday = Date.new(today.year, birthdate.month, birthdate.day)
    if birthday > today
      countdown = (birthday - today).to_i
    else
      countdown = (birthday.next_year - today).to_i
    end
  end
end