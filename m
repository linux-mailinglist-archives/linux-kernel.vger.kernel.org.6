Return-Path: <linux-kernel+bounces-312401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AC969614
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C2283157
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11CF1865F0;
	Tue,  3 Sep 2024 07:51:20 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2118.outbound.protection.outlook.com [40.107.239.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F61CE6E6;
	Tue,  3 Sep 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349880; cv=fail; b=cgLQMnUpHsgOSMhnTBQoBdnPAMprZyJlodBGvnGm/0JAXUTMsDZ9PufDCfTQSVoCx8MLYTFPgiuFwWOqsvFkkjSkGInTHRiP1vHiKSwWJt2i8oeaCHQuk7si8rcYZe3vVK2fi3zWU24t2JeWCylPWZdD08j+zFXodZPc8h0e+Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349880; c=relaxed/simple;
	bh=bvVVebyZWup4JjmxguendLVetsLGIk9kJXuLvN6vvGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RwMwC856QFJDww04PPKX8BQ1DF1jdiY7xp0d70gcXLh9lQ+qSUPtlu+jVhFaUu0XptXrfui4k3lhvWshWX7NSaP8EhtCHos9twsuINcVAy0gSwDykX9ngF0yNFmBx7dKpoO4iGi6kSmvOOnzErhroJenDOPvpq8paMSTasm+JQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDTR049O8XPfQODa5ncdr1wYIbtGBYBJzzm0Ptk7K68St4yMGku6A7zxx0eZOr6veqepLNCQ4f3JlqChn4EvJ9Te5p0Z9RG0OX1viXQW0SVhCvuKcwR9tbEg27nEp/J9PIinRqGAgoNI3U2cdmI/qLkzIvLyfzvLblmcPdcrwKgG7pVdvbcsFX+E7vH6v1zFNz1lP+94GIP3gwm9usBAM/+KCnH64VxuIpYUFXNia2Q1nxj85SethUN/g1+tyxePOwr9aPGJgujOxo0Zkvzcm/WGl8zd+YVSQLieEYzGKI+Rxlb4xsD/88dsCSiE1K11TFdfMgqmUzSVfVk1JswMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvVVebyZWup4JjmxguendLVetsLGIk9kJXuLvN6vvGg=;
 b=tu9fiFhu36mlHT/d1/TAEN3nJg3SfqcJXJoeelmXmdtGfgPsNXV0csD0liqBAg4QEydVgutaw54kqadXbde4H4aCim5SObac072nmHsvKQQNvBpUuZvwxe3v3uDBlEqARqnAsaQpF8NTx8ClbNF9Yz6KpRe2rUGMnxvr+l5cm6JVkZdHfbDceWISVdSgq5uEpq8ATCRibxbJR3+wGGDDNrLkaR5MkRijf/lJy4HKiyq/Kw1pcNjANM6NTnrPjH6OI1FOQPe8qePOiB1QgVjp2FaCKPBYskMaUsoQorAzspaU4NWT5SiloWwSPcN89KUEzXjivAn/+H0JSPXqC2aKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MA0P287MB1132.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:51:11 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:51:11 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Topic: [PATCH v4] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Index: AQHa/PtSp0Sac9bRAUGGdqu/C6ktFrJFoCqAgAAQWxw=
Date: Tue, 3 Sep 2024 07:51:11 +0000
Message-ID:
 <PN3P287MB1829DED3CA0A4B30D3C5B5478B932@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240902054456.5828-1-tarang.raval@siliconsignals.io>
 <Ztaw3xDa6yY1tWu1@dragon>
In-Reply-To: <Ztaw3xDa6yY1tWu1@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|MA0P287MB1132:EE_
x-ms-office365-filtering-correlation-id: ac0fa82b-5c9a-42da-3162-08dccbed2de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?MddQpjQolHMdmi+o4uTzP6Oy0w5dyb+HT3bAF436ppRmQs9/9b6vSNyL?=
 =?Windows-1252?Q?X98U7qsUHSPG77MosdjvSBXSEO+a5NxdRq2aJkwUPi5UV57aurQkrmIC?=
 =?Windows-1252?Q?0mvhwXR7evkdoN5Lganxi9CxJ1IK43hoi1ZS8hLVJcRgaYdU1f6pVU+9?=
 =?Windows-1252?Q?CmoYQ9WGThMEXpJdX8pjbuBg9K3QwtGARWhQ7cku/uLvUDcAGQxO2mhg?=
 =?Windows-1252?Q?EztxjYnSdCdC3HQiExahWzMklZfNeAErswmHj8TdDbSII3bIM2Ogb4zN?=
 =?Windows-1252?Q?NU8SdVJ5nMyDCCYQivbUQNE2m9V6yhSLvCPVb10HysHdXzb2RXJasMtB?=
 =?Windows-1252?Q?XbE0v37Q/Ntfr43tMjyGXoQFeKpBmXBjAnoaGGInbeFYi7JfQdaivyr9?=
 =?Windows-1252?Q?Pppymr6B8FhmnGEQVQRXpU1GvrVHNeevr4YjhHXTgJLgi24P47Kginpq?=
 =?Windows-1252?Q?IHAFZFYCY47RrLmGv1Tey03ieIMI2KqMx11+lNvvS6IEe5a+zTj3huxA?=
 =?Windows-1252?Q?y2jCFOJiWKQfmy51r3MdGJ6SLbKfQB/MzZiUKLMsdSDpFhxdmWAEljia?=
 =?Windows-1252?Q?EzGNr5jr8TQiWJtvf5ZfXVQlSRxtsJsR3DZuUITYQwljj85/JGT13L9i?=
 =?Windows-1252?Q?kxoc4QWit9ldkvF92vItN1YOx+3JE7O3Pt4KKBHliIvEijbTkxw5JYOf?=
 =?Windows-1252?Q?PHdtIMISwJqza5afIh6N3ANBoxJDEl2s1UZL22A83/OEFIBxZM4R8BgP?=
 =?Windows-1252?Q?Kg3+Fp1lmnp0OBXaqiIBLtwvCs/NVmzfwrPHPgthzz6LOLKQ9HmxD1iy?=
 =?Windows-1252?Q?2bUh5Pn4skrXdqlhTBms774NOOA+yHzLr5IntFU06KSM5J9IFnLAQGBf?=
 =?Windows-1252?Q?hwjKgHrhp+0obU0NIpQiEqTZsPZ/m/N/I/374ONVMwP59MurLetVvy3V?=
 =?Windows-1252?Q?pnowQ6CUwaYy2qE7vD9GfOA1WXPn+j2x7Vpl6RPgH19nQdczz4aw93BZ?=
 =?Windows-1252?Q?yV5h7cDk/plKZ0HZO4WgjtxkMp/s7/V1fnH3hLEVKaYJqOz2SHtj7idn?=
 =?Windows-1252?Q?hRAWNihJh+7eM2zFEPy0jITttgrIqEha120nwuUJSjZNp3qmZiYFdmzC?=
 =?Windows-1252?Q?aj+J0vz9XFhzOY/mtPiJU3oaT6/NtIYQ/Vj/f5+RAxo5iMHtGqm8jssr?=
 =?Windows-1252?Q?4/PLkHxtLFJBwwrAvGqU7cT4OHIsLv1hRw6h5+Ej45YponRh3e5xAf5k?=
 =?Windows-1252?Q?xa4CeOD7JJhsKlzgZJ7RhhmoCwtAmeSJnSuJ/o5TZeJHXb1cQmYVmPSx?=
 =?Windows-1252?Q?/xsFn6BPt0lb9bEcQTByOiG7huqiYfYfV9kS3T/riC41tb9LY1DTrXEq?=
 =?Windows-1252?Q?sNtAQyLip0X/APnHAhSrQQiKa4AY3dDPJc/uVdDysKkMWeQ5AHRGQVHM?=
 =?Windows-1252?Q?buoJ4RUo8J1TIHLX0dzSpWfO9v+hgI6ZhbdeJasntqISG4mGG0i6IYQG?=
 =?Windows-1252?Q?x0gEtOI2FDf0wzJ5BU5F+FcBseyXNQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?UNmXfFoGTnpWEKZNxyq4JEkKjFh+wFIQCGSgBrvRDxEXF7Tk55/5CVlo?=
 =?Windows-1252?Q?fugrlhV+x1+klIOf6T8hARFjWrILTR1QFWotCa910uuFNZVHcaxjpKCQ?=
 =?Windows-1252?Q?5+XJ8/HXd9IJkGIOc07q+384ocX0cXTxUCRrN96X24qA+4AROpq+E+lC?=
 =?Windows-1252?Q?jmCh0hc3QNjLTRCFJrPiotGxG+vhe3c0GH5SZwicw3e2ThxmjXBPGIV2?=
 =?Windows-1252?Q?QESkongxoOLHjuP7YmQ8Hd7xbqLFq3Hd/XHokd7YC+2Mm/0pWDCij93w?=
 =?Windows-1252?Q?BN88R7fNpd+Hmgp++REwfK6vql819FyidRZ39boo6sv2lhz0UgTYHOp1?=
 =?Windows-1252?Q?1NS6KGeM6kUoPkuJUYBjm/MLQCXdDoHvAjzig0sHiCk0lfMMZ4AJisDv?=
 =?Windows-1252?Q?wlCHeCFH/QoHjrbkHjjO4e+U6WuKQtp6qoLmzttluUqf0PAbVMZRJ4tt?=
 =?Windows-1252?Q?iY97rrTat53Im/HZOyXkbbZ/QKqXWtZ186hIYaTvMrvcCoflgAu35ujG?=
 =?Windows-1252?Q?DK70fSv5PLbEFz9QM9x4q9/2y/+aprrZyOKGgId+3Is7CC7EwcIvie5W?=
 =?Windows-1252?Q?+FDSZomUE0LXdQXRVaUwowrJflrhuDmNwcRywtHbFEbBlfRWznt2MUJr?=
 =?Windows-1252?Q?MaILI0cgknbD9gJPbvhQ1J0jn8XHw72iDgn8PRoCe/PymGT5lYAhxZXm?=
 =?Windows-1252?Q?lpogzhTAa9NocnuHJyadqpNA5gVHlXF1GYOpXgbe/nnRSTrf/Pm7AnGQ?=
 =?Windows-1252?Q?QcXdlBJBtzoTWutJP9lIdxt1Q3klyUwkHklHtCB7vcN2sPHAh7QcoAew?=
 =?Windows-1252?Q?ZRs4L0Ib+1b/cGhgaJ1J+TfEOs1/GrmRA8DOdtNa7y/Tdno74tc4Iqda?=
 =?Windows-1252?Q?rzY8SWlJ/MqvLC8DiEfam/MwUHWGByxn/4IczO1IJeBLfFME92sqMOEf?=
 =?Windows-1252?Q?l0gzWdPPv6rOIGmVfu0dmoW51+hBBtnaqmTPJEqkCC0c2XUnCemNZXEW?=
 =?Windows-1252?Q?BlvM4/RY8VCOJ/HeH86xbsZB5MMicCagP0sILBIfHYyPms5idh7SChJk?=
 =?Windows-1252?Q?xEsKamZYQCX2dwaiDxpbt7U12ZI8dJ79OuEUz/ODiArsKyUilO0FVsga?=
 =?Windows-1252?Q?USMgZBceYsidRlj+QFpGJ3MDE9F235eGwRSlE7bjVXAzFfRI8SjzRkMR?=
 =?Windows-1252?Q?WrxcyO90/dovgxKE7r5WCCSMaH1iRDenIUT6BS5LNrLY5rbUecnb0dN+?=
 =?Windows-1252?Q?5/VBzuiENc3uyJPekgwdVmj0s1hHjZYzrMY8RVy6xbMEbRb58aPWt7PO?=
 =?Windows-1252?Q?9C0zUEYyzAjEzG7knGxgJeLCGn6SpyoX0jDMKqgrORFSeCiCH60ShtZA?=
 =?Windows-1252?Q?j68agN8kpdMxn/hUgNKuriZ7VzqkVuqRTVqCxnPAqK6uO708hc10JnJ9?=
 =?Windows-1252?Q?R297lukfBc3CwcOcbiR5P2J9uBw701Z42UyJWELs3hYh9INtHoJTiogE?=
 =?Windows-1252?Q?NqaoLuRYBPxB4TEemkcnDwtZhiuiiVX44iSthvh5RYtL9Aa/2CeMPdcS?=
 =?Windows-1252?Q?ek54Syn+j/Ntdbd7KEwvQU4+y9hAbSpEbu47K2Asi0WfGNXi4qzIkryP?=
 =?Windows-1252?Q?pxOrIPJoqja+qywghzjkgkZ0stMpDTrUmFWHYMksNRVNDxAU+A09lRyQ?=
 =?Windows-1252?Q?STBX/pkt4OafMz2eKYEpDB7S+83VGnXiEe2+lYMfAk9UwWE41C1ghQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0fa82b-5c9a-42da-3162-08dccbed2de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:51:11.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWAan8YhIG53AabaxLqAP7RAfAPdN7FIVY1kVd5oF6jfEQkg0Dx9cEpPX2Y6r+6try6cKzt1ZNaQPGRYFp4Hp1osCwpTTK54NDFNg/hPfj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1132

Hi ,=0A=
=0A=
>I'm getting this:=0A=
>=0A=
=A0> arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts:111.20-120.11=
: ERROR (phandle_references): /soc@0/bus@30800000/spba->bus@30800000/spi@30=
830000/can@0: Reference to non-existent node or label "pinctrl_canbus"=0A=
=0A=
I=92m really sorry for making such a dumb mistake. I'll double-check everyt=
hing, run tests, and send a corrected patch.=0A=
=0A=
Thank you for your understanding.=0A=
=0A=
Best regards,=0A=
Tarang=0A=
________________________________________=0A=
From:=A0Shawn Guo <shawnguo2@yeah.net>=0A=
Sent:=A0Tuesday, September 3, 2024 12:16 PM=0A=
To:=A0Tarang Raval <tarang.raval@siliconsignals.io>=0A=
Cc:=A0shawnguo@kernel.org <shawnguo@kernel.org>; krzk+dt@kernel.org <krzk+d=
t@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley <conor+dt@kernel=
.org>; Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team <kern=
el@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; devicetree@vger.ker=
nel.org <devicetree@vger.kernel.org>; imx@lists.linux.dev <imx@lists.linux.=
dev>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradea=
d.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH v4] arm64: dts: imx8mm-emtop-baseboard: Add Periphera=
ls Support=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=0A=
=0A=
On Mon, Sep 02, 2024 at 11:14:55AM +0530, Tarang Raval wrote:=0A=
> Add following peripherals support for the Emtop i.MX8M Mini Baseboard=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * Wi-Fi=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * Audio=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * SD card=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * RTC=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * CAN bus=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 * USB OTG=0A=
>=0A=
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>=0A=
=0A=
I'm getting this:=0A=
=0A=
=A0 arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts:111.20-120.11:=
 ERROR (phandle_references): /soc@0/bus@30800000/spba-bus@30800000/spi@3083=
0000/can@0: Reference to non-existent node or label "pinctrl_canbus"=0A=
=0A=
Shawn=0A=

