Return-Path: <linux-kernel+bounces-176450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D098C3015
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B332A1F235C2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88932D531;
	Sat, 11 May 2024 07:37:12 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2134.outbound.protection.partner.outlook.cn [139.219.146.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896EC2ED;
	Sat, 11 May 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413032; cv=fail; b=Tirw4RuIGpJyjsfkL3dCf3RTX3jIEkxsiV7SLs4IpCipjRkCumwpL6BzvWJ4JDDvsqZVI9+S/Tu1ZiqCKj2vpclesRu01y2VVCKkI+ij4p9brXquTcnEwAYLJ6JOgzMnTv9B8utwN2SM39eik/SgnDYlFxnAbhL9RSHf7+eoKEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413032; c=relaxed/simple;
	bh=JCFDNBP8NP8wLWIr/ArFvm50MKjshvsYTDVZ86AtkkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RUFevTALU3HxjymxjRrqQnWbRWSxfo8p60+jZn3glNG1JNbZXBL/KbCyMYLjl9eIHkpviPbV48i06kbEDvvmmH7y8oIncsWzgua83VdU/k1YYc6xcBZCVyvDTwPi8BftBlOEXZZhsuO9arhl1c7jranvzykgrvyg69MfsOQbQ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7DSXLCv3HF7EKVZRZFN7Lozk1EKBLXObnejh4s/BpVoCSOfFD8hVb9z0+peN1PRNtqwXujF10xzQYGLrbxEFXdtM9W/y+0bPNsxB8Gtst7QCpmadg7E3/VkFFkiigRiYEBfFDzW0WJ11TArMYJNIkFJVcYOxLEerDXOoYtK7ELOUQchX2UFLScrxcED9D345QkVbVUSDb5ohJ4G3fpYrw3jteo+FahELwfSHqA20vu5T+CEKgppv5G73YnWZ6n4CxHSXyGQhR41EWm6feq+N6lxCHjhplYEvcIiwW2LVkMEgnmEKMO0EsCOgyZGJO8FvpsA6tTf0JHTlVaTkbueKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCFDNBP8NP8wLWIr/ArFvm50MKjshvsYTDVZ86AtkkU=;
 b=PzJi7dipg56/yODSpAQyubSn/og/ZDU8UBiYMt4Wg9AcW9bQ2z0PgUwfEla62x455hKGVwzUFj9KQyU4RG5uQmMImycQeChVajXntxJ+//dtl7FqzayqaECIgSATE7My83eEGorA5zsYeTVjuWms+egFGS2QgtO2InyVNOJTF0CBO1mMJ51jytozpCq2wzIVXEvwCkIWeUIyARtcV9AxJep7gmmNigmgwOUk+F6HcB1u5SRZnn/7Cs2jViHU0ZZOe6E8oq1i+sizlWc6a+mxHsvWqGmveiFAGfm79zHhjXwJiFwzPDgh1kXui7MM1mwALV6kspp7/5nV4NLZ+39i9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1113.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 11 May
 2024 03:02:56 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Sat, 11 May 2024 03:02:56 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Thread-Topic: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Thread-Index: AQHaoEtCPDK2HwhwXUSWjcDZE/pIQ7GQ+umAgABXAkA=
Date: Sat, 11 May 2024 03:02:56 +0000
Message-ID:
 <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud>
In-Reply-To: <20240510-unfounded-syrup-d1263d57d05a@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1113:EE_
x-ms-office365-filtering-correlation-id: 0a7f2ce1-10d1-4a7e-96c6-08dc7166db6a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aMrQmWIhWxwcKlwvwU2xvOhfo1zpwD7V1AM4iGsjxyJI5RyPhyqV4wcSDyWVHc2GrVpR4EryD/iEjC1w4egHHM6uz4T5fWQw+OCCBIqDLNlvZSDyV8Gs/Q9MlvTRV9pGAfNKLvOlKhsLfUbiGUe1x89tstIZXInDfwv4TKeZsOL57jxbOIZDfMw03avb2GvSjgEH9yhJNOHvyhbagvyracj43lusIakElpLQX8b64Ah6zwvwf0HcBVQHSuwwYtPXR8nKQz4sUvoTh9sQ8nMEWVTcv5qgg1oqCbft6bTRgBKacxlUdmuBoLOZ8qcwTYiBqv46YtkXij4nTELAVqeGgOLJAX1g4zp3RHsgm0P4lqNCVhwkvBmC/aPxML14hJKLdSOTI6g7xA3zawE6MC1NF/fFKDFKXB5ZrrWMS0ZzPpw9xVSpbPRFQMYoT6YZFzo3ByR8kUEpaqPr7/ZAGaLAOaQwAkly1zEcHT2y0EDNPRRsq96A/zyUeyZ9DoItBeEJpYGakklU4152Iry6SwadWoOXxOdp7E369JCW2tud6mc8/f9YsigvZBocdWbYHokt8/S0GM+XmKHXw26l/yV9yXRdttQME/93cZnwpCxNUVM2ecy912+9Tu2jVga9CXo9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/DbM0m6tNMF/YY7c84L8dkem20pVWyQmkgHDjys+10odUupbHTBfXXqR082v?=
 =?us-ascii?Q?cybqJu0jdPTDcOV0ZpRkmcwpMJ2Zz0XGpdZOjIdVPzcyFuEnQZ4K9jheUptj?=
 =?us-ascii?Q?zsv6ekgB1OZZO6RtpUAymztgAAFs9CleW38voupMaoMwUHOUgOSQ5MRFHhKK?=
 =?us-ascii?Q?2GJNfFK+kD5Bf2bcBU5kCH0HUr3qDY33FF1Z417iHrAp92OykJGV37quDCcT?=
 =?us-ascii?Q?Tjni+fE+Qk7l0bcNjLm1s50kBjBUwpeR4lgWxWlXDHgt04xc4h0mN++bDRBh?=
 =?us-ascii?Q?mRYVgaA4yYBVqBNWGRI+Ezj4Q/W3q2g20hgdBHcIE2Op0Af6qnyGpYt//1us?=
 =?us-ascii?Q?mCw/JcoGX3ftoPnSgSX0W68pKX/1TUl58NteTSbGZWMBHDMJfDs+2he0TSVd?=
 =?us-ascii?Q?oNSItlBBL7Sphx7kOR28SpKFypwaDk1B0Zlw5fhAHONSr005NZzZVz72E4TX?=
 =?us-ascii?Q?9Krbb0X8oOtWIcATdgcHysKtcJGkhZxs5YgqwVOn3648Kagayj24ANQVQsYr?=
 =?us-ascii?Q?VC3xwsw2wDhLn+MziKgeHfi2ZrD+z/5zDx7Y652hvC1iMNca2fvPoJUF1xZ1?=
 =?us-ascii?Q?cSrbeesocqZFt6xSqtGJBNY3nhbaWJOC75rR4R1+M7YOe4+1Sfrpjcp48fTx?=
 =?us-ascii?Q?lPiCij/40IUW0JyY8h67JsruFJtVeqQ0AcEXKWjyMwvY1PsKu3KxSeF/9clK?=
 =?us-ascii?Q?DRktjUp593SFtdwH6NWU2h4Ae0rzsXMHSotY37Wr7WAkMf5pNpttGUOuWMtU?=
 =?us-ascii?Q?BSJQUx0EKPEH9dcJLIESFchWcJxmk5LsfGhcWTcMJnzTXuYLzv9WjL7VHdE5?=
 =?us-ascii?Q?gHI3NSWWja6229Lu13t4PYIgovgXKpT8P8S9w2rT0joF4NFDQt6GhBX9ZeTf?=
 =?us-ascii?Q?ynLla6I9Q2JkVAGmTbRvCDjjg4AanahDfXxsI8UYEGD0JdTWMDUaEVmoIpj5?=
 =?us-ascii?Q?4x63bQ7gbaTNVZKzYXzPlZa+zXLHcJzhGT/LwrAvEmvNGHEJchiSDD/0tspX?=
 =?us-ascii?Q?PTvkFweEv5Kh77rEMn5Usx6Ixis5fa0xwVeOtz41sz35WCb8Zy2fQg7o9cWY?=
 =?us-ascii?Q?KczvbciXk1YsAO/fy31CBauPchakE8lrNHSUpUY9s5b/vtHHG0c6dgdVx8mf?=
 =?us-ascii?Q?6CTlstM+k2UQWRQutJ+tJimHd3mmc0L4hYUXmeE8eZuQkpQogOBeiyLDJKcX?=
 =?us-ascii?Q?BqgYhl/pqov3rwY945/4jRdZpPqMnEZu+kM8FbmPVfUW2MvNxmFan9txMkYt?=
 =?us-ascii?Q?axxLHoQHl1OYicAARY4RQ2H4VeCp1jQBxpFahr/I+MPzuTcyjkfOOa1NZIDG?=
 =?us-ascii?Q?Y86eH4Xz13HDvFQFXIQHraq0mkG7E1RVXYRW7AaWrG3yZ74Kp0jmfYgEo+nJ?=
 =?us-ascii?Q?kbL9yRY2mQv3pef5uc//bn64g0CSG8BubLzjdXEcI4LtRuDHrOMiAcD3AkgI?=
 =?us-ascii?Q?ATxVLQoz83uYZPVi/VXq0feu4A5p3pafIJLpoY1GPz3td8s6btr1beyBSXfh?=
 =?us-ascii?Q?ZdbXnah9IjsNCJb9tqF87+UE5trg9f/qYWcxE8iZQfAyURDzNUaf6jA3tI5I?=
 =?us-ascii?Q?L6FbVFWM2Gq+TzXlloSabaGP+u5ee/qw/m5W0vl0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7f2ce1-10d1-4a7e-96c6-08dc7166db6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 03:02:56.1492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BX4E6/8rlyJExq4/kQd0xRCVAlcUEBhuB3CvLspPwdrkRZyx0qP87oBHYd57TV379L/JOxbkxz6z3KTfuXkkOuWwXOTUunsQPySbetbLE1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1113

On 11/05/2024 05:05, Conor Dooley wrote:
>=20
> On Tue, May 07, 2024 at 02:53:17PM +0800, Xingyu Wu wrote:
> > This patch is to add the notifier for PLL0 clock and set the PLL0 rate
> > to 1.5GHz to fix the lower rate of CPUfreq on the JH7110 SoC.
> >
> > The first patch is to add the notifier for PLL0 clock. Setting the
> > PLL0 rate need the son clock (cpu_root) to switch its parent clock to
> > OSC clock and switch it back after setting PLL0 rate. It need to use
> > the cpu_root clock from SYSCRG and register the notifier in the SYSCRG
> > driver.
> >
> > The second patch is to set cpu_core rate to 500MHz and PLL0 rate to
> > 1.5GHz to fix the problem about the lower rate of CPUfreq on the
> > visionfive board. The cpu_core clock rate is set to 500MHz first to
> > ensure that the cpu frequency will not suddenly become high and the
> > cpu voltage is not enough to cause a crash when the PLL0 is set to 1.5G=
Hz.
> > The cpu voltage and frequency are then adjusted together by CPUfreq.
>=20
> Hmm, how does sequencing work here? If we split the patches between trees=
 it
> sounds like without the dts patch, the clock tree would (or
> could) crash, or mainline if the clock changes there before the dts ones =
do. Am I
> misunderstanding that?

Oh, I think you misunderstood it. Patch 1 (clock driver patch) does not cau=
se the
clock tree crash without the patch 2 (dts patch), and it just provides the =
correct
flow of how to change the PLL0 rate. The patch 2 is to set the clock rate o=
f
cpu_core and PLL0 rate, which causes the crash without patch 1. Setting cpu=
_core
rate is to avoid crashes by insufficient cpu voltage when setting PLL0 rate=
.

Best regards,
Xingyu Wu

