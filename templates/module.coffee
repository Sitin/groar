module.exports =
  name: "module"
  path: "#{__dirname}/module"
  messages:
    after: [
              'Done. Now try:',
              '    $ cd <%=relative %>',
              '    $ npm install',
              '    $ grunt watch'
            ].join '\n'
