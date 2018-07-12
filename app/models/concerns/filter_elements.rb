# frozen_string_literal: true

# FilterElements
module FilterElements
  extend ActiveSupport::Concern

  def scan(url)
    filter_elements_config = Hiroikaki::Application.config.filter_elements
    contents_name          = filter_elements_config['contents']
    links_name             = filter_elements_config['links']

    filtered_elements = Hiroiyomi.read(url, filter: contents_name + links_name)

    content_list = contents_content_list(filtered_elements, contents_name) + links_content_list(filtered_elements, links_name)
    content_list.select(&:present?)
  end

  private

  def contents_content_list(filtered_elements, contents_name)
    filtered_elements.select { |element| contents_name.include?(element.name) }.map(&:content)
  end

  def links_content_list(filtered_elements, links_name)
    filtered_elements.select { |element| links_name.include?(element.name) }.map(&:attributes).flatten.select { |attr| attr.name == 'href' }.map(&:value)
  end
end
