Return-Path: <linux-kernel+bounces-304274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D4961D11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4511B1F243BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BE913D899;
	Wed, 28 Aug 2024 03:41:03 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95820200CD;
	Wed, 28 Aug 2024 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816463; cv=fail; b=C5BGX0PwfD2AkOnBNC82cb4FVN7Cb2FM5vgkHQ7p2I8tEnrUKKwcx33b1zK73A51qYoXadgN7wB6VxaGy2xwciSl3x2cc5iw2UFJ8ZLZB757Tfr9swrOKl+HGWBJpJgigu0AGyI+vcoXks2QR1AlM7MMa9o5e/3yEI1b4AJaPzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816463; c=relaxed/simple;
	bh=PEGrCAGovNh9qzxlK6lVpl8kENQHQlvAGf3qit9UgDs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jPZKkWXNTTCpp57Qj2psBCIT1k4zfQ0/MEvFzkAF05ATJ5i4QO9IdKqFRHSPoDxdSdhBrGO7NStz+dEABhhMY8oZ8Q3ozWyNSGjP+sd0/BtNUbsQPjaGdpWk2NW1q4rhxlxTo0MQTvkxJtO8S1VvPrYWt5A9fWdjqLj75kDw7uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9c+JjwaQPBzewcJAMRkQfQoaGaASe/DBbYgVMOHCwuxm2U8b8lJ1TQHCylVlSPB/x+Mio0g//8S2GxlXyUTymoWbJBR1l5xWiUKHllBfsp+GkFPcIOglOFAmw7OJsdeJVW17WcGEYw5ruC3/ViJ9zaW4ZSdmHUOO8HwejlqUinoK/W7q+QlQZj8aThpZfNgN0rJGyHWAH3LAvozdjkKRUVM4Joi1hIOM6kDOLk8lJFbxLzF9/i8Srulm1c2Q3pDLq9Nbu64mmmRCKK14sTRc8iKR4EvUZ70Vc523YvcH44H5t/y44cVU/2bGu+oAIUKnRcTBhyDwPSDteyqU0yb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55ZMJ0XhOGKYl4gogAcDRDyFX1J+vQgsta98Oelpl6Q=;
 b=akB5v7lihwyyfimNP/IJKkXnPo990Yg/OYmbyFw74Khw9ByB7oprO7UQosdPAkBjwP9Pd7nF8/Vu7SCOyvI8YgBVer4hkiUaIT7FLD6GhqJuVGGguS+dDXu9g1CI0WFVrbo+7xPCcG7lNWZxzMCWwkajD/J8JJJB79bSeUiWkcxlHSdYeWLMJYCP2hwAoztH2ZVDgZbDlfitLju5f8ybkAA9EX2I8JFeSYjhKWk1Az+dEGlv39aDXAM5dy2OVmVBJ8eEK9cs/Rj16UIFL0BJdLU7ukNr1AykQ5COfxsG40U9M+eKLeFyx9/Hh5XbsZlyJ7g8M93Vuk80SMERoKcN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7977.apcprd03.prod.outlook.com (2603:1096:400:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 28 Aug
 2024 03:40:55 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:40:55 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io,
	robh@kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	dsimic@manjaro.org,
	conor+dt@kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v12 0/2] Add Wi-Fi support for Khadas Edge2 and fallback compatible for Apple
Date: Wed, 28 Aug 2024 11:39:51 +0800
Message-Id: <20240828033953.967649-1-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0185.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: b73c19cd-5eac-47d1-26b4-08dcc71338eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AH/mKlB6Tgw8fbFSpH1zpFuC6/pR539GXtKeuBNuoUX4oyiCk7i2YytnaBCj?=
 =?us-ascii?Q?CVGjN5sJKyLVZaKtFBggQm53Vzy9UbrwxfkJ4R5+fXaSHjDEqCXs5Ew59QP+?=
 =?us-ascii?Q?OmTHGu8rJ43AIiqVL5j74WUdm1u6HdFrUMTGAZb5EAbNTLyUD6vnt+2Icf1J?=
 =?us-ascii?Q?HQLAGMF6KjaAOoeVeCPf1BlUSVlZ621cKsrTuuT/EbVWMJkYzw865fGdTYce?=
 =?us-ascii?Q?6gkITUsa0coRhn5QU/BKID9k1mhjDXfa+dCm0i/bu6nT+SU7ucNqj/lzPbTR?=
 =?us-ascii?Q?GRvLymmuOtpfSUWizaS9WNz+/y7WF9+XZnxpiMLcUA3WZGrXDKWDlp8UB7av?=
 =?us-ascii?Q?8xr2rr2/6OFt1h6seXV9Pp3didc+ZSdt0LmKjnXsHo+CVscvdO/wbdpB+NDF?=
 =?us-ascii?Q?ow56xP2g9uM5CbTamrV9NDfzynznEtaetSw8eeAV+C06XrJD/cwBGvz1oY7M?=
 =?us-ascii?Q?trhhjRRx1Zbv9eONvcOXJxEr7dnddt2IABwlN21yiS6ggk3bgUqp7C5eVP8J?=
 =?us-ascii?Q?BvWfEgl825iQvIAhW+C85HeejvX3PQVOdsBkRUf5YxPPbUIOptlL8GHLKrEp?=
 =?us-ascii?Q?Uv9Ik71onAzE+vHRunjxiGeW5BUlQdybNqR3w0xXSeyd4P0ASkKFJNKMAn8l?=
 =?us-ascii?Q?6cphoju7+aOfPau5w3MI/dAUOl8P5DLSgEuUjdX/t8s+QUdzqpid6vlKxyD1?=
 =?us-ascii?Q?0BYlV+P5eYzK+d29oBFUcZfAPg6vH6NPJ3O3X+paz8nJ0RpKdIRqc7L5lIY5?=
 =?us-ascii?Q?bn0wjXkoE1gNlvvh5d4UFvpLnkQoJpEH7WaOjQEO+8/xcPYlSDRAi/zVPWaZ?=
 =?us-ascii?Q?asCRs6C/PiQzTI5S9NcNXFZ8/B0ZBz6Jh9Zegac54P/u6vUXQQf8To+ToJ07?=
 =?us-ascii?Q?yHDuij8TemcnfV0foSKKZbAlt68w0Sin0cTyEHQVSWvTBtoiRPMhoN4Jsolp?=
 =?us-ascii?Q?fJcPtxzqquxitBzeLdlc2Ndb2/hYLZ7wHqEEtFNMB5oM7f5q2T990LWPRLjZ?=
 =?us-ascii?Q?zI4i+7RtXEJ9Mr8bX2MtMJAZ9OuJoyZQaZH+xuWSF9r7f+mwfMirTLcpkEZv?=
 =?us-ascii?Q?3cwSHgexTmcWLJnk8qndrnwdoMJ4tWmDhBWLZKlMYefkUzi8kIkEpeivQYPC?=
 =?us-ascii?Q?cCVvn8m//0ybPWWR7gnHAbR8vQbLPgutDyidLcexrgPZ1CNVdQC7iL1ctwKn?=
 =?us-ascii?Q?k4/YMoQzGxTbzPqH4S5OH2uvypy+KggEqvBf+CvkishQ0iduowE3Ag8I3rBc?=
 =?us-ascii?Q?/bVg1J15ghyUII1FqAB9O0kXs6oZ5j+A+n6oYi+RCSy/bGT4E7cZUsfbaYat?=
 =?us-ascii?Q?GVyTe2+y7XSSFOXEhpdIBvRoIwMCz3X5uh3GkPpNmnpkuQJwoVdiTXPIOmlN?=
 =?us-ascii?Q?NBI9IzSTW2Y4lJUEVJCdl6o0VccspY+7zA4Q2Sw8cgxrh8cKqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKI6NdPOgigyRwMLj/uD6tfGDkPHCCqxsRXFVugNensdN/0Z5TcKtxIGfzt8?=
 =?us-ascii?Q?QmrL63hQbCceXUTpN1IJkRw7MyCuQFTyglNBVNoSXZQejpItKYeTg6VYM+ss?=
 =?us-ascii?Q?+rx+Z5Ok1C5R68CGBK0LuoRMXO1OXbS5xAq6nosOmPtPYELwdgIZt0WuMNGn?=
 =?us-ascii?Q?Ilo+O4pB9p0XFOQ3Ov1bwjyTzs/L33BsIegmNBZV8wrvRecUsH5zktk8zGOw?=
 =?us-ascii?Q?X8lIvIT+8vIxv+AUZeRIZlbWRXi2I9aELojmj+oGKf9pnHq44pnAFOQq//1i?=
 =?us-ascii?Q?AsvorjqdBxTNrDpSH8gpyKUEXT2ZHKaRyLW1YB6O9mH5DjNat1+c4qPVeB96?=
 =?us-ascii?Q?whIkJr7yQpVZGwFfKZyVKh7mypqmV1ANRoaAN2Tf25CIQS8jM6MVamer3ueT?=
 =?us-ascii?Q?72Fx1pBuxUtTMkDOl0bt57vEKZxnSILjf16KjyAN4EkD/LbUfBKll0oZrzAs?=
 =?us-ascii?Q?wSFf6iy4p2QYAEe73oi2kbmpv/DxK5/hXyHJ42pt09HMNb4NGkTofq/up5OX?=
 =?us-ascii?Q?moxd+HyrESH4fHW6Tm6+WRuC5FGDJTReTftDL30cbe5cKT2D7+9ujENLoexv?=
 =?us-ascii?Q?RemiheJPq/Szbzp7et34QeVng99JxNPLRH7OMaX+XD9gt1VnIN++Vm3tUHem?=
 =?us-ascii?Q?c39gM7NPG2t9MxyvNLNdqpyt71ybYyBzUOBtGBqObU7SNu/LWwt+WK9skZHB?=
 =?us-ascii?Q?RdFYp+M/gLzSgdtzZOSqIvszHEkIg+mxLx8JaidgODki4tbsdgDIMikzY132?=
 =?us-ascii?Q?dQxQJuvSqThEgt2QoQnTMnH0eEXe/c6WW9h/bFx244Nka/pjtR/86+EWPVda?=
 =?us-ascii?Q?2afVDJabfAeGmHPEX3iEdVSiAGTB2SM7+jwAOLVaBH2y8fYbtsLeJdTDlY53?=
 =?us-ascii?Q?+O9Ab01Of/6czSRJoBW+EQpJwi3tzNxoM58VEbUL5iV7/a7O6Y1SIcFoHoXz?=
 =?us-ascii?Q?MIYeRRX3qxqJ3kVK+Io8B01J8gFL/LAdjEGKS8dMbGaWARB7orxX/N7yKUBv?=
 =?us-ascii?Q?dKO6v7IVTlgJP1/qkOv1Qwyj6JvSbul7CzIdVL1Oi+xFuk816qEZCBm0NILS?=
 =?us-ascii?Q?ARiq/GvV5y6sn/b/8VgaSqxTW+ArrKK9AfkXQlx9rFgr9uy/ztQl0G7STzfp?=
 =?us-ascii?Q?9Iy8q1zrzw4B25COi8PXuaHVyqZwg75btDZ1HbKPdijto9D8CwPQsjqZHLmj?=
 =?us-ascii?Q?bahkc/n8dlUUD42GEeaBdGenFYi1W7iKJWvf7Mfbh+1dV/uHkuVrA+NNB/zp?=
 =?us-ascii?Q?riANkMyIpS0ZUGWqJahDOx2i2lt0rda5qRfXASlavhPwx1js2yUvj9GookS3?=
 =?us-ascii?Q?Sf7MtoLLBgc5wjiUg6PVgh2X/yt4wiLKJ4AyIPBa50qIx5FBTQyOjTM9TLnW?=
 =?us-ascii?Q?gyDjDPB6bKlaGl91EEUDA4Fro2lSzJjbqMqCt6oEbOhxcZsdUE54voV5SNqw?=
 =?us-ascii?Q?zLfcwQDOUpPkkYeIoae0q6hHzQKwjEYDB9NOOwYLamsepxfEgZNKZWmFkirY?=
 =?us-ascii?Q?iumQWlzQd80owhjNuqd/Bo+5lHDGdopAO9w07B93Pkwx8XuV98ebPyXSGMbP?=
 =?us-ascii?Q?dTe5pxNzLw19xlwoRZfL3KqkaJ2Wl1SI06EAfRRG?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73c19cd-5eac-47d1-26b4-08dcc71338eb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:40:55.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4v8Xx7Spyh0INAR2JBuupf+LM4ekL7lg7F4zzxO4iJe6buQnTjejA3/wL2LtcYeIq2ubQM50H2ZNFYvS71kEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7977

Add basic Wi-Fi support on Khadas Edge2. Wireless driver need to check "brcm,bcm4329-fmac"
compatible so add it to Apple's devices.

Changes in v12:
 - Add fallback compatible for Apple's devices

 - Link to v11: https://lore.kernel.org/all/20240816015214.1271162-1-jacobe.zang@wesion.com/

Changes in v11:
 - Split DTS and submit separately

 - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/

Changes in v10:
 - Use ret instead unused probe_attach_result in sdio.c 

 - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/

Changes in v9:
 - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
 - Add if statement for brcmf_of_probe in common.c
 - Retain modifications to of.c other than the return values

 - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/

Changes in v8:
 - Add appropriate errno's for return values that will be
    send to bus when error occurred.
 
 - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/

Changes in v7:
 - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
    value, move clock check to the end of brcmf_of_probe
 - Add "brcm,bcm4329-fmac" compatible for wifi node

 - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/

Changes in v6:
 - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
 - Add return if clk didn't set in DTS

 -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/

Changes in v5:
 - Add more commit message to the clock in bindings
 - Use IS_ERR_OR_NULL as a judgment condition of clk

 - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/

Changes in v4:
 - Change clock description in dt-bindings
 - Move enable clk from pcie.c to of.c
 - Add compatible for wifi node in DTS
 - Add random seed flag for firmware download

 - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/

Changes in v3:
 - Dropped redundant parts in dt-bindings.
 - Change driver patch title prefix as 'wifi: brcmfmac:'.
 - Change DTS Wi-Fi node clock-name as 'lpo'.
 
 - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/

Changes in v2:
 - Add SoB tags for original developer.
 - Add dt-bindings for pci14e4,449d and clocks.
 - Replace dev_info to brcmf_dbg in pcie.c

 - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/

Jacobe Zang (2):
  arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
  arm64: dts: apple: add "brcm,bcm4329-fmac" fallback compatible

 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi        |  2 +-
 arch/arm64/boot/dts/apple/t8112-j413.dts         |  2 +-
 arch/arm64/boot/dts/apple/t8112-j493.dts         |  2 +-
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.34.1


