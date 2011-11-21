#Load Noodall specific stuff
require 'noodall/permalinks'
World(Noodall::Permalinks)

Before do
  Noodall::Site.build!
end
