require "administrate/base_dashboard"

class SpeciesDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    species_superorder: Field::BelongsTo,
    id: Field::Number,
    name: Field::String,
    iucn_code: Field::String,
    observations: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :species_superorder,
    :name,
    :iucn_code,
    :observations,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :species_superorder,
    :id,
    :name,
    :iucn_code,
    :observations,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :species_superorder,
    :name,
    :iucn_code,
  ].freeze

  # Overwrite this method to customize how species are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(species)
    species.name
  end
end