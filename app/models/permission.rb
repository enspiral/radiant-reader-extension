class Permission < ActiveRecord::Base

  belongs_to :group
  belongs_to :permitted, :polymorphic => true

  named_scope :for, lambda { |object|
    { :conditions => {:permitted_id => object.id, :permitted_type => object.class.name.to_s} }
  }
  
  named_scope :to_groups, lambda { |ids|
    { :conditions => ["permissions.group_id IN (#{ids.map{"?"}.join(',')})", *ids] }
  }

end

