Return-Path: <linux-kernel+bounces-309850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9696710F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12391F22A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1BB17E007;
	Sat, 31 Aug 2024 11:09:16 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2113.outbound.protection.outlook.com [40.107.239.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5717DFE3;
	Sat, 31 Aug 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102555; cv=fail; b=DALaa5h34UF8AMJQ2k7VgdiXDPQdK75cKBgYZV8mOdLVOmJpTPF9OTs6jhKvutjHMDr8c2HzWPHEGR4Zp7IRmKn2vdrB6fxXDm5x4g+OJXirL2sizzBp1brtZ4dskG5WtLuAzGIkh9xka9uAEGgDfOjruuhPrDj1+0dMEktY5E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102555; c=relaxed/simple;
	bh=ROx6Vcx1xkpog84VPIGQqZ3aDdrMQROx8s953enWeSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVkDLQsMcSh/eu0oQOlbuec9P73+kO0XxzAZCbcYQUxBCCZcK8/paJDy/O9BREvCaTX/Vq/gYsOT06KIBSffVVE2+xyRZwYLztAEbFuSbIukUT6AdIXtlltXOQ8USSCbgkkXmpH1mrr46bxYkKXnEOxtpFWiixyF/zKmvyU38WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oS+dDh3A9ZdDIY4I+bqwUV+qz1YmdNMZzeBAo13FhvBZSjc8z8P+DyIRDQz5MKwe6kDmTFDsYe+OTXA5uoJ8qYVo/m4NgJXpsCLQYRmmEPWkveEa0plYNnDK5PwaKt8DSvg1D/F4DCbv2EDkBf/pao4wcoWB2ABqoriOg/c5ShwCN18Ari+WgfHQfkMcXzceimUR3AxFLdLjKy4tetEZ/B7JtTO6PUlHmmBXVewoFbJ3BmKclpmpjFlTyugM40Tk8bX8ilIDoiCOXrqzdFzEmsvvkpcuNppTe6NFbGtFXkZ0FkM/wrG4fqfKvHBKfLu8mtesYwAYbY54GtTtxc5X9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+atc/crgzcUMxU419NrhoHL29dKnRZV176C28L7b/3o=;
 b=gi0Yk9YzptYakfTf7fD5/Z1is+Q6ZI80Wkfqjr6OuxNx3DkPeLCLuo0ZF6q2gl4wG7lMnfbkrCErIgjx5AupQXEJKacp22iWKsvcfkVAWKcNZVLQqIaxWcMhxvmDssTYWrvUaaTrZzxsy/SHbGtibadGvnCOlsFwjO497LYFSsYKV4Nn9Y0daEjNfS+oLHG+VTJUlKy2S/xlVkqeKPs8BYtwDcyNk0duJHO03V2mjdGbUDJo7eUuD3wrqVfbNz+78RUNpUpoe62BrG73iUWUFHJkVmyvkyCFwJUOCYPS1Zw3gKhbscpfZLmi/1YYq78EqIEwncMvw/rZp3LsyrFTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB1765.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21; Sat, 31 Aug
 2024 11:09:11 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 11:09:11 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Yannic Moog <y.moog@phytec.de>,
	Josua Mayer <josua@solid-run.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Sat, 31 Aug 2024 16:37:40 +0530
Message-Id: <20240831110743.14280-3-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831110743.14280-1-tarang.raval@siliconsignals.io>
References: <20240831110743.14280-1-tarang.raval@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::18) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB1765:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ec968b-2dac-48df-4f3d-08dcc9ad573f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JCUNf/i+bKBVy9H8c0HxuLFuwYn1jzkPFZvphcGzkmQVMjhMa3CqR8MkE6VO?=
 =?us-ascii?Q?HsbU9IOJeQcLUOPhUReSruGefnj3VTQTGEBkLSIt71HMY9L5CvYvPK3WkUeA?=
 =?us-ascii?Q?8eQMMkJGRKosL1oNvPLugU8nj+KGSij4Y9i2pNf3q+M7fG1DPtkhsr10ynop?=
 =?us-ascii?Q?aM7OgPuhLoCc8b+9dMGkatEBp/sBwYyiePnpWHi1kz4xaGm8UJPQEGVHKGVu?=
 =?us-ascii?Q?X/8MhzggQeDyUAgmLZ1IXCuucUHWOe0EyPxelTUlwm6XKbN7+tI4iSSvv//j?=
 =?us-ascii?Q?YoQz5Gou0wDHaHAvOnd2Dz25Acx37lc66wbDRdqzrwu56uJHZp8t7ixnYHib?=
 =?us-ascii?Q?t78t2+Kwz9zKd0CC1voESzgXa/KxvRmKWfuiNFiw8gWnYbJOcLepsVSsRDUy?=
 =?us-ascii?Q?fAVg/5WG3epFpvH4X9Os1qjpm9EkwjLgrMVjZrGveYQXOpcaE5iIlkzJJS9W?=
 =?us-ascii?Q?NIBz2SsZjaFe72lGKNU1jJhzNddmatqLuDj4TrvdoEGdCR3xIPB/63B0jgEV?=
 =?us-ascii?Q?9J84FDjTiWt4HPHReaisZlv1Zum0oo5VnESC6etEa4SKSFdQJwEzrENHvTd8?=
 =?us-ascii?Q?E/qs4C3jrjrgik7clvhyvPlWZAJjncuXINZ0ZEm6zvN5FqCM1z3spuEK6P/L?=
 =?us-ascii?Q?Ipb6NS9vCTWt6BseD97yPjoYBYO/TCttXocKwWcFROPfIYQqrBCwEWBvHfbY?=
 =?us-ascii?Q?3QlOh4I6+gUXo9vU9sUcIK0653uB6vUJ8ajnudcXfeWPQXieUdtShNSwXfup?=
 =?us-ascii?Q?byi9/0rOf5vMfsQwflQKPyG0IABwUI7rpSltYQlgsnDgpJARn9MlSk9dD/Su?=
 =?us-ascii?Q?YTksIPrCUESv+nt5ANT71dP/5OgXXe5gTZ5IQZ2RUj6uQEqvhUdiaP+f+rHX?=
 =?us-ascii?Q?D6GIZaOSe7Eawd1GpDaxOGsH8KeJ0dy+TTqQK04UPv63RDSYHIcFMnDCUN9u?=
 =?us-ascii?Q?IZht+qoe9DJNNo5FtjJKbOHBU9JAr9w6qQ2uFk9eQ8NzeRNZt4fjli65wULT?=
 =?us-ascii?Q?LPzSq7i2t0TbU0+cw4b6uQwYm2gleAwDaLQ1/pjShmXSN6U1rJ5DwY309z5J?=
 =?us-ascii?Q?23T7RuLgvoInSbO/dVDi0GFxyA2OKv3XO/3ukyisV5a4eWd7ZVKkLvxU/JWF?=
 =?us-ascii?Q?+J+lgSVcx28fbgeFaJnjviBG/8cwEg9uumnlYBhysXcQIU2jn6FN8cZ+ihxO?=
 =?us-ascii?Q?sT6s48cscvdedSIrdc8JFsso1/Fq8nvKCO9446k0ZjXzCa69P7IGQc8Q9XkY?=
 =?us-ascii?Q?MCupH1fXfiez7JqhJ30s2QeLdGtZilk1iy1sv9rgc0Qx2rtPffi9pM9w2Pe0?=
 =?us-ascii?Q?kcoJyorCqrTILozAvPXriAKgydFYP+AF9OlxspmKj4q+RwufnuyRmvBGKjtG?=
 =?us-ascii?Q?e+Qw9O87irPJMs8yGDL0UYenlQmbPdfLjM1+Jy4y2Mnm1QffxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pL9oIC3dke4IU/FTxqiyiuLcI7k8y6wwUnsu7mNrvd7YTxFDIefGS3gSl9Je?=
 =?us-ascii?Q?FwmOyWNWEz/FGd6gUSM7uamwmuGdKuLoIN2lcyh5F6Jon3pOlCxOvo3otA9J?=
 =?us-ascii?Q?JDV2QmrjhqCMenapFsWImcNtOvoMJvrVYeTGn5WMapp2Pwuzw/sJJrgC+l9M?=
 =?us-ascii?Q?B6KykpHogvmRY4YubIXQXFaLfBCGasdSMA7b82dTcLzdnauTr3dOk2m/P7HM?=
 =?us-ascii?Q?3Tpa25jtXN5nL0b8beBJ3L2zze66guVB5Rb9vCpcN9fvgfLMqutzqBmAROeQ?=
 =?us-ascii?Q?NGAhGDqHyOb62fF5lGK6dr87JIPkZgwigsxO4WvkSWNZtmvGD31Xf/tRkHcn?=
 =?us-ascii?Q?jL3bKmFlVgZO9ARWEFv51jHT6ZAFCxHh2MewbHaBhVAUzGQBmWEHDp+Vo6yn?=
 =?us-ascii?Q?CxJvrjrN7BnO5XdvtFB1l7Nj1zzkgrm1q9vJ2vaZ/2KCi15pSqhNpBja0wA/?=
 =?us-ascii?Q?w2er70KpM30aHlUlW9Xk2xudrHlvUMJQjBp9NqJx2a+E5oF6/Nu5iActjmdx?=
 =?us-ascii?Q?VsbntjUSF9cRx/jubiVpNTb06LQCyf/HKkG2VeOgNSG3pWHK9P6SYcXLOq0E?=
 =?us-ascii?Q?vfl+zoEhhYOV1LdjU4eqEptT8JXJSC3GLrmcmdxRgaq2nBT7fk929BSrluFA?=
 =?us-ascii?Q?m+JQSZ69iku/IlauuOy0AkiCSlqHvn1WVXDCoPWc+t+qBHwj+cT9vBWScug8?=
 =?us-ascii?Q?MtEv7PoZTxJIhKZX/Z7x4hc8gbYKLXU/pL2WBFxacOZmCTurqeAbi/CWO6xr?=
 =?us-ascii?Q?Zh3fD5gdtQuxDPMLiPVhp/UttoUOGxS6EnYIWg4y9AybFSprynXQ0h6z40UE?=
 =?us-ascii?Q?j5YKjPYOdNrys/pCMQMxW2NkeioNWigVSPIBXo87B7McXzU1f+wqmgldxVXg?=
 =?us-ascii?Q?T4nNWDiZoRI5hBJlg2ukQhMX/sbnY4A7MPIwT6fhkoPw4+bMNoiQR40ocxsx?=
 =?us-ascii?Q?BekponZpkc1Kc9xzscSuyCNb/0slgaiDhc3+A6SSsfnPR6aHtgrQGeEara2T?=
 =?us-ascii?Q?zH3w38rbHfsZEp717z4oWLkULkatUPSmTHWyIMxAXihYRv41uaGAWAwFy8/Q?=
 =?us-ascii?Q?f28lyB5DHHxtPMQ0W6iOnapA+WNDlhi4hqSJbg39+GdrsV/En2NnG/iRN38V?=
 =?us-ascii?Q?eaSauDgQ1OJYl4bAVtV8I0rSoB7NDVWh04sATxPd/qKkIjaRSxF6WwZgd7zK?=
 =?us-ascii?Q?g6aQpGPuNapMOdbp4O/MDtNDRHyFiaA+DpHr3zY/uTmG9NePiFpy9N+fnaNL?=
 =?us-ascii?Q?rTdpSIeof7iEtgBIkoFHwN3Tc62VwtUgfk4Zlo7ZetjORUmh3cBvia1gK2rF?=
 =?us-ascii?Q?ueyHVw36CEPcniZayIMPjFqScJhdbtr7Q7AN3G0X5hWj/EaHDVExnIqoDURN?=
 =?us-ascii?Q?XEPHaTHrcYffM1puXw91wSWz49dbrKBrPOyUkHktZ4uXMJcRecXBRUp4/R6V?=
 =?us-ascii?Q?LPUXH3mqyZNXh+ZWfY/rug77Gry2Vrj11YJCkrAfkxvfMpoC/ORdpD1Xf1kT?=
 =?us-ascii?Q?NqH+KqdLFnUC9lTE6AnKH8ZyFbNUy/fK8zqD1UpGolaMPfBQ7fP2fMYPY5Gd?=
 =?us-ascii?Q?mUgAphPPR2wNL3FftituJJAAak2mC/Uf1MrpzieGBmbSrKC/dNHlXA0zkegf?=
 =?us-ascii?Q?dK7+ABleo0EbcBO3od8cHcc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ec968b-2dac-48df-4f3d-08dcc9ad573f
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 11:09:11.1227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rDFLKUGPFsZM9MitInXwAIc2x8F+WV6iggKxEGZ9+9t3y9FaSpfjKb9tsrHUgkVhXyrbqfVLWhRHOBjyF295mR8eBxHBYoWcLVeYZAMuEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1765

Adds support for the Variscite VAR-SOM-MX8MP System on Module and
the Variscite Symphony Evaluation Kit.

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..db835947f5ed 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1071,6 +1071,7 @@ properties:
               - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
               - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
+              - variscite,var-som-mx8mp   # i.MX8MP Variscite VAR-SOM-MX8M Plus module
           - const: fsl,imx8mp
 
       - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
@@ -1149,6 +1150,12 @@ properties:
           - const: tq,imx8mp-tqma8mpql       # TQ-Systems GmbH i.MX8MP TQMa8MPQL SOM
           - const: fsl,imx8mp
 
+        - description: Variscite VAR-SOM-MX8M Plus based boards
+          items:
+            - const: variscite,var-som-mx8mp-symphony
+            - const: variscite,var-som-mx8mp
+            - const: fsl,imx8mp
+
       - description: i.MX8MQ based Boards
         items:
           - enum:
-- 
2.34.1


