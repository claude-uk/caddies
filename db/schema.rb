# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140123183320) do

  create_table "categories", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cc_alls", :force => true do |t|
    t.string   "construct_type"
    t.integer  "construct_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "position"
    t.boolean  "ifbranch"
  end

  create_table "cc_ifthenelses", :force => true do |t|
    t.string   "textid"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cc_loops", :force => true do |t|
    t.string   "textid"
    t.string   "loop_variable"
    t.integer  "initial_value"
    t.integer  "end_value"
    t.string   "loop_while"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cc_question_universes", :force => true do |t|
    t.integer  "cc_question_id"
    t.integer  "universe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cc_questions", :force => true do |t|
    t.string   "textid"
    t.integer  "question_reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "response_unit_id"
    t.string   "question_reference_type"
  end

  create_table "cc_sequences", :force => true do |t|
    t.string   "textid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cc_statements", :force => true do |t|
    t.string   "textid"
    t.string   "statement_item"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_schemes", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "codes", :force => true do |t|
    t.integer  "code_scheme_id"
    t.integer  "category_id"
    t.string   "cs_value"
    t.integer  "cs_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datetime_types", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instances", :force => true do |t|
    t.string   "agency"
    t.string   "version"
    t.string   "instance"
    t.string   "inst_citation"
    t.string   "resource_package"
    t.string   "rp_citation"
    t.string   "purpose"
    t.string   "purpose_text"
    t.string   "cc_scheme"
    t.string   "category_scheme"
    t.string   "question_scheme"
    t.string   "ddata_collection"
    t.string   "instrument"
    t.string   "top_sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "numeric_types", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qi_rdas", :force => true do |t|
    t.integer  "question_item_id"
    t.integer  "response_domain_all_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_grids", :force => true do |t|
    t.string   "textid"
    t.string   "literal"
    t.string   "intent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vertical_codelist_id"
    t.integer  "vertical_roster_rows",   :default => 0
    t.string   "vertical_roster_label"
    t.integer  "horizontal_codelist_id"
    t.string   "corner_label"
  end

  create_table "question_items", :force => true do |t|
    t.string   "textid"
    t.string   "literal"
    t.string   "intent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_domain_alls", :force => true do |t|
    t.integer  "response_domain_type_id"
    t.integer  "domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "domain_type"
  end

  create_table "response_domain_codes", :force => true do |t|
    t.integer  "code_scheme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_domain_datetimes", :force => true do |t|
    t.integer  "datetime_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
    t.string   "format"
  end

  create_table "response_domain_numerics", :force => true do |t|
    t.integer  "numeric_type_id"
    t.integer  "min"
    t.integer  "max"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
  end

  create_table "response_domain_texts", :force => true do |t|
    t.integer  "maxlen"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
  end

  create_table "response_domain_types", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_units", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universes", :force => true do |t|
    t.string   "univ_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
