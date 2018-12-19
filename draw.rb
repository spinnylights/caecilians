require_relative 'totalistic_ca'
require_relative 'rule_drawer'

rule_1037 = TotalisticCA.new(
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
  borders: :toroidal
)

colors = [
  {
    red: 0.88,
    green: 0.26,
    blue: 0.71
  },
  {
    red: 0.76,
    green: 0.92,
    blue: 0.99
  },
  {
    red: 1,
    green: 0.98,
    blue: 0.97
  },
]

#results = rule_1037.run.flatten
#zero = results.count(0)
#one = results.count(1)
#two = results.count(2)
#total = zero + one + two
#
#puts "0: #{zero} (#{zero.to_f / total})"
#puts "1: #{one} (#{one.to_f / total})"
#puts "2: #{two} (#{two.to_f / total})"

drawer = RuleDrawer.new(rule_1037.run(scale: 6), colors)
drawer.build_image.save("1037_6_29.png")
