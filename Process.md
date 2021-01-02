In this section, I'll try my best to encapsulate my thought process for digesting and formulating a solution to the interview problem. 

On first pass, I noted a few key requirements. Namely, that messages can be looked up by sender, and the ability to look up in the past 30 days. This information means that our data schema needs at minimum: `userId`, `messageId` (both UUID's), `message_text` and a `timestamp`. A sample api contract might look like:
```
{
    messages:[
        {
            sender: int, // userId
            reciever: int,
            message: string,
            timestamp: DateTime
        }
    ],
    limit: int,
    offset: int // for pagination
}
```

After jotting down the minimum requirements to achieve the feature request, I've gone ahead and created some simple API documentation that will be used when creating the service:


## POST: `v1/`
Request:
```

```

Response:
```

```
---

## GET: `v1/`
Request:
```

```

Response:
```

```
---