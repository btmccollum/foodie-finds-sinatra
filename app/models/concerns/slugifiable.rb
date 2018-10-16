module Slugifiable
    def slug
        self.username.gsub(" ", "-")
    end

    module ClassMethods
        def find_by_slug(slug)
            self.all.find do |obj|
                slug.gsub("-", " ") == obj.username
            end
        end
    end
end