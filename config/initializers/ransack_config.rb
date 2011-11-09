Ransack.configure do |config|
  # config.add_predicate 'equals_diddly', # Name your predicate
  #                      # What non-compound ARel predicate will it use? (eq, matches, etc)
  #                      :arel_predicate => 'eq',
  #                      # Format incoming values as you see fit. (Default: Don't do formatting)
  #                      :formatter => proc {|v| "#{v}-diddly"},
  #                      # Validate a value. An "invalid" value won't be used in a search.
  #                      # Below is default.
  #                      :validator => proc {|v| v.present?},
  #                      # Should compounds be created? Will use the compound (any/all) version
  #                      # of the arel_predicate to create a corresponding any/all version of
  #                      # your predicate. (Default: true)
  #                      :compounds => true,
  #                      # Force a specific column type for type-casting of supplied values.
  #                      # (Default: use type from DB column)
  #                      :type => :string

  config.add_predicate 'to_f_gt',
    :arel_predicate => 'gt',
    :type           => :float

  config.add_predicate 'to_f_lt',
    :arel_predicate => 'lt',
    :type           => :float

  config.add_predicate 'positive_and_eq',
    :arel_predicate => 'eq',
    :validator      => proc {|v| v.to_i > 0},
    :type           => :integer
  
  config.add_predicate 'cont_any',
    :arel_predicate => 'matches_any',
    :formatter      => proc {|v| v.split(" ").map { |u| "%#{u}%" }}  
end