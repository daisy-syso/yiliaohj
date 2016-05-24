Disease.all.each do |disease|
	p disease.id
  p replace_to_br(disease)
end

def replace_to_br(disease)
  disease.description = disease.description.gsub("\r\n\t", "<br/>")
  disease.etiology 	  = disease.etiology.gsub("\r\n\t", "<br/>")
  disease.treatent    = disease.treatent.gsub("\r\n\t", "<br/>")
  disease.prevention  = disease.prevention.gsub("\r\n\t", "<br/>")
  disease.diet        = disease.diet.gsub("\r\n\t", "<br/>")
  disease.symptom     = disease.symptom.gsub("\r\n\t", "<br/>")
  disease.save
end