Disease.all.each do |h|
  hospital_ids = h.hospital_ids
  if hospital_ids.class.name == 'String'
    h.hospital_ids = hospital_ids.split(',')
    puts h.save
  end
end
