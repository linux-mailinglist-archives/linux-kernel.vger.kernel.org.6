Return-Path: <linux-kernel+bounces-298368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207D95C651
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BCA1C21E65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51713A41F;
	Fri, 23 Aug 2024 07:13:32 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74474F88C;
	Fri, 23 Aug 2024 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397211; cv=fail; b=PmB+0aL2y5CUOPpaPyh+yQPF+pjIP2f6koMfwZVR6pQNjpr+5Lb1zR4h6zo4Tbg8iiNm2OD9o/byMILrGPQmJnTUIWOQsY9Iw9lt2rCcov9DOKkPs/4Tyo+VmePHOfPnYwU/QTzLAiJzpekoKHLi5Ffm4MpI38hIgE2EZSMXrI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397211; c=relaxed/simple;
	bh=RezAMljIfAC54dfl84cxrDJkpcATnux1ormIw0SQuYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E1vLVeyn6XJvLIupoq6ud7lS/k+SNHq1nq+iIXGpXx8jAJb/HYTjRjj9bfK2vuw3ta0OT7+GBxrJKKA3MRLssAqv+tHwIENkZuufUix5jLBKI8XqTdy3wzEY9qbkjjan9bPruw1lIYH30Q71nLTqT68v9VeMoyQXBJO1EMejj9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5ZX24WiX7FWXjqbCLY3K0kL7K16KhP7naBbwiXjppLZq1NlCFo8BEk8nbRhrFi0jWFpRSJwUYgqREHOJiU1YiceZzbSqOUVgbWnPxAyS9dGfKyBctMI9b5J5eTykMnUyf8mTAHKCZea/HGbDLqpyh+ww84wyddhFkputC6xO8E3PogMPCM/QwieeCvCrNSmhkgpqpE2MZ5n0uVxuCTRXyGp1Noub12nBporrajfzKfKORT8bSeyV2UPOfpf6Z/ruWXzhBPMx9i0VuxH7gE5O3PUumtyppPXo6S1Z26SraKvx2WGpLE02z+molOMbvaiFT4sHEKQZLkDEa+HKI18Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5dG/Ix+ix/y4m9mJoAHaeymL5EYzVpDURGHn6jM8eM=;
 b=eRdQ3hOl/WRDBc01KiuPSipRHdj4qS2HoHCNhjNeeVai5G+3C3RD3rAVLdNHkOk8QQNulCWhYXSeJ1cWs2/7BAUAGGr5+X6pPOR7EtgW4Pqw1kTxuLEYIyoP+DJcFOo7EZJBYB2IruKTlN5vEe3n68QJcmJNxJpPbriEr5wKO5mcQwvXuWhKttNw/XpLcftCJLyjawPz79agl4ws6IpMgSL/zojt5tOyg5R6u/qKH1PiExqfhgbuw+n68pXK9ZCOb5l0GZzCgCdQ5P1oJgKj6cUjOJ9yaHGfPnsf52R4PJ6OaQorgZeMWR/s9VCK3YxSM+b92e4MSiM0um21Lijc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 03:41:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a83:8682:b030:e46b]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::5a83:8682:b030:e46b%3])
 with mapi id 15.20.7784.035; Fri, 23 Aug 2024 03:41:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, Xingyu Wu <xingyu.wu@starfivetech.com>
CC: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Index: AQHatVqd/BnwSLDGy0qsaRtnh1UgQbIaY5yAgAK8UYCAEF7QgIAHItBQ
Date: Fri, 23 Aug 2024 03:41:40 +0000
Message-ID:
 <ZQ2PR01MB13073EF3BD7A64F2C098AA8FE6882@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
 <CAJM55Z-_sOvRnaa8BuGcupsUksaK=tuTbTmF=AtzmzkCo7y5jA@mail.gmail.com>
 <NTZPR01MB09563DBA6F76281EB06914859FB92@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240818-flip-excusably-c89021683d20@spud>
In-Reply-To: <20240818-flip-excusably-c89021683d20@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
x-ms-office365-filtering-correlation-id: a167267c-fb83-4c3c-05cf-08dcc3257f8d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 ujOq+Qs6b9XrtA62IuEt/A+NvSY3o3fuvO/MIL3l0reHA62kMnYwhzEoHdBkx9J9dVmJpMr6U2MTqZadn/GxMziqH7TqmexZF0dzWrmXlscUuPvX5XE8R7TpMWVDuW+LasBppfSwcrffpJ38vhBu5F4NR5D9ggIjneH/aDVmQ8b0ZT5ZQwuioC7XAlRWCR01SQO3m0TEaClt+Mn8nZnRfp4WWD+Jaio/Dp3PV0CIvp8b2AdIamNt7Gp1qDc5uKrTFXkL4Ayns8HyKuR47f5svrCAR8hpybRr2Ud+xxEvAsywMzN4EIDchsJG5V++eJTVjtSawQf0FX6T+06Kt0LhzQmeLGCPrX1Wwpmh7X4mrrHptjK45Ho7HdGEoE4c19CT+fElBZ8PqnFEvNkVilYo4pLfFZyDcSDFcRtW7+tTumsLZ/l2VAhLvfZoxTGc6tyB2w/7layBSLxEeusgga6oLE4ch045vEHb9FhIKt8Ksibzle+ooKzqiifIeIMGmrp4N56Gm5qnD4LCx8lL7Q4KbR54WGqx93++/Co2aGyhEQXJVkNNGkWwA7jFyYPZfbIe9SdRv9Ha1lGUGBH6g0GpylLFnHZ+eGt9V5le2EX6XH1NFfrBfcwRu9CtWA0RM+33
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SIr/7cG5CCgB7mCSbwsyzZjjy/4SVM8aR1Q6hOgp9LFjNx1n28yMVYqO+VnB?=
 =?us-ascii?Q?3m2kKRNbg40sIv5UNRSMvWB+6aPuPnlLZZiHh5U06HjIL9u3UTZmodC3qPJR?=
 =?us-ascii?Q?C6pVi1W2aSZF9KYVRODheVsFECYPGHyDqOoOYe74Qs0d4DXk+jDbFXF/O+HW?=
 =?us-ascii?Q?sic0gCDzWS+Tw9ohSpq0steBtnKQ2MsLYEwsyuAjy3++8hilLPCLJoDlBHE7?=
 =?us-ascii?Q?rUTcbSEfKxx889a8CX/ASd7d34bLCCGcBSIH+93Woffwr/ti0rTILhupXehp?=
 =?us-ascii?Q?mMKLQaFdOwgqWBdtLj7eQATTuypjNkwl8xxf+ZdE7woZ5rvRRzbmNhjBzo+N?=
 =?us-ascii?Q?tcprBwm+ihrGg+oqgrW5buS7fbtjqqoHoj0illbB1LE3jIJT2tnnJaQV7wRH?=
 =?us-ascii?Q?9WGKpngqV1Q4lfhzb1B3grouW9PmpWIUiRds6xpbv7c6ltKjt0oGZN+UduSf?=
 =?us-ascii?Q?1g7b3J85+X49fyG4qf18iJduvHm3dD6/P+jagmxJnxk2hDT+gVy7sSPiUZPm?=
 =?us-ascii?Q?ks035uqH2rjZdzL/dWvHrqlzJwpGs5kfiut03hVacJJi04GxgssQoKsSEUcp?=
 =?us-ascii?Q?lSlJUcsID0FLlHy4+c8j0m545rgwYNkogylv+jF9ygPyp4kD9wXE86s1E3LQ?=
 =?us-ascii?Q?V0kuLbqVrdU8UiCPlR8AFCgyEzxB2PA0lZN4kk9VQrn03oBLfzVd+T4qn0JD?=
 =?us-ascii?Q?/B7qnADOe3Uvf8xX6FpZLBjUuWGeiDEf2ud3Zs7n9mEifTO588rl4Ux6lI/A?=
 =?us-ascii?Q?MtWymFr96BNUoyxaa7LWkpzL1yjwaMOmUrkDShoosVuVAUixfv+LLNIPmVAS?=
 =?us-ascii?Q?Nj9lIxzGvhyBGdaUyYliAe6L47AThNl+VQ95XFAH2Ja3ImkMXLUVBPPoFxkR?=
 =?us-ascii?Q?/XYJvW94ddiOuJDQmDIn/AegvMo8Tlqnu66nga/QokG7+SACfq3KGj5dL5ly?=
 =?us-ascii?Q?YeLZKV6lGfPByLaZzVHMH5Uan+CpuZUKKuRH6eBs26Vee/ovFDqy1DQgqtlY?=
 =?us-ascii?Q?tsxy6Dlm8JQGeEG+MKXQ9I2przzEfSQyidYEulEGExTcMed6UuAe6xv762xl?=
 =?us-ascii?Q?i/CgK7uv+pDvf9DQgBea902WfQp+qTTNpDtNy8N+9JbiEunKtXRe1iDy9AIh?=
 =?us-ascii?Q?6ATvtQ/pM0kkTUXG/4DxHyA2MyjsjDYRWu93c8c2cjpTOm7SzP01QtwelgYo?=
 =?us-ascii?Q?J2sxsCExzu0Lxaqve6LZ13KEjeBIQt00r4MM6EunG7Hozzfy9yaIdeiG2CcR?=
 =?us-ascii?Q?ELUOUJhhNRIGe/uHulD0s6bPkFj9UaoCFoUblPksnSth2zaOdHjtDtn2AHep?=
 =?us-ascii?Q?ZjobpblTA9t74lmwXugiY2mp6EeJ1nTTNmErFvCslNjiiX/No/Qehy6pBkks?=
 =?us-ascii?Q?VsvCWtxhMFDUFxI4I1aZXhx90QZNMX3td4HsygivOv1jZ/xChGX7qrb2A8CR?=
 =?us-ascii?Q?JOQ34q4BTjb0QJ+BoI8HYeNSCqKBJaFPwdikQQH76ATmTQS/Q8lfpus9qyIV?=
 =?us-ascii?Q?ZKac4BbIJULEtyjkf/f5GxPN6P2ce9dYxv49GgCOCgUFUBkwMNBzOSYXB+rD?=
 =?us-ascii?Q?EytAgtEalSnK5MnI0JuibTVIqWMk1ennCVZgnlV3?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: a167267c-fb83-4c3c-05cf-08dcc3257f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 03:41:40.0760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCW7+vIvLcVQIUvBBqSP+zCJHV0cApFzx62HnCvVxkF8hMAu/j3FEYtGjdwQY8X2khZbZ9HKG/ansHHLwq2VektPHuLdAVv4prQZsqrEVuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258

> On 18.08.24 21:44, Conor Dooley wrote:=20
> On Thu, Aug 08, 2024 at 03:44:49AM +0000, Xingyu Wu wrote:
> > On 06/08/2024 17:58, Emil Renner Berthing wrote:
> > >
> > > Xingyu Wu wrote:
> > > > CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz. But
> > > > now
> > > > PLL0 rate is 1GHz and the cpu frequency loads become
> > > > 250/333/500/1000MHz in fact. The PLL0 rate should be default set
> > > > to 1.5GHz and set the divider of cpu_core clock to 2 in safe.
> > > >
> > > > To keeo the cpu frequency stable when setting PLL0, the parent
> > > > clock of the cpu_root clock needs to be switched from PLL0 to
> > > > another parent clock and add notifier function to do this for PLL0
> > > > clock. In the function, the cpu_root clock should be operated by
> > > > saving its current parent and setting a new safe parent (osc
> > > > clock) before setting the
> > > > PLL0 clock rate. After setting PLL0 rate, it should be switched
> > > > back to the original parent clock.
> > > >
> > > > To keep the DTS same in Linux and U-Boot and the PLL0 rate is 1GHz
> > > > in U-Boot, the PLL0 rate should be set to 1.5GHz in the driver
> > > > instead of DTS.
> > > >
> > > > Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for
> > > > JH7110
> > > > SoC")
> > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > ---
> > > >
> > > > Hi Stephen and Emil,
> > > >
> > > > This patch is to fix the lower rate of CPUfreq by adding the
> > > > notifier for PLL0 clock and changing the PLL0 rate to 1.5GHz.
> > > >
> > > > To keep the DTS same in Linux and U-Boot as Conor wants[1] and the
> > > > PLL0 rate is 1GHz in U-Boot, the PLL0 rate should be set to 1.5GHz
> > > > in the driver instead of DTS.
> > > >
> > > > [1]:
> > > > https://lore.kernel.org/all/20240515-reorder-even-8b9eebd91b45@spu
> > > > d/
> > > >
> > > > Thanks,
> > > > Xingyu Wu
> > > >
> > > > ---
> > > >  .../clk/starfive/clk-starfive-jh7110-sys.c    | 54 +++++++++++++++=
+++-
> > > >  drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 +
> > > >  2 files changed, 54 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > > b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > > index 8f5e5abfa178..7469981fb405 100644
> > > > --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > > +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> > > > @@ -385,6 +385,32 @@ int jh7110_reset_controller_register(struct
> > > > jh71x0_clk_priv *priv,  }
> > > > EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
> > > >
> > > > +/*
> > > > + * This clock notifier is called when the rate of PLL0 clock is to=
 be
> changed.
> > > > + * The cpu_root clock should save the curent parent clock and
> > > > +swicth its parent
> > > > + * clock to osc before PLL0 rate will be changed. Then swicth its
> > > > +parent clock
> > > > + * back after the PLL0 rate is completed.
> > > > + */
> > > > +static int jh7110_pll0_clk_notifier_cb(struct notifier_block *nb,
> > > > +				       unsigned long action, void *data) {
> > > > +	struct jh71x0_clk_priv *priv =3D container_of(nb, struct
> > > > +jh71x0_clk_priv,
> > > pll_clk_nb);
> > > > +	struct clk *cpu_root =3D priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk=
;
> > > > +	int ret =3D 0;
> > > > +
> > > > +	if (action =3D=3D PRE_RATE_CHANGE) {
> > > > +		struct clk *osc =3D clk_get(priv->dev, "osc");
> > > > +
> > > > +		priv->original_clk =3D clk_get_parent(cpu_root);
> > > > +		ret =3D clk_set_parent(cpu_root, osc);
> > > > +		clk_put(osc);
> > > > +	} else if (action =3D=3D POST_RATE_CHANGE) {
> > > > +		ret =3D clk_set_parent(cpu_root, priv->original_clk);
> > > > +	}
> > > > +
> > > > +	return notifier_from_errno(ret); }
> > > > +
> > > >  static int __init jh7110_syscrg_probe(struct platform_device
> > > > *pdev) {
> > > >  	struct jh71x0_clk_priv *priv;
> > > > @@ -413,7 +439,11 @@ static int __init jh7110_syscrg_probe(struct
> > > platform_device *pdev)
> > > >  		if (IS_ERR(priv->pll[0]))
> > > >  			return PTR_ERR(priv->pll[0]);
> > > >  	} else {
> > > > -		clk_put(pllclk);
> > > > +		priv->pll_clk_nb.notifier_call =3D jh7110_pll0_clk_notifier_cb;
> > > > +		ret =3D clk_notifier_register(pllclk, &priv->pll_clk_nb);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > >  		priv->pll[0] =3D NULL;
> > > >  	}
> > > >
> > > > @@ -501,7 +531,27 @@ static int __init jh7110_syscrg_probe(struct
> > > platform_device *pdev)
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > -	return jh7110_reset_controller_register(priv, "rst-sys", 0);
> > > > +	ret =3D jh7110_reset_controller_register(priv, "rst-sys", 0);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Set the divider cpu_core to 2 and set the PLL0 rate to 1.5G. *=
/
> > > > +	pllclk =3D clk_get(priv->dev, "pll0_out");
> > > > +	if (!IS_ERR(pllclk)) {
> > > > +		struct clk *cpu_core =3D priv-
> > > >reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
> > > > +
> > > > +		ret =3D clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		ret =3D clk_set_rate(pllclk, 1500000000);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		clk_put(pllclk);
> > > > +	}
> > > > +
> > > > +	return 0;
> > >
> > > I'm still not a fan of hardcoding cpu frequencies in the driver.
> > > You've added the notifiers exactly so that we can use the standard de=
vice
> tree settings for this.
> > >
> > > In other words I much prefer v5 of this patchset.
> > >
> > > /Emil
> > >
> >
> > Thanks, Emil.
> >
> > Hi Conor, what do you think about this issue?
>=20
> Apologies for the delay replying, I didn't realise there was a question h=
ere
> directed at me. My only real thought on the patchset is that what is done
> should not cause problems when the same devicetree is used for both U-Boo=
t
> and for the kernel. As long as that's satisfied, I don't mind how you cho=
ose to
> implement it.

Actually VF2 U-Boot can run at 1.5GHz. It will work if the PMIC sets the CP=
U power
supply voltage to 1.04V. The reason why we run VF2 U-Boot at 1.0GHz is that=
 the
default voltage supplied by the PMIC is 0.9V which only supports JH7110 cor=
es
running at 1.0GHz.

So v5 of this patchset won't cause problems if the VF2 U-Boot makes some ch=
anges
to support running at 1.5GHz. And I will make these changes when I implemen=
t
OF_UPSTREAM for VF2 U-Boot.

BTW, if v5 is applied, the patch 2 of v5 should be rebased on the new mainl=
ine since
jh7110-common.dtsi has been created.

Best regards,
Hal

