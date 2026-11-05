# Rollback Strategy

## Objective
Restore the previous stable Checkout API version if release
v2.4 causes production issues.

## Rollback Triggers
- Application health checks fail.
- Pods repeatedly restart or enter CrashLoopBackOff.
- Critical API functionality becomes unavailable.
- Database or Redis connectivity fails.
- Production errors increase significantly.

## Rollback Procedure

1. Inspect the deployment history:

   kubectl rollout history deployment/checkout-api -n checkout-system

2. Roll back to the previous revision:

   kubectl rollout undo deployment/checkout-api -n checkout-system

3. Monitor the rollout:

   kubectl rollout status deployment/checkout-api -n checkout-system

4. Verify pod health:

   kubectl get pods -n checkout-system

5. Verify service availability and application health.

## Recovery
If the automatic rollback is insufficient, identify the last
known stable image and restore the corresponding deployment
configuration.

## Post-Rollback Actions
- Investigate the release failure.
- Preserve relevant application logs.
- Document the incident.
- Correct the underlying issue before attempting another release.

Note: Rollback assumes a previous stable Deployment revision exists.
Database schema changes may require a separate recovery procedure.
