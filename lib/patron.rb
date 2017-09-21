class Patron
 
  attr_reader(:id)
  attr_accessor(:name, :birthday)

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
    if @id
      DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
    else
      result = DB.exec("INSERT INTO patrons (name, birthday) VALUES ('#{@name}', '#{@birthday}') RETURNING id;")
      @id = result.first().fetch("id").to_i
    end
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
    DB.exec("DELETE FROM checkout WHERE patron_id = #{@id};")
  end
end
