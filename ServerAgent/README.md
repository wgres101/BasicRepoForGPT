# Server Agent

This folder contains a lightweight Python server that hosts Strmml files. A
Strmml file is organized into honeycomb-like *sectors* that connect seamlessly
to adjacent sectors. Each sector can declare a `portal` attribute acting as a
hyperlink to additional content. A portal may point to another Strmml file on
the same server or to a different *cluster* identified by a `strmml://` URL.

The server exposes several endpoints:
* `/strmml/<name>` – returns a Strmml file by name (defaults to `sample`)
* `/sectors/<name>` – lists the sectors from the given file in JSON
* `/portal/<sector>` – fetches the content linked by a sector's portal

Run the server with:

```bash
python3 server.py
```

It serves `sample.strmml` at `http://localhost:5000/strmml` and shows the
sector breakdown at `http://localhost:5000/sectors`. When a sector's portal
starts with `strmml://`, the server performs a DNS lookup and fetches the
remote file to bridge clusters.
