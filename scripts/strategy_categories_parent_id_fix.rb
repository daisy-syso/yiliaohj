StrategyCategory.all.each do |s|
  if s.parent_id.to_s == "000000000000000000000000"
    s.parent_id = nil
    puts s.save
  end
end