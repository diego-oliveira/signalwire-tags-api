module Api::V1::Ticket::Contracts
  class Create < Reform::Form
    feature Reform::Form::Dry
    property :title
    property :user_id

    property :tags,
      populator: -> (fragment:, collection:, **) do
        fragment.each do |tag|
          tags.append(Tag.find_or_initialize_by(name: tag.downcase))
        end
      end

    validation do
      params do
        required(:title).filled
        required(:user_id).filled
        optional(:tags)
      end

      rule(:tags) do
        if values[:tags].size > 5
          base.failure('Max of five tags exceeded')
        end
      end
    end
  end
end
