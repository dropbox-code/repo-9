module NetSuite
  module Records
    class CustomerSubsidiaryRelationship
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :delete_list, :search

      fields :is_primary_sub

      record_refs :entity, :primary_currency, :subsidiary

      field :custom_field_list, CustomFieldList

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

      def self.search_class_name
        "CustomerSubsidiaryRelationship"
      end

      def self.search_class_namespace
        "listRel"
      end
    end
  end
end
