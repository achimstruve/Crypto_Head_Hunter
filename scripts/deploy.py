from scripts.helpful_scripts import get_account
from brownie import CandidateNFT

def deploy_candidateNFT():
    account = get_account()
    candidateNFT = CandidateNFT.deploy({"from": account})

def main():
    deploy_candidateNFT()