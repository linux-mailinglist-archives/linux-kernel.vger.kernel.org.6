Return-Path: <linux-kernel+bounces-536216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD0A47CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91D77A6BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BCD22D4D3;
	Thu, 27 Feb 2025 12:06:28 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2134.outbound.protection.outlook.com [40.107.215.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBA22A7FA;
	Thu, 27 Feb 2025 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657987; cv=fail; b=WHS+hLzmuMOrp703IDnNVl7KYnp1DHliIiISn9aRtUpc0qaiU6Ebgcpri1dvq7Ja6d5DdLFUHYhEfmSDmpnW6FC7NiPs9fTv01CNezqYhtK9su1WbnkPtDtfD2fEUqq9q2aSTnK7F8Maow35lHY86euijhlJME0mI1Zmr3Fgnio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657987; c=relaxed/simple;
	bh=yTBDoOW4xFl5fi3TpYHcdH8mBxpVujBy/uyWN5HM0S0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKaEIgiOfu+rxCPUpMKYNvnBxf4WbGlLxjTA2iFd3XYUVcV2REuodOcNO+JfFyqfGId+8MhIzHq7hY/OQsCKxBeWzgqoRaMItO54Y9HeUMiBucLX+VVipi7UYOPPbj+dOYeikwcvdxAsT3Y6qpAahJLPyAjlPXaVzQZXzC91y5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.215.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+Y7MxPRPw3Z4849MNrp0SnTxauasq7J+Mvu99a65G4VSNPJNcOfrAI+48lV6oRdIwXpYMSKNp5P+Uqd47Z1eenAeohZOKJRHmmLfq9IXf0HeLXRRg7GZNY8GOVKuxToJFlu9C8G9oUbnI9r/zYSaYDu2P6pRd1dK41tSo6sSSYMmouyB/dfTktWkshNOhud/H25UtapQsl27Gm2tZtF0PM3qdhCCnt7KIbbYN+MaKvqyqGtbTBtzlZsFvHlqAjjuXpxAsD1yyygE1xMG0SjNbNz8FoIoQUNsugSSFdQCP46dOhJmHFmkthUA4Uced7MvPjHrOxQJ6IDjRm2H0qJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blYGi5QwkGqBEHm2vPIx7oqOaZdSyo7iw/GUhBFucvI=;
 b=xF83dVMNIR4l+Ywn1G4x+O71XDJQhIUCVx/P1ohCWbrRMJYJ4fiuC727dUVQoQ0J0IPoXjtmuIx2uyRYZffrTZTmSsBFNdlOiI6l6iF5k+vMnM2aCN7H0k60OVTZWLsO1FhXEvxFQoQ5yJLF0QJp+POWqW9sUt2JWg90rGmV9DgB8MDN1lM4oPn06gp0g2tNA7knnK+zaEmvgyRlZBjsWelU+BaNkx3NB6bLDUAzv8OSeVEYeRffg76zDkBfcS5cPwWhBJH10nBkUYG9nuHMRdrh7ataJBfJTy+CmBjU20bfIjn9RybgM9/rIaGqWh3kBeOoFz0BxbBeuEDfvo6k6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::35) by PUZPR06MB6171.apcprd06.prod.outlook.com
 (2603:1096:301:11e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 12:06:21 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:300:57:cafe::cf) by PS2PR01CA0071.outlook.office365.com
 (2603:1096:300:57::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Thu,
 27 Feb 2025 12:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 12:06:20 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B2E2C41604F7;
	Thu, 27 Feb 2025 20:06:19 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
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
	Peter Chen <peter.chen@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v3 2/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
Date: Thu, 27 Feb 2025 20:06:15 +0800
Message-Id: <20250227120619.1741431-3-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227120619.1741431-1-peter.chen@cixtech.com>
References: <20250227120619.1741431-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|PUZPR06MB6171:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ecba5588-6bc3-499a-d052-08dd57272606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bKMrm9mZ6QeuvyPg3J8XHcE6J1+J3N38aBdHJIMLm/McpVDvPNkEXxfQTDYf?=
 =?us-ascii?Q?hhBindVT7isJV4TOA1G7dDlqwhnVNY+cVV+Fhb9ubq4D5ztWynKDlpHWXQ6n?=
 =?us-ascii?Q?X1JP7jaN0VqbnwmPh4s+LP/fn/hDWi8XX/VIcR3i2bRPo4hn3JchXcp+cEf2?=
 =?us-ascii?Q?TqgXDJhvAE4j/RBAibeSqBBBE1j5uKieO/Lk7GM9dMByV9Kcpc0UlBKHohUp?=
 =?us-ascii?Q?IeiUstpknEESOax47G2ijfm+n3sqWrp/pVIvMMMBCRWjY5bjv1Iqs95ZljI4?=
 =?us-ascii?Q?TlyPvoFna38a60aVQ5LttVLc1seh/30E0i9sTV0tD3/UBxcfYfSXcO5FcY+1?=
 =?us-ascii?Q?k5fV9xPssGcBArKd7Cs44P299t21iFwUffmG+ex1LTYTDqZmWbqf7QRH+EIL?=
 =?us-ascii?Q?bsBQOxguIyatEaiu/5oj/kfnusO+gR85FKcxh0uxXHbJxmfppCNBe4vkV3iH?=
 =?us-ascii?Q?7CoRHhIgl8KVsFT3dnDdVUDMmohwKTzpq8qv441ftSmABBhLBgr8eBye8l0A?=
 =?us-ascii?Q?795aMmDG1xO4m0IguI2Z0HOpkH3pLzKRFCv9lD04SlpOT+z1myz0phbdqKL0?=
 =?us-ascii?Q?gohYiXUn6dD2RAzMLloIUfPJWJLKqvcXF1CdQk1UCVBG9yzBDs2eBdhCc+7C?=
 =?us-ascii?Q?dAPhMP6G9ZRUj+/kdcwNrTGy26SB+QrjLkhIVyqtaeZD8VoQtDfEyQ2lQwNo?=
 =?us-ascii?Q?2ej4gJ3hCv2OlucOyoh4pnO9+V82bkZXkoMfr2ZL71AiozvUKt5ofEfLJNz0?=
 =?us-ascii?Q?+8+Bkr5Xc2kIBkofHxPoYnIqYi1ORNR4OP/ppbowLaSaKzc9ykpYrqmCe4c0?=
 =?us-ascii?Q?F4rOZkuZBHO6alxQBJaH0C+s2ykjiG7Qrf7sv4VtACicH08xwpM4ZbyBw3D/?=
 =?us-ascii?Q?hdlhZZB0w/9sOJD1GKxLhxcRxv3OZo1BEI+1o0G+R3IjG/n0Vlwt0arwL/2B?=
 =?us-ascii?Q?or10Jyzdj4pUBiU8/thJe7zWh2Jkeolliz+iKQWhZTbjqsro4Ga/lq1Ix19Z?=
 =?us-ascii?Q?Pn8OIRgnXcB3zHowKPGLhSJhaDPys8EJxtCBk64K9M7XjaSje4u+Y0a1dDuB?=
 =?us-ascii?Q?BnHcxDMZmvmO5uioSd8RHUd1sAhdMWxc9tnzmEkLtKDEOm6Apjdiif7ttXDs?=
 =?us-ascii?Q?SzR/aOnLD7gETl/JmMR7daGi0hyGXkYSxD06r2pzfk+IqV/ahxFquPEwLGiH?=
 =?us-ascii?Q?z0LLboHKw5/9K6MX1KriDVhDO9OOHEsDPDaMby1jLfPLsnYFQBxQ6QrzG0D6?=
 =?us-ascii?Q?QEjFcXneuw1wVJhHmDURtgOpAQ9nru3/AB4Ft0kkjzsyNgojb94hcZEol52g?=
 =?us-ascii?Q?WX3euo2CbXQQAiKBchXYHvCoIP19zmDnh8sOAIx3Xvy441XliHV2lRXBn2JF?=
 =?us-ascii?Q?oYyYHvrW9kU+8xLluo18NXhdW9coUUkfKy7JY/LuwPFLsfTbH6Sdo37TPCo4?=
 =?us-ascii?Q?S/PR4CLAQYPXEmwTkEt2ucAwvSU3lt9U?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 12:06:20.7143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecba5588-6bc3-499a-d052-08dd57272606
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6171

Add device tree bindings for CIX P1 (Internal name sky1) Arm SoC,
it consists several SoC models like CP8180, CD8180, etc.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v3:
- Add Krzysztof Kozlowski's Reviewed-by Tag

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


