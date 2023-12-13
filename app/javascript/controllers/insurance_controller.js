import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insurance"
export default class extends Controller {
  connect() {
    const insuranceCheckBox = document.getElementById('insurance_check');
    const insuranceOptions = document.getElementById('insurance_options');

    insuranceCheckBox.addEventListener('change', () => {
      console.log(this.element.checked)
      if(this.element.checked){
        insuranceOptions.classList.remove('hidden');
      } else {
        insuranceOptions.classList.add('hidden');
      }
    });
  }
}
