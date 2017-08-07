require 'spec_helper'

describe 'Auto Inject' do

  class UsersRepository
  end

  class CreateUser
  end

  class MyContainer
    extend Dry::Container::Mixin

    register "users_repository" do
      UsersRepository.new
    end

    register "operations.create_user" do
      CreateUser.new
    end
  end

  Import = Dry::AutoInject(MyContainer) 

  context 'basics' do
    context 'by default is injects all the dependencies' do
      class MyClass
        include Import['users_repository', 
          'operations.create_user']
      end

      specify 'has a users_repository' do
        instance = MyClass.new
        expect(instance).to respond_to(:users_repository)
        expect(instance).to respond_to(:create_user)
        expect(instance.users_repository).to be_a(UsersRepository)
        expect(instance.create_user).to be_a(CreateUser)
      end
    end
  end

  context 'specifying the dependencies' do
    class DependendOnUsers
      include Import['users_repository']
    end

    class DependendOnOperations
      include Import['operations.create_user']
    end

    specify 'has just what is needed' do
      dependend_on_users = DependendOnUsers.new
      expect(dependend_on_users).to respond_to(:users_repository)
      expect(dependend_on_users).to_not respond_to(:create_user)
      expect(dependend_on_users.users_repository).to be_a(UsersRepository)

      dependent_on_operation = DependendOnOperations.new
      expect(dependent_on_operation).to_not respond_to(:users_repository)
      expect(dependent_on_operation).to respond_to(:create_user)
      expect(dependent_on_operation.create_user).to be_a(CreateUser)
    end
  end

  context 'aliasing' do
    class Aliased
      include Import[users_repo: 'users_repository']
    end

    specify 'has just what is needed' do
      aliased = Aliased.new
      expect(aliased).to_not respond_to(:users_repository)
      expect(aliased).to respond_to(:users_repo)
      expect(aliased.users_repo).to be_a(UsersRepository)
    end
  end

  context 'manual override of dependencies' do
    class AnotherRepo
    end

    class Aliased
      include Import[users_repo: 'users_repository']
    end

    specify 'has just what is needed' do
      aliased = Aliased.new(users_repo: AnotherRepo.new)

      expect(aliased).to respond_to(:users_repo)
      expect(aliased.users_repo).to be_a(AnotherRepo)
      expect(aliased.users_repo).to_not be_a(UsersRepository)
    end
  end
end
