# Gaslow App

Flutter App to check gas station prices in Italy.

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

## How to add secrets

### Android

If you want to add a secret in resources:

- Add it in `android/resource-secrets.xml`
- `cd android/secrets`
- `tar cvf secrets.tar *`
- `travis encrypt-file secrets.tar`

If you want to check if it works locally:

- `cp android/secrets/resource-secrets.xml android/app/src/main/res/values/secrets.xml`
