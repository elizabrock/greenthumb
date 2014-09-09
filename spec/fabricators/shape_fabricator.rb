Fabricator(:shape) do
  color{ Shape::BROWN }
  top      0
  left      0
  garden
end

Fabricator(:circle, from: :shape) do
  type "Circle"
end

Fabricator(:rectangle, from: :shape) do
  type "Rectangle"
end
