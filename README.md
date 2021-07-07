# MystexPizza on Broadway

Welcome to Mystex Pizza!

## Getting Started

To run the demo, first clone this repository:

    git clone https://github.com/mcrumm/mystex_pizza_on_broadway
    cd mystex_pizza_on_broadway

install dependencies:

    mix deps.get

and setup the database:

    mix ecto.setup

Then you can run the demo:

    mix run --no-halt

> Note: You will occasionally see errors in the output.  We're generating fake data, after all, and the Order IDs occasionally overlap.

Check the number of customers created:

    mix pizza.customers

Check the number of orders created:

    mix pizza.orders

Finally, you can clean up your database:

    mix ecto.drop

## Telemetry

Broadway currently exposes following Telemetry events:

  * `[:broadway, :topology, :init]` - Dispatched when the topology for
    a Broadway pipeline is initialized. The config key in the metadata
    contains the configuration options that were provided to
    `Broadway.start_link/2`.

    * Measurement: `%{time: System.monotonic_time}`
    * Metadata: `%{supervision: pid(), config: keyword()}`

  * `[:broadway, :processor, :start]` - Dispatched by a Broadway processor
    before the optional `c:prepare_messages/2`

    * Measurement: `%{time: System.monotonic_time}`
    * Metadata:

      ```
      %{
        topology_name: atom,
        name: atom,
        processor_key: atom,
        index: non_neg_integer,
        messages: [Broadway.Message.t]
      }
      ```

  * `[:broadway, :processor, :stop]` -  Dispatched by a Broadway processor
    after `c:prepare_messages/2` and after all `c:handle_message/3` callback
    has been invoked for all individual messages

    * Measurement: `%{time: System.monotonic_time, duration: native_time}`

    * Metadata:

      ```
      %{
        topology_name: atom,
        name: atom,
        processor_key: atom,
        index: non_neg_integer,
        successful_messages_to_ack: [Broadway.Message.t],
        successful_messages_to_forward: [Broadway.Message.t],
        failed_messages: [Broadway.Message.t]
      }
      ```

  * `[:broadway, :processor, :message, :start]` - Dispatched by a Broadway processor
    before your `c:handle_message/3` callback is invoked

    * Measurement: `%{time: System.monotonic_time}`

    * Metadata:

      ```
      %{
        processor_key: atom,
        topology_name: atom,
        name: atom,
        index: non_neg_integer,
        message: Broadway.Message.t
      }
      ```

  * `[:broadway, :processor, :message, :stop]` - Dispatched by a Broadway processor
    after your `c:handle_message/3` callback has returned

    * Measurement: `%{time: System.monotonic_time, duration: native_time}`

    * Metadata:

      ```
      %{
        processor_key: atom,
        topology_name: atom,
        name: atom,
        index: non_neg_integer,
        message: Broadway.Message.t,
      }
      ```

  * `[:broadway, :processor, :message, :exception]` - Dispatched by a Broadway processor
    if your `c:handle_message/3` callback encounters an exception

    * Measurement: `%{time: System.monotonic_time, duration: native_time}`

    * Metadata:

      ```
      %{
        processor_key: atom,
        topology_name: atom,
        name: atom,
        index: non_neg_integer,
        message: Broadway.Message.t,
        kind: kind,
        reason: reason,
        stacktrace: stacktrace
      }
      ```

  * `[:broadway, :consumer, :start]` - Dispatched by a Broadway consumer before your
    `c:handle_batch/4` callback is invoked

    * Measurement: `%{time: System.monotonic_time}`
    * Metadata:

      ```
      %{
        topology_name: atom,
        name: atom,
        index: non_neg_integer,
        messages: [Broadway.Message.t],
        batch_info: Broadway.BatchInfo.t
      }
      ```

  * `[:broadway, :consumer, :stop]` - Dispatched by a Broadway consumer after your
    `c:handle_batch/4` callback has returned

    * Measurement: `%{time: System.monotonic_time, duration: native_time}`

    * Metadata:

      ```
      %{
        topology_name: atom,
        name: atom,
        index: non_neg_integer,
        successful_messages: [Broadway.Message.t],
        failed_messages: [Broadway.Message.t],
        batch_info: Broadway.BatchInfo.t
      }
      ```

  * `[:broadway, :batcher, :start]` - Dispatched by a Broadway batcher before
    handling events

    * Measurement: `%{time: System.monotonic_time}`
    * Metadata:

      ```
      %{
        topology_name: atom,
        name: atom,
        batcher_key: atom,
        messages: [{Broadway.Message.t}]
      }
      ```

  * `[:broadway, :batcher, :stop]` - Dispatched by a Broadway batcher after
    handling events

    * Measurement: `%{time: System.monotonic_time, duration: native_time}`
    * Metadata: `%{topology_name: atom, name: atom, batcher_key: atom}

