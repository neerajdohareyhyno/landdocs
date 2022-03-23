# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
base_uri = 'https://dharani.telangana.gov.in/'

def land_records(base_uri, district_id, mandal_id, village_id, survey_no, khata_no)
  
  land_record_url = Addressable::URI.parse(base_uri+"/getPublicDataInfo?villageId=#{village_id}&flagToSearch=surveynumber&searchData=#{survey_no}&flagval=district&district=#{district_id}&mandal=#{mandal_id}&divi=&khataNoIdselect=#{khata_no}&ReqType=Citizen").display_uri.to_s
  puts land_record_url

  land_record = {district_name: "", district_telegu_name: "", mandal_name: "", mandal_telegu_name: "", village_name: "", village_telegu_name: "", survey_no: "", pattadar_name: "", father_husband_name: "", total_extent: "", land_status: "", land_type: "", nature_of_land: "", classification_of_land: "", market_value_of_survey_no_inr: "", transaction_status: "", ppb_no: ""}

  land_record_response = HTTParty.get(land_record_url)
  land_record_body = land_record_response.body
  str_senitize = land_record_body.gsub(/\t/, '').gsub(/\r/, '').gsub(/\n/, '')
  land_record_arr = str_senitize.split('<div class="row p-3">')
  land_record_arr.each_with_index do |lr, index|
    next if index == 0
    sm4 = lr.match(/<div class="col-12 col-sm-4">/)
    sm8 = lr.match(/<div class="col-12 col-sm-8">/)
    last = lr.match(/script/)
    
    if sm8.present?
      if  lr.match(/<div class="col-12 col-sm-4">/)
        lr5 = lr.split('<div class="col-12 col-sm-4">')
        transaction_status = lr.split('<ahref=')[0].split("<br>")
        ekyc_status = lr5[1].split('</div>')[0].split('<br>')
      else
        lr5 = lr.split('<div class="col-12 col-sm-3">')
        transaction_status = lr.split('<ahref=')[0].split("<br>")
        ekyc_status = lr5[1].split('</div>')[0].split('<br>')
      end
      land_record[:transaction_status] = transaction_status[1].strip
      # land_record[:ekyc_status] = ekyc_status[1].strip
    elsif last.present?
      lr6 = lr.split("</div></div></div></div></form><script></script></body></html>")[0].split("<br>")
      ppb_no = lr6[1] 
      land_record[:ppb_no] = ppb_no[1].strip
    elsif sm4.present?
      lr1 = lr.split('<div class="col-12 col-sm-4">')
      lr1.each_with_index do |lan_rec, r_index|
        next if r_index == 0
        rec = lan_rec.split('</div>')[0].split('<br>')
        if lan_rec.match(/District/)
          district = rec[1].split('|')
          land_record[:district_name] = district[0].strip
          land_record[:district_telegu_name] = district[1].strip
        elsif lan_rec.match(/Mandal/)
          mandal = rec[1].split('|')
          land_record[:mandal_name] = mandal[0].strip
          land_record[:mandal_telegu_name] = mandal[1].strip
        elsif lan_rec.match(/Village/)
          village = rec[1].split('|')
          land_record[:village_name] = village[0].strip
          land_record[:village_telegu_name] = village[1].strip
        elsif lan_rec.match(/Survey No/)
          land_record[:survey_no] = rec[1].strip
        elsif lan_rec.match(/Pattadar Name/)
          land_record[:pattadar_name] = rec[1].strip
        elsif lan_rec.match(/Husband's Name/)
          land_record[:father_husband_name] = rec[1].strip
        elsif lan_rec.match(/Total Extent/)
          land_record[:total_extent] = rec[1].strip
        elsif lan_rec.match(/Land Status/)
          land_record[:land_status] = rec[1].strip
        elsif lan_rec.match(/Land Type/)
          land_record[:land_type] = rec[1].strip
        elsif lan_rec.match(/Nature of Land/)
          land_record[:nature_of_land] = rec[1].strip
        elsif lan_rec.match(/Classification of Land/)
          land_record[:classification_of_land] = rec[1].strip
        elsif lan_rec.match(/Market value of Survey/)
          land_record[:market_value_of_survey_no_inr] = rec[1].strip
        end
      end
    end
  end
  # land_record_arr.each_with_index do |lr, index|
  #   next if index == 0
  #   if index == 1
  #     lr1 = lr.split('<div class="col-12 col-sm-4">')
  #     district = lr1[1].split('</div>')[0].split('<br>')[1].split('|')
  #     mandal = lr1[2].split('</div>')[0].split('<br>')[1].split('|')
  #     village = lr1[3].split('</div>')[0].split('<br>')[1].split('|')
  #     lr1_hash = { district_name:  district[0], district_telegu_name: district[1], mandal_name: mandal[0], mandal_telegu_name: mandal[1], village_name:  village[0], village_telegu_name: village[1]}
  #     land_record.merge!(lr1_hash)
  #   elsif index == 2
  #     lr2 = lr.split('<div class="col-12 col-sm-4">')
  #     survey_no = lr2[1].split('</div>')[0].split('<br>')
  #     pattadar_name = lr2[2].split('</div>')[0].split('<br>')
  #     father_husband_name = lr2[3].split('</div>')[0].split('<br>')
  #     lr2_hash = { survey_no:  survey_no[1], pattadar_name: pattadar_name[1], father_husband_name: father_husband_name[1]}
  #     land_record.merge!(lr2_hash)
  #   elsif index == 3
  #     lr3 = lr.split('<div class="col-12 col-sm-4">')
  #     total_extent = lr3[1].split('</div>')[0].split('<br>')
  #     land_status = lr3[2].split('</div>')[0].split('<br>')
  #     land_type = lr3[3].split('</div>')[0].split('<br>')
  #     lr3_hash = { total_extent:  total_extent[1], land_status: land_status[1], land_type: land_type[1]}
  #     land_record.merge!(lr3_hash)
  #   elsif index == 4
  #     lr4 = lr.split('<div class="col-12 col-sm-4">')
  #     nature_of_land = lr4[1].split('</div>')[0].split('<br>')
  #     classification_of_land = lr4[2].split('</div>')[0].split('<br>')
  #     market_value_of_survey_no_inr = lr4[3].split('</div>')[0].split('<br>')
  #     lr4_hash = { nature_of_land:  nature_of_land[1], classification_of_land: classification_of_land[1], market_value_of_survey_no_inr: market_value_of_survey_no_inr[1]}
  #     land_record.merge!(lr4_hash)
  #   elsif index == 5
  #     lr5 = lr.split('<div class="col-12 col-sm-4">')
  #     transaction_status = lr.split('<ahref=')[0].split("<br>")
  #     ekyc_status = lr5[1].split('</div>')[0].split('<br>')      
  #     lr5_hash = { transaction_status:  transaction_status[1], ekyc_status: ekyc_status[1]}
  #     land_record.merge!(lr5_hash)
  #   elsif index == 6
  #     lr6 = lr.split("</div></div></div></div></form><script></script></body></html>")[0].split("<br>")
  #     ppb_no = lr6[1] 
  #     lr6_hash = { ppb_no:  ppb_no[1]}
  #     land_record.merge!(lr6_hash)
  #   end
  # end
  return land_record
end

def log_generator(log)
  path = Rails.root.join('log')
  file_path = path + "seed.log"
  file = File.new(file_path, "a")
  file.puts(log)
  file.close
end

(1..35).each do |i|
  district = District.find_or_create_by(dist_id: i, name: i)
  log_generator("District - #{i}")
  if district.present?
    # binding.break
    log_generator("=> District - created")
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
      mandal = Mandal.find_or_create_by(district_id: district.id, mand_id: value[1], name: name[0], telgu_name: name[1])
      log_generator("District - #{i}, Mandal - #{value[1]}")
      if mandal.present?
        log_generator("=> Mandal - created")
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
          village = Village.find_or_create_by(mandal_id: mandal.id, vill_id: v_value[1], name: v_name[0], telgu_name: v_name[1])
          log_generator("District - #{i}, Mandal - #{value[1]}, Village- #{v_value[1]}")
          if village.present?
            log_generator("=> Village - created")
            survy_url = base_uri+"/getSurveyCitizen?villId=#{village.vill_id}&flag=survey"
            survy_response = HTTParty.get(survy_url)
            survy_body = survy_response.body
            survy_arr = survy_body.split('<body>')
            survy_str_senitize = survy_arr[1].gsub(/\t/, '').gsub(/\r/, '').gsub(/\n/, '')
            survy_name = survy_str_senitize.split("</option>")
            
            survy_name.first(6).each_with_index do |s_name, s_index|
              next if s_index == 0
              next if survy_name.size-1 == s_index
              s_value_name = s_name.split('>')
              puts s_value_name[1]
              kahata_url = Addressable::URI.parse(base_uri+"/getKhataNoCitizen?villId=#{village.vill_id}&flag=khatanos&surveyNo=#{s_value_name[1]}").display_uri.to_s
              puts kahata_url
              kahata_response = HTTParty.get(kahata_url)
              kahata_body = kahata_response.body
              kahata_arr = kahata_body.split('<body>')
              kahata_senitize = kahata_arr[1].gsub(/\t/, '').gsub(/\r/, '').gsub(/\n/, '')
              kahata_nos = kahata_senitize.split("</option>")
              kahata_nos.each_with_index do |k_no, k_index|

                next if k_index == 0
                next if kahata_nos.size-1 == k_index
                kahata_no = k_no.split('>')
                survey = Survey.find_or_create_by(village_id: village.id, survey_no: s_value_name[1], khata_no: kahata_no[1])
                log_generator("District - #{i}, Mandal - #{value[1]}, Village- #{v_value[1]}, Survey - #{s_value_name[1]}, kahata_no - #{kahata_no[1]}")
                if survey.present?
                  log_generator("=> Survey - created")
                  land_record_hash = land_records(base_uri, district.dist_id, mandal.mand_id, village.vill_id, survey.survey_no, kahata_no[1])
                  land_record_hash.merge!({survey_id: survey.id})
                  land_record = LandRecord.find_or_create_by(land_record_hash)
                  log_generator("=> LandRecord - created") if land_record.present?
                  puts land_record.inspect
                end
              end
            end
          end
        end
      end
    end
    # binding.break
  end
end

