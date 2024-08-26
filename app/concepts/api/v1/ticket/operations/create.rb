module Api::V1::Ticket::Operations
  class Create < Trailblazer::Operation
    # Only used to setup the form.
    class Present < Trailblazer::Operation
      step Model(Ticket, :new)
      step Contract::Build(constant: Api::V1::Ticket::Contracts::Create)
    end

    step Subprocess(Present) # Here, we actually run the {Present} operation.
    step Contract::Validate()
    step Contract::Persist()
    step :notify

    def notify(options, model:, **)
      most_used_tag = Tag.most_used
      SendWebhookJob.perform_later("https://webhook.site/db2f601e-8b20-49d5-9a4e-fc3406c4385e", most_used_tag.as_json)
    end
  end
end
