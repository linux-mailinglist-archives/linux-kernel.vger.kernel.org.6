Return-Path: <linux-kernel+bounces-546123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B811DA4F6A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F063AC9F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6791F09B6;
	Wed,  5 Mar 2025 05:38:36 +0000 (UTC)
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020094.outbound.protection.outlook.com [52.101.128.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF71C84C5;
	Wed,  5 Mar 2025 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153114; cv=fail; b=Oypq6hqtDZ9FF4aVsWXQayKMCaNe4b1oCIg9bWpbbEDeXpmxJ8odXNxkSs2F2904EWPaaYaX31rVrcjcGRD3E+8Qy9XloHSceqHTS8HZqCGgJW/K7THjGH32f33uvoKWP1p3XExvCprHKNl5AD1ciW3hbuE6+AlEJEYIzzTs/LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153114; c=relaxed/simple;
	bh=M5aPlOjRsMdM7XC7lqJJXUp59F6AVXTxXjkBZMJ410M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKGJyFa2pRfb6RQodsN1/rIYmJUQDz1CgpYRbufgX/B0DAAgCQyxWk8TO6q/fLvYUkaMr5hAN7eN7GOzaLjcUcw/IsKc8ZnG+yhUUkoi+v4OHPzc7I5VR0tIpsDKEbDkKniRyLtZKxTgUTal3n32uMsvYIzZO8PjOm2mxM+BCh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.128.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7zhuGDFkHFuJFPSG2ZLAgW2RZuizpBGTF+cvmpCk6mkqAZ8DoDMNK7qx4HUNrT9ronAq0pRkL8dbqXMmwymQxBjlBIek+Ytka779hiuaHPsDJXMDFWfL4WcyPCE/XuVD1IthZE0RDMNixH5oTd/7GVj2uAxngxsspTsPhZHSOEscLYp8Dw+oDGSCgJEfjNPpnrDVpZw6g7/x2JCVtLRf8r4bySs1AJmVBwFCC3XwHY6CxtlnYUS0myv3BTZjz2ALQCdGvcSK8y5kUSRNUepqPKdX3XuNmuQDi/HqRdgzXZO8uWkXIi6aPzs/qpB5aDVWCfFjyu5FRyzpAmzDkB0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IoJs7RDnb/wkfBdAtGLjJf0Mf2v1f0oMTrVyyqNadg=;
 b=jvWFCmhhuO0n+ZEKrR14E1dEx1LI/tD8nwURW4589vVwOlT7Dxa3vmfAYdvOk9Fp52Oem4eQjwfIaDoeedoIeIsxPbNJ8W70f3cx3ggg8/IOWGACQL1b407Mko7gKsA2WrMbcikggJPFwmeIdmMjvJSXtrQDkxVVCQSS/vjUPR0BdurRKVLUIBZ8n6HV+XK0zfvOrqiDoRvgezGB0lX1Dnfwy4kuJn+FpNXp5SDbzdbPM6os9TJ3vHzppLYRK31moDCLfvAQBBDlfG+OBzrydIP4UnT92Y7hS5uOjAmlL9fJNI52r4KbvVrWEs+Uhn9Gix8Bh9v+XIkm45zi7Jmhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) by
 SEYPR06MB5671.apcprd06.prod.outlook.com (2603:1096:101:bd::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.26; Wed, 5 Mar 2025 05:38:26 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::40) by SG2PR02CA0008.outlook.office365.com
 (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:38:24 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 96EF941604F3;
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
Subject: [PATCH v4 1/6] dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
Date: Wed,  5 Mar 2025 13:38:18 +0800
Message-Id: <20250305053823.2048217-2-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEYPR06MB5671:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fa836a06-58d4-4f0a-dd9b-08dd5ba7f2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?42LTxO6M0zvMsDJHzHHJdCZ7RmgsjdIng7U93Ru8PllisGBzOIdGhWU5QzaE?=
 =?us-ascii?Q?QDHQkwjHL6yvH1qYAgWNMgMVizjc4Cbl3Mzk/3rLYvblYuMRGxqziofFaK09?=
 =?us-ascii?Q?kZt2fZrd5DvgJ9bROtmL7FBrH0nP2A9WAFbaFyfwSBLOlfTBjBHJashZkReY?=
 =?us-ascii?Q?fmc5C0AUpRD1+CfVheliXOnd1HK/X5h92O7Cr7jYVZTa71YK15vnIGumfrW0?=
 =?us-ascii?Q?NJr9eW9L+xFWcNlvmyJDdVogJhTWYDdHXHEF9yPYP/h3dRnAovghtPNvDjK/?=
 =?us-ascii?Q?Arpul5vwkCfS+jXFZ1uZelRhwqD7cvxFkOMVmOl9x6YeXvPE5GynRqfRP98H?=
 =?us-ascii?Q?geDwm+7hVQWq/g/zA4h8OJYICrVa+JLpni2x/Z9f21PEyHjv8ofI63x2jvsG?=
 =?us-ascii?Q?OfR5T89Kz5Fl6TsJ12sk+xt0CZ7cVWnb9azRoWBB2ER/GmyqFolMWOr6ozzz?=
 =?us-ascii?Q?Y/kObSCpK4KszzzSvrppGQOl71A3PVSRqeOUOvhv6ur9ZeJx8JbsQwnN6htu?=
 =?us-ascii?Q?dy2rw7veoriuQBGt3iLKbOCBPlTHD+75hgeHb5Z4jo2JpMBOxAKC5Cl6vbzL?=
 =?us-ascii?Q?m9wkSrp2TUhOcwqYZVrgW3JN4dbKaqHhnQHfURoajNPFSDrjYAo3FG6qy67W?=
 =?us-ascii?Q?g5UnaY1odLJGFmoHQrzYomMA/V2M8Mh1y/ngADSz7kc5rwNgt56lxzfYQzbv?=
 =?us-ascii?Q?zcE/1N1wPXAOJIeXV4zp0itGQqGo+ntoEF9arcXOSinoVdpq7bKgKjk4A1Ig?=
 =?us-ascii?Q?5qtkAUdk7oS8BDJ5ZpM5OGbnhdNNrftdl3t+SlMiVZNrsDJvOng1Lq2uhv+K?=
 =?us-ascii?Q?O6zb1BFufhcb2gtuS/1tOlzo9Sg4kyEIOJdRSeW2qESX7GSzJcfRZnxFYoHx?=
 =?us-ascii?Q?NEZMdoQwWOnG5ZSHRXdVk3FAWjHaT2Alppo8G3eXy0rrAFQsxF7MmqcO991q?=
 =?us-ascii?Q?V0GkYa4FachZpE1boAbkloJPv6Xb9+P9hQng9MqM55IixWZT23CODXDZ/Mt4?=
 =?us-ascii?Q?lfZwooKlloADb01sy/ZL0mHy3/afy5XXpTCmygNByzNgK+59XcOfbXqlw4Vz?=
 =?us-ascii?Q?nQXp9XOfCBslqL05GrYH9c+cWQ7mWTZwWd6P2b4811mfzL8UgPXNXqC/2Ryu?=
 =?us-ascii?Q?788nSgchDlYDQZ6uN0PoDL7tWCzo1JdlHjQHYcHRhDDWhZV+QxCtH7WDDtz5?=
 =?us-ascii?Q?k1XRmSs4ei7PNKYC9hHO4eaPPGUob7H31zDIQDz6Q+Y9xS0R9pkFaXuvngTy?=
 =?us-ascii?Q?7+L0MHnvdtLFlEdTtrFxd2Kbeu8GvJkDw6ECx7aF92AcI3HxLNl6vuy3nCAY?=
 =?us-ascii?Q?DZpcZCHqm7GOauCjlhD4xaUMp8S9FX0oyBuhUwysnrbFS0L8Q4YCcaibNHNA?=
 =?us-ascii?Q?z6QUDM/jRcBwFGYLV2ZuWZklRJvvwgZq20BFJOwV5RlQeBGve9qfP52mikDz?=
 =?us-ascii?Q?hYBkS5S40rU=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:38:24.5716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa836a06-58d4-4f0a-dd9b-08dd5ba7f2cb
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5671

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


