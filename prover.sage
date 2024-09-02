from params import G, H, Fq
from utils import compute_hash, save_proof

# First, let us generate some random representation
alpha = Fq.random_element()
beta = Fq.random_element()
u = alpha * G + beta * H # This is the value we want to prove knowledge of

# Next, we compute the commitment
alpha_r = Fq.random_element()
beta_r = Fq.random_element()
u_r = alpha_r * G + beta_r * H

# Next, we compute the challenge
c = compute_hash(u, u_r)

# Finally, we compute the response
alpha_z = alpha_r + alpha * c
beta_z = beta_r + beta * c

# The proof is the tuple (u_r, alpha_z, beta_z)
proof = (u_r, alpha_z, beta_z)
print('Proof generated successfully!')

# Save the proof to a file
save_proof(u, proof)
print('Proof saved successfully!')
