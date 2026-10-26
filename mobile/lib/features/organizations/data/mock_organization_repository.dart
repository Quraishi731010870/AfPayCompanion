import '../domain/organization.dart';

const _bankSource = 'Da Afghanistan Bank — Licensed Banks';
const _bankSourceUrl = 'https://dab.gov.af/licensed-banks';
const _emiSource =
    'Da Afghanistan Bank — Licensed Electronic Money Institutions';
const _emiSourceUrl =
    'https://www.dab.gov.af/non-banking-financial-institutions';

class MockOrganizationRepository implements OrganizationRepository {
  static final _items = <Organization>[
    _bank(
      'bank-e-millie-afghan',
      'Bank-e-Millie Afghan',
      'BMA',
      'www.bma.com.af',
      'Ibni-Sina Watt, Kabul',
      '+93 (0)20 210 2119',
    ),
    _bank(
      'pashtany-bank',
      'Pashtany Bank',
      'PB',
      'www.pashtanybank.com.af',
      'Mohammad Jan Khan Watt, Kabul',
      '+93 (0)20 210 3863',
    ),
    _bank(
      'new-kabul-bank',
      'New Kabul Bank',
      'NKB',
      'www.newkabulbank.af',
      'Turabaz Khan Square, Shahr-e-Naw, Kabul',
      '+93 (0)20 222 2666',
    ),
    _bank(
      'azizi-bank',
      'Azizi Bank',
      'AZB',
      'www.azizibank.af',
      'Zanbaq Square, Kabul',
      '+93 (0)701 801 515',
    ),
    _bank(
      'afghanistan-international-bank',
      'Afghanistan International Bank',
      'AIB',
      'www.aib.af',
      'Airport Road, Bibi Mahro, Kabul',
      '+93 (0)20 255 1700',
    ),
    _bank(
      'islamic-bank-afghanistan',
      'Islamic Bank of Afghanistan',
      'IBA',
      'www.ibafg.com',
      'Shahr-e-Naw, Kabul',
      '',
    ),
    _bank(
      'maiwand-bank',
      'Maiwand Bank',
      'MB',
      'www.maiwandbank.com',
      'Turabaz Khan Square, Kabul',
      '+93 (0)20 270 0300',
    ),
    _bank(
      'afghan-united-bank',
      'Afghan United Bank',
      'AUB',
      'www.afghanunitedbank.com',
      'Zarghona Maidan, Shahr-e-Naw, Kabul',
      '+93 (0)20 220 3834',
    ),
    _bank(
      'first-microfinance-bank',
      'The First MicroFinance Bank',
      'FMFB',
      'www.fmfb.com.af',
      'Kolula Pushta Road, Kabul',
      '+93 (0)705 010 104',
    ),
    _bank(
      'ghazanfar-bank',
      'Ghazanfar Bank',
      'GB',
      'www.ghazanfarbank.com',
      'Sherpoor Main Road, Kabul',
      '+93 (0)20 210 1111',
    ),
    _bank(
      'national-bank-pakistan',
      'National Bank of Pakistan',
      'NBP',
      'www.nbp.com.pk',
      'Wazir Akbar Khan, Kabul',
      '+93 (0)20 230 2729',
    ),
    _bank(
      'bank-alfalah',
      'Bank Alfalah',
      'BAF',
      'www.bankalfalah.com',
      'Shahr-e-Naw, Kabul',
      '',
    ),
    _emi(
      'm-paisa',
      'M-Paisa',
      'MP',
      'https://roshan.af/m-paisa',
      'Shahr-e-Naw, Kabul',
      '+93 (0)799 992 015',
    ),
    _emi(
      'm-hawala',
      'M-Hawala',
      'MH',
      'www.mhawala.af',
      'Ehsan Plaza, Shahr-e-Naw, Kabul',
      '+93 (0)781 202 202',
    ),
    _emi(
      'my-money',
      'My-Money',
      'MM',
      'www.mymoney.af',
      'Dar-ul-Aman Road, Kabul',
      '+93 (0)704 801 801',
    ),
    _emi(
      'atoma-pay',
      'ATOMA Pay',
      'AP',
      'https://www.mtn.com.af/momo/',
      'Shahr-e-Naw, Kabul',
      '+93 (0)772 222 222',
    ),
    _emi(
      'hesabpay',
      'HesabPay',
      'HP',
      'https://hesab.com/',
      'Opposite MRRD, Kabul',
      '+93 (0)793 111 299',
    ),
    _emi(
      'aurum-pay',
      'Aurum Pay',
      'AUR',
      'www.aurumaf.com',
      'Wazir Mohammad Akbar Khan, Kabul',
      '+93 (0)789 056 056',
    ),
    _emi(
      'star-pay',
      'Star Pay',
      'SP',
      'www.starpay.af',
      'Kolola Pushta, Shahr-e-Naw, Kabul',
      '+93 (0)790 222 222',
    ),
    _emi(
      'las-pay',
      'Las Pay',
      'LP',
      'https://laspay.com',
      'Park Tower, Shahr-e-Naw, Kabul',
      '+93 74 448 4777',
    ),
    Organization(
      id: 'afghanistan-payments-system',
      name: 'Afghanistan Payments System',
      shortName: 'APS',
      type: OrganizationType.paymentInstitution,
      description: 'Development directory profile for Afghanistan Payments System. Confirm current services with the official source.',
      services: const [
        'Payment infrastructure',
        'AfPay information',
        'Payment education',
      ],
      city: 'Kabul',
      address: 'Kabul, Afghanistan',
      phone: '020 221 0622',
      website: 'https://aps.gov.af',
      source: 'User-provided APS media and public APS website',
      sourceUrl: 'https://aps.gov.af',
      lastVerified: DateTime(2026, 10, 26),
      status: VerificationStatus.pending,
      imageAsset: 'assets/demo/aps/logo-aps.png',
    ),
  ];

  static Organization _bank(
    String id,
    String name,
    String shortName,
    String website,
    String address,
    String phone,
  ) => Organization(
    id: id,
    name: name,
    shortName: shortName,
    type: OrganizationType.bank,
    description: 'Bank listed in Da Afghanistan Bank’s public licensed banks directory. Confirm services and availability directly with the institution.',
    services: const ['Branch banking', 'Payment services', 'Customer support'],
    city: 'Kabul',
    address: address,
    phone: phone,
    website: website,
    source: _bankSource,
    sourceUrl: _bankSourceUrl,
    lastVerified: DateTime(2026, 10, 26),
    status: VerificationStatus.verified,
  );

  static Organization _emi(
    String id,
    String name,
    String shortName,
    String website,
    String address,
    String phone,
  ) => Organization(
    id: id,
    name: name,
    shortName: shortName,
    type: OrganizationType.emi,
    description: 'Electronic money institution listed in Da Afghanistan Bank’s public directory. Confirm current products directly with the provider.',
    services: const [
      'Electronic money',
      'Digital payments',
      'Customer support',
    ],
    city: 'Kabul',
    address: address,
    phone: phone,
    website: website,
    source: _emiSource,
    sourceUrl: _emiSourceUrl,
    lastVerified: DateTime(2026, 10, 26),
    status: VerificationStatus.verified,
  );

  @override
  Future<List<Organization>> getOrganizations({
    OrganizationType? type,
    String query = '',
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 220));
    final q = query.trim().toLowerCase();
    return _items
        .where(
          (x) =>
              (type == null || x.type == type) &&
              (q.isEmpty ||
                  x.name.toLowerCase().contains(q) ||
                  x.city.toLowerCase().contains(q) ||
                  x.services.any((s) => s.toLowerCase().contains(q))),
        )
        .toList();
  }

  @override
  Future<Organization?> getById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    for (final item in _items) {
      if (item.id == id) return item;
    }
    return null;
  }
}
