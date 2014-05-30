module SharedMethods
  def urn_id
    Instance.first.prefix + Instance.sep + type_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end
#end

#for loops, not shared but here by analogy
  def loop_sequence_urn_id
    Instance.first.prefix + Instance.sep + selp_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end

#for IfThenElses, not shared but here by analogy
  def then_sequence_urn_id
    Instance.first.prefix + Instance.sep + seth_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end
  def else_sequence_urn_id
    Instance.first.prefix + Instance.sep + seel_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end

#for instances, not shared but here by analogy
  def category_scheme_urn_id
    Instance.first.prefix + Instance.sep + category_scheme_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def resource_package_urn_id
    Instance.first.prefix + Instance.sep + resource_package_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def data_collection_urn_id
    Instance.first.prefix + Instance.sep + data_collection_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def control_construct_scheme_urn_id
    Instance.first.prefix + Instance.sep + control_construct_scheme_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def instrument_scheme_urn_id
    Instance.first.prefix + Instance.sep + instrument_scheme_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def instrument_urn_id
    Instance.first.prefix + Instance.sep + instrument_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def interviewer_instruction_scheme_urn_id
    Instance.first.prefix + Instance.sep + interviewer_instruction_scheme_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def managed_text_representation_scheme_urn_id
    Instance.first.prefix + Instance.sep + managed_representation_scheme_prefix  + Instance.sep + mrt_scheme_id.to_s.rjust(Instance.just, '0')
  end
  def managed_numeric_representation_scheme_urn_id
    Instance.first.prefix + Instance.sep + managed_representation_scheme_prefix  + Instance.sep + mrn_scheme_id.to_s.rjust(Instance.just, '0')
  end
  def managed_datetime_representation_scheme_urn_id
    Instance.first.prefix + Instance.sep + managed_representation_scheme_prefix  + Instance.sep + mrd_scheme_id.to_s.rjust(Instance.just, '0')
  end
  def code_list_scheme_urn_id
    Instance.first.prefix + Instance.sep + code_list_scheme_prefix  + Instance.sep + scheme_id.to_s.rjust(Instance.just, '0')
  end
  def question_item_scheme_urn_id
    Instance.first.prefix + Instance.sep + question_scheme_prefix  + Instance.sep + qitem_scheme_id.to_s.rjust(Instance.just, '0')
  end
  def question_grid_scheme_urn_id
    Instance.first.prefix + Instance.sep + question_scheme_prefix  + Instance.sep + qgrid_scheme_id.to_s.rjust(Instance.just, '0')
  end
end

