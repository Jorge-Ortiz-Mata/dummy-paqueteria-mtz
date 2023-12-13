import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="destinataries"
export default class extends Controller {
  connect() {
  }

  onClickHomeCheck () {
    document.getElementById('home-fields').classList.remove('hidden');
    document.getElementById('office-fields').classList.add('hidden');
  }

  onClickOfficeCheck () {
    document.getElementById('home-fields').classList.add('hidden');
    document.getElementById('office-fields').classList.remove('hidden');
  }
}
