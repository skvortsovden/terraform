
**case**:
an app running in us-west-2 that requires 6 EC2 Instances running at all times. With 3 AZs in the region (us-west-2a,us-west-2b,us-west-2c).

**todo**: provide fault tollerance deployment if one AZ in the us-west-2 becomes unavailable.

**solutions:**
1. Spread accross all AZs. 

- 3 x EC2 in us-west-2a
- 3 x EC2 in us-west-2b
- 3 x EC2 in us-west-2c

2. Spread accross 2/3 AZs. 

- 6 x EC2 in us-west-2a
- 6 x EC2 in us-west-2b
- 0 x EC2 in us-west-2c