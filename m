Return-Path: <linux-kernel+bounces-278916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBDF94B693
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A27285500
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B261184553;
	Thu,  8 Aug 2024 06:18:49 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2138.outbound.protection.partner.outlook.cn [139.219.146.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF704A1E;
	Thu,  8 Aug 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097928; cv=fail; b=btBgKgJDLrm8fnuOWnGYCABGvE3GDJrp2JlAlZstNa2YPujnjPfl68qhHknpHHuM7iPIdhq1MuNWw3d4KLrOHOt+FF2nENzOuhJgZ7KntELGijcNeQbCRi/MKw6afNBSxtT20+CsYPYJpQFZgMw655mDhCavkh97YQBc0FTUbS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097928; c=relaxed/simple;
	bh=6x1lU4UTV6C4v4xKAeU5g0sbmLXdX0dtXJrhc7aNlek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SIvedvu+qI4D05JWvTONKuqLY1aDdVfOS5jVKJLVpU5hCdKnpNzP2g3LF1fHt8YWzY74V98ppBciIGgU6YfBhyi1n7spdX44apB/LNoQk8KM5DaJJJc+y/o6hGPXsSRW307KIB3i6Lpi30OHN6+bbxoxgdz8CpovyLh5agCFsNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl4SESPFw2RgQ0WHjtzgqToBcmgaRy4BwzuhGFcEaYDfgapbuxONYGpq3Gl2XbqEVahRfJI+8Ghg1rNYkEy0DKD2PhMD8wKF5iTyMTuTwIsKi5JNkA6sSlD3zLPCHPvmASJQv25ONrYK5LuRL2JlTxtaBMzP/PSmUVIvcUaRoIg8cA95QNrR8xKtxlBUKEmwNEVbsHEyJ7hXOUYb+5kzKCkAXaeD9Bx+8Jr75iRDui+/xOqfpH1K93pZJbR+TMqXDPiZMg+3ZnDa5m+/JTd/av2lwAcwUVWsPm/UvXqyVRgKE2LqztDpAXjnjrQAizPYcZgmKwz3ewn51iTU1JhBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x1lU4UTV6C4v4xKAeU5g0sbmLXdX0dtXJrhc7aNlek=;
 b=GJfUUqqJOYRkPVvR7tQmp3VmeNITQvsNMV35W8Y0CxiJeHoeBMynxg1WTJU/ZORfBnb6t9WE8jRho8/Y5zFMVNkJNWoAhbLtWo34c3mi91DNNxCCbMAxOufIV7Jl6fg3jbtbuh1YG7VjaRzTgHnC0lkCN9g8n6kldoCP6vc+BWFAnvG36U6byq/vy9qIVKOaDXoQUU6abB3iml2dJZ8pkcopfWlAMcSNQgBlKLv7gH0aFgvU2QMNeUos0rjfLZjjnK+9ohrf3bdYMUqf9qjiIdYQ7z7rKYVgPCeqdK2J8iJkGAoNXYThX/S1FANeYToGfXcnIF+eFauYjt4Ep8pR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Thu, 8 Aug
 2024 03:44:49 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.7828.023; Thu, 8 Aug 2024 03:44:49 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Conor Dooley
	<conor@kernel.org>
CC: Hal Feng <hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Index: AQHatVqcyH9jOZxH00+fSahpYZMQzrIaY5yAgAK6mFA=
Date: Thu, 8 Aug 2024 03:44:49 +0000
Message-ID:
 <NTZPR01MB09563DBA6F76281EB06914859FB92@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
 <CAJM55Z-_sOvRnaa8BuGcupsUksaK=tuTbTmF=AtzmzkCo7y5jA@mail.gmail.com>
In-Reply-To:
 <CAJM55Z-_sOvRnaa8BuGcupsUksaK=tuTbTmF=AtzmzkCo7y5jA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_
x-ms-office365-filtering-correlation-id: 85e6d0da-039c-4ec7-28d4-08dcb75c740a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 Mofo3rB26aY3u+lBxO/BLvpNLChV3JyI9KfuIH7hpnRhVfyp7DiHvzpP4FezoWgcXyLhiJh1TfSy8KGosG2uDmBv3fmMq+T6OgtkhsEPNlKAYbh2939STVuRI1D2bQTobmMmOi4h94kMY02QKCRGLFllViohg6hTZb1ZqIZBeVd5rfVdrQ6DU1r/nP+O5FVmXtwqJ3vWyfEewLaCc9zr2eWRPptWkAXzylNFENk6s8SOOGcse88JhRXHVK6ULE1N37vJ/AgdtBg3bPfOrAICW3+d4mBwSloUzYGFcoAb9yPya4ly300sRmUWIO31fUaeR7PHouQ40UdsodWeBnoRCbEtsD7XVEwJZQz9smzMNnrGyKgkEKy+WmZ2RPksiEbzlh5NoOCtUnRYkb4hgIUi38QaDQyaEFFd3ODuzbEKu5Nqu2i/y84ZJgEnnvCmXMkqpjI52IpHSMIGCtm5W9M+I0zY21oOsZpDiXRBjihZrh3ioMQ1DGyf28+fLNJxyU2vqL7jB63Ze2oNxSe5S9TEhTgSovdJ+ZT0J5RD0qiYVKvTcGQaweYUFEc0Qz0OnCdVXaRG2x/zBG5jKPlA694CCBVWTahynbcz73PqxMO8EWGlfl91cRIG7EuRDH5Zjs4t
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG55NUZucVhHWUsrM0JVSkN5TnJxbG9KL1lDSk1HbThpK1lGWkFOVXhBQURq?=
 =?utf-8?B?bVl2ZGN5MXE1QmdCMXB6bDkzS3poaVZkV0NRaGdVb21tZUh4UXVML2ZVQVJB?=
 =?utf-8?B?a2MxYXJNOWt2aEtucEVNQU40YXgzWm9nb0tHaFBzRHJuSysxQWdER1kzaVhN?=
 =?utf-8?B?Q1VOOHhRL2FIdmxWem1oOTZtUUpvc2RCSXJhY01zSzU3Y3pWOVBPTGlvVjdx?=
 =?utf-8?B?K1lJNVgvMVpYNlFDUkpzbUl4aHEvem5Ja1dLekpTZjNmaGUxT21XNzlySUk2?=
 =?utf-8?B?bjFVVEhQVEtyaUFJTzRCM1FUbDhJV3o3aVBDbE5NRlhwSEZYUzBKWWlrM0ta?=
 =?utf-8?B?RXpKSWZCQ01PMkpuOXdzQjhnWURHQis0Ym1CdXVZdExHUm5HSGwrditaNFJY?=
 =?utf-8?B?VkZjdXpUaTRlR0kyYUExK0JmZldYRzVNdXhlWW5KY2JUV3R2c3dYSzBkUE5m?=
 =?utf-8?B?ZTZjekxuRStGYWJsSXNlNDlLMEtpZEVLSG5mWmNxMmVpM3dSSGhrYUE5MWs4?=
 =?utf-8?B?b25RS2Z5cXBVb2diY3g3di9pN2NkUVpIUHV2S3Jud0w2NnQ5ekg5NGZCMkkr?=
 =?utf-8?B?Zk12R21CRkZ3V0tib1JCTnBpbmJVSE53QktvRHFZSmh0cU9YMFo0Vjd4dWFF?=
 =?utf-8?B?NjZvZkpwMXJPTTY3S1d1ejV1U2JKRFhDS21JY0RndDZuZUlCZ0VWLzZ3bnJV?=
 =?utf-8?B?dTdEcVVBZmNZS2lZNzErRjhtZ0I4MUdmcitIZTFOWXU0d3BKM1ZEYlpFTGJx?=
 =?utf-8?B?bDRtVHNXLzZ6RVJZL3dQRFk2dXY2eDVRVG9iRGc0NEZsNlpJeUpjUEtHRStp?=
 =?utf-8?B?bkRwMTdUbmUxVW9CY3hOZHdrcXdqM3NPUG5JeDM3dG1DWStBRGxZUHZQUFVa?=
 =?utf-8?B?QU4yQ2tuUlRqOVNpWmZOU2YxNlVUUnFXV0xKaGV1UEJoOS92bEpOTEhRQjk5?=
 =?utf-8?B?R25DT2pmc1pNN1E4THozd2QrUDZZTUdvVVNyRm1DVkhwSmY2MjNqdDY4bjdT?=
 =?utf-8?B?SFJKZG1FNXBBNFpXMWRMT2NUTTQzYXRCRFhyWWZ6TEFGY1NMYlRWYlp5aE5y?=
 =?utf-8?B?azZOSitSa0RHeVdUeGk4bVI3MzdmUUFOdXp0T0k2WW1kbnhoSEhOdGtJSWlZ?=
 =?utf-8?B?K0hmUi9xR0ZHTHhzZEl1WWZVbkQvRlVqMzhLNXdTekoyUGk4dVFlWS80MTgr?=
 =?utf-8?B?OVdKR3pDaDcyd05Ia21ubzM5STk0R0E1MnhZRkRzbEhNRWVESlhMOXhIdVM4?=
 =?utf-8?B?OGE4V1FjT0JGcnNOZ1ExdUJXd3Z3aW44d3BDTDZzdE55SFg3M1FUUDFnTXBo?=
 =?utf-8?B?cXFwVlhXMi9pUkt0RElHUHhKRy95Q2x4d056SmcrUHF4cHFFTzV3VVcxOWV5?=
 =?utf-8?B?ZjNvdTVGeEFDVUZJQ1ZuMGpwQkV1SmROZi9OTHJxeFlZMlZkMmhibXB4Z1o3?=
 =?utf-8?B?b2Q4ZHAzTGxlbEptTHFSend5R1lKdFRlU0sxWk5CY3RMTEVTRDk5OVFyTStK?=
 =?utf-8?B?amF1c2Y1VjdJd1BQUmtpMGdLaVN0ZGdHNTlORDBmbGxXZjRpaHNmQUpKeE9T?=
 =?utf-8?B?TUQwbjZNK0VHL0lLamFWWm8rY2dsaW1HK2NRMDN6N2hVQ3BKcGxWR2JibWhE?=
 =?utf-8?B?U1JJMFFaenBBSlFzTHZLZWh2SUFka25UMG4xWnZvc09mYlhhODRBMVJKdlBu?=
 =?utf-8?B?WndLZ1g1alliQzlUaGZ5TXp1SWJvbmpzMjYzZXRlZGtSWVc3NGRrekVZNkJo?=
 =?utf-8?B?K2lXb2RPSy9ETmhUbm16ZmxKbXB1VzlsSjlTT1JQUGRERjRTZkRyVmpzZnVF?=
 =?utf-8?B?SXQyeGM3NWhNaDM4OVltcGxqbjdxRllveUZGeWhkUTVnWFBGenBabEQ5cUQ3?=
 =?utf-8?B?UmxQMVZ3OWgzamx1ZnRNR25JbkZHUkxyUHgreXBKUDZ4clVXNFBPMTM4VzdF?=
 =?utf-8?B?MFBZYUxIYm91aTZqU2ovTXNSc2NsT0Y2M0J2czlTQitvZ21XWEtsempkMm1q?=
 =?utf-8?B?a1RmSjRETHFZU3BzQmVFeGgyUTJlSHlXcFBScEY2Skl6eHZFMVBNcXpDWHBB?=
 =?utf-8?B?WSsyWHRqc1JHMnorZFh1NnV5TWJjTEdDdEhIT1dqdWZ3Vjd1V1U5S01WZC9j?=
 =?utf-8?Q?wX5/wnsSoWFK70z++F6vKYGli?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e6d0da-039c-4ec7-28d4-08dcb75c740a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 03:44:49.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUjmn1f+F6SfKNZXh0TWpGZUx4xY/2rzO3DdsSLoUN3LMShJoVisJVp8oNfM1qnMKi6hqszAwnzsVck+NaYd8JZhNeXpwUeHvWN7Uj/hUlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0956

T24gMDYvMDgvMjAyNCAxNzo1OCwgRW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+IA0KPiBY
aW5neXUgV3Ugd3JvdGU6DQo+ID4gQ1BVZnJlcSBzdXBwb3J0cyA0IGNwdSBmcmVxdWVuY3kgbG9h
ZHMgb24gMzc1LzUwMC83NTAvMTUwME1Iei4gQnV0IG5vdw0KPiA+IFBMTDAgcmF0ZSBpcyAxR0h6
IGFuZCB0aGUgY3B1IGZyZXF1ZW5jeSBsb2FkcyBiZWNvbWUNCj4gPiAyNTAvMzMzLzUwMC8xMDAw
TUh6IGluIGZhY3QuIFRoZSBQTEwwIHJhdGUgc2hvdWxkIGJlIGRlZmF1bHQgc2V0IHRvDQo+ID4g
MS41R0h6IGFuZCBzZXQgdGhlIGRpdmlkZXIgb2YgY3B1X2NvcmUgY2xvY2sgdG8gMiBpbiBzYWZl
Lg0KPiA+DQo+ID4gVG8ga2VlbyB0aGUgY3B1IGZyZXF1ZW5jeSBzdGFibGUgd2hlbiBzZXR0aW5n
IFBMTDAsIHRoZSBwYXJlbnQgY2xvY2sNCj4gPiBvZiB0aGUgY3B1X3Jvb3QgY2xvY2sgbmVlZHMg
dG8gYmUgc3dpdGNoZWQgZnJvbSBQTEwwIHRvIGFub3RoZXIgcGFyZW50DQo+ID4gY2xvY2sgYW5k
IGFkZCBub3RpZmllciBmdW5jdGlvbiB0byBkbyB0aGlzIGZvciBQTEwwIGNsb2NrLiBJbiB0aGUN
Cj4gPiBmdW5jdGlvbiwgdGhlIGNwdV9yb290IGNsb2NrIHNob3VsZCBiZSBvcGVyYXRlZCBieSBz
YXZpbmcgaXRzIGN1cnJlbnQNCj4gPiBwYXJlbnQgYW5kIHNldHRpbmcgYSBuZXcgc2FmZSBwYXJl
bnQgKG9zYyBjbG9jaykgYmVmb3JlIHNldHRpbmcgdGhlDQo+ID4gUExMMCBjbG9jayByYXRlLiBB
ZnRlciBzZXR0aW5nIFBMTDAgcmF0ZSwgaXQgc2hvdWxkIGJlIHN3aXRjaGVkIGJhY2sNCj4gPiB0
byB0aGUgb3JpZ2luYWwgcGFyZW50IGNsb2NrLg0KPiA+DQo+ID4gVG8ga2VlcCB0aGUgRFRTIHNh
bWUgaW4gTGludXggYW5kIFUtQm9vdCBhbmQgdGhlIFBMTDAgcmF0ZSBpcyAxR0h6IGluDQo+ID4g
VS1Cb290LCB0aGUgUExMMCByYXRlIHNob3VsZCBiZSBzZXQgdG8gMS41R0h6IGluIHRoZSBkcml2
ZXIgaW5zdGVhZCBvZg0KPiA+IERUUy4NCj4gPg0KPiA+IEZpeGVzOiBlMmM1MTBkNmQ2MzAgKCJy
aXNjdjogZHRzOiBzdGFyZml2ZTogQWRkIGNwdSBzY2FsaW5nIGZvciBKSDcxMTANCj4gPiBTb0Mi
KQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5j
b20+DQo+ID4gLS0tDQo+ID4NCj4gPiBIaSBTdGVwaGVuIGFuZCBFbWlsLA0KPiA+DQo+ID4gVGhp
cyBwYXRjaCBpcyB0byBmaXggdGhlIGxvd2VyIHJhdGUgb2YgQ1BVZnJlcSBieSBhZGRpbmcgdGhl
IG5vdGlmaWVyDQo+ID4gZm9yIFBMTDAgY2xvY2sgYW5kIGNoYW5naW5nIHRoZSBQTEwwIHJhdGUg
dG8gMS41R0h6Lg0KPiA+DQo+ID4gVG8ga2VlcCB0aGUgRFRTIHNhbWUgaW4gTGludXggYW5kIFUt
Qm9vdCBhcyBDb25vciB3YW50c1sxXSBhbmQgdGhlDQo+ID4gUExMMCByYXRlIGlzIDFHSHogaW4g
VS1Cb290LCB0aGUgUExMMCByYXRlIHNob3VsZCBiZSBzZXQgdG8gMS41R0h6IGluDQo+ID4gdGhl
IGRyaXZlciBpbnN0ZWFkIG9mIERUUy4NCj4gPg0KPiA+IFsxXToNCj4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNDA1MTUtcmVvcmRlci1ldmVuLThiOWVlYmQ5MWI0NUBzcHVkLw0K
PiA+DQo+ID4gVGhhbmtzLA0KPiA+IFhpbmd5dSBXdQ0KPiA+DQo+ID4gLS0tDQo+ID4gIC4uLi9j
bGsvc3RhcmZpdmUvY2xrLXN0YXJmaXZlLWpoNzExMC1zeXMuYyAgICB8IDU0ICsrKysrKysrKysr
KysrKysrKy0NCj4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvY2xrLXN0YXJmaXZlLWpoNzF4MC5o
ICAgIHwgIDIgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvc3RhcmZpdmUvY2xr
LXN0YXJmaXZlLWpoNzExMC1zeXMuYw0KPiA+IGIvZHJpdmVycy9jbGsvc3RhcmZpdmUvY2xrLXN0
YXJmaXZlLWpoNzExMC1zeXMuYw0KPiA+IGluZGV4IDhmNWU1YWJmYTE3OC4uNzQ2OTk4MWZiNDA1
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcx
MTAtc3lzLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9zdGFyZml2ZS9jbGstc3RhcmZpdmUtamg3
MTEwLXN5cy5jDQo+ID4gQEAgLTM4NSw2ICszODUsMzIgQEAgaW50IGpoNzExMF9yZXNldF9jb250
cm9sbGVyX3JlZ2lzdGVyKHN0cnVjdA0KPiA+IGpoNzF4MF9jbGtfcHJpdiAqcHJpdiwgIH0NCj4g
PiBFWFBPUlRfU1lNQk9MX0dQTChqaDcxMTBfcmVzZXRfY29udHJvbGxlcl9yZWdpc3Rlcik7DQo+
ID4NCj4gPiArLyoNCj4gPiArICogVGhpcyBjbG9jayBub3RpZmllciBpcyBjYWxsZWQgd2hlbiB0
aGUgcmF0ZSBvZiBQTEwwIGNsb2NrIGlzIHRvIGJlIGNoYW5nZWQuDQo+ID4gKyAqIFRoZSBjcHVf
cm9vdCBjbG9jayBzaG91bGQgc2F2ZSB0aGUgY3VyZW50IHBhcmVudCBjbG9jayBhbmQgc3dpY3Ro
DQo+ID4gK2l0cyBwYXJlbnQNCj4gPiArICogY2xvY2sgdG8gb3NjIGJlZm9yZSBQTEwwIHJhdGUg
d2lsbCBiZSBjaGFuZ2VkLiBUaGVuIHN3aWN0aCBpdHMNCj4gPiArcGFyZW50IGNsb2NrDQo+ID4g
KyAqIGJhY2sgYWZ0ZXIgdGhlIFBMTDAgcmF0ZSBpcyBjb21wbGV0ZWQuDQo+ID4gKyAqLw0KPiA+
ICtzdGF0aWMgaW50IGpoNzExMF9wbGwwX2Nsa19ub3RpZmllcl9jYihzdHJ1Y3Qgbm90aWZpZXJf
YmxvY2sgKm5iLA0KPiA+ICsJCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpk
YXRhKSB7DQo+ID4gKwlzdHJ1Y3Qgamg3MXgwX2Nsa19wcml2ICpwcml2ID0gY29udGFpbmVyX29m
KG5iLCBzdHJ1Y3Qgamg3MXgwX2Nsa19wcml2LA0KPiBwbGxfY2xrX25iKTsNCj4gPiArCXN0cnVj
dCBjbGsgKmNwdV9yb290ID0gcHJpdi0+cmVnW0pINzExMF9TWVNDTEtfQ1BVX1JPT1RdLmh3LmNs
azsNCj4gPiArCWludCByZXQgPSAwOw0KPiA+ICsNCj4gPiArCWlmIChhY3Rpb24gPT0gUFJFX1JB
VEVfQ0hBTkdFKSB7DQo+ID4gKwkJc3RydWN0IGNsayAqb3NjID0gY2xrX2dldChwcml2LT5kZXYs
ICJvc2MiKTsNCj4gPiArDQo+ID4gKwkJcHJpdi0+b3JpZ2luYWxfY2xrID0gY2xrX2dldF9wYXJl
bnQoY3B1X3Jvb3QpOw0KPiA+ICsJCXJldCA9IGNsa19zZXRfcGFyZW50KGNwdV9yb290LCBvc2Mp
Ow0KPiA+ICsJCWNsa19wdXQob3NjKTsNCj4gPiArCX0gZWxzZSBpZiAoYWN0aW9uID09IFBPU1Rf
UkFURV9DSEFOR0UpIHsNCj4gPiArCQlyZXQgPSBjbGtfc2V0X3BhcmVudChjcHVfcm9vdCwgcHJp
di0+b3JpZ2luYWxfY2xrKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gbm90aWZpZXJf
ZnJvbV9lcnJubyhyZXQpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IF9faW5pdCBq
aDcxMTBfc3lzY3JnX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gew0K
PiA+ICAJc3RydWN0IGpoNzF4MF9jbGtfcHJpdiAqcHJpdjsNCj4gPiBAQCAtNDEzLDcgKzQzOSwx
MSBAQCBzdGF0aWMgaW50IF9faW5pdCBqaDcxMTBfc3lzY3JnX3Byb2JlKHN0cnVjdA0KPiBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJaWYgKElTX0VSUihwcml2LT5wbGxbMF0pKQ0KPiA+
ICAJCQlyZXR1cm4gUFRSX0VSUihwcml2LT5wbGxbMF0pOw0KPiA+ICAJfSBlbHNlIHsNCj4gPiAt
CQljbGtfcHV0KHBsbGNsayk7DQo+ID4gKwkJcHJpdi0+cGxsX2Nsa19uYi5ub3RpZmllcl9jYWxs
ID0gamg3MTEwX3BsbDBfY2xrX25vdGlmaWVyX2NiOw0KPiA+ICsJCXJldCA9IGNsa19ub3RpZmll
cl9yZWdpc3RlcihwbGxjbGssICZwcml2LT5wbGxfY2xrX25iKTsNCj4gPiArCQlpZiAocmV0KQ0K
PiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiAgCQlwcml2LT5wbGxbMF0gPSBOVUxMOw0K
PiA+ICAJfQ0KPiA+DQo+ID4gQEAgLTUwMSw3ICs1MzEsMjcgQEAgc3RhdGljIGludCBfX2luaXQg
amg3MTEwX3N5c2NyZ19wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLQlyZXR1cm4gamg3MTEw
X3Jlc2V0X2NvbnRyb2xsZXJfcmVnaXN0ZXIocHJpdiwgInJzdC1zeXMiLCAwKTsNCj4gPiArCXJl
dCA9IGpoNzExMF9yZXNldF9jb250cm9sbGVyX3JlZ2lzdGVyKHByaXYsICJyc3Qtc3lzIiwgMCk7
DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJLyogU2V0
IHRoZSBkaXZpZGVyIGNwdV9jb3JlIHRvIDIgYW5kIHNldCB0aGUgUExMMCByYXRlIHRvIDEuNUcu
ICovDQo+ID4gKwlwbGxjbGsgPSBjbGtfZ2V0KHByaXYtPmRldiwgInBsbDBfb3V0Iik7DQo+ID4g
KwlpZiAoIUlTX0VSUihwbGxjbGspKSB7DQo+ID4gKwkJc3RydWN0IGNsayAqY3B1X2NvcmUgPSBw
cml2LQ0KPiA+cmVnW0pINzExMF9TWVNDTEtfQ1BVX0NPUkVdLmh3LmNsazsNCj4gPiArDQo+ID4g
KwkJcmV0ID0gY2xrX3NldF9yYXRlKGNwdV9jb3JlLCBjbGtfZ2V0X3JhdGUoY3B1X2NvcmUpIC8g
Mik7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJ
cmV0ID0gY2xrX3NldF9yYXRlKHBsbGNsaywgMTUwMDAwMDAwMCk7DQo+ID4gKwkJaWYgKHJldCkN
Cj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJY2xrX3B1dChwbGxjbGspOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiANCj4gSSdtIHN0aWxsIG5vdCBhIGZhbiBv
ZiBoYXJkY29kaW5nIGNwdSBmcmVxdWVuY2llcyBpbiB0aGUgZHJpdmVyLiBZb3UndmUgYWRkZWQg
dGhlDQo+IG5vdGlmaWVycyBleGFjdGx5IHNvIHRoYXQgd2UgY2FuIHVzZSB0aGUgc3RhbmRhcmQg
ZGV2aWNlIHRyZWUgc2V0dGluZ3MgZm9yIHRoaXMuDQo+IA0KPiBJbiBvdGhlciB3b3JkcyBJIG11
Y2ggcHJlZmVyIHY1IG9mIHRoaXMgcGF0Y2hzZXQuDQo+IA0KPiAvRW1pbA0KPiANCg0KVGhhbmtz
LCBFbWlsLg0KDQpIaSBDb25vciwgd2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhpcyBpc3N1ZT8N
Cg0KQmVzdCByZWdhcmRzLA0KWGluZ3l1IFd1DQo=

