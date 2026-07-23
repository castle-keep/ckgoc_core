import 'package:ckgoc_core/ckgoc_core.dart';
import 'package:flutter/material.dart';

import 'package:ckgoc_docs_app/docs/doc_models.dart';
import 'package:ckgoc_docs_app/docs/doc_widgets.dart';

class BrandIconsPage extends StatelessWidget {
  const BrandIconsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DocsScaffold(
      title: 'Brand Icons and Logos',
      subtitle:
          'Documentation for lib/src/themes/brand_icon.dart and lib/src/themes/ckgoc_brand.dart. This page shows helper usage, all BrandIconVariant values, all brands, and every packaged asset constant defined in the current BrandIcon catalog.',
      children: [
        DocSection(data: _brandEnumDoc()),
        DocSection(data: _brandVariantHelperDoc()),
        DocSection(data: _allAssetGalleryDoc()),
      ],
    );
  }
}

ComponentDocData _brandEnumDoc() => const ComponentDocData(
      title: 'CkgocBrand',
      summary:
          'Theme brand selector. It controls theme tokens, colors, typography, and default logo helpers.',
      demo: _BrandEnumDemo(),
      code: '''
for (final brand in CkgocBrand.values) {
  debugPrint(brand.displayName);
}
''',
      params: [
        DocParam(
          name: 'castleKeep',
          type: 'CkgocBrand',
          description: 'CastleKeep brand palette and assets.',
        ),
        DocParam(
          name: 'skyGo',
          type: 'CkgocBrand',
          description: 'SkyGo brand palette and assets.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Where is displayName used?',
          answer:
              'Use it in docs, brand selectors, or app-shell labels when you need a human-readable brand string.',
        ),
        DocFaq(
          question: 'Does brand affect only logos?',
          answer:
              'No. It also drives resolved theme tokens and any brand-specific defaults that the package exposes.',
        ),
      ],
    );

ComponentDocData _brandVariantHelperDoc() => const ComponentDocData(
      title: 'BrandIcon.brandLogoWidget and BrandIconVariant',
      summary:
          'Primary helper for rendering packaged brand assets. The demo renders all BrandIconVariant values for every CkgocBrand.',
      demo: _BrandVariantHelperDemo(),
      code: '''
BrandIcon.brandLogoWidget(
  context,
  CkgocBrand.castleKeep,
  variant: BrandIconVariant.master,
  size: 64,
)
''',
      params: [
        DocParam(
          name: 'context',
          type: 'BuildContext',
          description: 'Used for theme-aware resolution.',
          requiredParam: true,
        ),
        DocParam(
          name: 'brand',
          type: 'CkgocBrand',
          description: 'Brand whose asset set should be used.',
          requiredParam: true,
        ),
        DocParam(
          name: 'size',
          type: 'double',
          description: 'Requested width and height.',
          defaultValue: '40',
        ),
        DocParam(
          name: 'variant',
          type: 'BrandIconVariant',
          description: 'master, logo, or name asset family.',
          defaultValue: 'BrandIconVariant.master',
        ),
        DocParam(
          name: 'assetPath',
          type: 'String?',
          description:
              'Explicit asset override if you want a specific asset constant instead of automatic resolution.',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'When should I pass assetPath manually?',
          answer:
              'Use assetPath when you need one exact logo file such as a specific master variant or alternate wordmark, rather than the default helper mapping.',
        ),
        DocFaq(
          question: 'How are SVG and raster assets handled?',
          answer:
              'The helper delegates SVG rendering through SvgPicture and raster rendering through Image.asset internally.',
        ),
      ],
      notes: [
        'Enum demo coverage: all CkgocBrand values and all BrandIconVariant values are rendered.',
      ],
    );

ComponentDocData _allAssetGalleryDoc() => const ComponentDocData(
      title: 'All Packaged Logo Assets',
      summary:
          'Direct asset gallery for every currently defined BrandIcon asset constant across CastleKeep and SkyGo.',
      demo: _BrandAssetGalleryDemo(),
      code: '''
BrandIcon.assetLogoWidget(
  context,
  BrandIcon.castlekeepMaster,
  size: 72,
)
''',
      params: [
        DocParam(
          name: 'assetPath',
          type: 'String',
          description: 'Concrete packaged asset path constant from BrandIcon.',
          requiredParam: true,
        ),
        DocParam(
          name: 'size',
          type: 'double',
          description: 'Requested display size.',
          defaultValue: '40',
        ),
      ],
      faqs: [
        DocFaq(
          question: 'Why document direct assets if helper methods exist?',
          answer:
              'Because marketing surfaces sometimes require one exact lockup, wordmark, or alternate symbol rather than the default master/logo/name mapping.',
        ),
        DocFaq(
          question:
              'What should I do if a specific asset is missing on my screen?',
          answer:
              'Verify the package asset exists, the asset path constant matches the current catalog, and the consuming app picked up the package assets after pub get.',
        ),
      ],
    );

class _BrandEnumDemo extends StatelessWidget {
  const _BrandEnumDemo();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final brand in CkgocBrand.values)
          Chip(label: Text('${brand.name} → ${brand.displayName}')),
      ],
    );
  }
}

class _BrandVariantHelperDemo extends StatelessWidget {
  const _BrandVariantHelperDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final brand in CkgocBrand.values) ...[
          Text(
            brand.displayName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const VSpace(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final variant in BrandIconVariant.values)
                Container(
                  width: 140,
                  child: Column(
                    children: [
                      Container(
                        height: 72,
                        child: Center(
                          child: BrandIcon.brandLogoWidget(
                            context,
                            brand,
                            variant: variant,
                            size: 72,
                          ),
                        ),
                      ),
                      const VSpace(height: 8),
                      Text(variant.name),
                    ],
                  ),
                ),
            ],
          ),
          const VSpace(height: 24),
        ],
      ],
    );
  }
}

class _BrandAssetGalleryDemo extends StatelessWidget {
  const _BrandAssetGalleryDemo();

  static const castleKeepAssets = <String>[
    BrandIcon.castlekeepMaster,
    BrandIcon.castlekeepName,
    BrandIcon.castlekeepSymbol,
    BrandIcon.castlekeepLogo1,
    BrandIcon.castlekeepLogo1Svg,
    BrandIcon.castlekeepLogo2,
    BrandIcon.castlekeepLogo2Svg,
    BrandIcon.castlekeepLogo3,
    BrandIcon.castlekeepLogo3Svg,
    BrandIcon.castlekeepLogo4Svg,
    BrandIcon.castlekeepLogoB,
    BrandIcon.castlekeepLogoC1,
    BrandIcon.castlekeepLogoC2,
    BrandIcon.castlekeepMaster2,
    BrandIcon.castlekeepMaster2Svg,
    BrandIcon.castlekeepMaster3,
    BrandIcon.castlekeepMaster3Svg,
    BrandIcon.castlekeepMaster4Svg,
    BrandIcon.castlekeepMasterC1,
    BrandIcon.castlekeepMasterC2,
    BrandIcon.castlekeepMasterW,
    BrandIcon.castlekeepName2,
    BrandIcon.castlekeepName2Svg,
    BrandIcon.castlekeepName3,
    BrandIcon.castlekeepName3Svg,
    BrandIcon.castlekeepName4Svg,
    BrandIcon.castlekeepNameB,
  ];

  static const skyGoAssets = <String>[
    BrandIcon.skygoMasterSvg,
    BrandIcon.skygoName,
    BrandIcon.skygoSymbol,
    BrandIcon.skygoLogo1,
    BrandIcon.skygoLogo2,
    BrandIcon.skygoLogo3,
    BrandIcon.skygoMaster2,
    BrandIcon.skygoMaster3,
    BrandIcon.skygoName2,
    BrandIcon.skygoName3,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _assetGroup(context, 'CastleKeep assets', castleKeepAssets),
        const VSpace(height: 24),
        _assetGroup(context, 'SkyGo assets', skyGoAssets),
      ],
    );
  }

  Widget _assetGroup(BuildContext context, String title, List<String> assets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const VSpace(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            for (final asset in assets)
              Container(
                width: 220,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 72,
                          child: Center(
                            child: BrandIcon.assetLogoWidget(
                              context,
                              asset,
                              size: 72,
                            ),
                          ),
                        ),
                        const VSpace(height: 12),
                        SelectableText(
                          asset,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
