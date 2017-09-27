module Slugifiable
  module InstanceMethod
    def slug
      self.username.downcase.gsub(" ", "-")
    end
  end

  module ClassMethod
    def find_by_slug(slug)
      self.all.detect{|obj| obj.slug == slug}
    end
  end
end