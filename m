Return-Path: <linux-kernel+bounces-388011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239B9B592A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BF51F23CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD23823DD;
	Wed, 30 Oct 2024 01:33:09 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E60BE46;
	Wed, 30 Oct 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251988; cv=fail; b=Q+MHNVPp6wwhue0autxgWzQGWw3mmpQ7uTs438z+ediXgSuaN2KdrzVYU1HMU1BvWGWbUns/z2xK3WlSXHE2nBpancm63HOajoEei8eP/v2OeYcC8/3ydrI5Qcox0PHSxpdPK/X28WBLTBnXEDXoFYPzndmh8ujw/nEaj9CWxZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251988; c=relaxed/simple;
	bh=NzVwo9ich7e2JfkjwxcY5k3BVihEi8+LZl9jjEMaNUg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tRRKMUkBH3AN8UpV36dbfT6peFP3R1CMtaIfVJR+Vz2yZ9ga6i4DyhphegngRyCFG8WmfHoC3SglyjvPYAgb8AI9vnf5Zv6uXx956D5Q16f+cqXyO9AAyfppT5Tt0kRLGBJNVmWIQAfitO1oR2ryqB4goa8W7kw6ashIWLCLcxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDyiTBUr0FQCfBRNQqW8nSVe81lmP1gGXRfdf8GZgX+aQSMngFhqLUktE69dPMbXBU6rTeJKs0f9XuMmkNv5UxgX7EBY2NeRiX5jenoJXMTXxujy2R+D/QB2DGIIj/1T23dWdcWDxQ6Jq616FdW9hqvCQ2LQ0fOHYOY6OqorZpQKeSt95sZ4uT1LKR7euRZa+vHGLnchs8BPuNvKwFVMy+k73D7fvxE2Sy6tl99cPl3RFOSWgqVnLH1nh+z+WGc6ItBL09SO0BOFjN6/lu8rQmERBML9nVls3LTf223THjdG2O4uFJQcUfip2GyfZq8aF47ddS3IPx4YJG2D0OBT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FGKjUCS/RSuA2vw1ZxKnx/bw5X5XYua+H3ZuKWeieE=;
 b=JVYopqRzqZ++U1yBNva+BIhFnyIqAFLQvwlt6lVc/yKENGNT0q9cqRAhav7J0uxISCFi6hw2apojLDMwsdQYQfXAOFVB7KRvAQ+xr6sPUq/qOEfdYIv4a8XE+dGh+AESm3yx9ZBQSza+dzC6VVo1B4rfwilC8rIQ96izQzCtLX8fcAXMJKPTFdLQ5gb8sDsRczEfhcvTmM6cy7k/R1fVdSIUR5WOomO36v+duziw7zMUq66AWj+5HQjHy2ynSNF9EzcnB09BPMXtJhfTT16DKIDrAeBUIYAjN7bHBLNxj6ndur5URXSt2wquBJqyEOLlho2oNZ16nfayQycyAsrt9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1052.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 30 Oct
 2024 01:33:03 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%4])
 with mapi id 15.20.8069.024; Wed, 30 Oct 2024 01:33:03 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: starfive: jh7110-pll: Mark the probe function as
 __init
Thread-Index: AQHbKbKrTkkKQNBM8Ea0IUaIPXt50LKegdSw
Date: Wed, 30 Oct 2024 01:33:02 +0000
Message-ID:
 <NTZPR01MB095605A72E938ECBE381F4E69F542@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1052:EE_
x-ms-office365-filtering-correlation-id: a2d9e37d-4c49-4c0c-4e43-08dcf882cbe2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 OPowV4+ep4ikb3+rzAKv46O+JnSDeWGuGTcx6pcAnkgAQjEe+u+p1hp4+o2b9F2luOg36jec3y4NKLd9yT9qUkC4nwXTRDG+Rpu5jwM0DKApDVMROTaULF2THeqUxW31FcMnB1XwnpHpEsaXmxOAzRf62wYveFKz1LV4bLjXRUhYdGKjttm7sNN9GPdhwAKiIjjCTqZ02Kk2RounQdPsKkvNknryCQyyQa4Pb+bOuBLBeb5ffxzsF3AR1U01zP4u+WI/d+cX+Nw1A2AEn66Wvsclia4Q0sXabrA8OeWC1g/r1QgoCn1461gcdCu2pQA7h1ek0xwewozttapuITe8PJrz21kWyscscyqQ0VqpxKcp673+ll4WzDYjfUcnSAsthItg8wAB1Yz3MWYvp8PJ21BBi95AvSuTEQK9DariKbJ6ar5zThXqFfP5Q1cVQSfG2/AJgalWBCsSlZDlXhFCK46xjuUupx7dzcCjSeCl68+mHPqgrGmfBsk9a8jc/rmI4nibhU9ZT6/m5xVVvSjFjND9pvCaSHH4bn57/7G6+52/bZcMWU3YQBlyv3BcWdl5D+UmlWBfcKJzpL+3IYk9swQ/kgoQSvX300XYdnp+5nYKrG8OQlqUQvaPyR1d/fdt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CLjPoldroc+XyqN7dNnceHRjtepcfhx16auAKnA9MM77uWXtw0JtHK4Xu7rM?=
 =?us-ascii?Q?JixgHoIEzqE8dTIhLnfHrnmWOtVb5fS2UwyJCbT3vvfqNtc295zxnMARj50c?=
 =?us-ascii?Q?fobmEuhKp/rUAsUeU47ufOAh6QHys9xenrhkub/93mA30pr823ol8W1gv4At?=
 =?us-ascii?Q?AnyAubPKLW/1ZGnoxVsFu9bjhu7eXUFj2tsu475d6oVhRfGi9eSekyePk0KZ?=
 =?us-ascii?Q?4sNm452RC6ZZ4+7U3m9sJXXYc5BTjIXvYNbG820sYMpLdpHKIiOMhgyrVc34?=
 =?us-ascii?Q?K0A/F3TMTn9VZkb2jV14iUYn8eci/415i+WD5FVacyRSt8czgu9slLHwmSIR?=
 =?us-ascii?Q?90674ih3XgNxGU/MZQQkKtDFgkv2zb5bY8bmVNyxcCzr6jJvaitLZ4dyTKsP?=
 =?us-ascii?Q?hCAVnDq2t3cpm6S6ZeoSly1DS9y20bEfta5O7fd04eFHlo6PPEgTMc/gb8zl?=
 =?us-ascii?Q?mRKBDJ25lOJz9vSxQ6KmFhsLHomwj3G+V2B2y5Whf0A196brSgWviCWeZrrK?=
 =?us-ascii?Q?6RlhLe2DJTw2w0HHn9GGhbUVFqeAup+thpj8rcFqld7EzTRLJ6bZRfNJawb2?=
 =?us-ascii?Q?2Iier4L0V3t6UP5usc3a2OnOy0m1e7Ofz/yXhq31yT11IrG1tYr2Jf7A5BJs?=
 =?us-ascii?Q?q05A4FH1+fNGTRrBudWHtObstqUQenMr/fVJj7uwvzCmTaN6lzPcwBpsk4AG?=
 =?us-ascii?Q?MNHcwudT8lSCMOAz05xkDTEqU8PF2rDfzLa1L+Jy/Ogh4HbZ7OHlhyAqeLRI?=
 =?us-ascii?Q?b95C73/D5V9sbhtJmxgsEsGZ7EgMqMEuKgDIQmRlow85ApPYLJHhRVA+QXQJ?=
 =?us-ascii?Q?kVKoquEj2Qq1Rkv6Y61zXrKTA2sYQ00K63wBUV6jsSurvr5fO4gDw8M66V02?=
 =?us-ascii?Q?JN8r54wladaKMBLw14MNeJm50Ggj4ySOGY7bWfCeeCP30VIsnT5Naiune1Xn?=
 =?us-ascii?Q?DXKtoa4HxltbYvHAt2OAITFeutQO7pRlHCIftVQUyYv4N52VLrukvZ4EoUKF?=
 =?us-ascii?Q?/yRyrMJHEj1OW15ixgGAPed26NpHrqMKVLjeLg7Aq4cfPk2+9cmoF385xylR?=
 =?us-ascii?Q?+QjDwXfHV6tdAiTxKjp+gK89++3aUFh026avPeiyxdG4KW5Br8bgc0/yDotc?=
 =?us-ascii?Q?iT8kEEVXFWtcou5C9YamTHQnm/7gUvmG9Q6zLte6s1D38gtuPbd8p38Vh6tj?=
 =?us-ascii?Q?9vE1Oz/toG8yUyXavXhfFlLvCqxANv8cS7xlD3NVjtmVLOJCmdYSP8qYZH4b?=
 =?us-ascii?Q?fzNPuInO53NXNo2FRSdWAmdP0YIoD1+x6qe69PQ2uXaT34xYNh2AYRQP+eGM?=
 =?us-ascii?Q?DzH9NqrFsaMaG8o75WygQ8NaMAmDISqQfAIp6/Pt8dl2J93PLHZTG3Tu0DRo?=
 =?us-ascii?Q?5tXgWfuwLclOqaPN5AL/d2/dhmUIM3DTLnamK+4T+N/0D3835sQbC6pmwxUJ?=
 =?us-ascii?Q?g1VZBNMz/bqqhTIqFvLMnBPQ2G5n6LHkYmyKsELN/Mfl+R+MWSE6NBweOzza?=
 =?us-ascii?Q?Gv0cp2GwQbZlw0ngJnPx20A6M+S+mnu1run8FZOazi/POIi4d4lL+BUMxwP+?=
 =?us-ascii?Q?THCnivErca4XCvxbOdMcetTY0Lxlli60Hmoxypyx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d9e37d-4c49-4c0c-4e43-08dcf882cbe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 01:33:02.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wapdls8ah+RvpNMgSqpTzgLYg+JXP/RVNecOyBkYXoIB3SpAZBN5YIHUENNSZLkJ98w5sBmXUkBnoEURFVSj2W4CoFeJcVFilSI3YM9PIDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1052

On 29/10/2024 11:28, Changhuang Liang wrote:
> Subject: [PATCH] clk: starfive: jh7110-pll: Mark the probe function as __=
init
>=20
> Mark the jh7110_pll_probe function as __init.
>=20
> There's no need to support hotplugging in the jh7110-pll driver. We use
> builtin_platform_driver_probe, the probe function will only be called at =
startup.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/clk/starfive/clk-starfive-jh7110-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.c b/drivers/clk=
/starfive/clk-
> starfive-jh7110-pll.c
> index 3598390e8fd0..56dc58a04f8a 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-pll.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
> @@ -453,7 +453,7 @@ static struct clk_hw *jh7110_pll_get(struct
> of_phandle_args *clkspec, void *data
>  	return ERR_PTR(-EINVAL);
>  }
>=20
> -static int jh7110_pll_probe(struct platform_device *pdev)
> +static int __init jh7110_pll_probe(struct platform_device *pdev)
>  {
>  	struct jh7110_pll_priv *priv;
>  	unsigned int idx;
> --

Reviewed-by: Xingyu Wu <xingyu.wu@starfivetech.com>

