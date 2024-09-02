Return-Path: <linux-kernel+bounces-311436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE196891E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF201C21A3F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC2F20FA9E;
	Mon,  2 Sep 2024 13:46:13 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2112.outbound.protection.outlook.com [40.107.222.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53378210189;
	Mon,  2 Sep 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284772; cv=fail; b=Tz5Gp13L3jNo1wVU+/n10+EmQkx/txBxbr2v7n/Anc2IF6Mf3dua2aJuGKkfQzq/OJLnctB0+cuKvVL+u+zfrqVrSWIBpbt3Wd104AVpziZPckmBh4RfEX1jVepY87GXC40erL4nHC0TsHOSeXi4sw33ViWUfGkFOkWhnhD+Cgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284772; c=relaxed/simple;
	bh=ERD8adc3ZKqnRFq6i/9CaUcQk+z+K5/3oQxVnkwqoTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CqnHJbIkrjl2zwV0WxLYiQB/nEelMuzSD+2q3TNOTT4+xTJJMWo0r8OdBZM+oulmue/q6PWwfxKv9HZN7uTsmz6dDY5x5tFIug9GsPj31Ds/HeqyVsQ566KM65tC1fVP/d0VszLD1qxEFlo+3BdSvFZpn8g2B0fgrNbkc09wzEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN0zBigx+V3rOP27nkVqainFMaASCqhE9k/EI4Ry+M2BXEk0xh9PjFYxNm6esDExcmN9cDMpCWgBty725pfok8qGb1+94jJYypd3XQaijEFGmfO71Jk9btnKq1vcQoO/JeqmU7r5lb+pt5ZSgVvwq5gYO5Rul8voUSAKce/Mb5Cj7VbwGqlrDAwj85lGBVgpx0jRmFWrNtT8wsEJs/PlXo7ExM1ZBLZMM7oijZ2qQgWpnPXILBq2sqGahX+XH75vDAIHeFx0HX/EEILigE30INducBGfU4b3/vKGv2HG2Z76FQK5NbubC5w6WKd4GqjvPZcCojKhgqYqANlmayEUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRPTwGUK+Mi3hPEOS3uswCRq4T1ixzdqudHBDjKk174=;
 b=msGiZ40e1l9Nz73oDx/c7/cq9r2hU2H62V248pZsniN8H+4heZl0YP78mOBrgcKkxalBRe8g8BLi9M3Fe6dVFL2pugVQWW/9+5Xt/xbwhnYnLPbqgp+07LVdBm8ugk4MKXh8sPrhigbWZMcNWkPZkQUJ5GVIQaMlcVjhF3QkgcC/qsWl8PY4L8+4TLBf6RldRJoAwr72yo1sK9vsOMODi/rBS0yLySFnO63W7h9o1Jq5PafFOtq32IlP1m7hKIVI0MRdyhbR9wl+62ro1qh5PV3kMweJ5g5YZRVBHJsJb3pytVmsUZE8seK9iUAJ3Zb7s4mqHG5hJxR0d7hycLUhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB0775.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 13:46:05 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:46:05 +0000
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
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Josua Mayer <josua@solid-run.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX8MP SoM
Date: Mon,  2 Sep 2024 19:15:08 +0530
Message-Id: <20240902134512.16717-3-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902134512.16717-1-tarang.raval@siliconsignals.io>
References: <20240902134512.16717-1-tarang.raval@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB0775:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c266d38-6532-443e-4bed-08dccb559768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XxwKON7nL8FwcEiyeRZG1ePVjfGhxe4dcIsHUSNP/ZHnQSfMIiVVzQc2puM3?=
 =?us-ascii?Q?W+HpFztlXJd8WqdILsbbZ5JwVUiKH/BQEJYF5SJurLwT8uaBEwOIbVMdrziU?=
 =?us-ascii?Q?x2GD9OWALYptTP1t//dRnkpMbCDhT+RWMYnvd+K9FNl6lfAGTcX2GS4JXtcL?=
 =?us-ascii?Q?0zRAy0NOD/dGGXtsJ6HwH7oQb31IMYPyVPFYpYfvzabi1sLSzFSqUGxAhXyF?=
 =?us-ascii?Q?Jrm6bXj3nuihswCejt/R1TwFX2ZbpRdULltNKQwNVTqQLL7IyinKSNpJD0MQ?=
 =?us-ascii?Q?NOjpda5dyEz5WD2p6VZRwhgZPrfUgRV78FG2Yr7MUwqUx6CqZhPNJzpEGn2z?=
 =?us-ascii?Q?9UJWoG02g2XxK6h0dSuJLfRTRK5pFUIhmfnfmJoajJJKYc1zke7CWauFRk1p?=
 =?us-ascii?Q?DxbOWT/eRC0a6WS+tDStCTK7GqJorIW9FzV9zNfnc80bgqbUm1A2WZdB9sRW?=
 =?us-ascii?Q?WuR030j5cPqWOqnHbxImZFsCfeN67UBDeobUlZ5J44pj5ilSz1aqlrL1Gobj?=
 =?us-ascii?Q?72EAHyEL3BTW/L4Wu8uIBaL+caSY8bmguhERlxlUppB1QqVC5Lmou8nUtqWL?=
 =?us-ascii?Q?bPvijKahxizGOcfxReN+DAvLPc7yRBejB5rEoycEu9BaY+8G0IFXFAblK62b?=
 =?us-ascii?Q?uTz7SP2P5eS3MMPZbHbqFXg1BwFfL9ZMIP+PFYw9G54Eu1JqMwHTNizMimUJ?=
 =?us-ascii?Q?gxEJM+AzfUGuS8aPoIuw+5oqCE/gIG+dJ+QsH4fV5nrFf5U9SsWn2u8HQizq?=
 =?us-ascii?Q?y+UBNdBenpRQdMwzHChk2g9PCkCeMVAWJ4xPiLH9p5I2I7VR9MSgWmUx6mus?=
 =?us-ascii?Q?HdUpD0uDAxq8FK84LAZ1iLO0gQRxj2fvmaoYYXKc0EdOvnXB+oDsTSdat/P5?=
 =?us-ascii?Q?1DqBCNJCQknbJ+UpFdHNvDMDg7CwEBMua4IQ+G7yHvm24jsJ3AFSpT9Cgm9l?=
 =?us-ascii?Q?mDnyDA0StN+W/9nz54DzX2VKudrxova2Vv3r1+y4ryG3DY+pvamF5imHn6Ww?=
 =?us-ascii?Q?PnExX6mv55Nw8sY5i5QWjWsmi+OhyTv5rRcoiutj/SHSfWO6DZr2FlSTESCK?=
 =?us-ascii?Q?92XIeivNWBf0JBoQeItNyS6c+hoITo6YUmF+KP8zpWAjMGKU89fGh0aCz/d7?=
 =?us-ascii?Q?7q8FQ0np9jFe8hVGl91fTujokpKKRR744zSJEAj3OHAht5adfrOh+mzZM7kV?=
 =?us-ascii?Q?pBlDG5L9XwO0CBJVZof4ieFS0K7p8G8j9MrFZM8kSDCNTVlPxftuLNrDefUx?=
 =?us-ascii?Q?aYzEPNHttmjhbbMwOVjavuXAU6QDEHpOZ0ubAODmjhqKu8DGjAbBLDCQOi5q?=
 =?us-ascii?Q?1MJu8MXVIz1sYJN9fUIoUOJy5WTxywWQOUwdRjLQTjVuM5pYpLcWBz9Bo+sy?=
 =?us-ascii?Q?vIdxho2LVnUatmGKWYmESgwt92opgoFm/7MUoHW3Uy4RKUGliQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5VZgBD4Kh6+4+a2IRT+kk03sWTCDzx40rFpcARihkkGsBnnHTyK9+mVxXHhx?=
 =?us-ascii?Q?tFwd4l92Jz12qVrOsDQKmRJCub6XNZGPq+/X6A00vQGccuP5SrKTKCCOcPTe?=
 =?us-ascii?Q?lBgnvsmtTQ1qikGjg4cMV5Rt7HkL/RpdiWHK3VKECVtnh0HtuMpR9TUqCtdT?=
 =?us-ascii?Q?tHIUvot72oxZebsFfBblPb8VOw0N1CRr0ijcvNXSHPFEvHf5xzxmRF6iC2bo?=
 =?us-ascii?Q?jQFSXDHl94u8nnzyNq932Dp2SpjwEvOKU8NgNFX8ZC9dnWsO8z568Y1JsKdk?=
 =?us-ascii?Q?z3TjyRLmMPIz6IsY1u9jJMQPL+fgMaaTUzdWuRhauoRwN0k1PLxGpKK77QJW?=
 =?us-ascii?Q?6YhmSx3md8FaDNs4TyZvZYQR1+m12N4y1AKXeHBnyoYYhBwspn3eGdbEDI4v?=
 =?us-ascii?Q?LhGtlYP1JgBduCquC5nPQomz8P+W5NJ1KAX+VPI/Due42PgpQkaTdjf0M7XJ?=
 =?us-ascii?Q?S0/hwnReVxm+sYSYaJysHC2gEOtW2ki7PKz5NChu7tNA7qP0XR6NatLJQx4b?=
 =?us-ascii?Q?0sBjhxCz253iBAx5p3PNO55P3h95x8fwpvOq/5He/rjlP3wxfL7s7YriQVSn?=
 =?us-ascii?Q?Tk/LVOGSCZqxXc3SRgC2sp/GRysiioibpyEN66uSLnoApJA22jMA4ZISwnV7?=
 =?us-ascii?Q?TM0qpQXgaFYdvCYdqPEfaq+xulVUOU/BQdh2/l1iEqAb2duW775k2ff5PK6N?=
 =?us-ascii?Q?QFJIP8TvOuv0YN2AEDPywoZlIEU31k96X4bG41xOdafmRzAIVwwIcsbTU3/g?=
 =?us-ascii?Q?pxQgo8rtktGejNC1Jjdo1F8GgfRf5kxQelHmptQEsNaxLJJC66B5VQaFZY5r?=
 =?us-ascii?Q?jyp6p1RzJ/k3pHDjnUJQ/TGzZ2zR+MTSiDztcvpHIrDpTLGAsACQ4aMW7Glt?=
 =?us-ascii?Q?xF3jv6Z56AjbgIKH2vPnISaYqssG4Vrma9C5YDyXrLROXUCvTz52IjjG5t5F?=
 =?us-ascii?Q?0p2AxxfvjyPiruJyvEDOcsdYXgcUvtKRH5hbOcMXI62f1pgD9o3hiXhynk/i?=
 =?us-ascii?Q?6qN6hiKVJgcv4nOfuqUbnf1mJfSHuBDC9tDyBma0icUMraNNCEx/UuqWekRq?=
 =?us-ascii?Q?byKPnLBJyXTrB0nW/qNKg8NgqGuuDwZbuufHOHsoMIKiN5kr+xKzPHpQjkUc?=
 =?us-ascii?Q?CBGd7B0duYj1YGOt7trY7GJEd/MM1lPsB3P3V1RrSlfO8vMRpmWY8wzhh5S4?=
 =?us-ascii?Q?nOVWM64WIJdXhTu5Xk7j/Orv/di2vwE2Z1njjWNoREsfulvRIiI3q2cWYV7/?=
 =?us-ascii?Q?RLm0L071ixSALT4ixO5H8k3rsavOqVYa+sKE2vXRDUX/ysg5SiJWZOo3ZvLj?=
 =?us-ascii?Q?nCfJw9zMHx6yd9AZlKBkeLTTPHrGDxayVLHYbZjgZuvujAk5OZ5fvRlHEZHu?=
 =?us-ascii?Q?oAtu35YdbqdW3JRg4/Q4UVygSC6pJPvk1L/4GxSohMXx3PCdTVGYXUKJBd8u?=
 =?us-ascii?Q?WpmTmSQ45NcUpzpqd0fu1AQKh5T2/rADtEkn0J1/okrRdCfvnXcyoxXMLfdO?=
 =?us-ascii?Q?B449+24D2g4c9q/OdAzlyLHpIsHe/Jz21T28/ukfcFTIqV5NNDVnscCDnf2P?=
 =?us-ascii?Q?1jtJBN3BepPT9jKnaMFWFbKPJXvdLFuVayrQAXZKHt1WlA4Na6t+3plKFQ4z?=
 =?us-ascii?Q?4aoanOLN4LV71wd/DgdzrMI=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c266d38-6532-443e-4bed-08dccb559768
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 13:46:05.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iK7Fwy04cU+IaN+mFW1pRno6lloVsPoYw4oDmIgJ1eKAeuBmJbF3OTfY6OItUmyh7jw8SOYxBJ++WMI/O314ZxHQ+pqyNYAWN3ZhTJLZT7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0775

Adds support for the Variscite VAR-SOM-MX8MP System on Module and
the Variscite Symphony Evaluation Kit.

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..b28e5c7a5463 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1149,6 +1149,12 @@ properties:
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


