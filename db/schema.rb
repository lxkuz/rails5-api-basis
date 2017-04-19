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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170418171412) do

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.json     "data"
    t.string   "file"
    t.datetime "report_from"
    t.datetime "report_to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "ticket_kinds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",         limit: 65535
    t.integer  "ticket_kind_id"
    t.integer  "customer_id"
    t.integer  "agent_id"
    t.datetime "closed_at"
    t.text     "closing_description", limit: 65535
    t.string   "status",                            default: "new"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.index ["agent_id"], name: "index_tickets_on_agent_id", using: :btree
    t.index ["customer_id"], name: "index_tickets_on_customer_id", using: :btree
    t.index ["ticket_kind_id"], name: "index_tickets_on_ticket_kind_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",              default: "",         null: false
    t.string   "encrypted_password", default: "",         null: false
    t.string   "role",               default: "customer"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
