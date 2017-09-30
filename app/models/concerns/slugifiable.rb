module Slugifiable
  module InstanceMethodUsername
    def slug
      self.username.downcase.gsub(" ", "-")
    end
  end

  module InstanceMethodName
    def slug
      self.name.downcase.gsub(" ", "-")
    end
  end

  module ClassMethod
    def find_by_slug(slug)
      self.all.detect{|obj| obj.slug == slug}
    end
  end
end
