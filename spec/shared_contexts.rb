# You can define shared_context and/or shared_examples which are re-usable
# between multiple *_spec.rb files.
# If shared_context and/or shared_examples are only needed insode one *_spec.rb file, it
# is better to include them in the file itself.
#
# Some good reading about the usage of both shared_* can be found on this link :
# https://blog.carbonfive.com/2013/08/07/bdd-composition-over-inheritance-with-rspec-shared-examples/
#
# If you start copy/paste stuff in your spec files, start using shared_*.
#
# Using them inside your your tes contexts, use the following syntax :
#
# * shared_exampeles : it_behaves_like 'name' argument1, argumetn2, .....
# * shared_context   : include_context 'name'
#
# official rspec documentation :
# https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples
# https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-context
#
