module.exports =
  name: "module"
  path: "#{__dirname}/module"
  message: [
             'Done. Now try:',
             '    $ cd <%=relative %>',
             '    $ npm install',
             '    $ grunt watch'
           ].join '\n'