module.exports = function() {
  throw new Error("Trying to execute project that hasn't been built yet. You should build it by '$ grunt' command.");
}