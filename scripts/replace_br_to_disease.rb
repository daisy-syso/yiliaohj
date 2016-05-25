# def replace_to_br(disease)
#   disease.description.gsub!("\r\n\t", "<br/>")
#   disease.etiology.gsub!("\r\n\t", "<br/>")
#   disease.treatent.gsub!("\r\n\t", "<br/>")
#   disease.prevention.gsub!("\r\n\t", "<br/>")
#   disease.diet.gsub!("\r\n\t", "<br/>")
#   disease.symptom.gsub!("\r\n\t", "<br/>")
#   disease.examination.gsub!("\r\n\t", "<br/>")
#   disease.save
# end

# def clear_description(disease)
#   disease.description.gsub!("　　", '<br />')
#   disease.save
# end

Disease.all.each_slice(100) do |diseases|
  diseases.each do |d|
    puts "#{d.id.to_s}"
    puts replace_to_br(d)
    puts clear_description(d)

    disease.description.gsub!("\r\n\t", "<br/>")
    disease.etiology.gsub!("\r\n\t", "<br/>")
    disease.treatent.gsub!("\r\n\t", "<br/>")
    disease.prevention.gsub!("\r\n\t", "<br/>")
    disease.diet.gsub!("\r\n\t", "<br/>")
    disease.symptom.gsub!("\r\n\t", "<br/>")
    disease.examination.gsub!("\r\n\t", "<br/>")

    disease.description.gsub!("　　", '<br />')
    disease.save
  end
end