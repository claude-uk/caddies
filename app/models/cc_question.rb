class CcQuestion < ActiveRecord::Base
  validates :textid, :presence => true, :uniqueness => true, :ascii_format => true, :no_spaces => true
  validates_presence_of :question_reference_type, :question_reference_id, :response_unit_id
  belongs_to :question_reference, :polymorphic => true
  belongs_to :response_unit
  has_many :cc_question_universes
  has_many :universes, :through => :cc_question_universes
  has_one :cc_all, :as => :construct, :dependent => :destroy
  accepts_nested_attributes_for :cc_all
  #after_initialize :init

	include SharedMethods
  @@type_prefix = "qc"
  cattr_reader :type_prefix
  
  #no longer needed
  def init
        self.cc_all ||= build_cc_all
  end
end
