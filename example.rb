require_relative 'totalistic_ca'
require_relative 'rule_drawer'

ca = TotalisticCA.new(
  rule: [1, 0, 2, 0, 1, 0, 1],
  rows: 512,
  first_row: [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0,
    1, 1,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0,
  ],
#  borders: :unconnected,
#  unconnected_value: 2,
#  columns: 100,
)

colors = [
  {
    red: 224,
    green: 66,
    blue: 181,
  },
  {
    red: 194,
    green: 235,
    blue: 252,
  },
  {
    red: 255,
    green: 250,
    blue: 247,
  },
]

drawer = RuleDrawer.new(ca.run(scale: 3), colors)
drawer.build_image.save("example.png")
