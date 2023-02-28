require 'spec_helper'

describe NetSuite::Records::VendorSubsidiaryRelationship do
  let(:relationship) { described_class.new }

  let(:successful_response) { NetSuite::Response.new(:success => true, :body => {:is_primary_sub => true}) }
  let(:unsuccessful_response) { NetSuite::Response.new(:success => false, :body => {}) }

  it 'has all the right fields' do
    [
      :credit_limit, :is_primary_sub
    ].each do |field|
      expect(relationship).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :base_currency, :entity, :primary_currency, :subsidiary, :tax_item
    ].each do |record_ref|
      expect(relationship).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :internal_id => 'custfield_value'
        }
      }
      relationship.custom_field_list = attributes
      expect(relationship.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(relationship.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      relationship.custom_field_list = custom_field_list
      expect(relationship.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '.get' do
    subject { described_class.get(:external_id => 1) }

    before(:each) do
      expect(NetSuite::Actions::Get)
        .to receive(:call)
        .with([described_class, {:external_id => 1}], {})
        .and_return(response)
    end

    context 'when the response is successful' do
      let(:response) { successful_response }

      it 'returns a VendorSubsidiaryRelationship instance populated with the data from the response object' do
        expect(subject).to be_kind_of(NetSuite::Records::VendorSubsidiaryRelationship)
        expect(subject.is_primary_sub).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { unsuccessful_response }

      it 'raises a RecordNotFound exception' do
        expect { subject }
          .to raise_error(
            NetSuite::RecordNotFound,
            /NetSuite::Records::VendorSubsidiaryRelationship with OPTIONS=(.*) could not be found/
          )
      end
    end
  end

  describe '#add' do
    subject { relationship.add }

    let(:relationship) { described_class.new(:is_primary_sub => true) }

    before(:each) do
      expect(NetSuite::Actions::Add).to receive(:call)
        .with([relationship], {})
        .and_return(response)
    end

    context 'when the response is successful' do
      let(:response) { successful_response }

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context "when the response is unsuccessful" do
      let(:response) { unsuccessful_response }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before(:each) do
      relationship.is_primary_sub = true
      relationship.entity = NetSuite::Records::RecordRef.new(
        internal_id: 12345,
        type: 'customer',
      )
      relationship.subsidiary = NetSuite::Records::RecordRef.new(
        internal_id: 67890,
        type: 'subsidiary',
      )
    end

    it 'can represent itself as a soap record' do
      record = {
        'listRel:isPrimarySub' => true,
        'listRel:entity' => {},
        'listRel:subsidiary' => {},
        :attributes! => {
          'listRel:entity' => {
            'type' => 'customer',
            'internalId' => 12345
          },
          'listRel:subsidiary' => {
            'type' => 'subsidiary',
            'internalId' => 67890
          }
        }
      }
      expect(relationship.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(relationship.record_type).to eql('listRel:VendorSubsidiaryRelationship')
    end
  end
end
