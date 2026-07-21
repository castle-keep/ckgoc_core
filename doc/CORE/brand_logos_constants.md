BrandIcon constants
=====================

This file lists the `BrandIcon` constants exported by the package and the
asset path each constant points to. Use these constants with `Image.asset`
(PNG) or `SvgPicture.asset` (SVG) and pass `package: 'ckgoc_core'` when
loading from a consuming app.

CastleKeep
----------

- `castlekeepMaster`: assets/images/logos/ck/castlekeep_master_logo_1.png
- `castlekeepName`: assets/images/logos/ck/castlekeep_name_logo_1.png
- `castlekeepSymbol`: assets/images/logos/ck/castlekeep_logo_1.png
- `castlekeepLogo1`: assets/images/logos/ck/castlekeep_logo_1.png
- `castlekeepLogo1Svg`: assets/images/logos/ck/castlekeep_logo_1.svg
- `castlekeepLogo2`: assets/images/logos/ck/castlekeep_logo_2.png
- `castlekeepLogo2Svg`: assets/images/logos/ck/castlekeep_logo_2.svg
- `castlekeepLogo3`: assets/images/logos/ck/castlekeep_logo_3.png
- `castlekeepLogo3Svg`: assets/images/logos/ck/castlekeep_logo_3.svg
- `castlekeepLogo4Svg`: assets/images/logos/ck/castlekeep_logo_4.svg
- `castlekeepLogoB`: assets/images/logos/ck/castlekeep_logo_b.png
- `castlekeepLogoC1`: assets/images/logos/ck/castlekeep_logo_c1.png
- `castlekeepLogoC2`: assets/images/logos/ck/castlekeep_logo_c2.png
- `castlekeepMaster2`: assets/images/logos/ck/castlekeep_master_logo_2.png
- `castlekeepMaster2Svg`: assets/images/logos/ck/castlekeep_master_logo_2.svg
- `castlekeepMaster3`: assets/images/logos/ck/castlekeep_master_logo_3.png
- `castlekeepMaster3Svg`: assets/images/logos/ck/castlekeep_master_logo_3.svg
- `castlekeepMaster4Svg`: assets/images/logos/ck/castlekeep_master_logo_4.svg
- `castlekeepMasterC1`: assets/images/logos/ck/castlekeep_master_logo_c1.png
- `castlekeepMasterC2`: assets/images/logos/ck/castlekeep_master_logo_c2.png
- `castlekeepMasterW`: assets/images/logos/ck/castlekeep_master_logo_w.png
- `castlekeepName2`: assets/images/logos/ck/castlekeep_name_logo_2.png
- `castlekeepName2Svg`: assets/images/logos/ck/castlekeep_name_logo_2.svg
- `castlekeepName3`: assets/images/logos/ck/castlekeep_name_logo_3.png
- `castlekeepName3Svg`: assets/images/logos/ck/castlekeep_name_logo_3.svg
- `castlekeepName4Svg`: assets/images/logos/ck/castlekeep_name_logo_4.svg
- `castlekeepNameB`: assets/images/logos/ck/castlekeep_name_logo_b.png

SkyGo
-----

- `skygoMasterSvg`: assets/images/logos/skygo/skygo_master_logo_1.svg
- `skygoName`: assets/images/logos/skygo/skygo_name_logo_1.svg
- `skygoSymbol`: assets/images/logos/skygo/skygo_logo_1.svg
- `skygoLogo1`: assets/images/logos/skygo/skygo_logo_1.svg
- `skygoLogo2`: assets/images/logos/skygo/skygo_logo_2.svg
- `skygoLogo3`: assets/images/logos/skygo/skygo_logo_3.svg
- `skygoMaster2`: assets/images/logos/skygo/skygo_master_logo_2.svg
- `skygoMaster3`: assets/images/logos/skygo/skygo_master_logo_3.svg
- `skygoName2`: assets/images/logos/skygo/skygo_name_logo_2.svg
- `skygoName3`: assets/images/logos/skygo/skygo_name_logo_3.svg

Usage examples
--------------

```dart
// PNG
Image.asset(BrandIcon.castlekeepName, package: 'ckgoc_core');

// SVG (rendered by the package)
BrandIcon.brandLogoWidget(context, CkgocBrand.skyGo, size: 40);

// Use the helper widget
BrandIconWidget(brand: CkgocBrand.castleKeep, variant: BrandIconVariant.name);
```
