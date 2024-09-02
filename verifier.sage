from params import G, H, Fq
from utils import compute_hash, read_proof

# Read the proof from the file
(u, u_r, alpha_z, beta_z) = read_proof()

c = compute_hash(u, u_r)
check = (alpha_z * G + beta_z * H) == u_r + c * u

if check:
    print('Proof verified successfully!')
else:
    print('Proof verification failed!')

