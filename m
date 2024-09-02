Return-Path: <linux-kernel+bounces-310661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC18967FC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C491C21CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DE415688E;
	Mon,  2 Sep 2024 06:57:13 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2106.outbound.protection.outlook.com [40.107.239.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A4136982;
	Mon,  2 Sep 2024 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260233; cv=fail; b=TqsOVhGwz5M2o166m76Z3R3gYkstwlPe/G3GG4SJYLA24OQFHlJrVhdx+v+LuScqj4VWq0vcM8EPy0ftdGzfy6WdAr4wZ6x1caKwSRz0sxpFhRx8QHtrWIptlIziESwAWdKsefdarAfFEH9flLOD8IgkhOjjxi9Lhw6vJ6lEr/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260233; c=relaxed/simple;
	bh=gipFjs8I578Fk3Hvq4fnhi3/MXUCk2jEUcdexyB+WAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bCkH0bQu+0e/X6Da6+SAAKNKhO4muGwDPxcAqzKJdQbMYEefZia2x1JH5JlEaLIpq+bkvBt2DY/7Fgg+Xr5X5XzhJ+3r3myY+ZoLBPRM4ewLtOpXfe6GaZ4qij4ISQzyRPV4r9aOMjs9M60+UNu7teTERTqrUeal2gc00hsmFKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGz3UJd8ij0PtTm3n0nRh1n1dzjSpwn0se9VjEQ2EBBX5/0MGaFbJsEGfNz98KFx1WFxGAqkx3RLS+fAR6wW7i7CIxP992LLvFUBd354+6EX4Z59B/33GFuUFJdF9x8RMXmAi2V1KKozo5aEel/hnl02K6f/iJDn8vsmfl2K+0pmdQMVXLIsYfVdOEiXzt6KUpO2ekgu4Wz6VQfdf/gUOPEMrTp6OvbRCsSHYcx6r834Wma2ARuY5UYwPYX3IUyHSsgICq/ZxHJzwFVMkGl0taFVInMnzEfUhHanlRyDM6mCTUowjUp2/oUH2k+EhpbDHofUPvSlZNasCuSHjDH8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9doCRNkCv66qKnQTg5pwZuh1FigO8S9SsSkRdd6N0nU=;
 b=Nd4vYFmwZGdn1NARjz5+XQcsFnKLbxY1JtBksY9y2mIisXOKv/YIMStjRFJ45u3OimHt0WttDWEx9BKwiKLRcP5dX2fP5TAtv6oreO1V+tUuJH8JAtcwTVf8anVdawobVrYKzcphTp9P9rnPJhVbQhWebxkqvr6LtzCRu/7EY7ibuHcJABk3wbLGH8soahInAdUCkVTToxVbl+Yh12UOm9h0eqiQ2IPtcfKsV4TDmBruVoBXOAX/Fih8RmSJyXirhcQ2sovQ6IMq3vcSrGOUhjZ8/BjRJG6MPfqVl6zFTklB4Bm6HseUcf1ojNiOrDdORttGnv1vkIcKnSEZ73CQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MAYP287MB3612.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:57:06 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:57:06 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] Add support for Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Mon,  2 Sep 2024 12:26:01 +0530
Message-Id: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|MAYP287MB3612:EE_
X-MS-Office365-Filtering-Correlation-Id: bae8238c-1545-4390-ace8-08dccb1c74ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APmtYv9ApGjIJvW7k41jJMny6sst2ch/53ILWQtyHiSF//RI97BEQl6QF/OY?=
 =?us-ascii?Q?eTg61lvv1k4JGcaBZPa7DzbCxlSiJ2Hy9VarMsYBRAQntvNWzc/6N+b+2rSu?=
 =?us-ascii?Q?vlDtxb6dX7jRdX/EBV8hpBKA2VGTuW5XWssYeIWYq+sWyUjvESuF4MVqlBvH?=
 =?us-ascii?Q?NDvG5IRk8eK5OmLwx6ZCYwX1/6EfmPIvKjHZgLHh0U/VM7UZOTS1cYN7+54S?=
 =?us-ascii?Q?QlxuGGv+g/9HhRSImVuDB+NXNGUmp/jZ7Zc379tRHxPfymHRHfguqoeXr6Lk?=
 =?us-ascii?Q?6iYu/i4Wu88A7cnltuyM/PLjrf2byrhmxftl0RdZAFRwle642u4zO18Ny1hE?=
 =?us-ascii?Q?qnEE+XTK3Vu9+tE+fsrIdVTtEaIY05YdDFazjOfUy8BrvDaatN9vdusJel31?=
 =?us-ascii?Q?9bqfcygClcvjxRy8bIdtDcPQsPOp7sHvoQS0qdFSe6ogbC0SFb8sPxkpwnu7?=
 =?us-ascii?Q?6n0N7TLafXNtlwnhtT5DoyiIIcbvY69fhPVG3qQWrtMRMB0Rhj79P40LERIX?=
 =?us-ascii?Q?YGO6b2IKYqUdpvdNE7YMk63WAtIzEcpFcTjK8O/muCpGlWHYxa9u/8cgnJwA?=
 =?us-ascii?Q?JT1Fl37AHb014B2QtU5sqSJP9uCeG7b2g3k8XoBEvqn/P+FqRhtx9tdsVu6J?=
 =?us-ascii?Q?RpJnwGDbTS2XOmiSGHavlPr2GJXXAx0Htk8ffZ2oQkT1CGHDLLE5iBa6XIDd?=
 =?us-ascii?Q?gHwUA1Xrtanp8y5j8dzU2UFv6o2h3EcRsY8R7ynedHv1ls2hTtJ0KB77RNw6?=
 =?us-ascii?Q?5m67KFsu+3lSFOlMZHk9/yp7jTOeh3lSskf2V292I4aV+N9/fCL1wViSdUeg?=
 =?us-ascii?Q?umDqja/KohoRGMmIeL88gedLn1f9jt6+mTPV187uOfW6AtGOKsiR2vOyYLZ6?=
 =?us-ascii?Q?EZ2KQaL06JbE9tncj39hcKB0GtvPKU9Jjt/VHnu1EP7CqBp+NcWMVUz6JnY9?=
 =?us-ascii?Q?t0/+liQJm8WLE1ZFGlzk+m89xBOsZgsEzNw5nbkNsWap+eVxIz5JNdEnSovI?=
 =?us-ascii?Q?9rJHFwQaGMMMLtD3kUdmLZK3qt4OmOnND59u25NpeFmPKFweZuRUDRRsnvTp?=
 =?us-ascii?Q?aEYZVbtNMXQFLvX53BlAOVRIVtlWrOGR6Nwvczac+qVYZ9vPc9LdkrN08m9t?=
 =?us-ascii?Q?vGK8yABH9Wu481HEcxO8ETnixQG06cEWI9fyjkJ2xf0SBY8HWH6LpNEqoZKx?=
 =?us-ascii?Q?4wpiaszMJVfMkaky2nBBs8d8QBsg+Ua7ZmuonU9K5ow3Tf4pWJLSklaq8MvL?=
 =?us-ascii?Q?sEKDLRzADFpZ0Dyix+pyhjRVE99Xh9vEUjIVfxikJ82psIdTqI0Mm562lRIs?=
 =?us-ascii?Q?6PN9OdE5SPYO4hmDDO/Wuj84ywGJXB9OCB11ZFatLN/JlDmuNpkaCW7kCGTF?=
 =?us-ascii?Q?POEAMymwh/Fbt+87ViF9x8RasWRck7Y81MODoZcFKLzrWg1zfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tu3RiNH5gJBDa2uDqe0/QHg9m6LtoxduSwLTl0OkxycUcPhsor5BAHFAPZD2?=
 =?us-ascii?Q?uqkyL8xd6vD9PkCCn+Lr4NO4u3i91TLjJBn17V1k8/ATMb+YQDB8f4oklrNs?=
 =?us-ascii?Q?qyR484f1JTIhKa9dwR8OX+jyTjxuwCATfcSFYv88BtofQYT1w2g8JN9TAonH?=
 =?us-ascii?Q?wW71jpe7cpibguoe2S5JMWbTfRcmdqcAxjQAGNl6zxUp0xstUe+AfPwgir03?=
 =?us-ascii?Q?eythJ0QIsy2f6x0ndtvAnQkkgzn8NQ7zdApMu/94DWc2itXZbyHYHqNx2i3X?=
 =?us-ascii?Q?DGHL+KlbGLuSpHA0zK49sHoriJG3dOlOCSRb2uMJAez+lVynIOOnNhyW7kpG?=
 =?us-ascii?Q?HeA+LE4ipRfJoAHxPjlQPMr12JqP84YlczTVdMc9UL1ybCLm5ro3U4N3g8aI?=
 =?us-ascii?Q?nQW0/9C0kH8so5/GXnx+0ZiMKincCGefv9byz+08UNi3aGEdTKmigvfyi1VC?=
 =?us-ascii?Q?NUNOuqvPWc3R0yVR338UR81ZR+GcKlZdR0p9QINUKd7g9As2HWTfJrozkHV3?=
 =?us-ascii?Q?owKbxfu+X1CaMPELK5dj1WYZGK8PzqtHgfEfPYO/6cM4SGDh/0kiIiemAgeQ?=
 =?us-ascii?Q?ACk/w6uUC7HmZm36WnOjnaGTyV6gO8otkTKopkANBdPHYdefbeuG6Gwih9HF?=
 =?us-ascii?Q?hbXeNoejHNcv5wWqqMG4Xli+wLrDG3ez765AmYaMuptUu8FqkgEDgz4AXztW?=
 =?us-ascii?Q?o8mLIqCd7RkhYVlnLCmtYaohUa0puWAvjY+tn6oPpQXX4k55Wxmo7ISOTVKP?=
 =?us-ascii?Q?ri1MMLW+Q+VOEiqxtWU0xuj7tUk9NNXf0kjnXypD3AWh3AaxSDKxy+kRNGVl?=
 =?us-ascii?Q?/wCudDHielezW1ZsgjztNf/petWhws4goVLHop8B1ir38+Jd7uRU1LY9wFTf?=
 =?us-ascii?Q?N2LTZDY55hW0zUqtQd5folkoD43QGjKe61Fb1COAb7PS0KSHjaEIxhW6qxYc?=
 =?us-ascii?Q?VA2H8jYj8PMBtQuw7IU7nw/SqjJRCgnPmX2aX3VafoEX9vPq5Ekcp51eXQMO?=
 =?us-ascii?Q?VKbeYyavxg/h7+Qtw7zYfRahPYIcSBTogucMnW4hg/Oa6JdkSfzS+BAjV66n?=
 =?us-ascii?Q?/1gLYZZj7KSgKUU2V9EG4YEgox0zUYNfKP8DUhgSstvzkLUvL0V2ILzqgxKk?=
 =?us-ascii?Q?Yri918QVCRFmlMapDccQQ8o55fi/60qNLhDnlc+bB0iYvnL05UHpWGamT70O?=
 =?us-ascii?Q?YuxvnThfbW3lF5+meqofo7KYFbRjmrQ0mjiALni/sptMXn/eH5vgmjS6kty+?=
 =?us-ascii?Q?QKciFASEcd87UywEIuj8NXETnZKv0jCLWeHlOM2o5iKWOo/yjyX5qwuf5EKM?=
 =?us-ascii?Q?NDtAwC007fY9boE/k6leghwOd1kVY6N7215l4Tq7GW99s8PV9ppAMMCXQ8/B?=
 =?us-ascii?Q?QDRd77lmYdS42jvP2XPh08cpudv5m19gEplDcg8XOqz5Ktuw9Bm/tTbhSWBD?=
 =?us-ascii?Q?VBIrHe9Bo/2o09cnUP2wsh7OVCDxBK8UPrm7mTPbUikUne6jxXkBqUEy79l/?=
 =?us-ascii?Q?IIGVnIQTcfIaQjyvAolPzc5/gaBnCZw1pEU9dUXbJ4am/K6FDFmLurFM1Yhd?=
 =?us-ascii?Q?RrgYxnT2We5i1NiEBP48ZP2DIniGOiEJvK6KFmfyreRPUdgaI11F8IhjGCRw?=
 =?us-ascii?Q?zF7hSbuwOoXzur0g/Zp5pq4=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: bae8238c-1545-4390-ace8-08dccb1c74ca
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:57:06.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bw8X5oUxP1DGon7u+mFYjgJwjwqulCwwlVTVOFY0Jj++4QgWJWAPcdglIV8Au2MMautu6k+CyZ35aWJuryevzLPL/qEfeaw3X+T34psLb/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3612

Add initial support for Variscite Symphony evaluation kit with
VAR-SOM-MX8MP System on Module.

Change in v2:

in patch 1/2:
	- Removed unnecessary property: "status"

in patch 2/2:
	- Appropriate board name instead of the SoM alone  

Tarang Raval (2):
  arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board and
    VAR-SOM-MX8MP SoM
  dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX8MP
    SoM

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mp-var-som-symphony.dts |  11 +
 .../boot/dts/freescale/imx8mp-var-som.dtsi    | 360 ++++++++++++++++++
 4 files changed, 379 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi

-- 
2.34.1


