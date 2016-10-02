class CreateMetricMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :metric_metrics do |t|
      t.string :type
      t.datetime :measured_at
      t.integer :value
      t.boolean :transported, null: false, default: false

      t.timestamps null: false
    end

    add_index :metric_metrics, :measured_at
    add_index :metric_metrics, :transported
  end
end
