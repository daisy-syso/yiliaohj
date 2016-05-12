Disease.all.each do |h|
  h.each do |h|
    doctor_ids = h.doctor_ids
    if doctor_ids.class.name == 'String'
      h.doctor_ids = doctor_ids.split(',')
      puts h.save
    end
  end
end