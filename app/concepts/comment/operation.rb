class Comment < ApplicationRecord
  class Create < Trailblazer::Operation
    include Model
    model Comment, :create

    contract do
      def self.weights
        { 0 => 'Nice!', 1 => 'Rubbish!' }
      end

      def weights
        [ self.class.weights.to_a, :first, :last ]
      end

      property :body
      property :weight, prepopulator: ->(*){ self.weight = 0 }
      property :thing

      validates :body, length: { in: 6..100 }
      validates :weight, inclusion: { in: weights.keys }
      validates :thing, :user, presence: true

      property :user do
        property :email
        validates :email, presence: true, email: true
      end
    end

    def process(params)
      validate(params[:comment]) do |f|
        f.save
      end
    end

    def thing
      model.thing
    end


    private


    def setup_model!(params)
      model.thing = Thing.find_by_id(params[:thing_id])
      model.build_user
    end
  end
end