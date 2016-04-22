Hospital.all.each_slice(100) do |h|
  h.each do |h|
    category = h.categories
    if category.class.name == 'String'
      h.categories = category.split(',')
      puts h.save
    end
  end
end
