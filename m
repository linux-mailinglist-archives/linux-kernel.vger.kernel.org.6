Return-Path: <linux-kernel+bounces-390045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000A9B74E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838261F25015
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05F145B1D;
	Thu, 31 Oct 2024 07:02:53 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D91BD9CD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358172; cv=fail; b=mc/YPW8dZiqylrcleUwPd130kICF/B0zmdCtQ1i+VeqlybDBRx+XOORS7hNOtnKGhp8mRaafF+DbdDZhHifm35/TkFdQP8sfBkkAAuanGJj8MA3C19C5DxB4lYMFaj9uP99jfENM+PioxSff0VSF520TsGNVb3dCB+uDkz3TmcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358172; c=relaxed/simple;
	bh=tHcYe15DcFfqkzDAWDnnCOf4ooEfNjE8o8MK4KihVjc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aAvINdF8xLfMlehSdbi9h3vafdGwrJnPDPyLhVoBIJmJC3ZdYPaMqJECfv0gYolqXQ0w/Yg1ht86zv7C2mvGl+lcO7tjUQchilAuKddllJDwKiUv4pwrka0LP6IUkb3FaxaOJuolbJU3t9xmeZPRyC0HhTueYw9TEG5khX6cKIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0NpZeByws25xSaVBNfLQEOSUCFp/bM2KnQnpZx2sZxd4MKRb3x0yZ1krcoRSffdZHfLYH0qu3lKkllvcBP4GWfIEr0n+XVyG3NLI0pF2oud/UyhyX0XBcG1N/gBgC/EqAHG9RKKZHivMCtp88gz8vNsbt2r+V+6Q4NwOjGdk41v+1bxFvcPvUvfb2TCsie9jboCs/p7EmNP/wMdS9gUV/FnicFsTPMSr73fiHh6jopf0/4Ewr3zUp7H88BPupGjIVoODL8GPoZSIaph4Y0T1C5OXZsWl1zQKDJ6wHMFue8YB3sPJaxz7bNiCZM83VKvJx3USOOsMFSFDgRU/lc9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHcYe15DcFfqkzDAWDnnCOf4ooEfNjE8o8MK4KihVjc=;
 b=J57f/RqkZeqYuvw6Cf78slt0jdB0J3pf23VoNRoVxKrkRdSqkxYv+P0cCwENw0BKBu6bgNgciVoqRRRTC417vWp2GTOSoAyM2BY7evUWdCAcWQTOQyA3jsteo/ygCZbP1vQy36P7gBBGSaHmBWPF0ZlbxvYJntxZGJHawquRSYJqC5f8BoLeTGygApIDzzur3ThDLOmkwm6BzoRlulC/l74Yl0Oh13KP18bf4Cy+b5lwxKqmjKNGVzBWsig+J14uB+eLupdbgw/QL2g0TtjBMomtnRdCWulsKI4rwZL7HHnR96mT7SSWXPJNxfVi/cHZUp2pcvIA04qArl8CI4849w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1221.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.36; Thu, 31 Oct
 2024 07:02:43 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.8069.034; Thu, 31 Oct 2024 07:02:43 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>
CC: "lkp@intel.com" <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject:
 =?gb2312?B?u9i4tDogZHJpdmVycy9waHkvc3RhcmZpdmUvcGh5LWpoNzExMC1kcGh5LXR4?=
 =?gb2312?B?LmM6MzM1IHN0Zl9kcGh5X2luaXQoKSB3YXJuOiAnZHBoeS0+dHhlc2NfY2xr?=
 =?gb2312?B?JyBmcm9tIGNsa19wcmVwYXJlX2VuYWJsZSgpIG5vdCByZWxlYXNlZCBvbiBs?=
 =?gb2312?Q?ines:_332.?=
Thread-Index: AQHbK2HsTAJnoaMZ2kSva+GAh/I4TrKgbgJg
Date: Thu, 31 Oct 2024 07:02:43 +0000
Message-ID:
 <ZQ0PR01MB1302617980DB7E9A514611F2F2552@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1221:EE_
x-ms-office365-filtering-correlation-id: 42acf57c-f783-4dd4-64e2-08dcf97a04a2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 2ya/6gJKP+RXgEfQZnpXbq9FCJzbgwI3Y6C4237ziuMGUNRG2UHT5a6pxL9EdlLUjzBs5V2UuJbz8wJilGRBRdmI0fSB/gYoqD0fnFnAvGJucwYyfFcq3d2LrJUrj/tuxYzEbP1m0m5uTEIo3PMmvFD0BH98SPyV7GmD0gZOYvY1sS25O5FtHKF2GD8lCQIdRyFMs4RlVjQkuexthuWmFgolaTfW5ajF/dUQM7JNk0zirRT0Xy4M3YQ6n94rOu1zrw/K4b5cAQEPHv4GtGkOejj4dLNhk4uiszSoV0a1OXxfXqbT72zeXkN4v/LvlJRJWlrF2/FLmBWMn4z+lduvzUSY0/15h9K7HO544Qvgd1bXSJnbOKPhKQ80zZlyQHvzMy8D4wuu+jvMH63MgWBqsbJ5rIp4D9Z+NxLVEbJGIsauI5npUMrStnjQMAP0+a7u6+DffM0kBJKPJbvd2WwJlxd3XzK7Wqp9LmmDU3Kz8KuxMZ/KUj48VieqGd5zIED3zbs7nG/Xd10cE6dsHzob55SdEgOPTYGWfwRBO+01qZ5/nNnTr++sfSNookzyRF+HOA7YrOlvvXVGouAXDJkvAD8Mg7rPYSFANGAkIwyhHndWGDu+Weas+B/KK9+nj2rZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NUc1eXJHT1V6enFQZ0VLYkU5QUZaR1FGMStKbS9NS3NVRzlVbjVIRHYzNGtB?=
 =?gb2312?B?NXpvZHJCYytPREFqNnMrRHBVYmJSYzhFM0ZqMHF0OFB1c0ttaExTMTNmTVIy?=
 =?gb2312?B?RkNoMVQraURiWnJiQWZWcVZBNEdid3Y1aGtVM3k4WGF1MWhxMWpOSjA4Zjcv?=
 =?gb2312?B?M0xHdnMwdHRLMGR6Z2h2WGcrc1p3YlFNUUp4dmRtVGRqK2tLZ2xEbTRDQkY3?=
 =?gb2312?B?Nnd0WUpoVXM1QmdtdHBwc0dtbTlUVXA2LzZDUDFGVGV2YVdONFRGM09RbHRL?=
 =?gb2312?B?ZXFBc0NYa1ZvbnBWL2dBZTBuclRzSitNK25tcXBMdHk3K0ZWTmxoMDFyZmJG?=
 =?gb2312?B?NGU0RUFkdEwxMTN0TmpLeGlyZkxDWDdqbFJMZXJQVUpCbUlFTlgrUS9vSmNJ?=
 =?gb2312?B?T1dQcHVuQjdKYTZRbnpncmtxeUZXR3ovdXhVOUs3ZDF0bE43RWFGODRmdW5h?=
 =?gb2312?B?bmQzTkpBWnEycWo1Ui9RaHNaV2hVeHNKWmp1eG9xTEExRDVXcWNNVjdqeHNq?=
 =?gb2312?B?MStrNVdpSS9HZ0ptSURpMVRWRFB0VGxIcEhSYkZjVytQSFhQSUh6SlYyTWFQ?=
 =?gb2312?B?YUxWYTk4Sy95TUxYK0ZQR1daalc3NE4vOUhPb05kRCsycmVmUnlwYlIvd1h3?=
 =?gb2312?B?ZUtOWXJGU3E0eVFEdU54UnpDZklOQzQyR2xvUXR3ekdWNnNTeWJQd2xVN0o2?=
 =?gb2312?B?YU9WaXl3R1l2ZlQ2OUhEM3lzZ1k5QmNIcCtkWUx5eW9neis3YlpZL3lxNWtv?=
 =?gb2312?B?WUJvWG1EanhNUzNuUWxWMVZkZy9peVU4N054cmtLclZvcE11NE5USGZSVGpK?=
 =?gb2312?B?WHVRRnAwSVFBR2FmeXlVZHltbGJ4Qjd5KzlxOTFYbEw2ZHBIbFM3K2FTV3ZL?=
 =?gb2312?B?dWFzTi9TeUhrZUh0TW8vYXJ5ZXYrRmlUUlBsWi8rVFRWUDNuNmRoSFdGSzRF?=
 =?gb2312?B?Y0IzNXZHMUdDaVg3TnlzZ2kxSXlzVnZsaENjTXBPaUYycVRSZUY5MVpHSEt3?=
 =?gb2312?B?Z3U1K3VucjIxUnowUXA5Z1RvQXpiZVhBNllaemxaT0cvVVI4QVJaNm9ZRDE3?=
 =?gb2312?B?elVXYUNrdm1Cc09lTTZxSWdiQjF6UGdDOUh6U3MxS3hFQ0taV1Q3OTd1QjY4?=
 =?gb2312?B?RzUwK0ZyQTYydzVxZ1dXQVZBTjlJQnZYeFVVb2plTFhhRlhyNVIzLzFDZjlv?=
 =?gb2312?B?NndyY3dCVVNZRSswa0pZbUgrMXp1bUtSb3Z0aW9YZWtGblU4aWN4WThiTm56?=
 =?gb2312?B?Y01iM3haRjY2NWc1M3lEUkRLKzkxM0JoazFzN08zQ3A3OGZvd0RiSVZIRWM4?=
 =?gb2312?B?NHFqVXB1dTRvQVlROGJTRjFCMUFCUzByR3FNb3JwdGx4cEh3cXFUSXlmSzdv?=
 =?gb2312?B?Z29jWUNydWtSZVd3NFF6NmdDNjRjOFh3K2pySTl6VEJrb3kxSkVnMVc4cXBX?=
 =?gb2312?B?Rm5sd1Z4eldPMERCL3VmbGtPR1crMnpNVE5CbUtWZjEyQnpuOG93cGllaThM?=
 =?gb2312?B?SjJGZFRULytsQklQQlVkdTdLc29aMlVRd0FlbUZoRVFWcytkVnZPSFpYa2dI?=
 =?gb2312?B?SkdlTkxGSE5FQjZiVTN1WnA0ZG9lc3laUkgvSHZvb2R2bTBSc1V2T0MwWFND?=
 =?gb2312?B?T3FxRHU0Ynh2TkN6L25Ec0RpeTU3LytLa01uSUdKcThFNmtlSXlIRU16N2VM?=
 =?gb2312?B?ampzeUhhNDg3eDQvR1BWUkxpYzUrL1JxOU4zbWNaSDZJTXpEUm1ud09RUi9H?=
 =?gb2312?B?aXJjZlV4dWV4S0E2TnpaQU93bU1OL2Q2eEpIcGNweUJ3TTJnWGJvckczbG10?=
 =?gb2312?B?bmZLMWZxZzIxUzNkSHBVL09sbWhXVjNKWmhGaVNFdkZMRkxKYTB5UUhWKzVR?=
 =?gb2312?B?bzBGNENvenJET1RKQjhMYXZuYlRYUzgrUElEcCs0NDNMdzZnRlYrZlNEZG9o?=
 =?gb2312?B?Rm9xNEVEZkhrN2VEQUpUM1p0Y2xGQWM1WEhKdi9QdHlwOU1lQWtodjI1dGJ6?=
 =?gb2312?B?a3ZFSjBQUDNMaGJPOUtEL3lSL2dmUlFXeHJZQ1IyMG5OcFlhcHJQRkVpYUQy?=
 =?gb2312?B?d21lYXVyQnlzZHlHRWc2dGd3L3c0TGE3U3NLWW9teHVuWHlOZDUrUzNKWTZ0?=
 =?gb2312?B?bXdvTFVoSFpSRVVJZXFpY3dDUlhFL0tzeCtGNzZ3M2JadTEwYVhDSUlWQ2VH?=
 =?gb2312?B?Y3c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 42acf57c-f783-4dd4-64e2-08dcf97a04a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 07:02:43.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00tKlpdeTwkTTUXMpr4rc4fU/7Uo0o4W4+5D1PfMK8pWPxCSTcQMDqKq+bs1+/ViVMyIPAfgYUS4nAbbENceqp++7NsGVTO7MAqeKxfbCGKOpE27hs56GBhg+8qDNPv/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1221

SGksIERhbg0KDQo+IGQzYWI3OTU1MzMwODQzIFNoZW5neWFuZyBDaGVuIDIwMjQtMDQtMTggIDMy
OSAgCXJldCA9DQo+IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoZHBoeS0+c3lzX3JzdCk7DQo+IGQz
YWI3OTU1MzMwODQzIFNoZW5neWFuZyBDaGVuIDIwMjQtMDQtMTggIDMzMCAgCWlmIChyZXQpIHsN
Cj4gZDNhYjc5NTUzMzA4NDMgU2hlbmd5YW5nIENoZW4gMjAyNC0wNC0xOCAgMzMxDQo+IAlkZXZf
ZXJyKGRwaHktPmRldiwgIkZhaWxlZCB0byBkZWFzc2VydCBzeXNfcnN0XG4iKTsNCj4gDQo+IGNs
a19kaXNhYmxlX3VucHJlcGFyZShkcGh5LT50eGVzY19jbGspOz8NCj4gDQoNClRoYW5rIHlvdSBm
b3IgeW91ciByZW1pbmRlci4NCg0KU2hlbmd5YW5nIEhhcyBsZWZ0IHRoZSBjb21wYW55LCBJIHdp
bGwgc2VuZCBhIHBhdGNoIHRvIGZpeCB0aGlzLg0KDQpCZXN0IFJlZ2FyZHMNCkNoYW5naHVhbmcN
Cg0KDQo=

