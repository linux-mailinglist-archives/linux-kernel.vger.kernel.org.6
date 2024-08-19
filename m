Return-Path: <linux-kernel+bounces-291924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E979568F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA85B1F226DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B9166F31;
	Mon, 19 Aug 2024 11:05:42 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2127.outbound.protection.partner.outlook.cn [139.219.17.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822F166319;
	Mon, 19 Aug 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065542; cv=fail; b=GjVZX6fZ7bAmvW5n59lL418wxWqV/nOa1teuSkiYLhqbs9K2A9ZbIFdhto9LTAalrMNpmBgK7zTto3aFzN7EXRVIiQ32mmIE9rqySYF1YNDLlHBujgUhDz3DEFQyuG7pgVIJIb1fIUUsurFG2SEKs5p4l5blAuWg5yuTJ8rGR5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065542; c=relaxed/simple;
	bh=XkIQcc7FBhcOziS6vzgCyoQHV5TtbM62ahR9MLIiJms=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dm2H3Mm6uXTnPcPFWTwbKZ2ySwJkG0bAz5pOA6wMvAoPiNkrck04+evqp31qaVuMgZ5RO4qUtX42UnbNelg4vYTMMg5XWNtvJG2Mw2VVSq5EufJGwQ1fAQFeBNxDffJo4R3gEj/ivsn+GoCTAo9/n6A7gpHMGci9vxUuc/xP3+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6ivFgf36ohQWsjmqbZpy0PuaSsqjTQ7VK88DCnLp19k0L10ekVRHUcql5D0ZlwycaiSZcaCIanEls8eR12jkL1ZM1WfRofCku8q6tRtIhOKJhSuv7ClzDIQ+tB7NV3cOnWf9DOPpL2TKeVZmS8wQCqmo7LzWVvxkzeE4BY+22LHf3CfMXtrvEO36HVScJYC27uEbm2xjaRf51skfp0qbaoLojpxELKwtxIP6000HqsoyRIzqPFp2CAkw9Us6lfh35i/yN8Htlb+V39ukxfAtj/iIzUz9TXTgaTauul+En49vymY/3eHEH0RsurobMC/g+flJSbdqe4v1+2G5r3w4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSNE3Qb/8B4lAuQPe0wjiuFdSfNHpxo3hqVTPicN2ug=;
 b=aX8/6T5BQIWR+54jjj64yVVzLkb3Fne48BDuJ2Z2/VE9LzhtT1bE5ycdCYAfc1wVswPxh3LRtKNkv328NwW4UtdcJLv+tdTZlgqBN6+CxV/ut4R17tEfAaUfV3PjWRepr194Oiw5i0Ycp+dfIGRbrHWjLjO1FktZfEwLzxynOnRkIuBb6ztbP+MUSZTuctXAWoZCOXsu7Z5odAgL4DsiA4scG0MT/raPt3hEeH7TZ2ZNr77wT7Sz8/HgTyiBLuAwxwaoNxlaLSfvJ4/59f8dmc9FweabqRydQGOOw3FjlacAQK599MrzQFh0C4NlV/YSxs42jsV6ttE7W3VOyAFvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1115.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 19 Aug
 2024 08:30:19 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.7875.019; Mon, 19 Aug 2024 08:30:18 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Yuntao Liu <liuyuntao12@huawei.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel@esmil.dk" <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "palmer@rivosinc.com" <palmer@rivosinc.com>
Subject: RE: [PATCH] clk: starfive: Use pm_runtime_resume_and_get to fix
 pm_runtime_get_sync() usage
Thread-Topic: [PATCH] clk: starfive: Use pm_runtime_resume_and_get to fix
 pm_runtime_get_sync() usage
Thread-Index: AQHa7vf/KMDE+QP350yAZxN03ppp1rIuRH/g
Date: Mon, 19 Aug 2024 08:30:18 +0000
Message-ID:
 <NTZPR01MB09564D3E3AE489D9C8101B8F9F8C2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240815093853.757487-1-liuyuntao12@huawei.com>
In-Reply-To: <20240815093853.757487-1-liuyuntao12@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1115:EE_
x-ms-office365-filtering-correlation-id: dcad4372-34f4-44e3-b323-08dcc02928a6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 oexLGvF+ALeT2s9eWzCPVB8cacAO/w+JDvUGCgaeBfw1518UljXs3xXziWUrnoIpm6b33SsSSKSPWSGHLn7DV3vWNrEqvQEpAzFpAhDs1yr+qRLPaeo1s/5e5bafm59CeS8SnI6YZ+kL3n7iyNa2XWqMSsQCsZD45wJwjuI78qtf/4zLPg3kDO13Gc++Qi/x25gFnxlYgE906C/C/dvHBwFPx2Yd5GeG31z6YIC4A4p2zVehyvj4LEXVOswMRv2FTIACXpyzmqH7TqzaCyeO5hJLJZHTg5UOF9EG2NX36Ganm+/d92bRN/SaQHOtVzYSGV5lM2m9djovss1F+0yX2rWWi+dlVmF29pAJBEo+UVGDsOXpTecui9gv0Wa1klapqg4Bgtt+/LYelDmZMXyhzqK4JEJQ2/fo7jOsss0pxMCaXepaq7ptx6GiBXh7FSFEQVtRgT9LVlacLzxL12504vgMXveI4nYTnq98Lq3CQPzDJYs8HKACfYNiJzitjHngEs45cTD41IrnMv3qyLt5yMUjIiixPN7hbOtdqYcKTROX7Va0Qlq7YLZTKypWrNgoUmhRlkJk3D2CYAjBik5YqGBl3doJELUJhWrfM0ltdMG9yufpbmBP9lMRVX1pbKdG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z/N9fUJnQFKXHT6OnL2CkZ6+bYwEJA+nW6JRFC5sy7abPkfcUCggNLtWPMMu?=
 =?us-ascii?Q?OCdtx2OhwfoJbSF3t24n4P2giQYb3pgyCq3UkrrX5HcmVnhkTdJfqEvUV6Cr?=
 =?us-ascii?Q?qkZ6P3Kgjpp+YjqIzZUYz/S5/NE6+LZfzGrkbmA23dDydpLGa5i0klM+eAGi?=
 =?us-ascii?Q?XSt7yoJS6t99enfqXTQNUG42vI4o0MaHSwFQJf7RivGasWV6Gh7XaTGGBtHh?=
 =?us-ascii?Q?TfJ2l1OY3qYyBTJj5ag/+WTBMW+P5DFjw5Y/wq5F4nltdOfrJEVhIpky2VXb?=
 =?us-ascii?Q?oNaifIpCWaliucSch35e/r0u1/O3YUXvPifbPMmRjJH59Ctt9h+ceZVyItla?=
 =?us-ascii?Q?CK/q/fEHUvasXXBj5l7/In+T7fnRzouSw0vA1t9/fLgEh8b8To7dDfyY6Mtq?=
 =?us-ascii?Q?6xKpfihqmVsKFb+TR1Gclxod+iZ+setKcnz3I7djXJWjHePAo6i8/wEvDvJY?=
 =?us-ascii?Q?A9WHN5AYGXBSmut/ZmiHreuGy2FCPs7vKNSndlZflQ0S7KDjS7yNCGv7kwAV?=
 =?us-ascii?Q?HRW8Dsr40+EWZ6Z20KeAhb12pkt8Qxi5C4e5Al/dZuYO9NzvtiPnY94pfwWv?=
 =?us-ascii?Q?9bASqU9frtZqNMlCs+Q4XU1fn1xM6gnOYmEoVyneU9/So7lyuzpfYdytM/OA?=
 =?us-ascii?Q?gIERh3xeAy6tNcyglYGKCLZrY5RfcA04nPJoiIGI4mHIXrhahNVTtCkASy7c?=
 =?us-ascii?Q?faz5NjbEPnpBJuw0fbJ5DE5HkgUQrgOT0GsvQbo7P3+WJHSBEX/mgUrjRYst?=
 =?us-ascii?Q?I2AkgzArW7fzEpqtMt2wOjaGHEf3k1kWHpIo1+def5pjmnkYQXBJokNh1mbE?=
 =?us-ascii?Q?d4YTXNfwn45S1aNGoTVGl2VhELV1vM14/CyWXALuInopp3zVkzt11QkvKW59?=
 =?us-ascii?Q?w4O1GQ7UcNx7ah4/JFuzEV+2aLy+UHBVqoP3BU34aOpX+uuUmPMM8k4H8zKh?=
 =?us-ascii?Q?oJZmnc6kuM0O0vO9ApwJ93Egq6Rhhv+sp+CcPzOGvGVDsjPbh3H27+I6Cruf?=
 =?us-ascii?Q?oiDcDCwa7tuv5QgBAQG0cA0aA0DIdU7VEK0xobmnYbmLEsEEdAFhuXPg16Cg?=
 =?us-ascii?Q?ds0xrN5Z+ywZ/aCHaE+EHuWpL0aE8GqBfI8N8f1EUNKa43L18qqqF+bcan8+?=
 =?us-ascii?Q?ZSvhsVJQZqRZdgZUslboKeJ1XVMaDTLb5guGG3lnkQ7lrj3nbSrvIUsu7LFy?=
 =?us-ascii?Q?c6GEASvCpWh0dWzUwshtEiwJSNhF6Txy627Nh4ePYdUncySlxp0RvKKO+CCK?=
 =?us-ascii?Q?YeMVKD1v6H/nbNr77FCFZI7G5ABi5QhRpNlv82GfUIAZKNgkpEAJ99n8YfuH?=
 =?us-ascii?Q?u1Z2h8i1s61lw5t53mUEinuufefueqjZM417xKwxiXzEBHIPQzl4+Yam87w/?=
 =?us-ascii?Q?Bg5prGhnDBcfGwyBLDFIK3+Pwx+VrI3fERtXbcI5KQNtc5Rb/JoI5uBaEMhG?=
 =?us-ascii?Q?FZmBoqs3/5+qofsPdVtTqzk0THFziSNTCNBZbWifUP92L8tfJmtq3FQgxne1?=
 =?us-ascii?Q?DOeoPngmLLfmCIFHScAyqQumknMliiiZZsAyMukFeWg8CFNYWlxZHdslUcML?=
 =?us-ascii?Q?6AtfqXxPkXgXCPy1xOi4/ydBFUlrOvbg+0ECPX4l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dcad4372-34f4-44e3-b323-08dcc02928a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 08:30:18.7639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eQUKP0yRASaR0YUrhCQZGr7FpfGNiFw3QIcU3bG1Zlc385d47OV5/8gNl2A8dJ8l2b1ADqjLwLdwx40urv6H9inTwuyoKu7z/Dm8HMPlzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1115

On 15/08/2024 20:19, Yuntao Liu wrote:
>=20
> We need to call pm_runtime_put_noidle() when pm_runtime_get_sync() fails,
> so use pm_runtime_resume_and_get() instead. this function will handle thi=
s.
>=20
> Fixes: dae5448a327ed ("clk: starfive: Add StarFive JH7110 Video-Output cl=
ock
> driver")
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> ---
>  drivers/clk/starfive/clk-starfive-jh7110-vout.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> index 53f7af234cc2..aabd0484ac23 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> @@ -145,7 +145,7 @@ static int jh7110_voutcrg_probe(struct platform_devic=
e
> *pdev)
>=20
>  	/* enable power domain and clocks */
>  	pm_runtime_enable(priv->dev);
> -	ret =3D pm_runtime_get_sync(priv->dev);
> +	ret =3D pm_runtime_resume_and_get(priv->dev);
>  	if (ret < 0)
>  		return dev_err_probe(priv->dev, ret, "failed to turn on
> power\n");
>=20

It looks good. Thanks for your patch.

Reviewed-by: Xingyu Wu <xingyu.wu@starfivetech.com>

Best regards,
Xingyu Wu


