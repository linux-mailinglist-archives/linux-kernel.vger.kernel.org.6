Return-Path: <linux-kernel+bounces-288820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1945953F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63891C21045
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4B73D0C5;
	Fri, 16 Aug 2024 01:52:37 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117629D06;
	Fri, 16 Aug 2024 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773157; cv=fail; b=XNrCGsAQjKLMM/Fc0m4kOWZXsftqXwc0xOAJH5+9iClmkjhxqFqSRkN6/pXWISp3Iy1Ye74Gqz0c5XRd11P6hu7ityBRmipeX8YYco3jxCrJchqtPYTyVAVfdHPLRRyapDWcLZjNb29/coSLGXvu+5whciMzwDR0uK4cpcj20FI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773157; c=relaxed/simple;
	bh=N/RtFVenj3Z7IEiCR7u1dVjyT5hCGTgxAcs3H2GIlSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSodFCrHqJqSlX3EKF1uCCH78sSgoqEDn3btcEC0z2Y7hREOIPFeuibBce28Wg2tFndydDamn6GiX4AIGqZt8rzJyzkRL/ScmsBWcQAfZYcucpibns/gDXgGADpmKJ+9jd6muqEM0oHqBW1ms0188gtn/Zm/RGz9uY0N+ok/eW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVLjjBCevRo7HAG/NE6ntLB7o+iL7ZmI2/1eT6++GkFcAB7ePGKnn1l/dv2fsjgv4gzceurbwnYNBMJMrUWx3OMpaSSRPCE5dorws3FIjfx9vFepkKHWkCpxa9cCDRkQ/0Z0/jAHg57Oyh6QR1lrIRP1d4Ad2J/L89ips0T6TKwLKwSd28TF0u1xsW6C6kdHlDg1x2eECbOaRLnYrBxc1Tu4zw9qZ1gDokx3/EAa9HZeCO4xvGESz4EZSe2xPythYRpbXBZvIK1jhfV02ACvsoFiQwg9qAlnT0fSYX7Sjatjzrn9F80tCPi62puK6aVwDeH/4beKK7TfmqxizX2BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnTJOa4JXmWzrBFSD6Yx6B5bbeWEUpHWGbPOD0Sh4do=;
 b=uYFFFYrH8me3Zf/SkITecCoU63L8CEDog43WTqiOopdTPLfKJg3OuSd+zvIgVSAY6OAZ9+Ok/e6QdDbGRlaRMvFK0vseyRCp3ton9lRqntV+10nlp+gpK7BcaWbr6INhO27qOVf6qKoEb4joOpxSnw4A5j405ndQ/FDBU/EqhINfnS4YakN1NQsnA8sYpEd2FgDvphyI6il9FdMS3fxGIww1YvHgwrV22DYoqbgIBZcWA3+gxZHdJaGONOcHzlVmIZyfKpX/ns13ZijWdnLPpRaBLLUomwBQQIUhcWc/I4Arna2bpN5+Bx5v/022cTqKsV1KRICrq9Or97kGvtdZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7985.apcprd03.prod.outlook.com (2603:1096:101:168::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 01:52:28 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 01:52:28 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org
Cc: efectn@protonmail.com,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v11 1/1] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Fri, 16 Aug 2024 09:52:14 +0800
Message-Id: <20240816015214.1271162-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015214.1271162-1-jacobe.zang@wesion.com>
References: <20240816015214.1271162-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 40800270-5f12-4531-0a05-08dcbd96152a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WGYljkhhw+wHm6uSQZ7dUFpIDLCXpekkbby2rRJyRB9yuoaXpAwLoBLGOG6w?=
 =?us-ascii?Q?GENg97s6CtvuxrjSYjumfysVoFKdzFw9SvY8ESqt+xxv2BKLs7+wyS1Hg5RZ?=
 =?us-ascii?Q?YpSsegoUM3ZuWbji/noxiTKPVgWSP0UabBChOYPub3+Z8fz939BT3V47KdDr?=
 =?us-ascii?Q?OT+gc7e+29MlWN70e140z81xWJ2/j2bcv/qHLpoV+gsVnWEAqANV4S/A9teq?=
 =?us-ascii?Q?b8q4jNU9LYd/JC2v/bvsUENUKcZY0cGWN5FuAgck05QD4mfCXGg9kTf//Twx?=
 =?us-ascii?Q?SDoUVks+iLtx6cvjE/Q5h9d42l22AHUu2VLzurU0vuyEQt4+FawzTrKl1F+t?=
 =?us-ascii?Q?ffRdsubH/eOtziuKHUuEtAZxe+yNZGRzoO09im8JX/zI+87xj9QNxdAJ/u/u?=
 =?us-ascii?Q?GsRLxB0TtnDsd2NkX/jjZCUXxEhbvtUbEr9QKBhVxGB7qAgwZNAvpdGjXG0q?=
 =?us-ascii?Q?QkdHtzxMYeannODnYx/dsYzvstM/YLEmKMgfLokEEAFRR3QjLpl10abV2bF4?=
 =?us-ascii?Q?jC62MC3Zxqzhd8fbzNrnVV4Esn8IVwZaHYYIo/p8JL1HnSMoYtjkp9oPn6qy?=
 =?us-ascii?Q?pQEKYePoktnfdqfbgU2I+Aoc1Ok9XcFZcJDa5a55vja3tNQXHukSV4xVdaGU?=
 =?us-ascii?Q?j5FTRzkDLC2yYuBbDKVZe8MUQoDNaZQHNof1xfRHrZV2U3YsZGNt0zXU9WBc?=
 =?us-ascii?Q?uGjQMj4WjI/GAEQ0q4uddxxg8hIoN9zbbxQQ5WpZDTgrH/OcU7dF8mD975/s?=
 =?us-ascii?Q?Z+wXIdta2klLL0M0DliAvehYeTrOCpLQFGZ5cIj2X2bw3vrYC7fJXUtrKoKa?=
 =?us-ascii?Q?I+O1+vzdFGeMHoYDUeNGiX0qGiWkiz5lnxMoubAy5p494kGrnh0S4X85Mg75?=
 =?us-ascii?Q?F6AFEseOhpaI5Ng5D7NZx9acJXEHmjh99zXEFZAaVWtE/9AuwEBBFffzBomy?=
 =?us-ascii?Q?UkK4IGHtsgv0K8hxOYbYXsUEdwo+RJSRWtN5ZZgQ+GCVMnje0sUQzweFssEp?=
 =?us-ascii?Q?CfXia8nvIfms3mOMHfcqBvTDnm4b++bkjmYsFqGsQz3RMrMHVydWP4kbJLM1?=
 =?us-ascii?Q?/NNduVkmAHeUg1gIcchI3joq1F8J/xqnAwGVGx5CaalUsx1E1uE2f9TudLmT?=
 =?us-ascii?Q?/3YlyfI3Eg0EXYIjHB7ISgHt3MWdJoIISSPadfgKiIlKvB5dvPdOLv9Alco2?=
 =?us-ascii?Q?QlmBE4LuIZbBogPVtmhHZMlhL8ex8OWhSLri8Bq+URJ2ofZoCSlARfGegSc/?=
 =?us-ascii?Q?+2DsIFQKDmn3BLBTRCrZmGQiOuKE6q66ZwT/sEgFHXmohaMVrmDBuQPi4aHY?=
 =?us-ascii?Q?MFylCJAWvdH15TApXk+Is/I9RuOR7/7eCyyHU9jx7fTjuT/DsB12o8Wz8BUU?=
 =?us-ascii?Q?yPT1jkRBrNuTGbhc43aGLJpyFl0lpOS4osJr7l/h4z80COJqUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hL8C2SdsWnq8aPqWyKW9SAwUj0nJWta3HIm/MM0KZBpieKHKcr96baJt/Uju?=
 =?us-ascii?Q?LfOq99iVF6KMqSemFOuRWdn/VScwsUcLbqKjAdR+Y1RZMgwb37jd7x/1R2zH?=
 =?us-ascii?Q?zGEz2jTeXWLhl/6oW6GohxE3d0uPPJBcdqCD5wGXvCaUN48Gt0rocSY5l/Y9?=
 =?us-ascii?Q?5MejF9R5+ougb9SJtF2NTiK31B5FLOpARbe9Eba/sUZBrs4yb4WhO6YMiWlB?=
 =?us-ascii?Q?ED3WMSwCHpOa3/IHKDUtE7li61ETbzl0DjNIy6+VCJGEBd9tOLDMNi0+G/SQ?=
 =?us-ascii?Q?t0sE6D9ySq30cOMSFzAbhVfkoeNBBJ5rsN4bWlPDE2JDxbRkptPyrpzzHSVv?=
 =?us-ascii?Q?WCDrjrVr4HGaqEsE/4weiz7c6MtNCjXJAxd6NV20yOk8XithoQEwVVmVTX3u?=
 =?us-ascii?Q?J8rHim2mkdYoWS2k9G6hejUQZEnUk64O6AxwvGzup1jPhVdM4bHG0oqy3p8h?=
 =?us-ascii?Q?5eQz0APVS3i8xQEazu8/0MKQZ4p7+KqgpOvrcQKnTU+oLyrkwhCXzAEF2UC3?=
 =?us-ascii?Q?L28Mdt36W9czlZhPxojgm/vlE2XNpe4ULzu65abrEbwdhk4vQWHOj8pGYjVv?=
 =?us-ascii?Q?80DipLEuxaewksYpVGjpvo3Mukno1HqLjnWwJg/vrSAr6BHeI7fUq1voEFQO?=
 =?us-ascii?Q?7C8UZuUVmq4LDPND3Tc/REfEUSSBxG2H0WDBp3h+TMtNkHcc+C/r+mj80v16?=
 =?us-ascii?Q?B95zvC9SSB9iEMjdDBorBX/EiMH6u4Hcm61Z7zs5AqqgGAOH2kz+biewiSsW?=
 =?us-ascii?Q?haKPQiGoQQeuNhnBUG6lsUDaSTmPHX5SFRVm+5uFPHATvKuDy+OsKsV5Ayz1?=
 =?us-ascii?Q?Qg3C72RPi1609ryKcHfhqfM9gKkuQ77mdNRd0TTIsG1vrNqOC5S1aK6EF0Ty?=
 =?us-ascii?Q?pMG9dUS6nAMynSb0mH3NWcdfaVb2RCTN2NWYMlF+sLNO0N1l4WR3Kry5rPbk?=
 =?us-ascii?Q?kG2w2Y5iC+zN0psu+EnyLlMoLs2gO7CM/Br0Ur1Krd9z4ymRldrvDjBxh0Ea?=
 =?us-ascii?Q?nwEErv2pH491d3oZar6Je9Gh5cfaBwKXM42bzYpo6bbi9WFP55H3Y0PxswsA?=
 =?us-ascii?Q?z1TvmB0goJd0iNIgbGEJ/rHhCM1cWt1MHTJfwwMDo4BCYPpS4is+ZVPFec/P?=
 =?us-ascii?Q?VTP4vuLOH8EBGp79hRgUB4to5nNU28Ya2OwD1Mu4CBtGGSbhEeR334nSAq7S?=
 =?us-ascii?Q?n4hbzVoglZxz2APxlSAxit2IzB2SaSeNsq3m8YqeuKWrmrv7GSggX2Vk2OF+?=
 =?us-ascii?Q?rWHCd3Y4R5ZgpRGIuu2czCRMFFDT7fOhEQHknDRcqwwrmvvN2UKqFKud0YCk?=
 =?us-ascii?Q?kulZ8zu7j7y2rTOLt7Rk3140lzt3o1XTGrHk+TMrmsYz4TUsALX0Kd/UNP/e?=
 =?us-ascii?Q?4x6E72ti4hYe++rLAJ++r6DJxWiyNNf4JcbXB9IL2CZcMiCe7oqubf6dBaeK?=
 =?us-ascii?Q?hyejj2YVlDlwAvyk3roS1aIpo+GJDORvKTMJIGA2vsuDlLBVKS6MS47PUj6V?=
 =?us-ascii?Q?7X+57Wu/TJIngKyUpJpqzIN4HJdQskVsS6LJE07gBSTCKYLEVejfj4j8OFoF?=
 =?us-ascii?Q?sQOwUV27C4DYMJj4Tx47ULcaAnuFpxilH9XQ8fx0/+q91evvWvx+L/rfXhDP?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40800270-5f12-4531-0a05-08dcbd96152a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 01:52:27.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T70x1H44KXLmlJ5uXdew3IoZpVTWb6/nfEgVaDGm7zXuN1NF0bnUPaRL4C/W0aNRZOtbOs5N1EDDfUPZwN3k2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7985

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..a3361ca25867d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,22 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		wifi: wifi@0,0 {
+			compatible = "brcm,bcm4329-fmac", "pci14e4,449d";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {
-- 
2.34.1


