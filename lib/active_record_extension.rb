module ActiveRecordExtension

  extend ActiveSupport::Concern

  # add your instance methods here
  def foo
     "foo"
  end

  # add your static(class) methods here
  module ClassMethods
    def self.search(params)
			metasearch(params[:search])
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)