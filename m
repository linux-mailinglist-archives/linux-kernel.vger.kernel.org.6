Return-Path: <linux-kernel+bounces-573200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57CA6D430
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CAC7A5775
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1FA19F41C;
	Mon, 24 Mar 2025 06:24:32 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C218DB3D;
	Mon, 24 Mar 2025 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797470; cv=fail; b=np7YMH2D4yQ5Aybg2r8SDNTumiS+azct4QnXKxA21+fLcYm49X9Qv9KsI3jyMkUCJFsHpsKzGq8iak2x54QPSVike+T0zgyaHNv1SbN8zHTohgKuaI6jfQrpFRykxtXcG7WyrOmkrV5ECs5aZNs44gZ1aVVcZapje52G6iwKJa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797470; c=relaxed/simple;
	bh=iQJ+6ma6PuNeCc0R6EXAkh6Mmqjho8iloH6nJAfmU/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akJoKhuY+7KuVVY+FirvCCYctRxYryoQT/uHKL+BMPzu9wds48NswY9ojFLS1UNUw7S6QmEMgwcNi1NFvmWigPWTVWlpOEeiVpJTcx3G06sr9hpKYppsD7U+MIPrHWhjlUgLjOQxEzNvLDbVlI50ntSqKUHBkZZIdALFze+g4C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXsmmJb6FCQreXwc41nnHCNXMQECK+SiDXIKryMI2n8Ay0yVZYp46+ealbddVue42Wixa4bdnIzSLryKwoV5L/oqq2tAtlncjj3n8lWiPyFFRkKyqc97wUUYFc4Q5sHdhkMDTklfL8C8YblXldm+Wq82XvqsGJtzQ1JPiXt+KBE/GSZpucqdWh8/t1W5YX8hQVW6kGgq9/LADJTIn7vmi4U6bwlnnXJpkPhdlgx1Mfn7/J4gf6ErePjvS8AYpBHSUSAU0GVnEf11ePu1IiEYVssHW/EBuqrMrmgbDkU+nmrDiSeUgKSK5hNyH8bzwVls+yPuHfMutfY66gV6polgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdPnR+qQTKK1uT4ot4BQhrMALpF3oO12PDINoZXQpt4=;
 b=Y3KV9WueeEE+hzZr6p4bA+jR+U3m9vnW3xDNY2eDt/H17I/SbDXcWldz3OGKIS+wzsLvMqaqdkIERk8blCYcqc1jzb93wutY0QgHJEbIJ48Njyy9cGfH1bq3qgk7Ub8dvLj0sObCLU9cxS/u5Tp0ka8qAvps31BImYDI+lO95HZAJpI9hSiCW7A9O0Dxa/H8rp6W6pDcTYgaRq8eqcq5aaNZMVtbMG1YNPj3kUDLVQfsYCNAQYsJ1EB7PP42EIF9OAdbh2InwXunkZLnDdlyydLpudu45afg4MtWM1yPFkx4PWS+HQ4tlarRsCg8cnyqa4giL8ngHFFNz4vvL+59Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0004.apcprd02.prod.outlook.com (2603:1096:4:1f7::12)
 by TYZPR06MB6191.apcprd06.prod.outlook.com (2603:1096:400:33d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:24:22 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:1f7:cafe::84) by SI1PR02CA0004.outlook.office365.com
 (2603:1096:4:1f7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 06:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 06:24:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AC7554160CA2;
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
Subject: [PATCH v5 2/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
Date: Mon, 24 Mar 2025 14:24:16 +0800
Message-Id: <20250324062420.360289-3-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYZPR06MB6191:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c18eac63-fda1-4712-4ddd-08dd6a9c8403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NgApj/52MgnND81kRAbXlNnGJbMPNDtRhN272dnXDhMpBSZ8wO1Cy+qmnHYN?=
 =?us-ascii?Q?sy5wHhH2YbUKXHjTjPLT6xQeDPt9caBMGwldvJq0+2orQFy2KNJKvZe4/FEo?=
 =?us-ascii?Q?VHNmOa0GLxbYiAbqxdfy5JhnScSbwi5e56lZkf8aalmfTSLCWe8vMmBaOZ6A?=
 =?us-ascii?Q?je2JeTtMReJElfo80MTDnpH89zAWem8iw6EILbPPEsjt9VccqTE/hwxLHrzi?=
 =?us-ascii?Q?E+lch7fumWZ3KPxOgeb29MRb/qe2Ybh4QhkS0lchdNfNHOfNKdPi7rZchV0t?=
 =?us-ascii?Q?AG5w5qrcd2KYlgG5Ek8Sf/pFvmOts5+9FZRqBhZsBM4G92qikO/o6unvJxTx?=
 =?us-ascii?Q?ebopK8X7p1YF5YQ+3iSOU/+KVBwj4kReV73yb3rA2N3fq6F6+e/suShNuGKj?=
 =?us-ascii?Q?+aLXxSBH+8YogAFUhTLNIpmXElIvJiOtFhS59hEO5q2oTB2XSfO4xGyWt9hN?=
 =?us-ascii?Q?wx9M+BmiFxuCYdmPZzSFzgkUTBVKJm+yrXx3G18w0EQgZiYZSSJWbECjZAuv?=
 =?us-ascii?Q?rO/9g3XrvCTd+QxAsOZ59zfMwT+BpET/0Wn8ZvDB1urQtqquxELDYu07cd/4?=
 =?us-ascii?Q?sbMPnlujcH+8JLHJ/YclWE2BK46yNQBBwM3EVHc1dGOogQJ54j5+TeffPwVE?=
 =?us-ascii?Q?YFtjKm5t79rGQ8BtAvPu6xBre4qktAsIBxaZJzXhQchOy1cm1gtJpKuo9WEs?=
 =?us-ascii?Q?JzLpSuWQp2GDeLNrDsKpJM4OcHXG0xamn3wwhpwi5qxmcjkMfpD6qSZfb0Tb?=
 =?us-ascii?Q?bDv7p+A2YlDYnpLqTDaQVJAhCBT8Z5o9uk82DtW/AieMxxPaeh+JSuxFIfHY?=
 =?us-ascii?Q?Bb0NS8619/mMl4XzoJh8UHcGI5cnOnkkMRP5Pyg77spsKPQzMpXUU1Xd6SEa?=
 =?us-ascii?Q?oa+17uYV2bGWDwA4NM1RwsCfihLEJ7d7n++D/4g6AGFgjxc6y8omn8+8ZW02?=
 =?us-ascii?Q?lG8woi/ghaXk7p0Vp1aLFiTUBkZd+pLGo8iQmlJa0y+smNZ3EIMgd/FCHuG5?=
 =?us-ascii?Q?DQPFC+k2WAdNXqJxfbOkye3Outn6gnX6aotsobqsYL4mCf0KHrdssw7LuaF8?=
 =?us-ascii?Q?dw2gDSG/TqiyduxCv9UX5YgPrw3WPH1s+n56q/3OcBr8CPpoZY+OGT51gePt?=
 =?us-ascii?Q?qOTgUMTCcyEDgjXz3ds2O7oHfhO8YIKJu9Ey4MThKof/wbq5IwkP2Mr1YGfa?=
 =?us-ascii?Q?ca7w2Falfu+tZkjAKtz5ppW35kl5CORPk+kA2zjYHg+6tc8yvXU/Fzxp8xvk?=
 =?us-ascii?Q?qWgeUgx2X8jmy5vs6BHD5hrXRcoGCpcHjw94ii2KaWUPTfam+ERL8zrjH2u8?=
 =?us-ascii?Q?2mFscs3X3VA/pxh6KJlnclDw9UDNFlsnDKtCZPNU5Y5qTf5xA/ReeG3dKcF+?=
 =?us-ascii?Q?cl1jDIthEsgrxIt50bAlM6bfNScZHo+OZMRfdDtWYs4wfgvPbj48PK528NhO?=
 =?us-ascii?Q?xeYQw3jzaY4F8fPVItMm6JlGYItHL98C?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:24:21.6229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18eac63-fda1-4712-4ddd-08dd6a9c8403
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6191

Add device tree bindings for CIX P1 (Internal name sky1) Arm SoC,
it consists several SoC models like CP8180, CD8180, etc.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 .../devicetree/bindings/arm/cix.yaml          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml

diff --git a/Documentation/devicetree/bindings/arm/cix.yaml b/Documentation/devicetree/bindings/arm/cix.yaml
new file mode 100644
index 000000000000..114dab4bc4d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cix.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cix.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CIX platforms
+
+maintainers:
+  - Peter Chen <peter.chen@cixtech.com>
+  - Fugang Duan <fugang.duan@cixtech.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Radxa Orion O6
+        items:
+          - const: radxa,orion-o6
+          - const: cix,sky1
+
+additionalProperties: true
+
+...
-- 
2.25.1


