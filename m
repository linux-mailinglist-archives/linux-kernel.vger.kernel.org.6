Return-Path: <linux-kernel+bounces-178420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A38C4D61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C96F1C2185C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30F17BDC;
	Tue, 14 May 2024 07:56:04 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2110.outbound.protection.partner.outlook.cn [139.219.17.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB614A8F;
	Tue, 14 May 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673363; cv=fail; b=FbdYz6WYhOV2+poQwaITRGoOn94ocAa/+rBUAnOcZqkqTQMEm8xuF7jqDwI12VgnZhAGWTmrUhI4D6BC5iplpVsQrRqG+HapfH76rNGrI344Vnykmwl0AQwpsk/ejE85zAWkgw0kdEyWzp+JsEFXvw8gXnqfW+BM43HedV2dpMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673363; c=relaxed/simple;
	bh=RGT1pq/Lc7fDWRg+v92Tmk0gg/MiNxoA/r4Jwcdambk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SS4nd4D2zX6BBPG/O0lZcpJndajbs+S7FzJSu4Fz6f8A5YsYqoRdFY/AG/sj2yq2UuNuM6nE1p0EDWZaPqIBsiB/2ivhW9s/0PA8VDVQiTGJPXdqC2lkONlr0yNZCZ690oIqRFCmmcyc4zPYpde+zz99Ww//bLotwTgMKLhnUIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7zJ7lQdRjnE4my57vK0e0FDK/F5cV0rkF28+R/OLMiMXpJuyBeqVcauQSFTd6FE+d9RRLy/2/pPlzlaTuQPqAY2qGhGQVziwTPN2ZCShJeSKSPmFNliHdOzVw5vyAnCljs/d12+aeHoVeQiLfIUpvL23k2j80kz4hqLFftCSWtt4dZDS4UOA1q1HEVbXnPGTTMcKx17RICuv/z5BcUawmB95afY669oLHToS1SUXRFa6bOjuUli5h0cfUAigsS+FFnvPoDaqN6nA47DTwiyBO1X1fTcp+McXDhGmhrhyAXZkLdvfjkAuEGYy494dWzvBQ4K6eK+rWTuKFvNF6fj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGT1pq/Lc7fDWRg+v92Tmk0gg/MiNxoA/r4Jwcdambk=;
 b=lcD+iBjxBdRmjELaTjEmRa+YBuE9qy3D/an3avIu/GfM4ZxpRz02rzqYIaypVxQBYdUezwaS9cV3nGtEXoNwJid4ZBt5ZAGSgFur++q4TZPkO+ycQhvUoSTJcWIiDIkfiHrp/VVj61FNjBDnWsuJfVZWXuy+t42k5Nmo6CZKRZHDPC0NPVu9cL496dZPRoao619fsZe3seLbUe/CKwYmk0jPEMc07zE/bJ1ByAmQUIC+QlnMs/8kKm3I8RFCymyPsn2Qs4mOFWvPz+M8VTmC9gh42rR+WVpH94UuODwhnnirgO1IkeawndQe0is2DwPaRNXW6d9A6GHjf/dIeedatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Tue, 14 May
 2024 07:40:18 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Tue, 14 May 2024 07:40:18 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Samuel Holland <samuel.holland@sifive.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor Dooley
	<conor@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng
	<hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] riscv: dts: starfive: visionfive-2: Fix lower rate
 of CPUfreq by setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v5 2/2] riscv: dts: starfive: visionfive-2: Fix lower
 rate of CPUfreq by setting PLL0 rate to 1.5GHz
Thread-Index: AQHaoEtDhNqmQ3vYiEeZ0Ra2PPyT0rGSZqkAgAOc2gA=
Date: Tue, 14 May 2024 07:40:18 +0000
Message-ID:
 <NTZPR01MB0956F91D339E1012A4F5897B9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240507065319.274976-3-xingyu.wu@starfivetech.com>
 <b970012b-c078-4c8d-995d-e2789afa3e4c@sifive.com>
In-Reply-To: <b970012b-c078-4c8d-995d-e2789afa3e4c@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1003:EE_
x-ms-office365-filtering-correlation-id: 8b47692f-cc6a-49bc-03b6-08dc73e91a60
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x1TgGa0wAhzTmFdg/Shmgb2la/NLK8LkyCXJF4wVeht7iiMBlfRUGq08D6g3tOmPbXoTyEFGw2HBCJyKZFXaMLADxy8fX6StT+o9bWSgg/kG+6DYf+hET09k+PtddeKXx7iEHOn4tKsvZBTfuH97muCRwb3QKz7K+NF8fsc7M49+uRYcLChd1cRUsoMiA2CrkUS7Mal0zViqi88EbZyy5inOPZ+O7DAq0txgFygl7k+n6rnj6jKgZHaLKEL22Pvss8sDlc+3zBHnBWvt7mrrr7VY2u/PRTlsfeCnmdQYqExvpXzKdN+srNViRcbnWgI5s6fuZfsAUCAwW2DdpqOkrFTSlT65io/2re0pc33QeeEkjpg4I4b/UghNhyVRADrvc8ZVnEyyYrUJNHVjMVFvG0MFKeYMU+OI2dnryRZ4HVOPgeWXJqUbDJDPuqbNrckGGuE3P+/jN4fbDSdGy+OKtfwrE52dla75iapFZYUVyonlneFZ5KyyfK3N2jQKSppTu8AqJ62QqLpE03PCnU9U6CcGA4h3yIlZ4qxB6pc+vxUSPIxNELwhxI6UaHKIl/RYa8knsvhcpTUBQYJkwiYWSOAQ2V2V+9sZcCP6vB7GDpEBHpNS1XHhE6CL6WBeuty5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGtDUTFQVzJTcEsyN1RaV2QxaE9nOGJnMnR2bjVxVUphYlNDNUJPanU4RkxN?=
 =?utf-8?B?YVorM3N2UjRudXdHRVRESjQ2WWhQV1prSnFpQU9jWUtRYVY0REkrRytJSlZY?=
 =?utf-8?B?MFhScnFpS2VoelFzMWQxdi9BZ3d4SWVLQVI2cGN5TEtwMzRxTE9FRlB6d016?=
 =?utf-8?B?NU5vQnlwVmF0UlN1UzMxb05FeUJ1bWF3QUF0NmQvUGFkRlNxQTdhMW1ybHFU?=
 =?utf-8?B?MzBIeXBBemIzbzdDLzA1elhyR3RocEp6dE5YeTkzTkRXM2tqSEg1WXkzMmVS?=
 =?utf-8?B?TitqNlR1bG5xZDh1dFNDRVdnTjZUczA3cUNaZmlIZVlzU0s3anQwYktzVmNQ?=
 =?utf-8?B?MEJrQlBBTHhWTDBXZkg2U0dzL1lOMC9SWDZ1cnhlb3dRY3FtTVJFdW1LN3l1?=
 =?utf-8?B?NGpkajVpekdvYnVjS24vUzJUSmQwWWlXNS9CekE1NUZyK242c3FtZnJ3L0h3?=
 =?utf-8?B?Y0NQVzVmU1R4bDh4bkxuZmVvQjVTcE5kQUw2YURySkJEdEFueTNTSFRxdjZ2?=
 =?utf-8?B?bjNKNU1ZeXlOMVBKNEhZaWw1SUlCcDZidFRsbDJJS3NBMHFDMkZibVVyWGx0?=
 =?utf-8?B?UGhvMXhzOGoybGxjYlZtVlNsSStQOVNncHNrZWNJRlVUMmRuOFpBQ1ZGR1NH?=
 =?utf-8?B?V21UdDZrVHR6N0VBYU8ySUNxRGxXeXdjVkdJS25WSGYvOTU4MFlPRy9qYVZo?=
 =?utf-8?B?ckNrK0RmOFJZQmJycVFwZzVHNDF5UmNXMnlldmcyNS9iR3NEclh4Zk9sNDF1?=
 =?utf-8?B?Y09VNXNrd2VtY1JQeW96c3E3dkQwT05sSDQ5ZEQxOFhzZzFqMWRNb3hPeFFj?=
 =?utf-8?B?Q2M3cCtJWTFUamJQU2w1NEcwVTFDaU44S0NHRFlDbmZUK3dZR1IrOGxKMDE1?=
 =?utf-8?B?SXBEUUpXb2dtMGxPR09OdVA3NkJ4bG1rQ050cW1zbUNOQ2szZ3B1dHFKZUFF?=
 =?utf-8?B?M2M0MHNhakErY1VzVnpmNEhhUUNIV2k5NkpXWFl6dEJ2SXdBamoxdkJNcTdC?=
 =?utf-8?B?V2xDbGZuRWtqdHdWdnk1SittZ1U4RkRBWVhXWm9ZeUd4c2F5ZElDYmJDdEw2?=
 =?utf-8?B?NDcrQlgxSFZ0QlRhNjRKVUtwbjZZRmZLWDVoZE05YTNVSE5uaGlRLy9lTkMv?=
 =?utf-8?B?R1RleFFWbmdhV242eEZNUUs2bEpzcUlET2l1UFZtUzkwNXdsTmtJQkZWK1dk?=
 =?utf-8?B?a3NWOHdyQXlGQ2F2a3Jybm9Tam9ERERZNVlybkRqcW9kVHFyRDBrWW5WbEl2?=
 =?utf-8?B?RmdlV2JlSzR4a3B3aGNORG50Tk50VC91N3k1Vm53L3RJQkI1eDc3cENtR1RQ?=
 =?utf-8?B?L2lBaTBsUno0YVdxQXBoSHZJMjRzUUxMdEdYUjVUWDJaUHZjTVZUL3Nkdk92?=
 =?utf-8?B?c1NvMWtSTm83QWZYTlVQWTZEMEZ0MDJ3RWhtMEREOURPSWxWV2V1Mjg2aGhF?=
 =?utf-8?B?R0JZTVhRN3E4azhReXl3WEhPR2QrZ1NGUDRDSVU5SWZ2TW1vNU53UHVzWEVT?=
 =?utf-8?B?UkRCZlFFd0hndTNxZzBJTDBONjZIb2psQmhDc0VwSnBKQVNUZmw2dnhveERL?=
 =?utf-8?B?Z3dCZ2lFOVVmUkRBUDR5V1FoNWZSbU9IWkZBZ1ZXRDVUMHpCUVFOeXBCZjM5?=
 =?utf-8?B?aUp6cFlJTlhpWWMweDBuZUg3cDZIV0ZmU2RTTjlSN0ZSVzlaSnp6ZjVKN0hK?=
 =?utf-8?B?ZnZzZTloYkdMSGhvdXhoQ1JzNVRuOGEwU2kwclg0VnpVcEcvS3Bvcjh2QTgr?=
 =?utf-8?B?U2VCVzk2Sm5yNTZ1NFA4S0FWQVk0YzFGL2w5K0V1VmtpR0FEeGxyNng3UldR?=
 =?utf-8?B?M2lGQ2xndzN2amtPcEZ5dDVNNXZJSDYrNkZZZVJmVXBhKzFOZlh0VDRTWGJx?=
 =?utf-8?B?TWZnbjdOdHJGUTlNQ2hXNlJtaEw1MXVvcnUyWGNMajViU2pWcU44WGIyZG93?=
 =?utf-8?B?Nll2c0x4TGdLQ3hNZFBYazc0OHQrOTQ4TFJTMjJtV3pYYzhiUHRrRUJrZjdD?=
 =?utf-8?B?SlBTdlhuV3dqRTRMWGc5VTc4OU96TE5KcHRFQnpralhCSkgwbXF1NG9vYStz?=
 =?utf-8?B?ajg4ZEh1NjFDbzNQQlJBQUFlODhnQ3JEMHczMzN2Y3c5eXJMRm5GUlkrWnht?=
 =?utf-8?Q?VTE60bZZeenTBkbbmA5V7rnDC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b47692f-cc6a-49bc-03b6-08dc73e91a60
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 07:40:18.6302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9mowPSfD0u+N1lxCW7w93Br8YDdk9RK/TL2o/YJ20NjiZiftcuYlgshyd3vWYN751uubTuLQSJYYS1KmL0yulvVjveZo8hUuZy46EBnLIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1003

T24gMTIvMDUvMjAyNCAwMjo0NywgU2FtdWVsIEhvbGxhbmQgd3JvdGU6DQo+IA0KPiBPbiAyMDI0
LTA1LTA3IDE6NTMgQU0sIFhpbmd5dSBXdSB3cm90ZToNCj4gPiBDUFVmcmVxIHN1cHBvcnRzIDQg
Y3B1IGZyZXF1ZW5jeSBsb2FkcyBvbiAzNzUvNTAwLzc1MC8xNTAwTUh6Lg0KPiA+IEJ1dCBub3cg
UExMMCByYXRlIGlzIDFHSHogYW5kIHRoZSBjcHUgZnJlcXVlbmN5IGxvYWRzIGJlY29tZQ0KPiA+
IDMzMy81MDAvNTAwLzEwMDBNSHogaW4gZmFjdC4NCj4gPg0KPiA+IFRoZSBQTEwwIHJhdGUgc2hv
dWxkIGJlIGRlZmF1bHQgc2V0IHRvIDEuNUdIeiBhbmQgc2V0IHRoZSBjcHVfY29yZQ0KPiA+IHJh
dGUgdG8gNTAwTUh6IGluIHNhZmUuDQo+IAkNCj4gQ2FuIHRoaXMgYmUgYWNjb21wbGlzaGVkIGJ5
IGluc3RlYWQgc2V0dGluZyB0aGUgQ0xLX1NFVF9SQVRFX1BBUkVOVCBmbGFnIG9uDQo+IHRoZSBD
UFVfQ09SRSBjbG9jaz8gVGhhdCB3YXkgUExMMCBpcyBhdXRvbWF0aWNhbGx5IHNldCB3aGVuIGNw
dWZyZXEgdHJpZXMgdG8NCj4gY2hhbmdlIHRoZSBDUFUgY29yZSBmcmVxdWVuY3kuIFRoZW4gdGhl
cmUgaXMgbm8gRFQgY2hhbmdlIGFuZCBubyBjb21wYXRpYmlsaXR5DQo+IGlzc3VlLg0KPiANCj4g
UmVnYXJkcywNCj4gU2FtdWVsDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuIEJ1dCBjcHVmcmVx
IHRyaWVzIHRvIGNoYW5nZSB0aGUgQ1BVIGNvcmUgcmF0ZSBhbmQgYWxzbw0KdGhlIFBMTDAgcmF0
ZSB3aXRoIHRoZSBmbGFnIG9mIENMS19TRVRfUkFURV9QQVJFTlQgYW5kIHRoZSBQTEwwIHdpbGwg
YmUNCmNoYW5nZWQgZnJlcXVlbnRseS4gSSB0aGluayBpdCBnb2VzIGFnYWluc3Qgb3VyIGludGVu
dGlvbiBhbmQgdGhlIFBMTDAgcmF0ZSBzaG91bGQNCmJlIGZpeGVkIG9yIHJhcmVseSBjaGFuZ2Vk
LiBUaGlzIGhlbHBzIHRvIHN0YWJpbGl6ZSB0aGUgc3lzdGVtLg0KDQpCZXN0IHJlZ2FyZHMsDQpY
aW5neXUgV3UNCg0KPiANCj4gPiBGaXhlczogZTJjNTEwZDZkNjMwICgicmlzY3Y6IGR0czogc3Rh
cmZpdmU6IEFkZCBjcHUgc2NhbGluZyBmb3IgSkg3MTEwDQo+ID4gU29DIikNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBYaW5neXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5k
dHNpICAgICB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUv
amg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpDQo+ID4gYi9hcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL3N0YXJmaXZlL2poNzExMC1zdGFyZml2ZS12aXNpb25maXZlLTIuZHRzaQ0KPiA+IGluZGV4
IDQ1YjU4YjZmM2RmOC4uMjg5ODFiMjY3ZGU0IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3Yv
Ym9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpDQo+ID4g
KysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAtc3RhcmZpdmUtdmlzaW9u
Zml2ZS0yLmR0c2kNCj4gPiBAQCAtMzkwLDYgKzM5MCwxMiBAQCBzcGlfZGV2MDogc3BpQDAgew0K
PiA+ICAJfTsNCj4gPiAgfTsNCj4gPg0KPiA+ICsmc3lzY3JnIHsNCj4gPiArCWFzc2lnbmVkLWNs
b2NrcyA9IDwmc3lzY3JnIEpINzExMF9TWVNDTEtfQ1BVX0NPUkU+LA0KPiA+ICsJCQkgIDwmcGxs
Y2xrIEpINzExMF9QTExDTEtfUExMMF9PVVQ+Ow0KPiA+ICsJYXNzaWduZWQtY2xvY2stcmF0ZXMg
PSA8NTAwMDAwMDAwPiwgPDE1MDAwMDAwMDA+OyB9Ow0KPiA+ICsNCj4gPiAgJnN5c2dwaW8gew0K
PiA+ICAJaTJjMF9waW5zOiBpMmMwLTAgew0KPiA+ICAJCWkyYy1waW5zIHsNCg0K

