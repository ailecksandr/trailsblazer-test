class MiniTest::Spec
  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.clean_with(:truncation)

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
