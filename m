Return-Path: <linux-kernel+bounces-310663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7F967FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC9A1C21EEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A75136982;
	Mon,  2 Sep 2024 06:57:24 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2122.outbound.protection.outlook.com [40.107.239.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247F15688F;
	Mon,  2 Sep 2024 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260243; cv=fail; b=EQWkkbY1nMSgoeqs6g2jPR7ZiJj9jRqG6KC0BuCysmVf4o1zCJYHc5Y1pNONnh7RhHJ7lBCcPP5/z/YwLg499gIl+lhaD86p1gKcADrSt2Z2pW5EqGSIO8ul5M3zsQsBMu4UWoK+QTLmfN+lPZ4fovDSVez6wHILgpJ6dNEuRXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260243; c=relaxed/simple;
	bh=0WIP46H2bQDIruO/AqZABS3olqaRSJP0pSBN0mBEDHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qaXqZuj/T8HXH5nWYxTPKVt7eS4so1MG2LmNPwd3vpb295TQI+NwIHSbd/rC2XqDCoRjpzS7BNFAxDXUckO2LFgJ5RKl3kTa+XFhmjQSnk/eNX+fPTp22LztjMZGdHpiy0skwZR/vxsL3SxB6AfuKCz3nabMezgCKLXuBqdgogY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6NQQXIpAG5wrdNJrIGvLk8zmDtWMZlxc54EvPavMJEV1kwWVMVRSl2FD1Aw+x6+5zG/gbb+bw4uLSpl3ebS8FyJW/WxxvhkKkGFAzXSi8qico37B4Yby9JRT9pw5fCtNdVrEmERsNX9fBRcsTAdP7MZJF/8WQ19OQjRzVN9G3yco8eZSHrUSEXry4izHLVNZJNkKFHRmgaiURyxsKs5XCnD7401V6G7Lz0IuOdMlenW4evjpWMsb6yvTPc6BxekekxA5jmsQYj20rsb5KC822G9O9DpZ+9DhssTagQoSzTy40dJbJeTx0DuaIPY0I9sS6JDNETUXzl7uyxfw0O32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvJ9VDqX94rTr0zYKhlhzv6QpV2pTm59yQ8wWZnjamg=;
 b=jO6EKTskSkAzCAoyqAnpyiacGtYlkX/NvCJeojxKMua9AAc9nmGXbK+ikiSm0GdS8tf9YB/PEj7BLN6kTvstQSjIdyiRjA+/XUs3kknGd9crM+i5U9dq80ScdrLFpjKsfXYttfZWQ3SMk5mcSfDoFsLvwjAuTLazSyEwJqgPKSLwd1fKkYkIeXHbaA4nGZJygMiHdK0K89H+nN+kETzv/MIGyDB43QR73udBjUNYMAGEwer1Zq8pJvq7t13lfhK7BtAE/Asc/rEVKqw52OapzpMG1Ondq3lvsCEy9MB7xNk7dphkzLjG8lLYmkz3GW3ryDT2Pxyk+pnziEznxaR9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MAYP287MB3612.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:151::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:57:18 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:57:18 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Mon,  2 Sep 2024 12:26:03 +0530
Message-Id: <20240902065606.8072-3-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
References: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
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
X-MS-Office365-Filtering-Correlation-Id: 6d217ba5-f971-44ea-452b-08dccb1c7c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFe/aQAoBodzg4XMedS00D0KTJr4ew7bNd6xb20M1GoSHN3N5qyg8+NFvoBc?=
 =?us-ascii?Q?WflOU7lgREIR7+KlTnTDzTqfzGLXTicm+1OG70eMbyF3iLNvHHNmRLUTMFcn?=
 =?us-ascii?Q?ZtyK0nPeyuZVDcFKniCI5lVlLrYVajiRnkMvcHGOqFm5hUdnrQj5j3Fww3oO?=
 =?us-ascii?Q?NnGtaQkCRxT2MYpqhY82aeUir278ADoIJJs3L7Aox3D4rK8XA01hhI/BD3Xg?=
 =?us-ascii?Q?DJ4tomwZh4zEalzZhBhCwLLSHSwDxQamxfcp1PJ5f66xMzKAWtrv3sw2RDyf?=
 =?us-ascii?Q?1QqQH4gQCXiXo/a4xxF6zDbCW8BnJj2s9xDqmWzP1lyWw1RG2kKHYfexug22?=
 =?us-ascii?Q?a+CuueYQrMx24CZ/7xt+JBSc3kE+G0+WKP5jZhDpt5+XuQuuNe323yROCmOE?=
 =?us-ascii?Q?cH1xvJ036DWLSI0deWNXiEBh0nETUuKG7vLkYJIyQPRNy+Bpsgd5MzttltCS?=
 =?us-ascii?Q?MPl8/hJffdq4jmEXo4VuMv6xLbcRxvGVZvu970Q2Ad3FJIg//3yC2PhhFirj?=
 =?us-ascii?Q?S/TXL66oHOj92wHUkiCn4w/daaJh6I9gnkSmXsf/0zPtlXa63G70BUben9kc?=
 =?us-ascii?Q?uv++z8zmy7ZWZoecPIIYRJqUpcEpjgVos+JCcNpP+3TTBRyBJhNGPi1DHeSo?=
 =?us-ascii?Q?j4ObA4dPQtuzEye+s+yPARZgqS7x54z5z78jsQ4j+QIXrL6iaZFARpyu928t?=
 =?us-ascii?Q?4ewHosgTwRCPbJFhB5N9Vrj9zlc2vrjQ131YW2o/oUEPd4W/MQGmHesGmkqO?=
 =?us-ascii?Q?RZU4jl791DNAqblZG+DNztLosZvPuJaTPUWJVnLXHSbLu1fGGhGTOdXVhxUu?=
 =?us-ascii?Q?obWB9/24/sk3q64mwNg+DqSzb9Tw9+qSRiELaXghcyEwuM/AMe02pI4ewE2Z?=
 =?us-ascii?Q?lPs/cTSIFVwGm5jWPqTB0/8RmOahyBdd4q0uOf7mKasuJNx4odzrm65Mcq81?=
 =?us-ascii?Q?l/1g+d/O9zB87dIRCT8MJeML/oMecZVvkTwQ91fTU9WjRfvT9lmodHauWlOH?=
 =?us-ascii?Q?NxuBdRZ+1/lr5QNuX+IaxxgWdbZjMUdZwUaAMAtJEOu0WyHMZFV4c/bxP+fn?=
 =?us-ascii?Q?KZz7TrEtA/TJ8AS5UX/ezjUwImkox3AwHSMAGkG7f2dngtOne6lqnChbB4vG?=
 =?us-ascii?Q?030+4DSNxOOS4AxcZ/0wlcFwLq4/huTBzR7jXf+QItD+SswCSW1OcOyEjX6j?=
 =?us-ascii?Q?aZdUIvFOOxU9se+2HRb2rgFtphCsJB4dJAkbCqQM5bYl4ar3FPIS+YAxj2va?=
 =?us-ascii?Q?RC7I2Md5RIg5agwshSFhHtBJeqwIpK2ujBAQ6Necp2xv7c9H1O9rcWS6JRjb?=
 =?us-ascii?Q?LTK+SzOKBS7GmIZ+/B5g9gUMXq0C2l7jtGCccLY3gfmUqZRJNjXgkh3S3055?=
 =?us-ascii?Q?Un99HfoIzqBWSepYdC3grzxrKwWf7xBRvvlQk6L+FYNRaTRtGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PO33/GqbLipVvEy0FrPRxvoZ8A7tji+GtXuVNABg9OXvty2ZJ0FjJmJjfjV8?=
 =?us-ascii?Q?2FwYiBL/F4C9LYCf27ih3HEjlTSu0uxMitCGemKGqnVkYBLaMDClYigQ7UUQ?=
 =?us-ascii?Q?+E5MxzNv7nmOItFKW3kdy6VxPqUtK70Ne/xNV52U0YFXU7wD4nU8+/HfphJc?=
 =?us-ascii?Q?h7z1tOmcZdLypRTe6wOX6XKR89oid7iNdjIzr8kWTvIf5LTJ6jYuUCN2saGN?=
 =?us-ascii?Q?3jOGwc3XLSNxzL98Iz3DlweJf6oIPxuLE/Yw5CHk/MjormtECNj5aPX7Fi+C?=
 =?us-ascii?Q?AtT8thTGTB8Mp1e+Fr3x4OlYLnmYDL7IeF1SwDHp0FwOw/bkG89Dv0jaDq4m?=
 =?us-ascii?Q?sWNXrnYADzQ2fGyHMYzbmgTfoWCiLjSURpz8w2FAI/Je5GGk/msLjtNOTabz?=
 =?us-ascii?Q?QkuCtiS5IIaIigPXiBBkuBgpGgWjINXetgdoDcp1FoPznPq0c7FoXPDdYLSe?=
 =?us-ascii?Q?GcBcFdvCnKYBMEsDQzKpxRgZlS7vEhbtP6i3H9cAm7uuDjmDdxOF07kcAnYs?=
 =?us-ascii?Q?Bg47X6vl98LyXtQ7m5s9c9lddFRHjUYBU9TaO0TP/MJfUjlxCZBRO4x4vtRo?=
 =?us-ascii?Q?7hHqTvcNCP40TGNKQ9Rp9R18JCRPc8eAUyWozLqQFx7Qz+US96hV+5ri7r0f?=
 =?us-ascii?Q?mgolewLW3GxvKTA42BI05chKl12xwDle4U8pgfZk04Hne7D1+SOuAdN/O+WO?=
 =?us-ascii?Q?wNDECGSSg4kGHGiEKwDcpdLul/BFCZGQZBnqYnFZuQCfZK0aEPjUqktcx0jO?=
 =?us-ascii?Q?j0rm/5oG+rjdzQyMkbOBWQQwmI1ILPwVjyDHjuqzru5WwZ4WFSEw/n0F5Tye?=
 =?us-ascii?Q?7HJiX/4LpxuE+VQi5OboGmUhB5GhJJ07MtHNL/GtGBMLlUmKa7AUE2DCgqHA?=
 =?us-ascii?Q?oLr88aaU0iol9U+o40m7AfYcrmktea8bQ82wN2R0DTs4qgSCDZEYSbs2CnC8?=
 =?us-ascii?Q?1Tk8znUjKbb/9Y0ocGuc33d/aTDUcZZfQRoYv9Qz/XGYODgGZc4IIklzSU/5?=
 =?us-ascii?Q?QjDQwJR30H1B7BWTJa+Dyk81rK1NW8ISZXMdX5HvCC4RS9Ao9lAgBZIW1/nA?=
 =?us-ascii?Q?mq1nplEqDn1KHn37/PKUKbThwGGjOzSM4Wsn6XkJKnMEyYIWbGh8aQ6c/hMO?=
 =?us-ascii?Q?BSCOOZmUdKGg1V+Irqv/FMnvpd1mZ02PK7zhNnBmthR7CfMfYqCtb+qz5hm1?=
 =?us-ascii?Q?43txqSn0tE8XsDrOUo16CxXXNJildWIJzeNk2t5Q/YRAcQ3/XbNbhP0+SuNQ?=
 =?us-ascii?Q?rZdQsQracJxplSJeqI+kDsSeuDwT481FTsCzuQXuS1hzdBQpC2ciwVEAx+vA?=
 =?us-ascii?Q?/6NKPy3mE5Qu50mZOBUUtSamr7M0+fOWoiSBqXGuK484Vjewh/W3WkL8T5PC?=
 =?us-ascii?Q?pbj7idPqJjR3pn7hTwDF7Hr7qk/4J16w8nHf+q5YLTyZT/lrQrzlnPDv2Zze?=
 =?us-ascii?Q?ljPMNWIPMkBxHzSXnWSf0I3KVhjH4Q2Fi/FikXlyVuqZD9W1TV7/xqykCgwP?=
 =?us-ascii?Q?lJ/6g8lzCNAMpA0S3iGxQbmCHezin5vzYloF/PuLAqP5oXDNx45T241tbreg?=
 =?us-ascii?Q?XgpxzSwgJWjYiARv6Xkx+vYfvsCMiGC58ZuIjfwULnh25/G0vJ1WhAVcw6E9?=
 =?us-ascii?Q?UwlrJnLPxzpHEDix414pTVA=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d217ba5-f971-44ea-452b-08dccb1c7c30
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:57:18.3858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdTeomNN051ieiF2kGMw0YuS2rip8QGSq0GtNFbMVJZSbT2FMN+aWrpEK5C2VN2vas/xEN/m0yeoxywi6XpZJHFOg80I8d3zvqgjlJCibDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3612

Adds support for the Variscite VAR-SOM-MX8MP System on Module and
the Variscite Symphony Evaluation Kit.

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..99555767f8d0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1071,6 +1071,7 @@ properties:
               - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
               - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
+              - variscite,var-som-mx8mp-symphony # i.MX8MP Variscite VAR-SOM-MX8M-PLUS Symphony evaluation board
           - const: fsl,imx8mp
 
       - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
@@ -1149,6 +1150,12 @@ properties:
           - const: tq,imx8mp-tqma8mpql       # TQ-Systems GmbH i.MX8MP TQMa8MPQL SOM
           - const: fsl,imx8mp
 
+      - description: Variscite VAR-SOM-MX8M Plus based boards
+        items:
+          - const: variscite,var-som-mx8mp-symphony
+          - const: variscite,var-som-mx8mp
+          - const: fsl,imx8mp
+
       - description: i.MX8MQ based Boards
         items:
           - enum:
-- 
2.34.1


