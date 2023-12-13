import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin"
export default class extends Controller {
  showProfileForm(){
    const profileForm = document.getElementById('edit_admin_user_profile');
    const accountForm = document.getElementById('edit_admin_user_account');

    profileForm.classList.remove('hidden');
    accountForm.classList.add('hidden');
  }

  showAccountForm(){
    const profileForm = document.getElementById('edit_admin_user_profile');
    const accountForm = document.getElementById('edit_admin_user_account');

    profileForm.classList.add('hidden');
    accountForm.classList.remove('hidden');
  }
}
