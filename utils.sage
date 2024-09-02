import json

from hashlib import sha256
from typing import Tuple
from params import E, Fq

def compute_hash(u: E, u_r: E) -> Fq:
    """
    Given two points u and u_r, compute the hash H(u, u_r)
    """

    result = str(u[0]) + str(u_r[0]) # Concatenate the two x values
    hexdigest = result.encode('utf-8') # Compute the hash
    return Fq('0x'+sha256(hexdigest).hexdigest()) # Return the result as an element of Fq

def save_proof(u: E, proof: Tuple[E, Fq, Fq]):
    """
    Save the proof to a file proof.json
    """

    (u_r, alpha_z, beta_z) = proof

    with open('proof.json', 'w') as f:
        json.dump({
            'u': {
                'x': str(u[0]),
                'y': str(u[1])
            },
            'u_r': {
                'x': str(u_r[0]),
                'y': str(u_r[1])
            },
            'alpha_z': str(alpha_z),
            'beta_z': str(beta_z)
        }, f, indent = 4) 

def read_proof() -> Tuple[E, E, Fq, Fq]:
    """
    Read the proof from the file proof.json
    """

    with open('proof.json', 'r') as f:
        data = json.load(f)

    u = E((Fq(data['u']['x']), Fq(data['u']['y'])))
    u_r = E((Fq(data['u_r']['x']), Fq(data['u_r']['y'])))
    alpha_z = Fq(data['alpha_z'])
    beta_z = Fq(data['beta_z'])

    return (u, u_r, alpha_z, beta_z)
