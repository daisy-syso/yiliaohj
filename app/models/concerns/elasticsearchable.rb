module Elasticsearchable
  extend ActiveSupport::Concern

  included do

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    self.__elasticsearch__.client = 
      Elasticsearch::Client.new hosts: Settings.elasticsearch.hosts, logger: Logger.new(Rails.root.join Settings.elasticsearch.log)
  end
end