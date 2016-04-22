# %w(ConfinementCenter DrugStore Hospital NursingRoom Medical Maternity InsuranceCompany).each do |klass|
%w(Medical Maternity InsuranceCompany).each do |klass|
  klass.constantize.all.each_with_index do |h, index|
    next unless h.location.present?
    puts index
    location = h.location.split(',')
    h.coordinates = [location[1].to_f, location[0].to_f]
    h.save
  end
end

# ConfinementCenter.all.each_with_index do |h, index|
#   if h.location.present?
#     puts index
#     location = h.location.split(',')
#     h.coordinates = [location[1].to_f, location[0].to_f]
#     h.save
#   end
# end

# DrugStore.all.each_with_index do |h, index|
#   if h.location.present?
#     puts index
#     location = h.location.split(',')
#     h.coordinates = [location[1].to_f, location[0].to_f]
#     h.save
#   end
# end

# Hospital.all.each_with_index do |h, index|
#   if h.location.present?
#     puts index
#     location = h.location.split(',')
#     h.coordinates = [location[1].to_f, location[0].to_f]
#     h.save
#   end
# end

# NursingRoom.all.each_with_index do |h, index|
#   if h.location.present?
#     puts index
#     location = h.location.split(',')
#     h.coordinates = [location[1].to_f, location[0].to_f]
#     h.save
#   end
# end

# Medical.all.each_with_index do |h, index|
#   if h.location.present?
#     puts index
#     location = h.location.split(',')
#     h.coordinates = [location[1].to_f, location[0].to_f]
#     h.save
#   end
# end

# Maternity.all.each_with_index do |h, index|
#   if h.location.present?
#     puts index
#     location = h.location.split(',')
#     h.coordinates = [location[1].to_f, location[0].to_f]
#     h.save
#   end
# end

# InsuranceCompany.all.each_with_index do |h, index|
#   if h.location.present?
#     puts index
#     location = h.location.split(',')
#     h.coordinates = [location[1].to_f, location[0].to_f]
#     h.save
#   end
# end
