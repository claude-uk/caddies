module SharedMethods
  def urn_id
    Instance.prefix + Instance.sep + type_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end
end

#not shared but here by analogy
module LoopMethods
  def loop_sequence_urn_id
    Instance.prefix + Instance.sep + selp_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end
end

#not shared but here by analogy
module IfThenElseMethods
  def then_sequence_urn_id
    Instance.prefix + Instance.sep + seth_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end
  def else_sequence_urn_id
    Instance.prefix + Instance.sep + seel_prefix  + Instance.sep + id.to_s.rjust(Instance.just, '0')
  end
end