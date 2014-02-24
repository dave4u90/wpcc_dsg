require "./config/environment"
Rails.application.eager_load!

require "rails_erd/diagram/graphviz"

class RailsERD::Diagram::Graphviz

  # Overwrite template in order to replace HTML labels with  
  # plain text graphviz "record" labels for Omnigraffle compatibility -   
  # see http://www.graphviz.org/doc/info/shapes.html for more on record labels.
    
    OMNIGRAFFLE_NODE_LABEL_TEMPLATE_1 = ERB.new("<%= entity.name %><% if attributes.any? %>| { <% attributes.each do |attribute| %> <%= attribute %> (<%= attribute.type %>) <%=\"\n\"%> <% end %> } <% end %>", nil, "<>")  

    OMNIGRAFFLE_NODE_LABEL_TEMPLATE_2 = ERB.new("<%= entity.name %><% if attributes.any? %><% attributes.each do |attribute| %> | {<%= attribute %> | <i><%= attribute.type %></i>} <%=\"\n\"%> <% end %> } <% end %>", nil, "<>")  

    def entity_options(entity, attributes)    
    entity_style(entity, attributes).merge :label => OMNIGRAFFLE_NODE_LABEL_TEMPLATE_1.result(binding)  
    end
    end
    RailsERD.options.filetype = "dot"
    RailsERD::Diagram::Graphviz.create

