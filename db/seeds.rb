# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
base_uri = 'https://dharani.telangana.gov.in/'
(1..1).each do |i|
  district = District.new(dist_id: i, name: i)
  if district.save
    uri = base_uri+"/getMandalFromDivisionCitizenPortal?district=#{i}"
    mandal_response = HTTParty.get(uri)
    mandal_body = mandal_response.body
    mandal_arr = mandal_body.split('<body>')
    str_senitize = mandal_arr[1].gsub(/\t/, '').gsub(/\r/, '').gsub(/\n/, '')
    mandal_name = str_senitize.split("</option>")
    mandal_name.each_with_index do |name, index|
      next if index == 0
      next if mandal_name.size-1 == index
      m_value_name = name.split('">')
      value = m_value_name[0].split("\"")
      name = m_value_name[1].split("|")
      mandal = Mandal.new(district_id: district.id, mand_id: value[1], name: name[0], telgu_name: name[1])
      if mandal.save
        village_uri = base_uri+"/getVillageFromMandalCitizenPortal?mandalId=#{mandal.mand_id}"
        village_response = HTTParty.get(village_uri)
        village_body = village_response.body
        village_arr = village_body.split('<body>')
        village_str_senitize = village_arr[1].gsub(/\t/, '').gsub(/\r/, '').gsub(/\n/, '')
        village_name = village_str_senitize.split("</option>")
        village_name.each_with_index do |v_name, v_index|
          next if v_index == 0
          next if village_name.size-1 == v_index
          v_value_name = v_name.split('">')
          v_value = v_value_name[0].split("\"")
          v_name = v_value_name[1].split("|")
          puts v_value[1], v_name.inspect
          village = Village.new(mandal_id: mandal.id, vill_id: v_value[1], name: v_name[0], telgu_name: v_name[1])
          if village.save
            survy_url = base_uri+"/getSurveyCitizen?villId=#{village.vill_id}&flag=survey"
            survy_response = HTTParty.get(survy_url)
            survy_body = survy_response.body
            survy_arr = survy_body.split('<body>')
            survy_str_senitize = survy_arr[1].gsub(/\t/, '').gsub(/\r/, '').gsub(/\n/, '')
            survy_name = survy_str_senitize.split("</option>")
            
            survy_name.each_with_index do |s_name, s_index|
              # binding.break
              next if s_index == 0
              next if survy_name.size-1 == s_index
              s_value_name = s_name.split('>')
              puts s_value_name[1]
              survey = Survey.new(village_id: village.id, survey_no: s_value_name[1] )
              survey.save
              # binding.break
            end
          end
        end
      end
    end
    # binding.break
  end
end