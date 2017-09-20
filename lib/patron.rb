class Patron
  
  attr_reader(:id, :name, :birthday)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @birthday = attributes.fetch(:birthday)
  end

  def self.all
    total_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    total_patrons.each() do |patron|
      id = patron.fetch("id").to_i
      name = patron.fetch("name")
      birthday = patron.fetch("birthday")
      patrons.push(Patron.new({:id => id, :name => name, :birthday => birthday}))
    end
    patrons
  end

  def ==(another_patron)
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  def save
    result = DB.exec("INSERT INTO patrons (name, birthday) VALUES ('#{@name}', '#{@birthday}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

end
