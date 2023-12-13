require 'rails_helper'

RSpec.describe SellPolicy do
  let(:viewer) { create(:user, :with_email, :with_password, :with_password_confirmation) }
  let(:editor) { create(:user, :with_email, :with_password, :with_password_confirmation, role: 1) }
  let(:admin) { create(:user, :with_email, :with_password, :with_password_confirmation, role: 2) }

  describe 'as an admin user' do
    subject { described_class }

    permissions :index? do
      it 'should allow this action' do
        expect(subject).to permit(admin)
      end
    end

    permissions :new? do
      it 'should allow this action' do
        expect(subject).to permit(admin)
      end
    end

    permissions :edit? do
      it 'should allow this action' do
        expect(subject).to permit(admin)
      end
    end

    permissions :create? do
      it 'should allow this action' do
        expect(subject).to permit(admin)
      end
    end

    permissions :update? do
      it 'should allow this action' do
        expect(subject).to permit(admin)
      end
    end

    permissions :destroy? do
      it 'should allow this action' do
        expect(subject).to permit(admin)
      end
    end

    permissions :show? do
      it 'should allow this action' do
        expect(subject).to permit(admin)
      end
    end
  end

  describe 'as an editor user' do
    subject { described_class }

    permissions :index? do
      it 'should allow this action' do
        expect(subject).to permit(editor)
      end
    end

    permissions :new? do
      it 'should allow this action' do
        expect(subject).to permit(editor)
      end
    end

    permissions :edit? do
      it 'should allow this action' do
        expect(subject).to permit(editor)
      end
    end

    permissions :create? do
      it 'should allow this action' do
        expect(subject).to permit(editor)
      end
    end

    permissions :update? do
      it 'should allow this action' do
        expect(subject).to permit(editor)
      end
    end

    permissions :destroy? do
      it 'should allow this action' do
        expect(subject).to permit(editor)
      end
    end

    permissions :show? do
      it 'should allow this action' do
        expect(subject).to permit(editor)
      end
    end
  end

  describe 'as an viewer user' do
    subject { described_class }

    permissions :index? do
      it 'should allow this action' do
        expect(subject).to_not permit(viewer)
      end
    end

    permissions :new? do
      it 'should allow this action' do
        expect(subject).to_not permit(viewer)
      end
    end

    permissions :edit? do
      it 'should allow this action' do
        expect(subject).to_not permit(viewer)
      end
    end

    permissions :create? do
      it 'should allow this action' do
        expect(subject).to_not permit(viewer)
      end
    end

    permissions :update? do
      it 'should allow this action' do
        expect(subject).to_not permit(viewer)
      end
    end

    permissions :destroy? do
      it 'should allow this action' do
        expect(subject).to_not permit(viewer)
      end
    end

    permissions :show? do
      it 'should allow this action' do
        expect(subject).to_not permit(viewer)
      end
    end
  end
end
