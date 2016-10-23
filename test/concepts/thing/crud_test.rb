require 'test_helper'

class ThingCrudTest < MiniTest::Spec
  describe 'Create' do
    it 'valid' do
      thing = Thing::Create.(thing: {name: 'Rails', description: 'Kickass web dev'}).model

      (thing.persisted?).must_equal true
      thing.name.must_equal 'Rails'
      thing.description.must_equal 'Kickass web dev'
    end

    context 'invalid' do
      it 'name' do
        res, op = Thing::Create.run(
          thing: { name: '' }
        )

        res.must_equal false
        (op.model.persisted?).must_equal false
        op.contract.errors[:name].first.must_equal 'can\'t be blank'
      end

      it 'description' do
        res, op = Thing::Create.run(
          thing: { name: 'Rails', description: 'hi' }
        )

        res.must_equal false
        op.contract.errors[:description].first.must_equal 'is too short (minimum is 4 characters)'
      end
    end
  end

  describe 'Update' do
    let(:thing) { Thing::Create.(thing: { name: 'Rails', description: 'Kickass web dev' }).model }

    it 'valid' do
      new_thing = Thing::Update.(
        id: thing.id,
        thing: { name: 'Lotus', description: 'Simply better..' }
      ).model

      new_thing.name.must_equal 'Rails'
      new_thing.description.must_equal 'Simply better..'
    end
  end
end