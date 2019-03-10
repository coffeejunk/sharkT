module Xlsx
  class Validator < ApplicationService
    attr_reader :type, :xlsx, :trait, :trend

    Result = Struct.new(:type, :valid, :messages)

    TRAIT_TEMPLATE = 'docs/SharkTraits-Template.xlsx'
    TREND_TEMPLATE = 'docs/SharkTrends-Template.xlsx'

    def initialize(file_path)
      @messages = []
      @valid = false
      begin
        @xlsx = Xlsx::Document.new(file_path)
      rescue ArgumentError
        @messages << "Document is not an Excel sheet."
        @type = :invalid
      end

      @trait = Document.new(TRAIT_TEMPLATE)
      @trend = Document.new(TREND_TEMPLATE)
    end

    def call
      guess_type
      validate_column_headers

      return Result.new @type, @valid, @messages
    end

    def guess_type
      return unless @xlsx

      if xlsx.sheets == trend.sheets
        @type = :trends
        @messages << "Document is a 'Trends' dataset."
      elsif !(xlsx.sheets & trend.sheets).empty?
        @type = :trends
        @messages << "Document is probably 'Trends' dataset."
      elsif xlsx.sheets == trait.sheets
        @type = :traits
        @messages << "Document is a 'Traits' dataset."
      elsif !(xlsx.sheets & trait.sheets).empty?
        @type = :traits
        @messages << "Document is probably 'Traits' dataset."
      else
        @type = :invalid
        @messages << 'Document type could not be detected.'
        @messages << 'Validation failed. The document can\'t be imported.'
        @valid = false
      end
    end

    def validate_column_headers
      return if type == :invalid

      template = case type
                 when :traits
                   @trait
                 when :trends
                   @trend
                 end

      if @xlsx.headers == template.headers
        @messages << "Data-Sheet column headers are valid."
        @valid = true
      else
        missing = template.headers - xlsx.headers
        @messages << "Data-Sheet column headers #{missing} are missing."
      end
    end
  end
end