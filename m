Return-Path: <linux-kernel+bounces-573197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3BA6D42A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42EA3A9060
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BCD194A60;
	Mon, 24 Mar 2025 06:24:30 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2120.outbound.protection.outlook.com [40.107.215.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA52AF19;
	Mon, 24 Mar 2025 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797469; cv=fail; b=ZAkOuRl2FNpw2DJZamFNqMJI82GfIAc0reFeJ6TerXRkKmgmrcByRLQpCMI9cE2YgTLY7vWoygFjYQ4KzoGgV+MG9hawM1X/fa3vkbrRV74VSaUSxo7HznCTSvF2aXG+Qy6Zg2+4bdYJ5iVfJsMJAotQCdjLIOl1ohbihEAPknU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797469; c=relaxed/simple;
	bh=M5aPlOjRsMdM7XC7lqJJXUp59F6AVXTxXjkBZMJ410M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufndIJ+XXkhTNkLmjEE4jRooIhygEJQiksPxATMReaGNLeWPbWjOGBtMnkCTTKvE1wlSiB2ebp7Da0XKBHYE1vnonuiUiHIKDqyBm+2o8/vdkvzyRqb1EGuh0ZZ9dg+FpDstpNo9VBr9e081t89gB27gIlLDI0/I2091gwTg1NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McHJz5YMrun6O7+bbxC9tAv904ZTMcBu39GsqIuxV+WfOhiCELpMeCNm94LSmPhJS2iitX/i+JxIPoBHHVMbFK6OwG812y363Cplh3spLHK0RIzyaL0N6Gv9ikSqFbk2hhLCJ1sx4gm8NL7TFPFts6PwjOUZHll3geUfDw+cvzX8JKAq4JZe+6zV5wexG2dnYiQ6WdC0pcGSS2sqB9S8qIltsQBPU+maS49z47mIbisMG9HjodgcDwh//LghTy/ESYOWUbONySPPaWLzSCbujlf7lTlRFqyGyMazx/ufjE61QAGT+FVjQhSpn5JUw7l5JAHTflNYusIrcivgHV23bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IoJs7RDnb/wkfBdAtGLjJf0Mf2v1f0oMTrVyyqNadg=;
 b=VxUNrW6ROxyzZrONjnf5KaPg+xM/11nUlfYzTjBdAMEayOuejmUER3/HUJXZymZgdsA0pj35rr7ct5f/uAOVRfrkudNWvS/EUAJIDuY5X1b3nTWN0/xYEFGN+N5LYtEt4GIEZIKTVsmJCMGPWkMW4hMDOy7MTB/Z4cbg3+4cd7yfWT3gs0zpDcGu6isLagWm3R6N1Ee95EPkZAWgTEFaJKOUlmAO5/krzpVBZVu58h1bgNVrOR1DC1L2m7eb/xZOYtU0Uy3Ieh0BJgH0jrSI+qf4512fOrh74RptNpgS7/g7nNcJH/l/on9ZFNacGyc6WX0idwfepfPWhHzmpGiumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0208.KORP216.PROD.OUTLOOK.COM (2603:1096:101:19::12)
 by KL1PR06MB6347.apcprd06.prod.outlook.com (2603:1096:820:ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:24:22 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:101:19:cafe::85) by SL2P216CA0208.outlook.office365.com
 (2603:1096:101:19::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.38 via Frontend Transport; Mon,
 24 Mar 2025 06:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 06:24:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9B1364160CA1;
	Mon, 24 Mar 2025 14:24:20 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: soc@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	maz@kernel.org,
	kajetan.puchalski@arm.com,
	Peter Chen <peter.chen@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v5 1/6] dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
Date: Mon, 24 Mar 2025 14:24:15 +0800
Message-Id: <20250324062420.360289-2-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250324062420.360289-1-peter.chen@cixtech.com>
References: <20250324062420.360289-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|KL1PR06MB6347:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49d5fe32-66d4-4f54-01ff-08dd6a9c8416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VxgJ3HExFIfY984GGqKvdGzYjSROdP8fldPuiUn4s/+if56WDpjD25EMzOKX?=
 =?us-ascii?Q?digPpwPYFzMV8buuzx45aCxp1K44TUZ/drN3BnGVytoTvJRIFpiZjYajgPLP?=
 =?us-ascii?Q?5KitHgNhMKP3732L/IrIka5ANQSjK/iMwraMeMedPq8XEPpCp79GJkdzlivU?=
 =?us-ascii?Q?naM7zwcNI2CHRZexvEAk4DNgavwX+D+0YIy6FVawFKaPeU13aVhpjNRiUcjy?=
 =?us-ascii?Q?sH4QO2IDiH76INs8vAlzWtY9ZkbYXK7jrQaAnuWHABUE41D3AWAF26ujOa/6?=
 =?us-ascii?Q?AQmtOgQ7rFR6sw/dH80VuFyBNwzklYYIaB9Ha9ZiQCiv5lMkmLe+j5A4Gyby?=
 =?us-ascii?Q?kTcCRqWbB2QhHabSOYayZB1zWVMLZX4nJvFvPecuFNsN2qYCk2aTwPlhSQgE?=
 =?us-ascii?Q?US1KjZqsVgz7/aigPKuTIGJE8O8Bv9gKgbSe5Ie2+frQLUElGfZ9b3c5QRl+?=
 =?us-ascii?Q?WaMtSKUbykMrKNA+B1yOTmy0ytjscDEqQQ6cKohiUB0uNw2yXZ2YJ36HWDeI?=
 =?us-ascii?Q?760oOruQCF3pfesxAFM2mj9LdwJZ9jQMem3XsMvjogmWwH5GxCVFCPlTsUnT?=
 =?us-ascii?Q?nnskkWAFskWf76ZmIYfYVnCp/dFpO0FZMzg4wp6e3Oe7MIsaANcpCcOQJ60l?=
 =?us-ascii?Q?JYvM/bHKqH4l3MrvWlUE7vnCWz/pPbVUvo+TpQlBeLeJqHh4ftStXlFvqgSH?=
 =?us-ascii?Q?28+dBh/fizDOwEEYjD+mGn0Ixrje2Dtq05zobGA6Y2+VCvih9JcN8A/djQrU?=
 =?us-ascii?Q?KFhZAUHsCILm8q4vP8pQfqs2eWvfaf23s4wsywdEgudOwPkAU9QVBUGbseqA?=
 =?us-ascii?Q?1waQCF48boEr4tjw32Oac048sSLXyUD8dmmZ2ycEdcq0UHSQ7icB4FCL7sSp?=
 =?us-ascii?Q?V7xGjPsfFx6/OgUOPhP4HOhYolsPWrBrT8sOhSVYLWhCUNdRPBGe6vgssukV?=
 =?us-ascii?Q?J8ls7ubLUtLO7T5+ECvndYK0aUOFpq5YQz6TBuLU6cQIEg9AmaznwaluN+qV?=
 =?us-ascii?Q?7VoRGiXxyvuMA/ps6UJ6C/vHY8r/kq/3oG0EBenabhxh31uUx7N0WDb2g7B1?=
 =?us-ascii?Q?uhWdcpAXaJZPyqtZ8zEbpfvNuk7FcO8Oqu1nKQ595GC/PlAVhSGJbfEqyDY2?=
 =?us-ascii?Q?kLVE5HyQaFg4l9HGpnJoceitjaLN61f3G1bR/aSmhVN+NHNHV0NDvxG51TfY?=
 =?us-ascii?Q?DWmmXPtPWML8xuxd6BLnxbQ2jtqAu+LoYfYm+sYNPyWoh9RnMfLArHA12zKf?=
 =?us-ascii?Q?0Yg8H4IOA0qqLYmFHSS3lY3gj3GQs3rG1krzxy1amO6pSkJ0yi7X08P2wUXP?=
 =?us-ascii?Q?Mx5tkqDgrLpYWZ9WleWmo6JOKkwNDhEO++P9QGUXjNwUY/ktGBJ8IibMHvuq?=
 =?us-ascii?Q?ZTEggKK7B5kaR5Zfz528m6cv0Xm7+OK846wZ+6hqBpedZfIbaS0dmdXt9RWz?=
 =?us-ascii?Q?jZ8Q+Qte4sA=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:24:21.7611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d5fe32-66d4-4f54-01ff-08dd6a9c8416
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6347

CIX Technology Group Co., Ltd. is a high performance Arm SoC design
company. Link: https://www.cixtech.com/.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..5e76223e4570 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -302,6 +302,8 @@ patternProperties:
     description: Cirrus Logic, Inc.
   "^cisco,.*":
     description: Cisco Systems, Inc.
+  "^cix,.*":
+    description: CIX Technology Group Co., Ltd.
   "^clockwork,.*":
     description: Clockwork Tech LLC
   "^cloos,.*":
-- 
2.25.1


