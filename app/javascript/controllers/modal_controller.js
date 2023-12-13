import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeModal() {
    document.getElementById('modal-section').remove();
  }
}
