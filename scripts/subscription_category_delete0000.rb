SubscriptionCategory.all.each_with_index do |s, index|
  next unless s.parent_id == BSON::ObjectId('000000000000000000000000')
  s.parent_id = nil
  puts s.save
  puts index
end
