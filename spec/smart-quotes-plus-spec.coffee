{WorkspaceView} = require 'atom'
SmartQuotesPlus = require '../lib/smart-quotes-plus'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SmartQuotesPlus", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('smart-quotes-plus')

  describe "when the smart-quotes-plus:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.smart-quotes-plus')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'smart-quotes-plus:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.smart-quotes-plus')).toExist()
        atom.workspaceView.trigger 'smart-quotes-plus:toggle'
        expect(atom.workspaceView.find('.smart-quotes-plus')).not.toExist()
