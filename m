Return-Path: <linux-kernel+bounces-310964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBDC968361
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC621F211A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6F81D417B;
	Mon,  2 Sep 2024 09:34:12 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2131.outbound.protection.partner.outlook.cn [139.219.17.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A61D27A7;
	Mon,  2 Sep 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269651; cv=fail; b=Bbo+oRLMTQIT6Y0CDIHDIGZn9BnBJZW2/fCBuSR2zyEr7z1eojZn1v2QMSfD1qjTxdHA1OlVdBdX9owlLG6gZJhaf5S9bMMiS+JBcxtVKg1WUUnJFsPSpxkGsf3fzL+dZ7FgTF2X1XQSh3UMHtx6uTksKEx3k+nHWAJTbk/bTnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269651; c=relaxed/simple;
	bh=6ImnsclLme/KtMHX4JpSccwhujSum/X/ngfsqnRPIKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l7vEyU8MuVrwP2qeQfhBuDlpk2IUZLravQM0iX4hbKWpBh6zmQorSjmvyryeiTRa3O4c3HvwV+JpbvI+EJsFCw+34Iu/YSH3VK/g7nPtsyp01HdAOxwxftyGIDKGu8UxOsA3JYVWyJBE+Kb64J+doQEgm3TWqsf4M+QohW/w/Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBkfgacbTUpZnM6EPnA0zf2M0afssU43qpWQfoXZMiWdBlq8qE3s293QiBDgpJSzlZzr1Oqku+goata2x3HspiT1NPSmdrJkKycvsQvmfYJnQ2oMr8PPflAJxLYZZMhQGBjXLdNaKw6+bq0ThhdHkzWtuqKI68yq1rjo4jVLAttzHuiyjIr25eN+dJEsVnn9DSsDa3UHckakCLoZ6hm61iB+rxS6EFY8dzeJRK0kYFULGh0MApHCJJP2xxM5B860RrAtLXKq6DyWlwNNI1BYBfZZ84ymWgCdi2CjTLspKI8gJMHG7vIaQi91mOcC+pRIisuDcKJ3+bkHP2RKvvnSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2Qa+BOFe7WUy5JkpJRa9t8lAnu3Cn+nLJZpGLJgLOs=;
 b=W8EaF8UvbNFg8OLHv+uTpsJYGMr7xf6Tnm9wOf0VB4uJD9G/Vuhk77VrFhPmnVMGeA6/zgM01ybIkqsmWiVXWdk/U0f0FzvZeZkwWJOl/bkndzL3NqhAhDJX+nuse8i7MTLxAaSAAeCoJ3mLQG02PSyrthlf2AF5n0wIFiYU3u5gQRhJeVdQAEAYBbuBP4lTpThva3IaRPhOznK93fUjEUrUC65Jd5hjS+2uxaHqDW33AeUr59WYQvSPvIGAwtPh2Rzz24uN4et4R3Kw/+Dtvk48S5it3Hd+sCNEQBis4lHjGNVG1EZpDILNrYvAdjHmMK46PbDZdi2Az7AregFaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.31; Mon, 2 Sep
 2024 09:19:29 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Mon, 2 Sep 2024 09:19:29 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Jan Kiszka
	<jan.kiszka@siemens.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham
 I <kishon@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
Thread-Topic: [PATCH v2 1/3] dt-bindings: phy: jh7110-usb-phy: Add sys-syscon
 property
Thread-Index: AQHa/Rk2nIla84OkdUyCXgqm7iSxew==
Date: Mon, 2 Sep 2024 09:19:29 +0000
Message-ID:
 <SHXPR01MB08632E50DFE53BE0CFAA99ABE6922@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <cover.1723472153.git.jan.kiszka@siemens.com>
 <30f3ca9f6bd788e16767b36aa22c0e9dc4d1c6a4.1723472153.git.jan.kiszka@siemens.com>
 <20240812-overstuff-skirt-7a8aabbcdc6f@spud>
 <8cdba8b0-7364-4c09-b18a-f3f59da1eae2@siemens.com>
 <20240813-haiku-pusher-f2fb037a2f49@wendy>
 <SHXPR01MB08633B523DA1F6C5632F6D9DE6802@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
 <20240815-endless-credible-324438d164f4@spud>
In-Reply-To: <20240815-endless-credible-324438d164f4@spud>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0670:EE_
x-ms-office365-filtering-correlation-id: 46d7797e-4a03-477e-cf68-08dccb30591a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|7416014|38070700018;
x-microsoft-antispam-message-info:
 KRyB2MiHhMOWuxG10Ns9JxjgOJfTYzlkdBExw4Zpwz9UGmpD0Sz3qZ9LHtinimx963U/ZKxTVKZiy0/nui83fXzig2HZyE2g7Cg2KkGWdtzYSO89xEd5oFTZqEfLrXu7GOtXyUZKV1Ja6zFGiQiwQ1Xj4FJr0RebKq0nhHAPaMKdqA2A+m8X7vHdIXCeJmY5xGjRL5r3eev0P9fjDPtdsD3jtCJtY3LKFrt2kl2Frf9sQBouWyLctoXzFpkrZd6vehzXlXfGo8K8GWeyQ7Z3+h1NxBKS9IZOD44R6JNBzw54GJMYJOpWUVxetvRx87VWGS9X7YBS6UBVdYgb/zQ5OeCStO+eGU6dGKGWpf5bs2BNpOXkgfdHfp8k50UiJLIMxI129uOcgCoDLHUOKbP7+gle0684jBPxtMknqNGk4snly3N5NFAWYPcZh/PELZ/j/6UmCHDl6lNZy/E8QZF1zk+BqhQ3+zGxSYDagaYpLlpSAGN5azTY8mjBHgB201fYNTWNYipIADdoPMZBPLrg6NRvNaCwwMuXY9nSNBm0QfCVIGxd0J/2JruvJUJ4/Y0wEKelu4miaqdelyG0Lwa0A+JLc9j2DawSvAgyHPwAVVAONzxSd/PYqB0DVfGfZQGr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NiHY1GGDnak/sDonsOO+5ArVsDIzKKBGWmDoSyAbZTZPRgJHZbUOwDS4PRIf?=
 =?us-ascii?Q?UbgHaCh3RlDTjZilAH6+cBLQtpQWd/3oS5LBCCk3+X/Bb72nDkXZmX0Z4jCE?=
 =?us-ascii?Q?Uoh0ch9H8TrIKlj0X1Ts50yDpHmBs+1JdHb9qPjzJj5J4woEjM67xB+wjJVu?=
 =?us-ascii?Q?4hjjRb3t+81OyKTPIfEfaUftx0pVTn1SN7fRCsliunhyDX5ruLY4hVV/h9oh?=
 =?us-ascii?Q?1sWwnRnf76D3n96WmMqpfw0Stn4liyKPp00lrCyW1YXtcwhVgrY1zEtu7eFB?=
 =?us-ascii?Q?na1bxLrsthddFdHHpIwPZmdoQln2zKwzvCDYuMAArqPYP/V0eNGkOfTPZ/ap?=
 =?us-ascii?Q?uzYOwpOjDiBNFLtfAtlnjSzNL/M4p8wYRsTgQBcLwrWogvioWkUghorajpBZ?=
 =?us-ascii?Q?c0hp6BceDVgiTgg+uXwjuDCw0WyZjx56DuOy6Dp3illviw5yhlviDYp/POVY?=
 =?us-ascii?Q?3J/aOc1H0/FT3r4JA0kCGeHWeOvZVtGrOtXpT/Fw7bK09TGLVwVNAKTYjVJR?=
 =?us-ascii?Q?0PeF5c6/Lq3IOGqRYIYJUgB5KN72Mp23Jy6qUbtUoUKwzdwGJ9RzMGmG57x4?=
 =?us-ascii?Q?zqpGxzxWqZCESNIf1XYRHxZrqsiKe7bPeUI72mc79GDqT/Y8NSBAW2IUxdB0?=
 =?us-ascii?Q?+9OO2jlFckWTLn8jLuG5xCdkkR4gnELkqlAwCFg+nAsnz8CG9TUUoE8VXyjD?=
 =?us-ascii?Q?832jthJHsLXgsA3OKX4F1voYuevj6B9m2AGrvZN2WE0uAupclloFFzy1GLsQ?=
 =?us-ascii?Q?DxxJ2AGazKQIiNEZEq3F8yKOSy9Z/pA8k/8uAXEJvIDdEBtRcHpiHtBBb7WD?=
 =?us-ascii?Q?6pDqgHQbFebkiTgzu2CSYS6x69xJ2cuNlZf4voayauGwno6h2mt4pjSQKjGW?=
 =?us-ascii?Q?syUdSA2f4FkPwvzdbVm5zJsBgzNRkUgtgGEqmybSONvQkBuX98iYG4V1Ry85?=
 =?us-ascii?Q?DX57xDyuIAzlROiSLIRKNIt6MWU9b3VJyzXls4zD+885S0KlpxjrOrL7b8Ne?=
 =?us-ascii?Q?ESYBe/p7GGCk9JewkuA/oYZKVu3qYU/YnSRJDK0YybC2n3dzuPWUgS7ALEYA?=
 =?us-ascii?Q?dkl4OuY7FlHR4NOnHc/h7J/WwVJqHbUOg4zEksnNLL7jVA2SaZ5pHMXaScrF?=
 =?us-ascii?Q?BPEbQwlirHssDCNyG1zX4Dq7y9QNoLpGFGS/wHxtqDLT+Mw3odZXSdrAlPGp?=
 =?us-ascii?Q?UEukJkwNDR8Zy0APBM6HGFCjgc+4SvzJdoPGxL5w8GdUwMXP5uZF5dMI0SAF?=
 =?us-ascii?Q?SgzKMa3KGB2kODf/eocmNuinWPuSXY/4VsFF3Tv/gd38iBHvAImoA2APfG4T?=
 =?us-ascii?Q?96XPtSqBme2SyQs8M/xJ7dYHRDHEb3Gcn+3G1FacLb3QWW2AzE3E8yAaiJ1t?=
 =?us-ascii?Q?xQZEb6AIHvicCwTO4unBfithZSipmg/oXAGt8+hs0tAAKGASNAh+fFRHyTzr?=
 =?us-ascii?Q?bz7gBcNwTM4VBH3ifXXWPNeyLfEwboOhsqKEFpzx3854CfuuOfqRXOwAukPp?=
 =?us-ascii?Q?hrHDjWxobYG2qXGVG8env3g9xi6zo3WkUZhcVHceci5j/Qvl34frLBCzMGmE?=
 =?us-ascii?Q?4oE8+CcE22F0GFrMJmXvBdsQuGwFtMcFyS6CZDnQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d7797e-4a03-477e-cf68-08dccb30591a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 09:19:29.3158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NsRkzD1LTDQ7VaZA+kGUyeowrirOg3/GaERVTpl8IpuYOWtFn9c/tslyKNGhZw35mOh/kQ5j1rCg1K1xBg0vMHEdzMDphMk1RvEnXZFgAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0670



>=20
> On Thu, Aug 15, 2024 at 10:33:55AM +0000, Minda Chen wrote:
> >
> >
> > >
> > > On Tue, Aug 13, 2024 at 07:31:50AM +0200, Jan Kiszka wrote:
> > > > On 12.08.24 17:55, Conor Dooley wrote:
> > > > > On Mon, Aug 12, 2024 at 04:15:51PM +0200, Jan Kiszka wrote:
> > > > >> From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > >>
> > > > >> Analogously to the PCI PHY, access to sys_syscon is needed to
> > > > >> connect the USB PHY to its controller.
> > > > >>
> > > > >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > > >> ---
> > > > >> CC: Rob Herring <robh@kernel.org>
> > > > >> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > > >> CC: Conor Dooley <conor+dt@kernel.org>
> > > > >> ---
> > > > >>  .../bindings/phy/starfive,jh7110-usb-phy.yaml         | 11
> > > +++++++++++
> > > > >>  1 file changed, 11 insertions(+)
> > > > >>
> > > > >> diff --git
> > > > >> a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy
> > > > >> .yam
> > > > >> l
> > > > >> b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy
> > > > >> .yam l index 269e9f9f12b6..eaf0050c6f17 100644
> > > > >> ---
> > > > >> a/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy
> > > > >> .yam
> > > > >> l
> > > > >> +++ b/Documentation/devicetree/bindings/phy/starfive,jh7110-usb
> > > > >> +++ -phy
> > > > >> +++ .yaml
> > > > >> @@ -19,6 +19,16 @@ properties:
> > > > >>    "#phy-cells":
> > > > >>      const: 0
> > > > >>
> > > > >> +  starfive,sys-syscon:
> > > > >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > >> +    items:
> > > > >> +      - items:
> > > > >> +          - description: phandle to System Register Controller
> > > sys_syscon node.
> > > > >> +          - description: PHY connect offset of
> > > SYS_SYSCONSAIF__SYSCFG register for USB PHY.
> > > > >
> > > > > Why is having a new property for this required? The devicetree
> > > > > only has a single usb phy, so isn't it sufficient to look up the
> > > > > syscon by compatible, rather than via phandle + offset?
> > > > >
> > > >
> > > > I didn't design this, I just copied it from
> > > > starfive,jh7110-pcie-phy.yaml. As that already exists, I'm neither
> > > > sure we want to change that anymore nor deviate in the pattern here=
.
> > >
> > > To be honest, I think some of the other users of phandle + offset on
> > > this soc were just copy-pasted without thinking about whether or not =
they
> were required too.
> > > This one seems like it should just be a lookup by compatible in the
> > > driver instead of by phandle. As a bonus, it will work with existing
> > > devicetrees - whereas your current implementation will fail to probe
> > > on systems that have the old devicetree, a regression for systems
> > > running with that devicetree and downstream firmware.
> > >
> > > Cheers,
> > > Conor.
> > >
> > Hi Conor
> > I know you would like to put the offset value to the code, Just set sys=
con in dts.
> > Just like pcie-starfive.c. right?
>=20
> No, not quite. That still uses a phandle lookup, I was talking about usin=
g
> syscon_regmap_lookup_by_compatible().

Okay. Using syscon_regmap_lookup_by_compatible() can just modify the driver=
 code only.
But syscon_regmap_lookup_by_compatible() is not exist in uboot now. If I wa=
nt to enable
CONFIG_OF_UPSTREAM in uboot. I have to add this function in u-boot...

