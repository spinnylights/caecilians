require_relative 'totalistic_ca'
require_relative 'rule_drawer'

rule = TotalisticCA.new(rows: 3840, length: 2160)
rule = TotalisticCA.new(rows: 2160, length: 3840)
drawer = RuleDrawer.new(rule.make_matrix)
drawer.build_image.save("2.png")
