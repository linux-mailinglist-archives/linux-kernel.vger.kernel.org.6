Return-Path: <linux-kernel+bounces-380456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07E9AEEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8D3286D02
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA61F1FE0E8;
	Thu, 24 Oct 2024 17:57:45 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2114.outbound.protection.outlook.com [40.107.239.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F71EC01B;
	Thu, 24 Oct 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792665; cv=fail; b=Anyd9cgYrIB/1jvaZqoPFDsf5wGTvDq1NT9xA/2lm/vhb+Rnub22umYUjrI5NfF5YhPLxgCG36sVzALoKG4O8+eDtb0Q7BYXu9bhdQYeQQcNtZz1zUUU5GEi+4J83wk5LZjDXq8juefBTZvAKIMTmD/EXfz901/XJO/0oHEqCbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792665; c=relaxed/simple;
	bh=/GW9CZZTqZ0Kct2FjeeOSByeqHVUgwsYKh6a/T5r+KU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dCzORRfDeqWGe7puftwhLyQ/Gl+qXfmvI+Yc/Zwct1pQss+n+Hu24ExZC5TEzb3wLZhnUinmIXFAQ+kBvm1j8l4qY8+ooE0z8OTui2BTf9o3aBYpKAYGVRxQ2lI8X6knKy7PdPnbvOJdCIT4cXcwClY1iBR8Qlu/jfIADbIzGsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3EIHJ59j3L0KCIDU5/hgCEfM2l7XjbGKkAirY0cduvCKKmEp6/6h4G937Rt6hXNmLF7Zcn2Xo3XdpmaMYD4cmZorm+2fsKldTciBeRfPoVW4V1jppukWfhTvZRO4EGrFFciETSy9WMnIRR1m9fqAJTatsBXI3agqMpanc/vGOYnUfO1A2Wc8UMSX0vJgTGwPq6UV6Vi5CvaIKcSlEm9hJHUdId3OKTh9AL8M/iw8zYkktgYW/gCfrpSkMQxeHYHDHe0zP9DeeXoMYDRAUv90nBf8VpIodwE8UKZfbTh0r8t69CzpmuCUZhjevOSC7oqrl4RoiB4BK/VwQiLylgkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GW9CZZTqZ0Kct2FjeeOSByeqHVUgwsYKh6a/T5r+KU=;
 b=To/mnX8IPnjQv9vy7qd1eAM4XKZAy91VE6rKYzz9B5GPARyyP4zl0fpYYg73lzQTxD/WRiDuteT2Zg0Puimy52cTTH5ODRxucSnuCGLrK8g/Ko8wPOtFyguJ9YLuRWbp5zUbCFOQE8mNmQyOY2BIdsRXX43VTNj8jg4khAzY7MlTkQgpmKFgJ+hYqNE7WdMxeVNYiiW03WYeopaC0RCUrK+s2ziteTqkodQLR6DsPjuxMiHcsZ22VAQ4ugiwZoiMa2kftS3s2nO/EfuOwHvkAyi8uvPdii85AUHYvZI8CHD3Lm9byqWK+nVJUKXeUm+xhbP/RHS754kyVq8xrnbYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MA0P287MB1865.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 17:57:37 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 17:57:37 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Fabio Estevam <festevam@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
CC: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, Hiago De Franco
	<hiago.franco@toradex.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Michael Walle <mwalle@kernel.org>, Tim Harvey <tharvey@gateworks.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>, Max Merchel
	<Max.Merchel@ew.tq-group.com>, Conor Dooley <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Gregor Herburger
	<gregor.herburger@ew.tq-group.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Peng Fan <peng.fan@nxp.com>, Mathieu Othacehe
	<m.othacehe@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 0/2] Add support Boundary Device Nitrogen8MP Universal
 SMARC Carrier Board
Thread-Topic: [PATCH v3 0/2] Add support Boundary Device Nitrogen8MP Universal
 SMARC Carrier Board
Thread-Index: AQHbJSvLkb89zyHfvk+FXId2gM9wCLKWGoIAgAAO4YCAAAYusQ==
Date: Thu, 24 Oct 2024 17:57:37 +0000
Message-ID:
 <PN3P287MB1829C20F6685FC27E91E4C9A8B4E2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
 <172978739819.623555.106741073057492931.robh@kernel.org>
 <CAOMZO5A7Erks3CHh97AN-XP=Aj2QBUcikAT0ijxkGEchqMfWVA@mail.gmail.com>
In-Reply-To:
 <CAOMZO5A7Erks3CHh97AN-XP=Aj2QBUcikAT0ijxkGEchqMfWVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|MA0P287MB1865:EE_
x-ms-office365-filtering-correlation-id: a721e842-315b-4b4a-ddd5-08dcf455588e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L05iVEltYjBOK0pDTHluajI5MHNUbCt1UXllRWt2a2hJOFFXZmhhUTB6Ui9O?=
 =?utf-8?B?WlVaN2Z5RVAxdHc2NHg2cFFDZitsNGFIVWU2ZUdlMnV1cmtpbnBTMWtkWTJY?=
 =?utf-8?B?VGhJbXpCU1ZnNXFtTkFEMTJiYmJmUXgxOXN3OEoydFN4dUdsdzEvSlNucXUz?=
 =?utf-8?B?cGx3NmpxbVd1VENzZ1JZOWJueWlOQktlR3lyRjE1YzdrMmxST3ZvTXdndDQv?=
 =?utf-8?B?S3Vvci9sQUtMZnM4Ylh2Sk1CQlNaVk1oZXN5dnR3ZkxiUWdHRWw1cjllQXB0?=
 =?utf-8?B?Y1d3TmRQZzBCejJ3ZXYrSzBNT1I4bkJZWGtSSnFTdFJMWmFSK01rd3FJMCtw?=
 =?utf-8?B?NnlBUXBtUFYwNzdja013dmZZVithSzVObCthSzVXNDBiVGc1MzdFOHhrRXcy?=
 =?utf-8?B?WThSTEZPODh1SlhLdk1GWW1IT2JES0VtVWhLTUtVbmMxMGZhQnppWVVFdnI4?=
 =?utf-8?B?eWNtZkhmeS9ROTZhRW82ZTVrMVpGZjNpc043YzlMcWsyK2RteGRJYnEwWWtI?=
 =?utf-8?B?WW9CdkxpSjBZdEZlbXFsWE1vTHBkMmg0L0xDTFVnd09ocWVOYVg1NE12SkRF?=
 =?utf-8?B?T2tEdEIzNlp4VllLUmdjeGllcWt4T3E4WkcxcUsySk41YktsL1BDMVVtTVFx?=
 =?utf-8?B?bmp0UnZsRTVWZXRUR3hBbjNZQTd3VWszc3dIZng3ampqelNkWm9kK0JmRUlD?=
 =?utf-8?B?SStiYVVXdVdXZkFNdjRiN2ErT3ZhVTFnYno3Tm9WYUJBdnpjd2crNlkxbCtu?=
 =?utf-8?B?U2JkSnNkMHBHM2I0K2dpMXVBblVraFoxU1RaVWk0bTc4RXhDN051V2RmcTNm?=
 =?utf-8?B?VWQ5RkVQRW91S3RuZ2JnV3FQZU42WWJ3bC9MTGsyeWFPQjNJc3M3ZERpOFU4?=
 =?utf-8?B?dnB3dTJpemxXV2JQb0s1b1NjK25ITUkxN2Q1bTBlRVBZWTFUb1pBRUdINWJJ?=
 =?utf-8?B?ZHZFN1IxNkljM0RpOGdFK2l6eHZXQ3NWeVp4bm4rVkhaNU9kU053M3BHbHR0?=
 =?utf-8?B?QTNEOWdzVlMyM0d2UHBRMmNDOE1jNlUzVC95VmxPQnh6cmVFdkJpemFpNE1M?=
 =?utf-8?B?TmlMR1orWXdzNDZqcmxQWGtUbjA5bUUwREN0RkVBbWNpZFVCTlJyOW1IVHBI?=
 =?utf-8?B?ZFVhRmpOZHFiclJlVS9JRXdrRkVtTjA4WCtWT3E0bWEva3dEQlNDWUsrTSts?=
 =?utf-8?B?RUxPUDNEVm8yMFJwWEV5MGFDUXZsUlZ5RjBTN3dYSThSWG90THlDN3N1eUZz?=
 =?utf-8?B?K0txR1VGdmtOZmd6U0hvWVV6TjFEaGdFWjhRM3dPNHpWQ0o2MEtZMWtvdVZu?=
 =?utf-8?B?cmlMTzlUYU1mU0tnNEdmdys0NldHTkJQSWRtZTJJeW1pMU5xdC92NFR0eG0w?=
 =?utf-8?B?VVpuejBJdXdKRVZQdGFYck84MEZKazhuOW1ZUWd4bWVMMzMxLzZQQ1d5K3Vn?=
 =?utf-8?B?anMydUdvQmo0YlZScldPbVdOMG14WURQaWs5TDRUYTZZZnBMTXBkS29CYWFm?=
 =?utf-8?B?b0g2c2V5UzAwUExlMmlIOXZTZmRDQ2lFUVpaVjg2eUIwOG0rZzFtZmp6TVBo?=
 =?utf-8?B?a1l0MXZ0eW9LQ0NiK3MyR1JUcitrRG9WV0JJS2g4ZVdFS3NsaUFvanAydGMr?=
 =?utf-8?B?RlFhM0drRjJwZG5UM21MNGYrZ0s3UkhCQnRvQUtqQkZpd0x2dzBsa1hicVQ0?=
 =?utf-8?B?TDQ5ZkFIQjk4emQ5eU81VUE0Y2tRdHZvZjR3ZGVKSlVvZWtVQXB6ZzJBMWpG?=
 =?utf-8?B?ZHNSVFZSU0VaYlpEYi9HN2pBc0c3cUlvalFvNkdhaFplU0xQWjdYSHRXV1hs?=
 =?utf-8?B?SVhXMVlsQ0ZnUGE0Qm45NHFuUUpZaXZxWVBYS2Iza3VNelFtNDhsblEwYmNZ?=
 =?utf-8?Q?F0CIEva/ZNPz6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2pkOXYvcW9pS3FyRjdSa2pjV1JEdnp4eVh4TmR2Ty9CdXErRC94ZDRkQTF0?=
 =?utf-8?B?R254dm9Zcld0Q1lONjlMa3RTZjFzN1hGUDJwRUJ3VEUrTy9WUmJ4L1NIQzFp?=
 =?utf-8?B?MEt2M2FzcUNQN21MN3NwM3lvcHlrcm5UaFk1T21PdmFlYy9yV0ZTS0JrcE5k?=
 =?utf-8?B?UW9MK0xDamVFMGpReGh2TlluT2VuMHhsaXBwM3JSTlVwcHpFTjhrTWxjSm1Q?=
 =?utf-8?B?ejVlUXIrUXo1S0ZHNEpNMzN2WksxajlxdmdsTnRNV21SOXU1M29ZMURYcWlT?=
 =?utf-8?B?QXluL3RFTmVZVis1Ukg0aTJLNVVWWEtNcUFZUndIQzNUR1FWb1JqVHFsVHhp?=
 =?utf-8?B?YXdpajVDMlI5QWhTN1pjbEQzcXdZV1lURGtHNDZJc3A5R3diSzBWU3F2NzVJ?=
 =?utf-8?B?ZXhOeFVRVlpVVGU4S1JlaVZHTTFhdUc2U2h5R2MxQlZQbllvOEZoaEJEdndH?=
 =?utf-8?B?OUNJbEJ0a3Y5aHF4aEtHVEh1ZGFkVlRaVThOdHRNUlk3MmJza0pyTTdJY0ti?=
 =?utf-8?B?Vk1qYVFreWRROCt3SzZQMDhucTA0S3A4QyszZVJYMGZveU5vWmtCUCtSTmxQ?=
 =?utf-8?B?WjMzUnp5L3V4YjI5c0luZXgzY2x5WkhIRmpIWGlJbjY0ZEMwOG1TWmJTOW05?=
 =?utf-8?B?Lzd2YkZLak52T3Mvc2hxNFpDdWFydmo4cXNmUXkrZDMwNjcvRUlPUisyVkZl?=
 =?utf-8?B?VTg0alh5VnNJeHlwNnRJaWY3UUMrazk1Mkx3UHNOUWFsSWcwZFFmb3NkeExI?=
 =?utf-8?B?eHVWS2ZMK05DVS90cmRrNCsrNHFSTTE2bGR0ZlF3elBtM0JGK09ZVHZndHJK?=
 =?utf-8?B?MG5Oa3RRWVdXU0QyTWFYcktaNzZrRkVkZzZqek1DU3ljWXF3cmpBb2R3VGN6?=
 =?utf-8?B?WnZXSHl0WWQ2THF6WFZ1OS9GYlFhYUVXcDRsbDFsdDlDNG1admt6NXFvM0Iz?=
 =?utf-8?B?V2U5QTZRb2g4RWFsakk5dzZqQUVWK3Yrb2NrUFp0a1daWGlTTG5yL0xLODVr?=
 =?utf-8?B?NmpqdlVpNWlWWlVxeTFENDhuT0lnQk5LZFdQQ2VaN09zNFNiM3ZGOEp6WUJw?=
 =?utf-8?B?Tzh6QWp6L3gwV1orRnNBZ0FubkYzNW5IMmZ2anA2SEVRNWd5UVRlY0ZBZVNX?=
 =?utf-8?B?bFhtOE51cERFaGZHV2ZrdmluSGRXSW1UaXVLQTUrRmxMd2JVSkpWcnhDUVRL?=
 =?utf-8?B?TjNVYkR1bDVWdXI0YzY1Y2tSQTMzL0NnUG5weGVhbVVtc2NON2pOQ3E4SmNM?=
 =?utf-8?B?RFY5V0ZxTVhVdjlkdGVoR212YXBiV3J4VVBoVVJMZG51endMTklMcU1Pcloz?=
 =?utf-8?B?RUVaUHhlcC95a2NhOFcvOWc1VkQwMDVTNVY5Q253d2YvdmhYQk1FUnVzK3R6?=
 =?utf-8?B?MkV0eVBrYjNKMDlKK0VKQjVWMEVYRUtyY2hkVGtCUFpRN0hNOWhvN09KZlRI?=
 =?utf-8?B?YzVXZVc5bVFmTS9teXRmOXF3cjk4MWlvaUVQNFpKdk5ua1p0ZzJuWURTby90?=
 =?utf-8?B?SnVWdGJTZDhsdmxrOERFUGJmcFhaVjlEY1B1bXA5ZGhUT1dzZ1lSNjAxbHYx?=
 =?utf-8?B?MkdBRHNpclBNeDN2ZzlKV0N4YVZRWlVsaWI2cmpDVVdhNXdCVXlFYnNMTkJM?=
 =?utf-8?B?a2MzM2M2VTlMaTNwS1R0YXhkSFhjVXBnY0oyVTQ3N1JlUFRWcmxDZDBtbndV?=
 =?utf-8?B?WU0rMUIwWUo5cU5BMUljM2Ewa0xvSitaYWR6WEx5V2ZoYk5mZlR3WWpLMU14?=
 =?utf-8?B?clZXZUtLTUtVQTlkYWltaHZ4QUtoVGFQdzlMU2ZrQmZaNW9yRmVZMWJWUkI5?=
 =?utf-8?B?bUZCN1dRK0ZOVlhpYzRKaGJoMFNOOWp2VTZhMm5yODN2eCtFNnNBOHdMSUxO?=
 =?utf-8?B?QTU5WityV3poZmRhMk9vR2JqUittcGZmZy9RK2YrSDAvdExaN1RLam1JY0o2?=
 =?utf-8?B?TDBlb0E4c2lMZ0xOSU5KR3VxcHRXZVRWb3pTYlpxQVpKWEo2bE5TVUhNaE5T?=
 =?utf-8?B?a3dhOWg3QWRNNUJZdHUzQWd1ZnpSNUQ1WlN1VDlKeUlZVFdVY2hyZkdGY2FX?=
 =?utf-8?B?TmJwOUxTQWcxbWlSSGZoalRtT3YyeWxiOStzNkozMklNU1BwOHpMRm1BelYy?=
 =?utf-8?B?RERNNDV0a1JoaXNwVlQ1cG1CT0tqSXJiSHU3M3dNaHhQZ0pUVkUxZ0tLeTM3?=
 =?utf-8?B?VGJHRmdsRHAySlJpVmZCa21WTW8vMHJUL2hCRVNmYUN4dGF0QWlFWGYrVE1I?=
 =?utf-8?B?bnU2SlJvMEcvdFNxa2UvWlBTbmtRPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a721e842-315b-4b4a-ddd5-08dcf455588e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 17:57:37.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XlGgOMmdVp80s1EXRiK1cXJ5olJxC7MIjwkaxb0jRYvjrX/eyfgZMIbMlOD7HZFYUWnF2OjPa2t2rU+GQoKTwxLDfoEJ2MUXn+nbHo3c75M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1865

SGkgUm9iLCBGYWJpbwoKPj4gTmV3IHdhcm5pbmdzIHJ1bm5pbmcgJ21ha2UgQ0hFQ0tfRFRCUz15
IGZyZWVzY2FsZS9pbXg4bXAtbml0cm9nZW4tc21hcmMtdW5pdmVyc2FsLWJvYXJkLmR0YicgZm9y
IDIwMjQxMDIzMDkxMjMxLjEwMDUwLTEtPmJoYXZpbi5zaGFybWFAc2lsaWNvbnNpZ25hbHMuaW86
Cj4+Cj4+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1uaXRyb2dlbi1zbWFy
Yy11bml2ZXJzYWwtYm9hcmQuZHRiOiAvc29jQDAvYnVzQDMwODAwMDAwL2kyY0AzMGFlMDAwMC9n
cGlvQDIwOiBmYWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoID5jb21wYXRpYmxlOiBbJ21p
Y3JvY2hpcCxtY3AyMzAxOCddCj4KPlBsZWFzZSBjb252ZXJ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9waW5jdHJsL3BpbmN0cmwtbWNwMjNzMDgudHh0Cj50byB5YW1sLgoKVGhl
cmUgaXMgYSBwYXRjaFsxXSBmcm9tIEhpbWFuc2h1IHdoaWNoIHNvbHZlIHRoaXMgd2FybmluZwoK
TGlua1sxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZGV2aWNldHJlZS8yMDI0MTAy
NDEyNDY1NC4yNjc3NS0xLWhpbWFuc2h1LmJoYXZhbmlAc2lsaWNvbnNpZ25hbHMuaW8vCgpSZWdh
cmRzLApUYXJhbmcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpGcm9t
OsKgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPgpTZW50OsKgVGh1cnNkYXksIE9j
dG9iZXIgMjQsIDIwMjQgMTA6NTYgUE0KVG86wqBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBrZXJu
ZWwub3JnPgpDYzrCoEJoYXZpbiBTaGFybWEgPGJoYXZpbi5zaGFybWFAc2lsaWNvbnNpZ25hbHMu
aW8+OyBIaWFnbyBEZSBGcmFuY28gPGhpYWdvLmZyYW5jb0B0b3JhZGV4LmNvbT47IFBlbmd1dHJv
bml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBNaWNoYWVsIFdhbGxlIDxt
d2FsbGVAa2VybmVsLm9yZz47IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT47IFBh
cnRoaWJhbiBOYWxsYXRoYW1iaSA8cGFydGhpYmFuQGxpbnVtaXouY29tPjsgTWF4IE1lcmNoZWwg
PE1heC5NZXJjaGVsQGV3LnRxLWdyb3VwLmNvbT47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2Vy
bmVsLm9yZz47IHNoYXduZ3VvQGtlcm5lbC5vcmcgPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnIDxkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZz47IEh1Z28gVmlsbGVuZXV2ZSA8aHZpbGxlbmV1dmVAZGltb25vZmYuY29t
PjsgSm9hbyBQYXVsbyBHb25jYWx2ZXMgPGpvYW8uZ29uY2FsdmVzQHRvcmFkZXguY29tPjsgU2Fz
Y2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgR3JlZ29yIEhlcmJ1cmdlciA8Z3Jl
Z29yLmhlcmJ1cmdlckBldy50cS1ncm91cC5jb20+OyBpbXhAbGlzdHMubGludXguZGV2IDxpbXhA
bGlzdHMubGludXguZGV2PjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBNYXRoaWV1IE90
aGFjZWhlIDxtLm90aGFjZWhlQGdtYWlsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBBbGV4YW5kZXIgU3RlaW4gPGFsZXhh
bmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0
QGtlcm5lbC5vcmc+ClN1YmplY3Q6wqBSZTogW1BBVENIIHYzIDAvMl0gQWRkIHN1cHBvcnQgQm91
bmRhcnkgRGV2aWNlIE5pdHJvZ2VuOE1QIFVuaXZlcnNhbCBTTUFSQyBDYXJyaWVyIEJvYXJkCsKg
CkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgdGhlIG9yZ2FuaXph
dGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBy
ZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLgoKSGkgQmhh
dmluLAoKT24gVGh1LCBPY3QgMjQsIDIwMjQgYXQgMTozM+KAr1BNIFJvYiBIZXJyaW5nIChBcm0p
IDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOgoKPiBOZXcgd2FybmluZ3MgcnVubmluZyAnbWFrZSBD
SEVDS19EVEJTPXkgZnJlZXNjYWxlL2lteDhtcC1uaXRyb2dlbi1zbWFyYy11bml2ZXJzYWwtYm9h
cmQuZHRiJyBmb3IgMjAyNDEwMjMwOTEyMzEuMTAwNTAtMS1iaGF2aW4uc2hhcm1hQHNpbGljb25z
aWduYWxzLmlvOgo+Cj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLW5pdHJv
Z2VuLXNtYXJjLXVuaXZlcnNhbC1ib2FyZC5kdGI6IC9zb2NAMC9idXNAMzA4MDAwMDAvaTJjQDMw
YWUwMDAwL2dwaW9AMjA6IGZhaWxlZCB0byBtYXRjaCBhbnkgc2NoZW1hIHdpdGggY29tcGF0aWJs
ZTogWydtaWNyb2NoaXAsbWNwMjMwMTgnXQoKUGxlYXNlIGNvbnZlcnQgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvcGluY3RybC1tY3AyM3MwOC50eHQKdG8geWFtbC4K
ClRoYW5rcwo=

