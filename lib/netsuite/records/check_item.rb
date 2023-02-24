module NetSuite
  module Records
    class CheckItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranBank

      fields :amount, :bin_numbers, :description, :expiration_date, :gross_amt,
        :is_billable, :line, :quantity, :rate, :serial_numbers, :tax_1_amt,
        :tax_rate_1, :tax_rate_2, :vendor_name

      field :custom_field_list, CustomFieldList
      field :inventory_detail, InventoryDetail
      field :landed_cost, LandedCost
      field :options, CustomFieldList

      record_refs :klass, :customer, :department, :item, :location, :tax_code, :units

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

      def initialize_from_record(record)
        self.attributes = record.send(:attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

    end
  end
end
