# RappGem TODO


## Next step of architecture

  * Implement a Command-Queue
      * Workflow // Loop
          * Wait for a request / Start a request
          * Build a request-object and put it to the in-queue
          * Wait for result and pull it from queue
          * Build a response-object and put it on the out-queue
      * Input: Push "commands/requests" to the input-queue
          * Take input from stdin in TerminalApplication
          * Take input from tests in BaseApplication or when used as a gem
          * Take input from routes/params in sinatra/rails
      * Work: Pull requests from the in-queue
          * Instantiate an interactor from the request
          * Run the interactor and build a response-object
          * Push it to the out-queue
      * Output: Pull from the done-queue
          * use a presenter to "render" the output

## Threads

 * A RAILS- or Sinatra App
     * A request from the web is the startpoint
     * Push the request to the in-queue and wait until the response
       apears on the out-queue
     * Render the output
 * Terminal-app
     * Command-Thread
         * Read commands and arguments from stdin or a file in a loop until
           :exit occurs
         * Push the request to the in-queue and loop
     * Worker-Thread
         * Pull from in-queue and do the work
     * Outout-Thread
         * Pull from out-queue and render output



