Disease.all.each_slice(100) do |h|
  h.each do |h|
    drug_names = h.drug_names
    if drug_names.class.name == 'String'
      h.drug_names = drug_names.split(',')
      puts h.save
    end
  end
end
