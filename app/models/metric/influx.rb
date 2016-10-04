class Metric::Influx
  def initialize
    #TODO move username and password determination to initializer
    #'user@password@db@server'
    tokens = INFLUX_CONNECTION.split('@')
    user = tokens[0]
    password = tokens[1]
    database = tokens[2]
    server = tokens[3]
    @client = InfluxDB::Client.new database, host: server, username: user, password: password
  end

  def write(measurement_name, values, tags, timestamp)
    data = {
      values: values,
      tags: tags,
      timestamp: timestamp
    }
    @client.write_point(measurement_name, data)
  end

  def write_value(measurement_name, value, timestamp)
    write(measurement_name, { value: value }, nil, timestamp)
  end

end
