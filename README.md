# Shopware 6

Shopware is a trendsetting ecommerce platform to power your online business. Our ecommerce solution offers the perfect combination of beauty & brains you need to build and customize a fully responsive online store.

# WIP - In Work
**DON'T use it unless you know what you do**

## Prerequisites

- min Shopware 6.3.0.0
- External Storage like S3, GCP
- Kubernetes 1.12+
- Helm 3
- PV provisioner support in the underlying infrastructure

## Parameters

See ``values.yml``

## Installation

* Generate a JWT Token using `generate_jwt.php` script
* Configure parameters
* Run `helm dependency update && helm install`

## Example parameters

### With S3 Storage

```bash
helm install -f values.yml shopware .
```

```yaml
db:
  name: shopware
  root:
    password: shopware

shopware:
  appUrl: "http://shop.com"
  databaseHost: "shopware-mysql"
  databaseUrl: "mysql://root:shopware@shopware-mysql:3306/shopware"
  customConfig: |-
    shopware:
      filesystem:
        theme:
          type: amazon-s3
          config:
            options:
              visibility: public
            bucket: theme
            credentials:
              key: Key
              secret: Secret
            endpoint: 'https://s3.myshop.com'
          url: 'https://s3.myshop.com/theme'
        private:
          config:
            options:
              visibility: private
            bucket: private
            credentials:
              key: Key
              secret: Secret
            endpoint: 'https://s3.myshop.com'
          type: amazon-s3
        sitemap:
          config:
            credentials:
              key: Key
              secret: Secret
            options:
              visibility: public
            bucket: sitemap
          type: amazon-s3
          url: 'https://s3.myshop.com/asset'
        public:
          config:
            credentials:
              key: Key
              secret: Secret
            options:
              visibility: public
            bucket: public
          type: amazon-s3
          url: 'https://s3.myshop.com'
        asset:
          config:
            endpoint: 'https://s3.myshop.com'
            bucket: asset
            credentials:
              key: Key
              secret: Secret
          type: amazon-s3
          url: 'https://s3.myshop.com/asset'


ingress:
  hosts:
    - host: shop.com
      paths: ['/']
```
