Return-Path: <linux-kernel+bounces-237411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A891F0B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB9CB20DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9EA14883E;
	Tue,  2 Jul 2024 08:01:59 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2111.outbound.protection.partner.outlook.cn [139.219.146.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5B16419;
	Tue,  2 Jul 2024 08:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907318; cv=fail; b=B70AFsl+YT9R9nk51polf3h6tcjRHM9N10iMBrCOh39ImqGff2DxGPysC/D3pRmh+fwtmhrEtgNpTJ1iCWnMeGNPhVY6QvNTrXtddi6wLPJtwxbmGV0Txxpz1yz8NN2GchkDraBb/3EzGSPRds+M4S7TLCoQqfkLyCo2Ym4Q1H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907318; c=relaxed/simple;
	bh=5BTwPE7zG+n974OqP+CIksId4hSO1xM5x+0p+sXctkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o3sUfN6tcdeqxzTz17jffKKzP87TvlTzTUOUcbswQVKYHPt1kAKKdD+HAUc+gpViCQdGt92nxlCKZK3CHa0dR0ESIO72pPEGCSKu3ARuF2UMoPNSsF0gLWDYgK1fuWg/RzhlflVl9CoCiaNDml33KYI4tEFJPitUJZC5/v1prek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD2SC9vda3WKZAN6O2+xIaJq4eQ41edespHrtv/29Z+ApTBiqPc51WldaKrFk4DzTQ2a3XJmWy+xxFT/dKkzpogySzWW7XwFyr13plAWdQXlYuo8K1n9/WSUnL0zJ+Gf5fChZ7o4xWO6+qDB2vu/oArTM9D4YH3fYlzKi7d6at1+Jz63AFMXiiMGG/847G6iS2132meAUZrj6hyXE8Sz0ircNQmRdR4BwVn2Y6wfnwM2rGXOo5EqgDVq/Jng0+KbZcBAlFHySyfhma+oS3w4FBMahqBoBjVjza6pNBS62VzTbcckCa0k0RU2CceQmAuTfB/zszWPiz/CHFyrUW2RUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1ZRZC1N9eLLM1w+Mw8waWRUN33e4Xr1/n42IxI5H3w=;
 b=gcLfrYkUicNsEZQp57cmv/jSUngnhQNyzK3mV0plIEFUZJayQD/vcZpfmnhGPq3kL8rfeR5OS75m5XsGZGlZs/7G34TZJsh7ZAsIXAg+9LhnmGB0XUr8fL7UOK1dRrq0jdl1PWdkhth9HUKC8OLFbpsLK0tNkR/XYnIcYfA6fLlDVB2gJhyhOFRIpmwjHhjyleBn9Zg9SWaSF7IG41KQcZdLnMMF6C3JB+6QjzW7OUUwgrVK+k4L02llNpvnZXtL01SL10f57S8aLWqZLnTQjrKd8x+trDxo15pmcpH2Vy4CxgO1JLPHkac1FroOjv+X6TvDy81LssMM61OT9lvrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1100.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 06:28:03 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e088:653e:f729:598c]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e088:653e:f729:598c%6])
 with mapi id 15.20.7719.028; Tue, 2 Jul 2024 06:28:02 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: Hal Feng <hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Index: AQHatVqcyH9jOZxH00+fSahpYZMQzrHjIHxA
Date: Tue, 2 Jul 2024 06:28:02 +0000
Message-ID:
 <NTZPR01MB09562C9EB5231A714E82BDD59FDC2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
In-Reply-To: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1100:EE_
x-ms-office365-filtering-correlation-id: 6fec4efc-068e-4126-6d42-08dc9a602043
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 z2tP9/eZHhrf8Y4FiW/LSlr3vnq/jK9YMBxtQb7p1r49LN6l+ggk4pJZMiyV679HH28PJffhQz07d6hp2s88M8IjvU62XazJHT5NIHZVPRH7jQCtobl5+1K+mTW1uYh9Bb0H+Mh2BWAL8Y2UuS+fCJHeu3dJ98f6ywGSjxqab0DGktXOgZRmxfB2m3szHF2ru/Um5Oujc1KFB7qsvS9Do0Hv6T9kfAVCBFPWfJmR8/FPy5dDtW5Jj1ifWlWWmckbR1zpLh9JHb42hII3tQNB8Ica2Q3k/+8dh2b9/wk6ii9AhRFPbKAHg/1Pp4D96N62QqnvQH3zAZrrLWctswGnTVqigRo62WfzywSFR37Dph+AJI3NrFmIsNJ9zgcl16t7lCqvGP+myRXD2aJy61o5d7QG0vSxa/d4rEI1cQEBda0xtHB/gG1SsNTB0KYUKeppIn9Q/OvM92b2jddYszN0bZSneSZgcer8iasJKCwUoHZTn1Xn6nzE2ipysAzvlQeu1PmHGV1oA9f0Nz+fshjM4jSBhGMEnEAo1OChtEl1ylx1OC3wLP+X80ByDSh+orTHafUNh/egqMCLa4c/4OD38Ub7v3RkkO5pyWD57U7qW/YF1Oyt/6QZfuzhvknPbPEG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vms3eGyi5pnKAbmYBBEQwPDinadNdOaDMBjP04Rn5t3eIBKgZKdTk706MLEM?=
 =?us-ascii?Q?OViwkgo40BodIFgw2Uec9zqHtuTOBaght14u5kW5x9KPJ/nv9z2pkYEc0CTe?=
 =?us-ascii?Q?K/WpOO4MhnH9qhOaoAJ6Y8AWIHQPYsnp0y/v3wIqkctBgg9DO001TdvVf4qS?=
 =?us-ascii?Q?eIOOtCrwwt2cI69zmLRj0lxEjozewhzBJCq+uuUfORZvfWVvhyhOxA1brip0?=
 =?us-ascii?Q?lzl7uMESjWEvTSKzK3NH6TEHa9g5R7nal3xc5R5h0Aaepfk1XTXI2dKRJNzn?=
 =?us-ascii?Q?CyuEQDgGn+vh/ch8K2+DT4mgEgS9aZ5Um+Nd97QpPcDP58zQsOL2c0gnr5fl?=
 =?us-ascii?Q?ccrjJvDK1FN90rPxjyOEo/QLI/bkz0mtccPJuPUc5Y6+uVA1p2t5DDFjSo9V?=
 =?us-ascii?Q?KUzq/CfirFAAzdRg+IrTazK/lfqlkYo4dZKomC/XCI5F6iE2VGAKMSPc4Cme?=
 =?us-ascii?Q?tytAYTfJNUNvzaZWCUbEKxLCsI8iNjY4H+BB/kuCvps8MuUTv6OYJcrcGk3I?=
 =?us-ascii?Q?n7v9hksh0qAMv2eH9d89oHYrLwHeGfzaPDtpXweWnLZ8lXPPTU4EYsVBJcbV?=
 =?us-ascii?Q?KXNCAueKsIxHJguwRZONGZ1ptYkXcpi6Su6l/BN0+rcsoUKz7XbqcUxG7IGX?=
 =?us-ascii?Q?i8uXCgfn42xwohQTGKVwBNdAmQkRpH4dPJ5qysMepauV74yXMda86SFgvFuS?=
 =?us-ascii?Q?RFscIffrcMDJ41dJAebZ51BpdvJiqcUfHWXopYeg7CitURX2OiGnz/I81u3I?=
 =?us-ascii?Q?CEok8aqe6hvUorZP4cKH1ZnONfYw05SYW57NFOI5PXK6/PdzCW6lGwykVf6P?=
 =?us-ascii?Q?gCwE/+nhOlptpRnkoQe0TJ+0awjAAVHKha/+wiyF4M5kSChN5/g1A8rYl0li?=
 =?us-ascii?Q?z5VHL1Aqm9Kr0MFtxptkOgsPM+rLCGthPnc/TCtleteknsSZEuDCSu0Oboqv?=
 =?us-ascii?Q?wSXu3Fcluy6e1iHLClL9nRAwgzMSpv1UWK7dDXuEif+StG0nfdZ+CxnP2H4V?=
 =?us-ascii?Q?hGu8Irh2vq3g1VZlTl6+EAFB+Q5K+ghXV7R6kiKuuHBSPh7WykJ3CwCCZ3/B?=
 =?us-ascii?Q?08a2iHWXqWRsI6tIpZtEA4nmf3giRIE9O/C8ptA+vZ1H3+xH9bjqWJ6KFYRP?=
 =?us-ascii?Q?f88Cy/7lCofX9pE4OCSQKPjqqxsbnJP4bI0slV9lu3TzraiWsGW443G73Y4h?=
 =?us-ascii?Q?yRL6e6sn6irbKRBWTGtK+W6ck2NPnkhhnv+k9NlklEyzAVifyl08++mhQ3HH?=
 =?us-ascii?Q?7Qpf4MMBakJGZS8pK0e7qKpWnHGYh65f2BaNUct+VkjRyeos5xrJhBOU012p?=
 =?us-ascii?Q?+mxXVSAt6BtTzuk2XdjVO19SK8rq638WGMWRrMVT5nFkyGvs4GE3kkm9lhT5?=
 =?us-ascii?Q?P95f0yDFaUUyn67h7uGQQij6OW415W9CPXTwi1/K3dPhUNFNg7cE4NuVYD49?=
 =?us-ascii?Q?kPiFwTZ54uKWWbmFhUbbhYudLSbCyi3GGJZKPiH67d5cPCWRVfoUlUmCHIZF?=
 =?us-ascii?Q?ZzqBTVThUn1CsVcBzoBOKbMPj5BdtIrzZ8K4ywlKUsVHEII+/wwR7qvrjRsS?=
 =?us-ascii?Q?yUJQClkHNpvst04LilUOaoC5Qny+cb+G4oy7zFNa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fec4efc-068e-4126-6d42-08dc9a602043
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 06:28:02.8067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFjmkTC/m+xNOxUOj0WkTLwSbRWTDWHPmrKMfgwj57EZV2yhxB+JGbVvM9f3avWblJm5xRc/y2cyRg01HER0eU/E6xNDSbenuUU6fExqzBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1100

On 03/06/2024 10:06, Xingyu Wu wrote:
>=20
> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz. But now
> PLL0 rate is 1GHz and the cpu frequency loads become 250/333/500/1000MHz =
in
> fact. The PLL0 rate should be default set to 1.5GHz and set the divider o=
f
> cpu_core clock to 2 in safe.
>=20
> To keeo the cpu frequency stable when setting PLL0, the parent clock of t=
he
> cpu_root clock needs to be switched from PLL0 to another parent clock and=
 add
> notifier function to do this for PLL0 clock. In the function, the cpu_roo=
t clock
> should be operated by saving its current parent and setting a new safe pa=
rent
> (osc clock) before setting the PLL0 clock rate. After setting PLL0 rate, =
it should be
> switched back to the original parent clock.
>=20
> To keep the DTS same in Linux and U-Boot and the PLL0 rate is 1GHz in U-B=
oot,
> the PLL0 rate should be set to 1.5GHz in the driver instead of DTS.
>=20
> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 So=
C")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>=20
> Hi Stephen and Emil,
>=20
> This patch is to fix the lower rate of CPUfreq by adding the notifier for=
 PLL0 clock
> and changing the PLL0 rate to 1.5GHz.
>=20
> To keep the DTS same in Linux and U-Boot as Conor wants[1] and the PLL0 r=
ate is
> 1GHz in U-Boot, the PLL0 rate should be set to 1.5GHz in the driver inste=
ad of DTS.
>=20
> [1]: https://lore.kernel.org/all/20240515-reorder-even-8b9eebd91b45@spud/
>=20
> Thanks,
> Xingyu Wu
>=20
> ---
>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 54 ++++++++++++++++++-
>  drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 +
>  2 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk=
/starfive/clk-
> starfive-jh7110-sys.c
> index 8f5e5abfa178..7469981fb405 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -385,6 +385,32 @@ int jh7110_reset_controller_register(struct
> jh71x0_clk_priv *priv,  }
> EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
>=20
> +/*
> + * This clock notifier is called when the rate of PLL0 clock is to be ch=
anged.
> + * The cpu_root clock should save the curent parent clock and swicth
> +its parent
> + * clock to osc before PLL0 rate will be changed. Then swicth its
> +parent clock
> + * back after the PLL0 rate is completed.
> + */
> +static int jh7110_pll0_clk_notifier_cb(struct notifier_block *nb,
> +				       unsigned long action, void *data) {
> +	struct jh71x0_clk_priv *priv =3D container_of(nb, struct jh71x0_clk_pri=
v,
> pll_clk_nb);
> +	struct clk *cpu_root =3D priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
> +	int ret =3D 0;
> +
> +	if (action =3D=3D PRE_RATE_CHANGE) {
> +		struct clk *osc =3D clk_get(priv->dev, "osc");
> +
> +		priv->original_clk =3D clk_get_parent(cpu_root);
> +		ret =3D clk_set_parent(cpu_root, osc);
> +		clk_put(osc);
> +	} else if (action =3D=3D POST_RATE_CHANGE) {
> +		ret =3D clk_set_parent(cpu_root, priv->original_clk);
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
>  static int __init jh7110_syscrg_probe(struct platform_device *pdev)  {
>  	struct jh71x0_clk_priv *priv;
> @@ -413,7 +439,11 @@ static int __init jh7110_syscrg_probe(struct
> platform_device *pdev)
>  		if (IS_ERR(priv->pll[0]))
>  			return PTR_ERR(priv->pll[0]);
>  	} else {
> -		clk_put(pllclk);
> +		priv->pll_clk_nb.notifier_call =3D jh7110_pll0_clk_notifier_cb;
> +		ret =3D clk_notifier_register(pllclk, &priv->pll_clk_nb);
> +		if (ret)
> +			return ret;
> +
>  		priv->pll[0] =3D NULL;
>  	}
>=20
> @@ -501,7 +531,27 @@ static int __init jh7110_syscrg_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	return jh7110_reset_controller_register(priv, "rst-sys", 0);
> +	ret =3D jh7110_reset_controller_register(priv, "rst-sys", 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the divider cpu_core to 2 and set the PLL0 rate to 1.5G. */
> +	pllclk =3D clk_get(priv->dev, "pll0_out");
> +	if (!IS_ERR(pllclk)) {
> +		struct clk *cpu_core =3D priv-
> >reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
> +
> +		ret =3D clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D clk_set_rate(pllclk, 1500000000);
> +		if (ret)
> +			return ret;
> +
> +		clk_put(pllclk);
> +	}
> +
> +	return 0;
>  }
>=20
>  static const struct of_device_id jh7110_syscrg_match[] =3D { diff --git
> a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-s=
tarfive-
> jh71x0.h
> index 23e052fc1549..e3f441393e48 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
> @@ -114,6 +114,8 @@ struct jh71x0_clk_priv {
>  	spinlock_t rmw_lock;
>  	struct device *dev;
>  	void __iomem *base;
> +	struct clk *original_clk;
> +	struct notifier_block pll_clk_nb;
>  	struct clk_hw *pll[3];
>  	struct jh71x0_clk reg[];
>  };
> --

Hi Emil,

I'm sorry to bother you. In order not to affect the dts of U-Boot, I did th=
ese
changes. Please give your opinions if you have time. Thanks.

Best regards,
Xingyu Wu

