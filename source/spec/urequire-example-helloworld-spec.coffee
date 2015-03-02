hello = require 'urequire-example-helloworld' # package.name
expect = require('chai').expect

describe " 'urequire-example-helloworld' bound to `hello` :", ->
  it "equals 'Hello, world' ", ->
    expect(hello).to.be.equal "Hello, world"