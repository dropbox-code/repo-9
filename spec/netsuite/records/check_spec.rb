require 'spec_helper'

describe NetSuite::Records::Check do
  let(:check) { NetSuite::Records::Check.new(external_id: 'some id') }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :@internal_id => '1', :@external_id => 'some id' }) }
  let(:unsuccessful_response) { NetSuite::Response.new(:success => false, :body => {}) }

  it 'has all the right fields' do
    [
      :created_date, :last_modified_date, :status, :balance, :address,
      :tran_date, :exchange_rate, :to_be_printed, :tran_id, :memo,
      :tax_total, :tax_2_total, :user_total, :landed_cost_per_line,
      :transaction_number, :bill_pay, :landed_cost_method
    ].each do |field|
      expect(check).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :custom_form, :account, :entity, :subsidiary, :posting_period, :currency,
      :void_journal, :department, :klass, :location
    ].each do |record_ref|
      expect(check).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10,
          :internal_id => 'custfield_amount'
        }
      }

      check.custom_field_list = attributes
      expect(check.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(check.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      check.custom_field_list = custom_field_list
      expect(check.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        :item => {
          :amount => 10
        }
      }
      check.item_list = attributes
      expect(check.item_list).to be_kind_of(NetSuite::Records::CheckItemList)
      expect(check.item_list.items.length).to eql(1)
    end

    it 'can be set from a CheckItemList object' do
      item_list = NetSuite::Records::CheckItemList.new
      check.item_list = item_list
      expect(check.item_list).to eql(item_list)
    end
  end

  describe '#expense_list' do
    it 'can be set from attributes' do
      attributes = {
        :expense => {
          :gross_amt => 10
        }
      }
      check.expense_list = attributes
      expect(check.expense_list).to be_kind_of(NetSuite::Records::CheckExpenseList)
      expect(check.expense_list.expenses.length).to eql(1)
    end

    it 'can be set from a CheckExpenseList object' do
      expense_list = NetSuite::Records::CheckExpenseList.new
      check.expense_list = expense_list
      expect(check.expense_list).to eql(expense_list)
    end
  end

  describe '.get' do
    subject { described_class.get(external_id: 'some id') }

    before(:each) do
      expect(NetSuite::Actions::Get)
        .to receive(:call)
        .with([NetSuite::Records::Check, external_id: 'some id'], {})
        .and_return(response)
    end

    context 'when the response is successful' do
      it 'returns a Check instance populated with the data from the response object' do
        expect(subject).to be_kind_of(NetSuite::Records::Check)
        expect(subject.internal_id).to eq('1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { unsuccessful_response }

      it 'raises a RecordNotFound exception' do
        expect { subject }
          .to raise_error(
            NetSuite::RecordNotFound,
            /NetSuite::Records::Check with OPTIONS=(.*) could not be found/
          )
      end
    end
  end

  describe '#add' do
    subject { check.add }

    before(:each) do
      expect(NetSuite::Actions::Add)
        .to receive(:call)
        .with([check], {})
        .and_return(response)
    end

    context 'when the response is successful' do
      it 'returns true' do
        expect(subject).to be_truthy
        expect(check.internal_id).to eq('1')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { unsuccessful_response }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end

  describe '#delete' do
    subject { check.delete }

    before(:each) do
      expect(NetSuite::Actions::Delete)
        .to receive(:call)
        .with([check], {})
        .and_return(response)
    end

    context 'when the response is successful' do
      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { unsuccessful_response }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end
end
