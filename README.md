Introduction
============

Simple wrapper for MutationObserver based microtask queue for modern browsers.

    var microtask = require('microtask-queue');

    // schedule a microtask
    var handle = microtask.queue(function (){
      console.log('In Microtask Queue');
    })

    // cancel a microtask
    microtask.cancel(handle);

    // immediately runs all queued microtasks under situations where the queue needs to be processed immediately.
    microtask.flush()

Test
====
TODO: Write tests
