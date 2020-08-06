# Overview

**Title:** fanclub  
**Category:** Crypto  
**Flag:** libctf{padding_oracle_attack_first_published_2002}  
**Difficulty:** easy to moderate  

# Usage

The following will pull the latest 'elttam/ctf-fanclub' image from DockerHub, run a new container named 'libctfso-fanclub', and publish the vulnerable service on port 80:

```sh
docker run --rm \
  --publish 80:80 \
  --name libctfso-fanclub \
  elttam/ctf-fanclub:latest
```

# Build (Optional)

If you prefer to build the 'elttam/ctf-fanclub' image yourself you can do so first with:

```sh
docker build ${PWD} \
  --tag elttam/ctf-fanclub:latest
```
