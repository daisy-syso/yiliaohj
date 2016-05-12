Disease.all.each do |h|
  h.each do |h|
    information_ids = h.information_ids
    if information_ids.class.name == 'String'
      h.information_ids = information_ids.split(',')
      puts h.save
    end
  end
end