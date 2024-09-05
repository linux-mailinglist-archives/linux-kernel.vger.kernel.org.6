Return-Path: <linux-kernel+bounces-316638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55296D23C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F60288940
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F60194AE2;
	Thu,  5 Sep 2024 08:33:48 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2133.outbound.protection.outlook.com [40.107.222.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278BA194A65;
	Thu,  5 Sep 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525227; cv=fail; b=BADb9yrIIz0CmbHjZeg/o54dFiJQL5Nrp7Hjkwfgzxm6FqSaGpib0pmJa1sdl+RyxLJSLJxyo+/Wtof4qcga2GlxQ6d7iGFd4wUnurqMZWCHMvAmyMny0OOnYep4f0ouN/iyWn9/9tqCZq/F/0w64bsFDJrFhxLLego+JzIITb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525227; c=relaxed/simple;
	bh=CY38kD11gdlbsbb9RXh9m1WuW5ReoQj1TqZCp+m2vx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lC0cIqzboxLClxg0ALV7DOCMP3MyNf2IpxROO804EFBYcMokmvxdPmG6a6HlxRMY5kBguLldiHpbeDQf4lWTc7cifLyeymNnZnSw+lPbVMYNGBo3T4xwLtKrtxxspaT8TpaXVoa7pVpst1uwjPgdOkzXfuCM2lI0XXtEmcq1oog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSF7A+iH9eH3QwxU+vXLb2ny8DeDNVmDMnw4wa+leKJ6+E9wk/0u2aPwlEm+S0u8SQ3dYZ5s2QvkhotiRDVoIJRzF1L4n1aEhOD0IL2BgTl6wP8NWQjNaIp4ynSSnttFKq3ZFwILqRai0oEHBayI/2cZdefurQfkcTk+5BjSYzocQvuGqjb2lz05dbDl0/YqNW6UvOYdEPxZhZauLYsi8K2lFnQ7/ibatHuzuVrAl08sk/loutJEgBTc1o3rfmEiquKSNdLfqv9FeGf6acbxFuXVmkT0f8Y41t9RgZ0w3sYSKkFgE+vNrJsa++BVXZ0MiE3zzW4/7sVKvhQsnMZf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY38kD11gdlbsbb9RXh9m1WuW5ReoQj1TqZCp+m2vx4=;
 b=LgRj3PyzZJ+nuJjdOqNybo5u1uIr1jVM3DVjFDwH2cjyEtmYmH1t67fm4YawghrWbXADwm9DS4WdKCWeP4CL0AWfQ1wHD0TzZLLI0pvOGhK2i0qIsmP4KS0gf2ubaWUvnrbbGQnudxYRgyd041Az59Vt0MOdbRMrNh9cVI3ZYVykZP/6OQND5JoIJnwp6+mCKRIDawkPrZjx1Omuj5vcfSOGA0VOVPJx2gyRi0Cib6UnNMzmuN+t35Os7GHpeJOiXwUgUoBpBMp2UoQ4LBCSoQmRxKle5KzDGwZAiHmsl6TOGs0efKe1qTC8BcoBBPqgohPPMy9aMb9I8thgRtO6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MA0P287MB0620.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:11c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 08:33:42 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 08:33:42 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: "Rob Herring (Arm)" <robh@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, Sascha
 Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Topic: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Index: AQHa/eIwzwcEDJ69bUWxWwoatqaLUrJGHtUAgAAAfYCAAADKAIACvZHt
Date: Thu, 5 Sep 2024 08:33:41 +0000
Message-ID:
 <PN3P287MB18295916174A4CC5121A90828B9D2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
 <172537334994.875077.18308965320836312656.robh@kernel.org>
 <CAOMZO5BNYopFt=_o5qrK7piwxYwF4E10DzCKPW4oh0k4Yj0hUQ@mail.gmail.com>
 <20240903-amazing-shaggy-ant-6751f7-mkl@pengutronix.de>
In-Reply-To: <20240903-amazing-shaggy-ant-6751f7-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|MA0P287MB0620:EE_
x-ms-office365-filtering-correlation-id: 95f4e17b-4b46-4589-dd9e-08dccd8572d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVRXUWdCdS9nYmNHN2ZvWEJUWWd1VU5mWlQ5U1RBVEF3Z2NRemtlUFJHcWlk?=
 =?utf-8?B?NE04WkhYRU1MckZNS1g5emd5Y3VjTUFnWGxhTnRrTksxZGUzOW1GMCtCUWkv?=
 =?utf-8?B?Kzlkb2JJWFB5TUMxejlsc2VIZk9DNWxPTitDVUNsR0F5MHQzZ3d3ZmhTYlM5?=
 =?utf-8?B?clpiRUd2U0Y3enMvRGFkNFJpOXBvOWJhbDUwQm5IN3RGYjFNT3N0KzZJY1Np?=
 =?utf-8?B?Y3Z5VWduZTJLQmNjY1hwVlg0cW5teUF1S2doNnczR0Vyc1Y3ZzJTU2cyWlVY?=
 =?utf-8?B?VDFURUlVWVh3anVEd1VvQmdFUWFMSTl1a2Q5VnNoZ3ZWcWRMMmdhci9pZmd2?=
 =?utf-8?B?SDNIcWVaM3pEMVh5VFR3amc4M09hT2FSbWRpeHVEVUNnYktVdEYvRXVTU0NZ?=
 =?utf-8?B?cjdGVTRWNEtrajhoNFgwSUw3NUlSUUVydkZ1aHhhMDBkVTRKbHY5NVp5Z3k5?=
 =?utf-8?B?T3RvUXhVcC9zcGlvcksxMEI1WklIMGN3SG93OWtoaWF5MnE4SHF1SFRXczBq?=
 =?utf-8?B?bzhYam1zNnZtMU1VRS8zU2wwR0lmbmFkYk9lZW43eEdremFaWE5NVnVhQlJH?=
 =?utf-8?B?dm54QmMzSUM3ZUV4M2RqWVJxRkFremRxeFhmZEZGbzRvclRaa2g0WHMyM3Rz?=
 =?utf-8?B?TzlMV0FjYmlraVRRUUZZZWVpT1pja1NGWWVBSjQ3NmtOUzlLL0JZKytsSUd4?=
 =?utf-8?B?UER2ZWVNN3FSVUJERW9qcDVZa2tTSEUyeVNqcHE4Y1pHK1FRV2xhb1ZLOWh3?=
 =?utf-8?B?d2FqZ0xlcjZUMTJTSWFrYXJ3bzk5d1V1dGpWd2ZkbU9mNlhBS2tFV3EzTTFj?=
 =?utf-8?B?dURub0pDamN0QWZEZEJXVWdsaHdVRCtob05NaUNyZmJlaUtiV2lmb0F6bU8v?=
 =?utf-8?B?SlErVzdxdSsvdkFKOUhsdlNUK1hRaDRNRHM5K1ozY0ZmMEl5c1pmcVl3NWh2?=
 =?utf-8?B?eVprdCtwR2ttR250ZnRaUWlxY1YreG5SUmdXeDYxU0FYL0FJUFpMOEVoc1pl?=
 =?utf-8?B?WlJiUStETUVEMnA3QVY0Q1ZOekhNajdud2NaRXBMYmRuNlV5aXJPZ3AxUVZP?=
 =?utf-8?B?b3RGa2xMd3NWVTFzQ1N3VTVVdDM3UHdHNlNjSjBORk5LZVVmVWpXSUxpV3Fm?=
 =?utf-8?B?RHphS05JVE5oSFQ3ODdyaU1SaWlNVFNqRTBwaEtiQy9UUUhhdmJzRkkweXZZ?=
 =?utf-8?B?WDhZakg0bWMyNmIxbjU0U1pNMlZaM3kzTG5LeFB4dnVSOWNkNFZ3YlFqOTVU?=
 =?utf-8?B?WHR0bEc5ODBSL0ZSeTFOT0NXN1VpWjlBdXFFTytLU0paQU9rejdPY3RLeENV?=
 =?utf-8?B?REc5Z2J0bEZKQ01hVkQ2NUsvOU5ER0tWRWV0NUhjdXNOR1p0ZG84eVBDQkd1?=
 =?utf-8?B?RkhyR1lGOElOdzNIalQxUU9RSVRTWDh2TlI0M2VRM1ovbEwyVnhWZDhNL3dJ?=
 =?utf-8?B?MVFLbmxWQ3UveTcrN2VOZCtsSEd2Wmh4Qi85VTdsakl4S2Rra0lPZUYzazQy?=
 =?utf-8?B?ZHRIWThuYnpEQUNmUTY5UFlUOVlxV2ZSYm1QQmZENE5veFdVSXMyYStzK0tP?=
 =?utf-8?B?eXRKdS8yUmhtSW5DL2JTWGNnY1FDOWlZWjZoNys0QnFLNnFIcGpoamplaHBu?=
 =?utf-8?B?R1RtamxOdnJ3ZStCU1hFQndXb2IySmUwb1NCMnIzcTFvb3ZSTDE2ZjdmWnVm?=
 =?utf-8?B?VndVQ1RHN1dPZnJPUW5Icy9aSUw4WEdvNlFMdjhQT2Y0aHRnNFlMWVlBclBR?=
 =?utf-8?B?N0N6T0FXam5yN2pLTUIrN3MvYk9BdTJ4MUlMa1ZRQnVoOUZ6WW82MVdUZFND?=
 =?utf-8?B?Ui8zbGVJSDZPSmZXbEFMNGdFRUZjQW8zTXN2S1ovZzhwdmM1WEFYWkF0blcv?=
 =?utf-8?B?S3ZDWTJpMnBPNUNhbGxTTXNGSHlCa2pjREVMY0hXdFlXUXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXNoTkFnY29Qc0pUNFdOdjBuZFJUdE8vOUFMbjUySE84ZitWSVVqTENHU3h4?=
 =?utf-8?B?cUxnRm8zdHlqdStxdzdMNDlFZU00SnY1ZkJVRUFjVGR6cEJ2YW5YOHA0VE9L?=
 =?utf-8?B?ekpPVGVMR3ExRWRtSFZRb0E5Y1VTQ3dSaTVUMW9qM3BJcG1sTHhqN0RYbEtz?=
 =?utf-8?B?VEJFUVF4ZFEwYlNWUEt1T0NrQ0NaZGtDQzNnWWFwaS9OOWZFSDlnRE5QWTZt?=
 =?utf-8?B?S1RZaWpMNVB6SWxBWGRZcE9aOFFxQm5LSlk5REQvR29admNwYnoxeEwremRS?=
 =?utf-8?B?WWtwajBhWmNaQ0grQnMwNm5DUlhIUVBWaHZPQlNKRGQ2QzM2WFBBWWdVRzU2?=
 =?utf-8?B?a3Iwc1NId0VGVld0dUFhT05zcEVhdDM2QTRTTzdxak1rK2RtdHpab1JMVW9i?=
 =?utf-8?B?MEZZcEhGL2hKdGZpanVNQ2FtZWd3TFE2eXdBVkVlZ1I1dW9QZ3JvM2psam50?=
 =?utf-8?B?QWNwUk5aZFcwcG5tRXpzK3Awb1BaNWlNUk92MjRpN2d4WmlsSEVtMkRWU29R?=
 =?utf-8?B?bm9LbjhNWjNtd0ZVc0dkSURvd3p0c00zWSsxSWxtZWE1K2dYQzlUaW5kakJn?=
 =?utf-8?B?REdFUCtYM3JWTWJXVEh1U1NKdkNpQjZWUU1JdUpaTTlPMXV0ZHk0UzlMSDhu?=
 =?utf-8?B?cGdSaTdsT0VGTEtYV0VMTDdhbHN0WFBVSmdrWE1yaFNsQVhQK21kZXZNS01s?=
 =?utf-8?B?Yy9jWlZOaVc0cW1oLzZYclBtZDJOYlhWYnVoZjZTcWRwNWlYcmpML0NmcVFn?=
 =?utf-8?B?WUtMbVhtSmNPeXp0TS9GNi9nNktJc1pYd3NLb0JHK21LbzVyV3diaGNkcXZk?=
 =?utf-8?B?NnluSkhVeCtCdWV5RGk4czBxMXpCL2gwTUthUU9YYTFNNGtiSGVSdjlMNklt?=
 =?utf-8?B?c210OW8vYmZhVWFCalBDaENNY3YvWmVpeDZoM1g1Rkt3cmpsbWZES1UrN1NT?=
 =?utf-8?B?TFNJN3o0YzFmQ0RVUWptVDJFUnp6MjNkdzZ3a1lVSTRsRHA1b3RBZXlpMzdi?=
 =?utf-8?B?ZHVMMkJKek5zbjNLcXFoSUtjT24ybzMyZWlQbVl1R0gzeE52MUVpekNBU1pk?=
 =?utf-8?B?TGl2ZExjS09FMW5oeHdjVDY0ZG5TWU1wOG5FZnpMUlY2NTcyWmNFSzNUM1BD?=
 =?utf-8?B?OTFuMlRjdVNBcnU5RTdMZUllK1A3LzJEWWkzUzdxY2hkL2djYWpNeWNHT3BN?=
 =?utf-8?B?UTJwcmZIN1cxRy9sNFpIQnlRV29qNFRyalpiOHo4RU9HekVGWndXczZnOVo3?=
 =?utf-8?B?a21lekppc2txeFB2R0R5aEFoVFZlU0pSQWxXZHdUM3JKckRFMWhmdVdZbVBM?=
 =?utf-8?B?bkpZTHc1Q0psV0tXRXY5MDFPVkQ5MjljTnYyRm5jZ1JqRmJKSGI0UHdjSGVv?=
 =?utf-8?B?S1pyUXo1T2NoUWtZZWhGYjNTNmphR0NzQXZNSTIwank4UGRoaHBjR1dKWnhZ?=
 =?utf-8?B?R2xlcHhkMllRcDZTRVVRZEdBRlhsNVd6SVhwMlFVeDZrQ0VBNEQ4RFJoM2lO?=
 =?utf-8?B?aXB2VXhteGZSa3JKMlpoRTFMbmp3VnM3K1R0cE91MUtFWVVnMEh0QXk1NFZo?=
 =?utf-8?B?RnM2QVZpZEt6Y1JCWWc5YlVUZWd6VzZVN2kyNzlRUnRITjl2ZU16U1p4SlZJ?=
 =?utf-8?B?LzVsS0ZHejQ3VUVwZUNvbkxwZk5udk5ZR2xqcWpwcFZoc1FjL3NLY051bkZN?=
 =?utf-8?B?bW1ZRW9lamY1UlI5OThIcjE2T0ZvSjlValhGb3Fyc3ZJanRzNit3N2tBdTB4?=
 =?utf-8?B?ZTdkdk1ycjFzdHZaQWdSZS9jVmpRUlF2SVN5SU1wQUdjWjBQYVYyL3F6alZF?=
 =?utf-8?B?K25MREM5bFIwYWYyYkRINTBXZTNCd1pTdTVJNEd2cTNtY1RVRnc0OUxmNVdq?=
 =?utf-8?B?K2g5MTJxa2RCa213NU5Oa3hHNElNenVYTjZlRWo2ZXdDd0RzdTdmNGFFNUxj?=
 =?utf-8?B?dEVBNkRNQnprTHlBU0V6UmtTdGtVeU53V0Fzck1qZWl3SU1MVFB2L0o4MW1O?=
 =?utf-8?B?dWQ4bTZ3ZGJEV1gvbnBBYUdvVWtpVER5eXRuOEE3L2VMQ2hUTWUzYUlldkoz?=
 =?utf-8?B?Yjl2VlNtRlhuNlMyWnM3cVFjaWUxMjYyMVJzeE5TQUhWWnJ6V2QvNmo5Qm5a?=
 =?utf-8?B?V3RkSnpFcHZuWmw2UE4yWU93NVJibXpaVFJMcW1nNitLM1N0RXMxNGtWMW5Y?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f4e17b-4b46-4589-dd9e-08dccd8572d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 08:33:42.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5NirGesTvzPoQGu9MptShUVGCK3h3Z84k2J7MkH5h+36b6LH9YVMKTeGdZ2Mrj27KmD43mcieBBZU+HmNrI3A6aKAtYJs1eaBp5FokzBxvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0620

SGksCgo+T24gMDMuMDkuMjAyNCAxMToyODoyOSwgRmFiaW8gRXN0ZXZhbSB3cm90ZToKPj4gT24g
VHVlLCBTZXAgMywgMjAyNCBhdCAxMToyNuKAr0FNIFJvYiBIZXJyaW5nIChBcm0pIDxyb2JoQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiA+IE5ldyB3YXJuaW5ncyBydW5uaW5nICdtYWtlIENIRUNL
X0RUQlM9eSBmcmVlc2NhbGUvaW14OG1tLWVtdG9wLWJhc2Vib2FyZC5kdGInIGZvciAyMDI0MDkw
MzA5MTcyMC40NDMwOTEtMS0+dGFyYW5nLnJhdmFsQHNpbGljb25zaWduYWxzLmlvOgo+PiA+Cj4+
ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWVtdG9wLWJhc2Vib2FyZC5k
dGI6IC9zb2NAMC9idXNAMzA4MDAwMDAvc3BiYS0+YnVzQDMwODAwMDAwL3NwaUAzMDgzMDAwMC9j
YW5AMDogZmFpbGVkIHRvIG1hdGNoIGFueSBzY2hlbWEgd2l0aCBjb21wYXRpYmxlOiBbJ21pY3Jv
Y2hpcCxtY3AyNTE1J10KPj4KPj4gVGhlcmUgaXMgYSBwYXRjaCBmcm9tIEZyYW5rIHRvIGFkZHJl
c3MgdGhpcyBjb21wYXRpYmxlOgo+Pgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIw
MjQwODE0MTY0NDA3LjQwMjIyMTEtMS1GcmFuay5MaUBueHAuY29tL1QvCj4KPkl0J3MgaW4gbmV0
LW5leHQgKGZvciB2Ni4xMikgd2l0aCAwOTMyODYwMGMyZjkgKCJkdC1iaW5kaW5nczogY2FuOgo+
Y29udmVydCBtaWNyb2NoaXAsbWNwMjUxeC50eHQgdG8geWFtbCIpLgoKU2hvdWxkIEkgcmVtb3Zl
IHRoZSBub2RlIGZyb20gbXkgRFRTIGZpbGUgdW50aWwgdGhlIFlBTUwgc2NoZW1hIHBhdGNoIGlz
IGFwcGxpZWQsIG9yIGlzIHRoZXJlIGFuIGFsdGVybmF0aXZlIGFwcHJvYWNoIHlvdSB3b3VsZCBy
ZWNvbW1lbmQgPwoKQmVzdCByZWdhcmRzLApUYXJhbmcK

