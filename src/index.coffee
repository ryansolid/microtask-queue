class MicroTaskQueue
  constructor: ->
    @tasks = []
    @max_recursion = 5000
    @__next_index = 0
    @__next_handle = 1

    @schedule = ((callback) ->
      div = document.createElement('div')
      new MutationObserver(callback).observe(div, attributes: true)
      return ->
        div.classList.toggle 'foo'
        return
    )(@flush)

  queue: (task) =>
    @schedule() unless @tasks.length
    @tasks.push(task)
    @__next_handle++

  cancel: (handle) =>
    index = handle - (@__next_handle - @tasks.length)
    @tasks[index] = null if index > @__next_index

  flush: =>
    count = 0; mark = 0
    while @__next_index < @tasks.length
      unless task = @tasks[@__next_index]
        @__next_index++
        continue
      if @__next_index > mark
        if count++ > @max_recursion
          console.error 'Exceeded max task recursion'
          @__next_index = 0
          return @tasks = []
        mark = @tasks.length
      try
        task()
      catch err
        console.error err
      @__next_index++
    @__next_index = 0
    @tasks = []
    return

module.exports = new MicroTaskQueue()
