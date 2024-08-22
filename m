Return-Path: <linux-kernel+bounces-297170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965795B413
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209B7283177
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0591C9436;
	Thu, 22 Aug 2024 11:42:14 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2098.outbound.protection.outlook.com [40.107.239.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555971C9420;
	Thu, 22 Aug 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326933; cv=fail; b=kHlzszWEOb1VLyqnHnUNqw6mY9rGNLO35fqdwAgBbeXz4xOddtg0nQ/rTuOs7RRTdxvzDDYh0SfdiqdYwcs1T4iVU8ysh7NlnCLv7M+Det8wvdAjaGOTIxbTA7ZboRnw+zjysPZY1+X3vV9iz42T7SCuCmpFHHmoGHL/Wz/cDPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326933; c=relaxed/simple;
	bh=78lKmM/jVvyIKd90tAtXb6aQJRJapQOlxd6Ie7nMgdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dhbgg8Bzu7Rlq1vjhbvdYJbYDfv7BRd7LRT2/uZ4We0pTSbs2z9GOmh/VQV6WBYQrgv1M+kC9aoNGmx+CEHr4TF44BSXByqcKrgOVkF9kazZUzgq94eyw+ZoBy9ugf2iVisC6bs9tEhNzt/UnNobrLzDeqHStMr7KOZUKT6wlZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSzoldtzgdRj9GghYHhlePesdxwFRAXIrHpNR5QesI4H4VRnljaE5Vq/TXJHSscBvGsEdPqpaeE9S69BKjqzQKxM9O65nbJjfvHv7R5Cshme19dl+DAGze7CTfX1YEWPxgtDraR3G1XZgR+M1rTj+WkDxws0XuFzvlWbnZ2RazQZgwVfe6bH3UcKJKkmtVw1NMAQ4xPg+iFy1ZQREAxFyEN/HLh76YNffW279A4bJEQG/4FolXve9HjdJ5FH4uvvpPPj3d/6lv92hP49NOMXERlLr+v8d0ZC2rq8pXq86sz6FUTOXhynf2tdk+qvNjHh3WT4FpvnCHNHtFcetFYztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78lKmM/jVvyIKd90tAtXb6aQJRJapQOlxd6Ie7nMgdQ=;
 b=RGvPs/eVwnA64YqG5W7420jUdCtqlI+JoS9ReDBlFiupvjsNgE/7N1FOyxJ1MZfKjsGzoZEv7FrbuV2bNL8CCGgyGJrJvFDD5QN1n3/+IbisRtvl9kxOFidoYDZnzaEMe1mjmq4rLWZhrPyqUCHn4h2xE+c6irS/2xQzX/aA2Cw59X9yJrYV+zea87eeUriKwFW7Hrg9objq3WzWsjmwiqx/b/So/jYkx07BSOLuIZEdzKXDPxUjZm7T/F3O53HsnBaTc1PSbhfFo+hWMEJHD/jSFoiqI9B0R6OJaOlOWSYS35LnZ1wo/4/y+B3sckbnvw+z23UeyXB3nSnpx4mJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN3P287MB0918.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 11:42:08 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 11:42:07 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "festevam@gmail.com"
	<festevam@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Topic: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Thread-Index: AQHa89I5BbwXUGmzXESMOglvow2nPLIxxPAAgAEJg7CAAAsPgIAATOYk
Date: Thu, 22 Aug 2024 11:42:07 +0000
Message-ID:
 <PN3P287MB1829953DB0BBC5423672FF728B8F2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
 <20240821-cute-cougar-of-atheism-3a9121-mkl@pengutronix.de>
 <PN3P287MB18298292CD27FD9D8365C9178B8F2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
 <20240822-holistic-fearless-bloodhound-e9095e-mkl@pengutronix.de>
In-Reply-To: <20240822-holistic-fearless-bloodhound-e9095e-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|PN3P287MB0918:EE_
x-ms-office365-filtering-correlation-id: 74e87f9c-23c1-4937-f42c-08dcc29f73c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RibXA5HmBw1B14GeWfaR41qVYDyfpCoDdnRnOyIJE+n7CKNnQNodV6h+0s?=
 =?iso-8859-1?Q?+IgZbHJQqUqoiHDvt+8+u5sKkLMIOcPvL0IGdCNWiua10um7nftWwtV97C?=
 =?iso-8859-1?Q?t/9EnhyZOiPf5KYM7cGQ32f4N7ABPbUXqgmE0M08rnuf2oSepC9e+dr1Lp?=
 =?iso-8859-1?Q?Dz2o82MacBIwuSj5/OAu7QgbfXRvcQ/CYHEfAzQlGRxEftMonhd3yYkqSp?=
 =?iso-8859-1?Q?WJ8cbagNoLyyzZsgeilTmVglGQhoW8+UgtHVrcs2dMrupf/CqYOxK2UFjU?=
 =?iso-8859-1?Q?6fZottIrtt6fSKp1CXx6bB88Pqyp7Lh+3TdbUpn6R7j4AQlOsCGm7zPPO5?=
 =?iso-8859-1?Q?oH8mYXQiDcc6S+gVwYoRYJY9MJQFjs6an5I0HcQ6yVEDyc2r6edGh5gHji?=
 =?iso-8859-1?Q?42vfXkM3WsymLWUxAt9IaO4n910ykxILrrSkC1R3Kv8XjbsnlHQKBB55BN?=
 =?iso-8859-1?Q?WP/jf4XA/uP/vOFcloPuI3QGjcflFM1OT6gxHkxZFBytMMFPMW2o4g/3nW?=
 =?iso-8859-1?Q?aZ78eFAqiOCCIUstQvyoGa4MhYc6qU98OKV21ddY0VWqhuL7/wHiMqAMMd?=
 =?iso-8859-1?Q?1C8NXEHxRR8rXpejD6+q/+IugucVOm//gC1GWQRU4l+TaVDEZ1MYAH7Bt3?=
 =?iso-8859-1?Q?gK5Txjjuj6dJRbPqLU3VZ67igot/ka0350LlghOP1fjttl3lD3NSD4Eu3Q?=
 =?iso-8859-1?Q?t4LnW2Fuwj/zHLEY37WKvalsTTVkbJM4fHF8BPH1i9qJy/JedmvF5uW3Us?=
 =?iso-8859-1?Q?i14xmZQxmxGgSXENN7sFlZF0e42xkbRFTrKXz7qRDOXjyCG4tQgIw59yY5?=
 =?iso-8859-1?Q?ZaxMjqGJ2qtIjTQZ2edmKCEx9nQMzb0TOu2dCHcE5WPyfwv7L/wWsxb54N?=
 =?iso-8859-1?Q?Dqr0jiYziXMyTF32WQKBR4ujSqZgZRe8Rd2UsGkciVVZK7v5KEX2tz51jc?=
 =?iso-8859-1?Q?GPnqW+Id97zPPCx5eT+s2RzAl7KBeNSeGd1sLmn1Th9ghfHDqRdcSRVQfg?=
 =?iso-8859-1?Q?p8rEPIlSjLB6Y34gk43NNflhp8sve4azZb2HQXRYbroR6NCwU7qNs7Aeqr?=
 =?iso-8859-1?Q?PmHyOoPuYeIvcqDOSy5WmG9rTuvTPRDSGs3qqMqseXdZOmcrkT0ce8lUq6?=
 =?iso-8859-1?Q?Qofcftl7Ajlb6UzUmUPxDEDipR0PnO7avcotKev65i9PZw7TRrt0QJUkXH?=
 =?iso-8859-1?Q?btD9/d5u+inzPb9wkJLM60NukFMnH5gbvpFprvbXIUgnzEDB+XPttcLwvH?=
 =?iso-8859-1?Q?LijFyVzaDYpUFvVERRXjotuYjSyrOWsgpM+1jAnsmBaqrR3/10BpAht30E?=
 =?iso-8859-1?Q?ooRVbMn8LgTiYh5hJjHXzypO6OuhINc3xJyj2+W9WIvJb0ahYOTujL2BgX?=
 =?iso-8859-1?Q?Nhobul1OrlYxsH3+aIzxYWtxwKjiem8GmPOnyY59xOuAF6yP2bmavUskqd?=
 =?iso-8859-1?Q?ZulbvuKuXknODnLIeLVkpvq5INrQLz6+gMNDXQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Sfuj6hlq3FUvbI+4hBI7YhbhmoCTBmRz6wJC/B2/aSUK6Ql527lNqrM9jf?=
 =?iso-8859-1?Q?NNGcerX3BT9bWzHQze0qe9sgWMPDYHsmC1/vNJm204GxQ+1NS+VdGmo8RS?=
 =?iso-8859-1?Q?E1RcnirvppuBmUw0I5AUPPynm/SnHdSZbLlJmPCFTX/Gmm29P+4sy0bA+Q?=
 =?iso-8859-1?Q?rEangvD91uklSYvEcVaGBJKyxjBJkztRvIUQHCBmP+c92JvV3CHTuJCMQQ?=
 =?iso-8859-1?Q?N8xAEsgKW/2DEAcuzcNathAUNuUEEK44Q630ndZtUGiTZ6uamANBNRJBXU?=
 =?iso-8859-1?Q?zpYaKAsezxTqJm7blHQO7z3R5Btm4kwDHnwbd5iT/bp6i9RTyKpagtq+Mj?=
 =?iso-8859-1?Q?kJlZ/G9fj+UZuktrgawN4auxGpACjQEVtnYBj75I0Dmbtyr9OsO4rqUaw0?=
 =?iso-8859-1?Q?4IQZmxkf41ddqATgninmfgVZGgrkLvMTx+/DCNZyzHsR73k2eYCc/mzN1C?=
 =?iso-8859-1?Q?N9NDohJJIaKbPGJqe0B0F6vTOa/X80c/l2tAYRCX7dP5afCKArzVKORZpf?=
 =?iso-8859-1?Q?9ZqJaXZm9715meiFF8Tx/9H4Zz0kPXGezIPnQQ8WJ+6p43NT97FwH/d3M0?=
 =?iso-8859-1?Q?hBzuzB6D/vsamkBekzblXXTpeUmmqTZaTwKkzdd0FgfqHHGkbBDM07zVuP?=
 =?iso-8859-1?Q?xY/TqRjxdR5vlHwv1oOOUYdBtpZQcwdBaCNbAn5K7YAHYB6WJisUZOVGUZ?=
 =?iso-8859-1?Q?Qkg1Q3Kx507hAeTScj90Vo5xPCmJmZnTufZ7ubAfi5ct2vov2x6egD6a9C?=
 =?iso-8859-1?Q?P4IEIaOgkoFJ+rH+7Q8e9QUqcf3iUwQIfDYJtteco75ijw2Z/grn2gZXbS?=
 =?iso-8859-1?Q?qR9eFjkBGC7Lw1P8+rckt71zbDSoKhe3JApAK3hpW8kmjBl4VaR99vkz/M?=
 =?iso-8859-1?Q?6D6hsVomJ+6xnekVjVA7L2bjkNZWwh29Jg0MYjfk0SPv/TEI48GJJ3918x?=
 =?iso-8859-1?Q?Zl4RPGs0oTcPNvxfY38tbD9ondfebTl2ZGyoya9l0xmHW9xKY50AzFqJPR?=
 =?iso-8859-1?Q?60YTdIOHdOcBp6kDQ7cdoouyBXH96BAebfBpc+9Qp42w7CjZzgeBUfcN4E?=
 =?iso-8859-1?Q?h/9GoNUgpc4hbHUCsqzvWnI1TjmrePy2ZxvnIKf4MffNk0GwPp6iiJGKOm?=
 =?iso-8859-1?Q?tkIUPaW7kRmakImWPx/+gIMiAMqLCDbI89690mnkvXsQ4uzL8PWlf71tc0?=
 =?iso-8859-1?Q?FxjrDwzqRy9HmCaMZVxbF7/M3OWtoZf37JHdnGUo4mYVIIUUQFVi5PKTO7?=
 =?iso-8859-1?Q?64gvB3MXlFqq3UJD1FDkll7S+N9dTVclow5cTw9rtlNt2HcLlmAdSTCGRu?=
 =?iso-8859-1?Q?ubm7sRTULpaTTdmqRNSu+xoM/1EqU7Bnyzga0POu1XnluCQ60YX+C1FqGR?=
 =?iso-8859-1?Q?DQ8mDJ+6M/LBcNvzDbdtfbLzYueJt2mHIv2LKltCgF0fILlvCrGfR6CZPI?=
 =?iso-8859-1?Q?+IhyS5+AGkbh+/ppR9s5Pal8XB3EJt+0xmdgIFgANYYaYLpsPl09xsTCpj?=
 =?iso-8859-1?Q?vvi6HKft/0ueeYxUEcpWetZ2frLl5ckyXKHCWcUAYA3sgsFi6TFc67Y+17?=
 =?iso-8859-1?Q?kVVReSTbXKimgJ/BR5DM88fZui37ClEvXdlmJoi475QZYd0VpKnEKvfv7M?=
 =?iso-8859-1?Q?9MuJF/ECtmeMA/GcsnwSGPbvUWLqPSw/CX2YnDN7YDckda8u2I+q85VA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e87f9c-23c1-4937-f42c-08dcc29f73c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 11:42:07.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqpsxQSO4eL4gWnOfUY6fOlWq7GNWhCbSmifLkpMACsnwzeZZXAKGNO3b+ZEqnMOBE9vKuFp0mH2D9LcqOwTfxo7/AaAM6PLSqAswqK4yYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0918

Hi Marc,=0A=
=0A=
The CAN chip on the Kontron i.MX8M Mini Baseboard is the MCP2515, the same =
as ours, and they also use edge triggering. You can see the patch in the li=
nk below=0A=
=0A=
link : https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/=
commit/?id=3D8668d8b2e67fe7cf65f02becd5d67c0636689e82 =0A=
=0A=
Best regards,=0A=
Tarang=0A=
________________________________________=0A=
From:=A0Marc Kleine-Budde <mkl@pengutronix.de>=0A=
Sent:=A0Thursday, August 22, 2024 12:27 PM=0A=
To:=A0Tarang Raval <tarang.raval@siliconsignals.io>=0A=
Cc:=A0krzk+dt@kernel.org <krzk+dt@kernel.org>; festevam@gmail.com <festevam=
@gmail.com>; shawnguo@kernel.org <shawnguo@kernel.org>; Rob Herring <robh@k=
ernel.org>; Conor Dooley <conor+dt@kernel.org>; Sascha Hauer <s.hauer@pengu=
tronix.de>; Pengutronix Kernel Team <kernel@pengutronix.de>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>; imx@lists.linux.dev <imx@lists.l=
inux.dev>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.inf=
radead.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject:=A0Re: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Periphera=
ls Support=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=

