Return-Path: <linux-kernel+bounces-546117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A34A4F698
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333B216E9B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407D1DAC81;
	Wed,  5 Mar 2025 05:38:33 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C6192D97;
	Wed,  5 Mar 2025 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153113; cv=fail; b=HdBakZKIkRxOtmiIT5k99FLkvJ/VkLi7GmAJRd8IH1GW5YNkZvhJE8EeM50uxEnrgAXDh9ToN6F0K3v/VqyiXhTejHSjsE/Mqysec2aygdfoqXILKR9Bt69VJJ9/LxTsfk5gKGtFdngZDiLEFCE9aM9f766wgTZFHAp+LKPpPH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153113; c=relaxed/simple;
	bh=iQJ+6ma6PuNeCc0R6EXAkh6Mmqjho8iloH6nJAfmU/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TptsR96FIT0nnBL+r28t0Pjo+BVRD75sY8IeVaWhZSpHixJMMCBAcISJUqzKe2Ym/HCYHfoVljFuSvMRIWXju42xcZM7PIrwcfOhD/14IEAEDyhMisjqJEs+zCDisSBvTSbJO9lOjuWWVS0keGlbbFrvKTLAXP2DjC7qfbBLfSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlA1EeUfsUIRQXhcI93xV9ICyOjpuNCGwx+x119tUvbKD+axn9HAgvY2SrEns2ddFAcQzJrUnBQwdYwJPOlr1oqV8rI3Pk+GGtGuxYBb+zbKbNRd+NU+gg3feKFoKb3nAy0oiMwfX4frXq9V2tPWUanns9bUYnjlNIrm9w0hFSyCrUPBH7EyhISUI0glAmAfaGZoNDVa6gRQ7ZExTGbVW48sF9TQDjSsK3uHDxGTa/mLo+VgOLxsdRqH6G74/fIrJBW1i7x5iWGQ3Iq73zE2nMqEdwL+5ZJ9e05yMNUZPB9mire8gxURwlBVJniOL5WFcp2SvWxGS0AlUsROvmx5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdPnR+qQTKK1uT4ot4BQhrMALpF3oO12PDINoZXQpt4=;
 b=Y2LUZeNwfDykuFplLbMr/9AVkJunOVETg1hSpjnyQpuRgwSgCpenXzGrZY2qDwU3nJXVJhyK9m2BVUBoWpNJwRFII8YbL2HhwHjzS3S8W/xCbiYluq/30C4lz9ZAzuOn1oZAp+Re04bEnA9ET2ZYWW2yF3BZZES2I4InthjVMf5JSgvHWc8mmMJQm5zqI4PyoY36as80GnQNF7Y9NKcsMbJLX1O0W8nfHqsOHfJ0k6Tza4rB7eUKYUfTJSjlXu4wCiJ1wBRRDfSWb9jIyH0GgTGdf4fYmiTLmneBjOkdGOr1T2O+J6h5WNEyb0+/tjCs30t89XGN4Eb2yPTj7SMJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0030.apcprd02.prod.outlook.com (2603:1096:4:195::17)
 by TYZPR06MB5228.apcprd06.prod.outlook.com (2603:1096:400:1fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:38:26 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::f2) by SI2PR02CA0030.outlook.office365.com
 (2603:1096:4:195::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Wed,
 5 Mar 2025 05:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:38:25 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A7EC4416050A;
	Wed,  5 Mar 2025 13:38:23 +0800 (CST)
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
Subject: [PATCH v4 2/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
Date: Wed,  5 Mar 2025 13:38:19 +0800
Message-Id: <20250305053823.2048217-3-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305053823.2048217-1-peter.chen@cixtech.com>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR06MB5228:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d475a08d-f98d-4c61-137f-08dd5ba7f32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E2G6gZ30YDt0KLG3qqWUtt5AFZuBRMNDr/ujkCvKf+3zdu29DgVuWN/vxNF4?=
 =?us-ascii?Q?o9/hsxZZVKYaW5zXMSn8t46S8+zY6ZivNfrB/HV91T6zqZtAZE3FITdKPfBf?=
 =?us-ascii?Q?zD8v5JWIg9spD8T8Q8daM4ZWHcouC47fe8hBocEvv5xqZ8OE4M41nlPqG7Nd?=
 =?us-ascii?Q?LBAbUl8Xfx26L/MrIlUGM26800uklXwGMWfNPh+wP2BeUrpwmd4N5kWpfG4S?=
 =?us-ascii?Q?vS5tH6GYcQKgaDOaU+iBuDG56ult6AGPjXyClxLoGCUDKaoDHbacNkMs9rzS?=
 =?us-ascii?Q?AesmalmGow3XNTaV8W9in8m8wMrKnk84hF+xPJVR9Dp+Me9pURua0Dm4hG1q?=
 =?us-ascii?Q?/t+TjHGsNj8O/nkuw5HxbT0BXKiDnLe/PwB9TwKQeQ4IxvY26C+lEj3fd4yi?=
 =?us-ascii?Q?f3/waFfjlXklavL/nnxYAXkObz9jL0gs85N9O0HfyruLzke7UMcTV2PlxjsX?=
 =?us-ascii?Q?WUqwTpDCMnhChuiCR3pxOmbMhpPPagzKCLNGVF2xyaLSoqigYYbknXCELpSh?=
 =?us-ascii?Q?mxNaVtaW6UdwsVns/PrIhcOpKDZW4fc1smUrrCoqFSB0rPvEk8ozmvXmkaIW?=
 =?us-ascii?Q?KQuJ5sk/SIaweYrtefd1pc0LVMNjkZCO64IaSm0QPtVJphXwzL9FtqA3uwT1?=
 =?us-ascii?Q?sclPP3w1L2d78L6SHFxjxZ8x134i9ybh6bi3yEn4uChzj13wI+EPke460dfm?=
 =?us-ascii?Q?31N0zybbXn6gW8XTWfwkhiEXaotq5qg80TSKksL9dOCjbXCYsLK6Mn+9Hgv6?=
 =?us-ascii?Q?IqLGy0OwiPdu2jhBWjTM6l6y8W+k+9BqOmQk35wxQZKGDi57YvtqrGbRa5sB?=
 =?us-ascii?Q?EeCeQPRMGNQdZFG2On5XSjPYK8kQ5BXrcdgNgJFFAzi7j3nNK+FEGNLXNkfR?=
 =?us-ascii?Q?brMge4hZFWZD63ooKUcDe1F+Y2caKQAcRmWxVErLAtJV8iaRGv1lDNashIWU?=
 =?us-ascii?Q?HyJjfcPgDonyzX4sQISlFiEMAcXAQ+sEzofWFB7elkySWWfYDvRAalyJUYXk?=
 =?us-ascii?Q?rTY/VkUmcF+vfD+BwTT0z+yovcwPNjU4hpBpGGyTh9F9meiyB8zdtQ8yRh8c?=
 =?us-ascii?Q?sedBNjb/ykyguYGBgzX8uYzw7l9Xex7ambnHE1X4m3KmLKx+ClqGZyf/zIk2?=
 =?us-ascii?Q?F49RtZVoVEIQCIEkEZZSjvPsffxLHcim6Vb0GKqGrz+1/Mi6chW0ZB6BF0Tg?=
 =?us-ascii?Q?+heY8DHR5YGYNEtvU1BhG/M/EIHgGtWxjdwSJyPKulkMI2Fk5ef+gr/5AAIv?=
 =?us-ascii?Q?+squgDIuugsb3ZQHiqbCGgB+HEsZ/YF3CCcSLynSMrSDuVGTXrruwEks1O4w?=
 =?us-ascii?Q?zqV7ORsuuGrIbDWDYYzW20olK+iBGJDND6gornA8mikoypV0vLIa890bG70l?=
 =?us-ascii?Q?4YoeRVtcrl1b15254ERUAE/mMBvrocZCEP1n1hqB47Dcy5Iwlc6khJd+SnZD?=
 =?us-ascii?Q?e1EGgINnydqEbSZeUszT2dB5q7Ne8uk5?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:38:25.1487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d475a08d-f98d-4c61-137f-08dd5ba7f32b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5228

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


