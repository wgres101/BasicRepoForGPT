"""Minimal server for Strmml files.

Strmml files are divided into honeycomb-like sectors. Each sector links
seamlessly to its neighbors and may define a portal URL acting as a
hyperlink to other content. A portal can reference another local Strmml
file or a remote *cluster* using the ``strmml://`` scheme.
"""

from flask import Flask, send_file, jsonify, abort
import xml.etree.ElementTree as ET
from urllib.request import urlopen
import os

app = Flask(__name__)

def _list_sectors_from(filename):
    tree = ET.parse(filename)
    root = tree.getroot()
    sectors = []
    for sector in root.findall('sector'):
        sectors.append({
            'id': sector.get('id'),
            'adjacent': sector.get('adjacent'),
            'portal': sector.get('portal')
        })
    return jsonify(sectors)

def _file_path(name):
    if not name.endswith('.strmml'):
        name += '.strmml'
    return os.path.join(os.path.dirname(__file__), name)

@app.route('/strmml')
@app.route('/strmml/<path:name>')
def serve_strmml(name='sample'):
    path = _file_path(name)
    if not os.path.exists(path):
        abort(404)
    return send_file(path, mimetype='text/plain')

@app.route('/sectors')
@app.route('/sectors/<path:name>')
def list_sectors(name='sample'):
    path = _file_path(name)
    if not os.path.exists(path):
        abort(404)
    return _list_sectors_from(path)

@app.route('/portal/<sector_id>')
def follow_portal(sector_id):
    """Return the content referenced by a sector's portal.

    If the portal uses the ``strmml://`` scheme, the server performs a DNS
    lookup and fetches the remote Strmml file via HTTP. Otherwise the portal
    is treated as a local file name within this server.
    """
    tree = ET.parse(_file_path('sample'))
    root = tree.getroot()
    sector = root.find(f"sector[@id='{sector_id}']")
    if sector is None:
        abort(404)
    portal = sector.get('portal')
    if not portal:
        abort(404)
    if portal.startswith('strmml://'):
        url = 'http://' + portal[len('strmml://'):]
        with urlopen(url) as resp:
            data = resp.read()
        return data, 200, {'Content-Type': 'text/plain'}
    else:
        path = _file_path(portal)
        if not os.path.exists(path):
            abort(404)
        return send_file(path, mimetype='text/plain')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
