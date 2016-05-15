Drug.all.each_slice(100) do |d|
  d.each_with_index do |h, index|
    puts index
    h.name = h.name.strip
    h.save
  end
end
