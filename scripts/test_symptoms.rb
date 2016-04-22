s = Symptom.new
s.name = '测试'
s.english = 'c'
s.save

s = Symptom.new
s.name = '大测试'
s.english = 'd'
s.save

s = Symptom.new
s.name = '小时测试'
s.english = 'x'
s.save

s = Symptom.new
s.name = '不测试'
s.english = 'b'
s.save

s = Symptom.new
s.name = '阿测试'
s.english = 'a'
s.save

Symptom.all.to_a
