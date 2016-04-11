module Frontend
  class HospitalsController < FrontendController
    # 离我最近 最近发布 人气最高 评价最好
    def index
      params ||= {}
      lat, lon = $redis_position.get(request.remote_ip).split(',').map(&:to_f)
      
      params = params.merge({location: {lat: lat, lon: lon}})
      @hospitals = SearchService.search(params, 'hospital').records.to_a
    end

    def show
      @hospital = Hospital.find(params[:id])

      @comment = @hospital.comments.desc(:created_at).first

      # @doctors = @hospital.doctors.includes(:department)

      # @doctor_categories = @doctors.collect do |d|
      #   d.department.parent
      # end.uniq.compact
    end
  end
end


# (&:department).uniq#.includes(:parent).map(&:parent).compact
# doctors.map(&:department).map(&:parent)

# doctors = Hospital.find('56f633b4e8f1112870ccc010').doctors

# doctors.map(&:department).map(&:parent).compact.map(&:name).uniq

# includes(:parent)