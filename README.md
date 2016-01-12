job-application
-----

serve an endpoint to receive job applications from
candidates + give current employees an authorized
endpoint to query the applications

`GET /careers`
`POST /careers`

```
{
  "name": "You",
  "email": "you@aol.com",
  "resume": "www.linktoresume.net",
  "github": "github.com/you", // optional
  "website": "you.me" // optional
}
```

