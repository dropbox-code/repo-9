module NetSuite
  module Records
    class LandedCostSummary
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::PlatformCommon

      fields :amount, :source

      record_refs :category, :transaction

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        else
          initialize_from_record(attributes_or_record)
        end
      end

      def initialize_from_record(record)
        self.attributes = record.send(:attributes)
      end

    end
  end
end
