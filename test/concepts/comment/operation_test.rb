require 'test_helper'

class CommentOperationTest < MiniTest::Spec
  let(:thing) { Thing::Create.(thing: { name: 'Ruby' }).model }

  describe 'Create' do
    it 'valid' do
      res, op = Comment::Create.run(
        comment: {
          body: 'Fantastic!',
          weight: 1,
          user: {
            email: 'jonny@trb.org'
          }
        },
        thing_id: thing.id
      )
      comment = op.model
      comment.persisted?.must_equal true
      comment.body.must_equal 'Fantastic!'
      comment.weight.must_equal 1
      comment.user.persisted?.must_equal true
      comment.user.email.must_equal 'jonny@trb.org'
      op.thing.must_equal thing
    end

    context 'invalid' do
      it 'invalid email' do
        res, operation = Comment::Create.run(
          comment: {
            user: {
              email: '1337@'
            },
            thing_id: thing.id
          }
        )
        res.must_equal false
        operation.errors.messages[:'user.email'].must_equal ['wrong email address']
      end
    end
  end

  describe 'Update' do
    let(:thing) { Thing::Create.(thing: { name: 'Rails', description: 'Kickass web dev' }).model }

    it 'valid' do
      new_thing = Thing::Update.(
        id: thing.id,
        thing: { name: 'Lotus', description: 'Simply better..' }
      ).model

      new_thing.name.must_equal 'Rails'
      new_thing.description.must_equal 'Simply better..'
    end
  end
end