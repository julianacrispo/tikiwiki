module CollaboratorsHelper

  def add_collaboration(wiki, role = "collaborator")
    self.wiki_associations.build(:wiki => wiki, :role => role)
  end

end
