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

    job_position_type_array = ["Road Show","Promoter","Distributor"]
    counter = 1
    limit = 4
    achievement += "<table>"
      job_position_type_array.each do |jp|
        ujc = user.jobs.where(position: jp).count
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
    review = "<div class='rating-section clear'>"
    review += "<h2 class='content-title trating'><i>&nbsp;</i>What other people think about #{user.name} </h2>"
    review += '<hr class="divider dashed">'
    user.reviews.each do |ur|
      review += "<div class='reviews'>"
      posted_by = User.where(:username => ur.post_by).all.first
      if user.is_a?(User)
        if !posted_by.cover_image_uid.nil?
          review += image_tag(posted_by.cover_image.url, :size => "40x40", :class => "reviews-img")
        elsif !posted_by.fb_profile_pic.nil?
          review += image_tag(posted_by.fb_profile_pic, :size => "40x40", :class => "reviews-img")
        else
          review += image_tag("default-profile-photo.png", :size => "40x40", :class => "reviews-img")
        end
      end
      review += "<div class='reviews-details'>"
      review += "<h5>" + ur.post_by + "</h5>"
      review += '<span class="reviews-date">' + ur.created_at.to_date.to_s + '</span>'
      review += '<span class="reviews-rating">'
      rating_title = ["Bad", "Poor", "Regular","Good","Awesome"]
      count = 0
      while (count < (ur.rating||0))
        review += image_tag("ratings-on.png", :title => "#{rating_title[count]}", :size => "15x15", :class => "rating-star")
        count = count + 1
      end
      while (count != 5)
        review += image_tag("ratings-off.png", :title => "#{rating_title[count]}", :size => "15x15", :class => "rating-star")
        count = count + 1
      end
      review += '</span>'
      review += '<p class="reviews-comment">' + ur.comment + '</p>'
      review += "</div>"
      review += "</div>"
      review += '<hr class="divider dashed">'
    end
    review += "</div>"
    
    return review.html_safe
  end
  
  def load_nearest_job_map
    nearest_job_map = ''
    
    return nearest_job_map.html_safe

  end
  
end
