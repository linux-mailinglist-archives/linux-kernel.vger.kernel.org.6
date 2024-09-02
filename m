Return-Path: <linux-kernel+bounces-310675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABAA967FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E275E1F226EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C8155A2F;
	Mon,  2 Sep 2024 07:07:10 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2092.outbound.protection.outlook.com [40.107.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C115381A;
	Mon,  2 Sep 2024 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260829; cv=fail; b=UevtwazY8HmJHmFSk/ZxDr+UDhNQ9TfHwNzeDP5yvPx879hzF5MARsyEXd4Da76GFoobce/72En1uQz7UAfpfZUiVseZl+eOzf0UsjRqF6dbOIOIp5phziB6x+9CMF9RlJzvLzzsqu+Q55/KU16Q0ie06McBlF90EwbxcY1XoMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260829; c=relaxed/simple;
	bh=BOovaC2vwExudgOYV6qQ4ZcwvdNg6gjjIn087NMiDz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/0Xrh1hr0UmXhPpdiF5Y/NVKpMu43f/QLbTvJNlHex+g0O1c3wosej3QZfGaDE98lfIXaVth2sNpjEViPqG8xwKwlmmB0AaBah3aUaLH0njOUs+kd7mV5USNwu8vf5DbrosJY5CjJA5SOgqJF2D2MoT/nQ+pRIsltBnxoUscts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1h/JwbCYosKdW64gVg8CrbKCx4swr+mHBd2igo/DzoweSbjqkK/7D3UsD0ZGB7+EjjCGq3eXB+OZimApphorf8emV7PZKW40L09x6B02/HRe51vau+GazONXr9aDLcfROdMAlDln8fVrzs/n4pw6fiSVJBr7JHdMlgsSD+7Zfik9S1sBGyPrupatj/Ea5bCnFBI2sq3kXm9N6krbg/RzxeHe71fl7huuYDxmhPWAD5SSpFC1yMvR4bz7ptFASAOhw6YVK+KpRTnuO6r3YEdX5U7BPwNOw7DvSwJCfRYYmTPSyDwSVNGQNoXR54derv89NFK6ALkiYws+8ZePxtFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOovaC2vwExudgOYV6qQ4ZcwvdNg6gjjIn087NMiDz8=;
 b=motuumzUcZ7YccoRqz6/CN+l4dMdlG9cut+jiIpUngtWj5Keh/uqXrwaG2zu+IG1g48yILWIqNhRTCpRqDOggSZxPatNdLgc/zuoKNIgr+FZ+Zhb4VN34wxzzLZN4LRyF7KPdZ2iaHfRJd9nNSyb43KE0bUq0N98NK700YqXt8LXS7qiykDiIMtNot7wJfkrzmCnABjOCQjVvdWqGbnLxbEj0GI70Tz1hrTlDVv5O2O2JkxOIabRE41snmBtJ86Me7gcSExtTtqOLGgzaS3Z5k/wyCsFBGtv5xU+AlSXbLKGzQXwKv8Tz9qd78hDpf65FwXl/L4pAQfG9HYYal0O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN0P287MB0374.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:07:02 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 07:07:02 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, Gregor Herburger
	<gregor.herburger@ew.tq-group.com>, Joao Paulo Goncalves
	<joao.goncalves@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Josua Mayer <josua@solid-run.com>, Yannic
 Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: fsl: Add Variscite Symphony
 board and VAR-SOM-MX8MP SoM
Thread-Topic: [PATCH v2 2/2] dt-bindings: arm: fsl: Add Variscite Symphony
 board and VAR-SOM-MX8MP SoM
Thread-Index: AQHa/QVZO9DjaeeHeEm3sOrdEo17YLJEESYAgAAAm4c=
Date: Mon, 2 Sep 2024 07:07:02 +0000
Message-ID:
 <PN3P287MB18293C640A4A027E6292758C8B922@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
 <20240902065606.8072-3-tarang.raval@siliconsignals.io>
 <f3f65c33-335f-4769-958c-9b75fa7083dd@kernel.org>
In-Reply-To: <f3f65c33-335f-4769-958c-9b75fa7083dd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PN0P287MB0374:EE_
x-ms-office365-filtering-correlation-id: 0caccb16-c0d7-4eb6-281c-08dccb1dd878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Uwjml3GrefXNB64vgzfha/nAWsXMkUW3ewUE+GPEROharB/59rxKCar1Gz?=
 =?iso-8859-1?Q?cdy4Gz5wI4iyLlKrG51PcoABcECCnKtLOeXWelXEwD5wfu1zg9iXwnNKbD?=
 =?iso-8859-1?Q?j5E0vTIinQc1XLkaAGxl7dbfIXROAvS8ZTHMw3h6TABxsubM9UTiF/V96U?=
 =?iso-8859-1?Q?mLn5dpRadkR2vGU3QT+7CMmPTeQeRhU1LkbJUBvItfsDtq84AhrL0Y/P1v?=
 =?iso-8859-1?Q?2nkpg9wGFIEehxXPefHBlQKumQKYMJ42txDrJp2n61wf7fHTfT6RQ54dh/?=
 =?iso-8859-1?Q?csKJuAY+ZeuJxz8jutKRsZwioo93ObzAF/uQ7rkOpqSZiyJSCTYEjrko1k?=
 =?iso-8859-1?Q?vsMaXYOZPXS1025zk/qa02t9bbYr364U9hDIFK9LwYWORk06S8bOuMQeZ0?=
 =?iso-8859-1?Q?uzl1zsy7pVZXGqrWzeMNh7rVzJTKxZCwQDEG9XcwBxiDDk39TeVldDRpfG?=
 =?iso-8859-1?Q?mxY3vs90CERyNPKVTpiSctZMSXuEkdFoSK3SCtRUhiIQk04GRWpKVQjIiS?=
 =?iso-8859-1?Q?ZD5D8FWMmmFCLavLrNWmmxMEgCw92QoziAm4abX97S8A/qM0usXcVkwVi8?=
 =?iso-8859-1?Q?fB1kjK14QJ68Hr0dfYKzbTSJF8l3oIgtaF0UFQz2szwcA0rIEWI+4f9ohB?=
 =?iso-8859-1?Q?aSmkFwE1c1OVgg2F4sgykWbBJILqGhOhs2tldJmBifbXEzI4UvO0ccJsOg?=
 =?iso-8859-1?Q?6UOPdFwRrLGNQX6k9yRaRwHoLYf2qDLWfb55VBuc37GnWEPefIbUDuMftR?=
 =?iso-8859-1?Q?bMM+0t4EQX6+9maVufMgCVgmQFf1aYgzx/+Mr2/JCZ2wQxOpt2M8lmrHh+?=
 =?iso-8859-1?Q?Tz4/VubhDEZGNa2yR4DHAGfHqA4HyTMH5OaA8ZYikDsCozaCAmWXU4ehkA?=
 =?iso-8859-1?Q?KcAHATU2pv9mIyY3syIcqCk9KGTplDkpbwxbMLhP+5LsVwjbHM+Jgx57Bw?=
 =?iso-8859-1?Q?19vEbh36+rYJvqFV97dozRP65Oi9VrfJnO8X0dDk6TWZmFu93nN6F84q4g?=
 =?iso-8859-1?Q?gfmOuRAPmz/+B7c3p15zxntDhQAJ8YwhuseUNJoDOY1lIuVGR5ba1fuPa9?=
 =?iso-8859-1?Q?wRyUl5l8INPZLNsLzL3MbWUXKJJrdJPs7wmgbRoeYanh0T6lzazPHzeOny?=
 =?iso-8859-1?Q?x0IBoyHo44/TREPXS3+ApQqY5Qbmobv5L6U7CuSVPrZtI1hYsWFwsnoTY2?=
 =?iso-8859-1?Q?PAGRg5PNJWisuhLeEfJtLTcQtE2NbF5yJUWtN8RHPWQuUCvirFnmISvVZV?=
 =?iso-8859-1?Q?lbeMBtSIwxODt1xT5GrfojwqQoEfG+Cocc/vrHBvsS/om0vzU/6gMYRq6n?=
 =?iso-8859-1?Q?0EDv7kbpO45dGfPQdsr47a0A3IR8iNxVc8YFSCZUzMRcZ6bTn+nAVNKBo5?=
 =?iso-8859-1?Q?Mt4HSl8uAMHH2oYC+nCEh7GzrR3+e7sCYAP8YrR2YuaUyuRLuJAJM7HFSQ?=
 =?iso-8859-1?Q?O8x4JUhN184oVUwjK3T9a74pb6Gbgmg1EDRDtg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WzEMyGfMPHV0+ocEZQugKB56ldYjkXG3fC1SqMnbqFn/xii5mvvFjmJD+a?=
 =?iso-8859-1?Q?rghjulPHu7hKSubAfBt85pvYrySgsNP0q8d5zTMQKTRohZJnVSTor96W3c?=
 =?iso-8859-1?Q?IRtaUUYRmOY4Wi403enG1LjPeThBKG6okZAfikhfBhBquQpnj5E1mcZT/i?=
 =?iso-8859-1?Q?MHoLNJzst0e28d1QwxS5vQh8Qtn5caROuw4vTG7W8Cdqocyug3A6jAtvfD?=
 =?iso-8859-1?Q?/CtWKxNHd0wCnbhiYnKpJXzCd5R4/dR4ngIMonP8Ymi9rssLSpRQj53iB1?=
 =?iso-8859-1?Q?5en4uV502hqAfPfAKSRdVRVei3FAS0iGvPZMwQNYdZoOmWzTejSLTP2YgQ?=
 =?iso-8859-1?Q?597Fhm8pqaRqM1oxyHeEBXp50djN9c0ecxnr/IYS7ssyJURbLFhTm5yeSx?=
 =?iso-8859-1?Q?TbJ4NDgmTQQvvGvk7jFR9QmUwtZywvmnpVmxIDj/oBlEcBcM0l4Za+ndl3?=
 =?iso-8859-1?Q?4HGtDR2FXfcn9Dftc/zOLdR7Qo6WBnF6U1oXyVV3ME2rzJN3m7vEUXrBcX?=
 =?iso-8859-1?Q?0+1CMNaYX6TWo9571djt86uZCcvuVuVAWspMUKX+aZK3RuUKv+3zeSIqO5?=
 =?iso-8859-1?Q?gzQrEj1Vf44ejIyU2lxbSYYSlYk+DeLc0yNkv8HuaqJIIwwZiuwMqeHF4d?=
 =?iso-8859-1?Q?EqmFiZwqMDy52MKpi9SFMPAgitIzSun83+ONjYgruLa2hBlxW7sKiLSije?=
 =?iso-8859-1?Q?vqJMkzljH90S4CeQhh4OaGh5wRvqgZmruVjOk1wkcHWa0udB5NYAY3T6Ox?=
 =?iso-8859-1?Q?BCNYuXJBqT2cdtcC1U0aodawfJTzcmRVblDm0J1goEeYc4IefOdHX/DIhW?=
 =?iso-8859-1?Q?2xJh6CrYwNGLPCTG37dGptTMvBweKRTeNXAsTWZdyjptxNrEGB76xM/3FV?=
 =?iso-8859-1?Q?b4jkEmQNLfTTJaBOxKKMNzCC43UHEuDYOC6XYfNKCIoEvK8ha7iOMFXlSE?=
 =?iso-8859-1?Q?uuaHAAt+bDr00h6IQtXLTfo2cPj3vXf+7wrbYINQGqyrxt3/7JZqSnMEXm?=
 =?iso-8859-1?Q?eXhk9XCyTITwxyV4Ez7Zlgdf5cpLf8/Fw+UCCpxhhUbZamIDiurZPZt5L5?=
 =?iso-8859-1?Q?nFxkWxAO6YiYA5GNKNvjXqt4C5MN3l+ecX5lPgQtJ/Z92AsPyI1f5uxcl/?=
 =?iso-8859-1?Q?jFx5pDhX02nn6NLncpadpsrfVFGoALUmYdbxZjvXCf5G8ick5HnHmQukY0?=
 =?iso-8859-1?Q?ZpKRrWSqlPWHXEh+if/kwGSR5l4dmthh6y+IvI2OUTcqrAeER9JxMP4sSb?=
 =?iso-8859-1?Q?tg3O+dra+BEz5iZs/rZhV/TPgkeZKiU6PZ9lppzzASXfdpC8dgqyH8+tZ1?=
 =?iso-8859-1?Q?qJy0vusm5W35nJhZ5g/tZq07Wh9PMH9txfBpvQXpZagC9JH3DUPAGe5Zfs?=
 =?iso-8859-1?Q?g4+/SQj7g1g/9H6MWVzqYR+WWay+1r/FjrUsztiu9DgvcfZbwf36bZivPq?=
 =?iso-8859-1?Q?LMCZ2H6RuzRFy4ZIgGJI1dZijejF4UBdF7Qvo641pPy2dvI9q4nsLeTHpy?=
 =?iso-8859-1?Q?4F3ARrK58ljBDTwMEuOytPYRCpPhCehbiiXz5TYt+xrtI9VMdvICGcWQYe?=
 =?iso-8859-1?Q?MXmZ4x1R3AwYAcxKGv4ce96cTs11Q6Mck/0kVstqgaCOJ/blY5fJMv1eY1?=
 =?iso-8859-1?Q?86xqcT9Fxp9pWIdNpM5by1/lhkjjsiLFvqPF/nzl2d8LfzhiXEkcDn5A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caccb16-c0d7-4eb6-281c-08dccb1dd878
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 07:07:02.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QUxC6+zpchN/X4SqWYmk2AXGB+HhJ65YG7YAn4BnzfGYrNBuX5HJ/NDkpstRjDLrFVk6r7EGf3J8bEUX8Pyn4Uy/UuX2SRuODcbV+ES3ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0374

Hi,=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - toradex,verdin-imx8mp-wif=
i=A0 # Verdin iMX8M Plus Wi-Fi / BT Modules=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - variscite,var-som-mx8mp-symph=
ony # i.MX8MP=A0Variscite VAR-SOM-MX8M-PLUS Symphony evaluation board=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: fsl,imx8mp=0A=
>=0A=
><form letter>=0A=
>This is a friendly reminder during the review process.=0A=
>=0A=
> It seems my or other reviewer's previous comments were not fully=0A=
addressed. Maybe the feedback got lost between the quotes, maybe you=0A=
just forgot to apply it. Please go back to the previous discussion and=0A=
either implement all requested changes or keep discussing them.=0A=
=0A=
as per your comment, I did update the board name to "variscite,var-som-mx8m=
p-symphony" instead of "variscite,var-som-mx8mp."=0A=
=0A=
Best Regards,=0A=
Tarang=0A=
=0A=
=0A=
=0A=
=0A=

