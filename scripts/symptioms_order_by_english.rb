symptom_first_chars = Symptom.all.asc(:english).pluck(:english).collect {|c| c[0]}.uniq

symptom_first_chars.each do |char|
  Symptom.where(english: /^#{char}/).asc(:english).each do |s|
    puts s.english
    $redis_symptoms.rpush char, "#{s.id.to_s},#{s.name}"
  end
end

$redis_symptoms.lrange('A', 0, -1)