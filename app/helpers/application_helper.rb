module ApplicationHelper
  def body_attributes(obj)
    attributes = {}

    if obj
      attributes[:data] = {
        current_obj: {
          id: obj.id,
          path: obj.path,
          class: obj.obj_class,
        },
      }
    end

    attributes
  end

  def image_url(image)
    request.protocol + request.host_with_port + image_path(image)
  end
end
