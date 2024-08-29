Return-Path: <linux-kernel+bounces-306826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A08964431
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EDD1B20A28
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F4198A39;
	Thu, 29 Aug 2024 12:16:19 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4A194C86;
	Thu, 29 Aug 2024 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933778; cv=fail; b=fbHfTJ5iPjrI12YQIATU5WYIgfc+UTIi/xqQHhrJ6NljEqL3F7assSR5kR6ZcZhu1ZzaCQBqQqu2SiKNKPnksCN+WGxUKj20+Hd+NK8wEMiDw7KuEA4AxgYnL4MMp4kfuDP5vgDSBEiYBBeUoJsVmbW5TFabJhfPWHw490qUYqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933778; c=relaxed/simple;
	bh=sj4URFo6PkVv5WK+rRseCwBE8nDj0TZcPznItL2YiDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T9E2PWQIcDJ5D5ys8FhdKU65Q3/isghz0os0Kglvt9WqtMh3qSxiR15J9FFda4ML/nOcBEjG3e9uC0VpOG+22Kb7ESWQXbj4tgy+xjoPNPo5eLoahkjOWBKShT+6O3DS0B5YUeiWgfYLfVlc+dEFSb5ePJ6HVE0QSdh1AMENxs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+7mlMD1UWAAaHpXr+HPfcpJFpiO7xR3FDXxpikImD2QXQaGeIg9zcjKnoNlGfj27JiCBa0HgttHCDvvdrCpfJglU7sVD4J2T6VI6CU1Z0mtRKcdRGZF5SGawyHQpTEnyQ3c6vyuKv1hVI0RRrSSw9MxnSFPwEeXmQlQ3dcFCKIE1wHC8Ynm2ZRmTPzaMMuUDSPGJ8IsiCkAWnpQho1pM5q6W2KCkMoKImJOBqHB0P6lC9YyHH+uYTBgmrApUhCkUb7pFo/4x0or201IeeEpKYq/o2X0KUNz/w2VBuiwWJd+En+vwol9m7qKsO6m9lq2xzTgc5hrMc23r7U7l8pEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sj4URFo6PkVv5WK+rRseCwBE8nDj0TZcPznItL2YiDw=;
 b=P75kxnxgOPBbeKhlpX+Jp6panTdp4Irnd+dWIs7RgvOF9FepaBnIu/WFm39eajVYuThKyY7ui0UQg2OxNbq3KBW7Fh3Vnmp72/3EhVUKITAChTHSTejcqu2yXL8IOMoWoyMn8NeSip7ZvZFlpAklg7Z/sQ6TSpsLTqJXQAyy0dzv/OpAgx5Owrw3zCIBlGsngnhrgUMvjQdrfhwb6WPYWsBfcT3mDOKxAKvBcDLvKb9qPJr8woW55lBAlqd2wuGDpA86LEjKOWpY9eihHHEQmpM5Gh7T8MCpXiWyN6Un8mCKe1szacU3cM1IU3xikyqowjAGHUvClkfw+PMt/W7kNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 29 Aug
 2024 05:42:44 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%5])
 with mapi id 15.20.7897.021; Thu, 29 Aug 2024 05:42:44 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Michael Turquette
	<mturquette@baylibre.com>
CC: Hal Feng <hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: RE: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0
 clock
Thread-Topic: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0
 clock
Thread-Index: AQHa946ZxFTIDR+2oEuXc4Ii2u/z4rI9IAeAgAB3ZiA=
Date: Thu, 29 Aug 2024 05:42:43 +0000
Message-ID:
 <NTZPR01MB0956E46297168E8E21D6F17F9F962@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
 <20240826080430.179788-2-xingyu.wu@starfivetech.com>
 <ba3077ef4b155649812fd8be75f131e7.sboyd@kernel.org>
In-Reply-To: <ba3077ef4b155649812fd8be75f131e7.sboyd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1067:EE_
x-ms-office365-filtering-correlation-id: 4d9c8f19-7d4f-47a6-e5bf-08dcc7ed679c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 jvhcLJn6Qua9MWYN4HgH1zZftDExIvuZ4CXQc0pTAoOF+0dFih4cz/pQZp5UMyos/zx0lhvTDzRrqhKDYKQEe6bS2xcUg4pnsV9OyjqwvDJyX3Qjmoxh269iYmwinu08wtAbBe7Ja1dh2quwRmeE/G6yqMqZb5bNLYWS/Keg4b/FlteFotZsNQyUycCj8fDe7FAFkdACYqdeWaj/U2piinbEzaTU+U3T/JXn5uOfb5WhCQviYyDgHUbMd0XBKV8/zdcSZC0Mkp8GkWBRoDJIgJpiD8ilf/s3r8tdVtTOkUXQaX86XDSWmIruDwKp2/ZiMdN48Yius9LQuKR+bxI8JaDwjzB09rlHD8k4w7+bZ0akDPbUyRxVTlPCsyzrOKX5z2F8nJ/LepqXtfdm9htso8TEwbjT/N7Uvuu7qvm8xnbzuOFa+pTolfQVmmlOTCnc4XFBZ5pw41+oyJ3gR0xdgCCoz64pK9FkAEJmQ17UDNmS/g3K7dfew1xRAyJYH9/J07q+zVit/aIf4L4F7rZxEa3vHZ2J51Ixuxu3TUK0ZRVg8DMk6ra9w4+Dne/uGJ0IqYgygolTvdm+B64a/Xbq/Yx3fMHojnadSlyBJjgsV25cklbbxc9HMs7pmyhNFs47
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUNpSTV5OTJUT2tRRXQvZkdHVGplL1NJeEszN21HY0wzMkVPRERxbkpTdXdz?=
 =?utf-8?B?OUM0RzQ0cG9QdHd3ck81RmJYSVg4RzFua0FZRmVSK3I1RE5YUUxMZjdtbXNK?=
 =?utf-8?B?dG1NcXpXZ1hRWHNoVHBYRDJCMHd6bzhBQnllTDQwVDBkWGU1UENTV3l0OFNK?=
 =?utf-8?B?Q3BXeCtNNmpZTzZOekZDb1hBUHpKZEZUUGk1c0s1NUZDSDBFTVpYZ1lGYytP?=
 =?utf-8?B?YStORkNCcWk3MjVSZWRrQkhMVXU5ZUxCSWtqUzIydlVVeXp3RmtlNXQ3UFBY?=
 =?utf-8?B?a0pGWlBPZ0U0NnVYaGhlc0ZlditQT1FPMVhQSFFkMmlENFVrU3p2RE1HYnZQ?=
 =?utf-8?B?R1NFYnZsQnltOUNUSUI2cGZpaGRIQXJ1SkU1Y0dFTXRYdS9lQnVXY1UxWjVB?=
 =?utf-8?B?WjVsaUpCdGwrbk5TZVh5TGE0THZlN3pGQlpDR1RGWm5NbHowMTRVcytSQkQ0?=
 =?utf-8?B?RzJWN0NaM2hvWGNGVGtBc0wyVFRoTnJyRXM2cmFXc29OdnhHYzVvamF0c29K?=
 =?utf-8?B?Q1RJR0RjMzc5OUVzcmlNRVNLVGRHNUxCOUVZNHV2UjgyelhqenpGTzZIeEZD?=
 =?utf-8?B?VXdFNFFkMTI1ekF6STNzcmNzdStNdmtzMXJyQ0MweDd4MVdjL3FnTkk2RzRU?=
 =?utf-8?B?SHpIdFdqQy95K3ZEU3ovV0t4TW1YR3RveWRlM01JSThOekdqMU5ES1plOGpP?=
 =?utf-8?B?QnBET2JJbmVoZzM3ZTdrUzk5RDFsWWV3cmdmRFpFbkhhdUFZandpbjdKUHZ3?=
 =?utf-8?B?V2pSTG9kVUhJM2JNSHArVEtIRnpwOFV2UUZCZUVFU1VId2QweXBuNG1rZENG?=
 =?utf-8?B?MUJLZkk5T1ZHWkxSRkpuMll3VTZpM2NHTmFweEphdnFNcWtpVUlpd2JtUFJu?=
 =?utf-8?B?eUQ2TmtjcjZoV0U4aXhSaWZWYkMwWmtuRjVseGFxRUhLY1J2OGZKQmY5UDdZ?=
 =?utf-8?B?SjVCS1Q4NDYvMGR3Z1h3em1OUkRMaUxsdGRSanRUaGdzNmordlErSWZMOEd6?=
 =?utf-8?B?VVVTcVpqZktDTitKSmVKd0lNTlZsbnNJUVI3WkpSL0R6RXlKUE9EMVVpb2dG?=
 =?utf-8?B?M3NQbDh4MEdRWWo3NVNZMW9kNno4SHVPbU4vUVpIYmU4ZTRaNnF6SmVYTm5k?=
 =?utf-8?B?RUNtRjZicE5JMjZwMC9jTk45QVJJMnl3OE4zc3cycSs5NFVRcUc2SWxmOENN?=
 =?utf-8?B?TGxKb2c5UjF5YTZ5QUZ3T3FSbno0U3kwbHJoWFlvdWtWWm1ZamU5SkRJemYz?=
 =?utf-8?B?WWRDaGduNTZFZWxzRVNzTjBNdUVhUUMyNnNCSEdDeVkxQ0syOE0wUldZeVZz?=
 =?utf-8?B?QnFRVGNST0lPc2V6dHkvb1lGWThvZ3NheDRIS3FBTWtoRllEcjNKNjFiTDhI?=
 =?utf-8?B?cy9KT25XNVZiOW9RZDBOeXUwRnY5TzAwL0xPR25VcitrbVRZMkU1VGlNcm85?=
 =?utf-8?B?d0wzSHN2VHpWc204RmJHT05MdFV6RkJtdG9xTHRKK0JIUGk1TzlheTZPL3VK?=
 =?utf-8?B?ZUtiNThONXhkM0NXUEUyRmpzN2Q0d2RwN1pIcGdBM3FHK0JlVVUzT0hiUUlC?=
 =?utf-8?B?UkJRZWxrUEFxeExyVzlrRzBmRXNPS04wWHVNYkVIcTBocEg1NDFtZnpWSklr?=
 =?utf-8?B?OTBTLzVPT2todVp0OWtEc0ZmcEtlQzBheXFIYWE5Y1N0aVZoNVB4ZlBjRzN2?=
 =?utf-8?B?RmJpRzMwTURLNDBwSzlvS1NvT09hLzc4cEYvQzJpZVAybmNvTW5DSkw0bEZi?=
 =?utf-8?B?MjJ3M1E3ZUNVdUJDU3hWQy9iU2J6RnBIZm9DNUg3NUZyRUM0VkJYWnk0NStO?=
 =?utf-8?B?eW1HREdpbXpuako5allwNUlvOWFhMkVXOUlUcmZTTXdDRi9lWWNjNWlrVWo3?=
 =?utf-8?B?alJvakRIY0dSTXJvbnJuNWFYM3VZeVh6N1k3QS9zdU9mblJ5QVhseFhrTVpU?=
 =?utf-8?B?L2FWQWlVZ3RXdExiOG0zZUZBR1pUYktxczdOcHNpS01GUEZUQXR2a3RwT3Yz?=
 =?utf-8?B?TDhRRHhRem0wdzdiODVVYkQ4U3lzNnYxUC85QytjWkJjK1lMQkZhbjhnejFF?=
 =?utf-8?B?dTRoRlN5YUc0ODE0Q1FhaHVDeWRpMGJnZHc0bHVEZk9ENU1EMlZkZ1hzMUk2?=
 =?utf-8?Q?CVD3cy6hk5K8QpmVjUVQ+wMxw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9c8f19-7d4f-47a6-e5bf-08dcc7ed679c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 05:42:43.8648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dg0DhAlIc1EpvfvlD/3cXaRVDPujDvIHMs9KBpza06b9keGHxFmULqzesxUW2F2DU4aU+RgLyakd1zi3ZcIcJvQKNP909lwviWd5CoQ/7Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1067

T24gMjkvMDgvMjAyNCAwNDoxOSwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiANCj4gUXVvdGluZyBY
aW5neXUgV3UgKDIwMjQtMDgtMjYgMDE6MDQ6MjkpDQo+ID4gQWRkIG5vdGlmaWVyIGZ1bmN0aW9u
IGZvciBQTEwwIGNsb2NrLiBJbiB0aGUgZnVuY3Rpb24sIHRoZSBjcHVfcm9vdA0KPiA+IGNsb2Nr
IHNob3VsZCBiZSBvcGVyYXRlZCBieSBzYXZpbmcgaXRzIGN1cnJlbnQgcGFyZW50IGFuZCBzZXR0
aW5nIGENCj4gPiBuZXcgc2FmZSBwYXJlbnQgKG9zYyBjbG9jaykgYmVmb3JlIHNldHRpbmcgdGhl
IFBMTDAgY2xvY2sgcmF0ZS4gQWZ0ZXINCj4gPiBzZXR0aW5nIFBMTDAgcmF0ZSwgaXQgc2hvdWxk
IGJlIHN3aXRjaGVkIGJhY2sgdG8gdGhlIG9yaWdpbmFsIHBhcmVudCBjbG9jay4NCj4gPg0KPiA+
IEZpeGVzOiBlMmM1MTBkNmQ2MzAgKCJyaXNjdjogZHRzOiBzdGFyZml2ZTogQWRkIGNwdSBzY2Fs
aW5nIGZvciBKSDcxMTANCj4gPiBTb0MiKQ0KPiA+IFJldmlld2VkLWJ5OiBFbWlsIFJlbm5lciBC
ZXJ0aGluZyA8ZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fub25pY2FsLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBYaW5neXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0K
PiANCj4gV2hhdCBpcyB0aGUgdXJnZW5jeSBvZiB0aGlzIHBhdGNoPyBJIGNhbid0IHRlbGwgZnJv
bSB0aGUgY29tbWl0IHRleHQsIHNvIEknbQ0KPiBhc3N1bWluZyBpdCBjYW4gYmFrZSBpbiBjbGst
bmV4dCBmb3IgYSBmZXcgd2Vla3MuDQoNCkhpIFN0ZXBoZW4sDQoNClRoaXMgaXMgdXJnZW50LiBX
aXRob3V0IHRoaXMgcGF0Y2gsIENwdWZyZXEgZG9lcyBub3Qgd29yayBhbmQgdGhlIENQVSBjYW4n
dCB3b3JrIGluIHRoZSBiZXN0IGZyZXF1ZW5jeSBvZiAxLjVHSHouIFRoaXMgcGF0Y2ggY2FuIGlt
cHJvdmUgdGhlIHBlcmZvcm1hbmNlIG9mIHRoZSB2aXNpb25maXZlLTIgYm9hcmQuDQoNCkJlc3Qg
cmVnYXJkcywNClhpbmd5dSBXdQ0K

