require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  def setup
    owner = owners(:one)
    @property = Property.new(name: 'property test', description: 'two bed apartment second floor with garage',
                             status: 'available', rental_price: 200, owner: owner)
  end

  test 'Property saves correctly' do
    assert @property.save
  end

  test 'Property has a valid name' do
    @property.name = ''
    assert_not @property.save
    @property.name = 'a' * 47
    assert_not @property.save
    @property.name = 'test property'
    assert @property.save
  end

  test 'Property has a valid description' do
    @property.description = ''
    assert_not @property.save
    @property.description = 'd' * 256
    assert_not @property.save
    @property.description = 'property description text'
    assert @property.save
  end

  test 'Property has a valid status' do
    @property.status = ''
    assert_not @property.save
    @property.status = 1
    assert_not @property.save
    @property.status = 'published'
    assert @property.save
    @property.status = 'deleted'
    assert @property.save
    @property.status = 'available'
    assert @property.save
  end

  test 'property has a valid rental_price' do
    @property.rental_price = ''
    assert_not @property.save
    @property.rental_price = 'hundred'
    assert_not @property.save
    @property.rental_price = 1_000_000_000.02
    assert_not @property.save
    @property.rental_price = 150.23
    assert @property.save
  end
end
