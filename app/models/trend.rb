class Trend < ApplicationRecord
  belongs_to :user
  belongs_to :import
  belongs_to :reference
  belongs_to :species, optional: true
  belongs_to :species_group, optional: true
  belongs_to :location
  belongs_to :ocean
  belongs_to :data_type
  belongs_to :standard
  belongs_to :sampling_method

  has_many :trend_observations, -> { order(:year) }, dependent: :destroy
  has_and_belongs_to_many :source_observations

  has_one_attached :figure

  validates :start_year, presence: true
  validates :end_year, presence: true

  validate :species_or_species_group

  def species_or_species_group
    if species.blank? && species_group.blank?
      errors.add(:species_id, "species or species_group must be set")
      errors.add(:species_group_id, "species or species_group must be set")
    end
  end

  def title
    "#{species.name} - #{reference.name}"
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << %w[year value]
      observations_data.each do |data_pair|
        csv << data_pair
      end
    end
  end

  def observations_data
    trend_observations.map do |trend_observation|
      [trend_observation.year, trend_observation.value]
    end
  end

  def create_or_update_observations observations
    incoming_years = observations.map(&:first)
    existing = trend_observations.map(&:year)
    to_remove = existing - incoming_years

    trend_observations.where(year: to_remove).destroy_all

    observations.each do |year, value|
      observation = trend_observations.where(year: year).first
      if observation
        observation.update(value: value)
      else
        trend_observations.create(year: year, value: value)
      end
    end
  end
end
