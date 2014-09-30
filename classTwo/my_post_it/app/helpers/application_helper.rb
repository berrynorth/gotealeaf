module ApplicationHelper
  def fix_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end

  def pretty_datetime(dt)
    # formats "2014-07-04 10:45:22 UTC" to "07/04/2014 10:45pm UTC"
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime("%m/%d/%Y at %l:%M%P %Z")
  end
end