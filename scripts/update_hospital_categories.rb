Hospital.all.each_slice(100) do |h|
  category = h.categories
  h.categories = category.split(',')
  h.save
end