module ApplicationHelper
  def resource_class
    "User".constantize
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def load_achievement(user)
    achievement = "<h3>My Experience Achievement</h3>"

    job_post_type_array = ["Road Show","Promoter","Distributor"]
    counter = 1
    limit = 4
    achievement += "<table>"
      job_post_type_array.each do |jp|
        ujc = user.jobs.where(post: jp).count
        if ujc != 0
          if counter == 1
            achievement += "<tr>"
              achievement += "<td>" + image_tag(jp+ujc.to_s+".png", :size => "100x100", :title => "Have experience working as #{jp + " " + ujc.to_s} time") + "</td>"
            counter = counter + 1
          elsif counter == limit
              achievement += "<td>" + image_tag(jp+ujc.to_s+".png", :size => "100x100", :title => "Have experience working as #{jp + " " + ujc.to_s} time") + "</td>"
            achievement += "</tr>"
            counter = 0
          elsif counter != 1
            achievement += "<td>" + image_tag(jp+ujc.to_s+".png", :size => "100x100", :title => "Have experience working as #{jp + " " + ujc.to_s} time") + "</td>"
            counter = counter + 1
          end
        end
      end
    achievement += "</table>"
  
    return achievement.html_safe
  end
end
