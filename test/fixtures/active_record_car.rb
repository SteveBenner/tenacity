class ActiveRecordCar < ActiveRecord::Base
  include Tenacity

  t_has_many :mongo_mapper_wheels
  t_has_one :mongo_mapper_dashboard

  t_has_one :couch_rest_windshield, :foreign_key => :car_id
  t_has_one :active_record_engine, :foreign_key => 'car_id'
  t_has_many :couch_rest_doors, :foreign_key => 'automobile_id'
end
