# Project overview

I'd like to give a brief overview of next steps for this project, the pros and cons of my implementation, and potential future modifications.  

## Next steps
If this were a production service, here are some of the next steps that I would take:

1. Configuration injection:
   1. Set up env specific configuration injection for all dependencies
2. Logging / Monitoring
   1. Hook this application up to both a logging and monitoring system (newrelic, cloud watch, kibana, etc)
3. CI/Ci
   1. Configure this project to build on a CI/CD platform to ensure quality (add lint, run tests, etc)
4. Add sad path testing (and potential fuzzing)
   1. The tests I've implemented (happy path) are very minimal, and I would like to mock out the services better (db, etc), and add some edge case testing.

---

## Pros

Overall, this implementation is simple, scalable, portable and adaptable. With this service, we can deploy it to various servers, or easily port it over to a lambda env for execution. With a little more abstraction, we can leverage the repository pattern, and easily swap out the underlying data store

## Cons
While this implementation works, there are a few trade offs that need to be made. 

1. client would need to implement long polling
2. The service is scalable to a point
   1. The limiting factor here is the relational data store, which under load can (and probably will) cause performance degradation

## Alternative implementation
If scalability and though put is the main objective of this API, then the service I've created here will perform well to a point.

Once those business requirements become a factor, we should consider implementing services that write to a distributed queue (high throughput, distributed) with a highly available data storage (cassandra for example)