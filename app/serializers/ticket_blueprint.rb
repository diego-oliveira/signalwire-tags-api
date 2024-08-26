class TicketBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :user_id
  association :tags, blueprint: TagBlueprint
end
