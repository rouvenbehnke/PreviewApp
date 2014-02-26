class AccordionWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'AccordionWidget',
      type: 'publication',
      title: 'Accordion',
      attributes: [
        {
          name: 'panels',
          type: :widget,
        },
      ]
    )

    create_obj_class(
      name: 'AccordionPanelWidget',
      type: 'publication',
      title: 'Accordion Panel',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'main_content',
          type: :widget,
        },
      ]
    )
  end
end
