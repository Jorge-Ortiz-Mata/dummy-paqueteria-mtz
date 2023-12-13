if InsurancePolicy.all.size <= 0
  InsurancePolicy.create(percentage: 20, price: 100)

  InsurancePolicy.create(percentage: 40, price: 200)

  InsurancePolicy.create(percentage: 60, price: 300)

  InsurancePolicy.create(percentage: 80, price: 400)

  InsurancePolicy.create(percentage: 100, price: 500)

  InsurancePolicy.create(percentage: 120, price: 600)

  InsurancePolicy.create(percentage: 140, price: 700)

  InsurancePolicy.create(percentage: 160, price: 800)

  InsurancePolicy.create(percentage: 180, price: 900)

  InsurancePolicy.create(percentage: 200, price: 1000)
end
