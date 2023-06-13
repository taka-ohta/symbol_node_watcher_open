import * as express from 'express'

const app: express.Express = express()
app.use(express.json())
app.use(express.urlencoded({ extended: true }))

app.listen(3000, () => {
  console.log('server start.');
});

app.get('/node/health', (_, res) => {
  res.send(JSON.stringify({
    status: {
      apiNode: 'up',
      db: 'up',
    }
  }));
});
