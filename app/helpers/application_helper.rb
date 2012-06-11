module ApplicationHelper
  def resource_class
    devise_mapping.to
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
  
  def load_review(user)
    review = "<h3>What other people think about #{@user.name} </h3>"
    review += '<table class = "table table-condensed">'
    review += "<tr>"
    review += "<th>Date</th>"
    review += "<th>Rating</th>"
    review += "<th>Comment</th>"
    review += "</tr>"
    user.reviews.each do |ur|
      review += "<tr>"
        review += "<td>#{ur.created_at.to_date}</td>"
        review += "<td>Put user rating here</td>"
        review += "<td>#{ur.comment}</td>"
      review += "</tr>"
    end
    review += "</table>"
    
    return review.html_safe
  end
end
