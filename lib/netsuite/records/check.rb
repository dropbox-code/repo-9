module NetSuite
  module Records
    class Check
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranBank

      # <element name="createdDate" type="xsd:dateTime" minOccurs="0"/>
      # <element name="lastModifiedDate" type="xsd:dateTime" minOccurs="0"/>
      # <element name="status" type="xsd:string" minOccurs="0"/>
      # <element name="customForm" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="account" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="balance" type="xsd:double" minOccurs="0"/>
      # <element name="entity" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="address" type="xsd:string" minOccurs="0"/>
      # <element name="subsidiary" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="postingPeriod" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="tranDate" type="xsd:dateTime" minOccurs="0"/>
      # <element name="currency" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="voidJournal" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="exchangeRate" type="xsd:double" minOccurs="0"/>
      # <element name="toBePrinted" type="xsd:boolean" minOccurs="0"/>
      # <element name="tranId" type="xsd:string" minOccurs="0"/>
      # <element name="memo" type="xsd:string" minOccurs="0"/>
      # <element name="department" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="taxTotal" type="xsd:double" minOccurs="0"/>
      # <element name="class" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="tax2Total" type="xsd:double" minOccurs="0"/>
      # <element name="location" type="platformCore:RecordRef" minOccurs="0"/>
      # <element name="userTotal" type="xsd:double" minOccurs="0"/>
      # <element name="landedCostMethod" type="platformCommonTyp:LandedCostMethod" minOccurs="0"/>
      # <element name="landedCostPerLine" type="xsd:boolean" minOccurs="0"/>
      # <element name="transactionNumber" type="xsd:string" minOccurs="0"/>
      # <element name="expenseList" type="tranBank:CheckExpenseList" minOccurs="0"/>
      # <element name="itemList" type="tranBank:CheckItemList" minOccurs="0"/>
      # <element name="accountingBookDetailList" type="platformCommon:AccountingBookDetailList" minOccurs="0"/>
      # <element name="landedCostsList" type="tranBank:CheckLandedCostList" minOccurs="0"/>
      # <element name="billPay" type="xsd:boolean" minOccurs="0"/>
      # <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>

      actions :add, :delete, :get, :get_list, :search, :update, :upsert, :upsert_list

      fields :created_date, :last_modified_date, :status, :balance, :address,
        :tran_date, :exchange_rate, :to_be_printed, :tran_id, :memo, :tax_total,
        :tax_2_total, :user_total, :landed_cost_per_line, :transaction_number,
        :bill_pay, :landed_cost_method

      field :expense_list, CheckExpenseList
      field :item_list, CheckItemList
      field :accounting_book_detail_list, AccountingBookDetailList
      field :landed_costs_list, CheckLandedCostList
      field :custom_field_list, CustomFieldList

      record_refs :custom_form, :account, :entity, :subsidiary, :posting_period,
        :currency, :void_journal, :department, :klass, :location

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
        "Transaction"
      end

      def self.search_class_namespace
        "tranBank"
      end
    end
  end
end
