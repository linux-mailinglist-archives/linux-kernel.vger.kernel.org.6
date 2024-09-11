Return-Path: <linux-kernel+bounces-325087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250B9754DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A501C23196
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE119E987;
	Wed, 11 Sep 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="TwmqFXBf"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB01714AC;
	Wed, 11 Sep 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063067; cv=fail; b=Yh1wXoid5eB0ivUzv2jFgVl9anuthoCdxSVjP0JcYRtaPjYIXpxYQkbyOl8z8vDFlRKfqnbqTP85TvwgPbz6v48EhkF6yTBbHHUud0Y1jAXm3oh2fIypv6n+br2AfQ4pH9Bp81ESI8GArvPaKhGwXS8N5Cs4dzVoW/fz634NYuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063067; c=relaxed/simple;
	bh=VO9n0uW2VLSq8mnwgmBaFU6/3BPrlMOzwLJJ9taMs5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLblI7XyzjGC2ArORY+TJSlSaAk0NpztSkBY/94LGK4BuSF71YgpvgjXs5Rlmt4OGdG/A/WBpOJJrhP2+Tz8gplPnvPmLWmwrfVGhCHlCnKeyBu6xZqcf2V40FIsT8DfVEe6MRqBrnaOBxP/gdKMNLGmGjw3afH16ZWZvn+kjKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=TwmqFXBf; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BDtMgh016831;
	Wed, 11 Sep 2024 13:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=4iy/7Ik
	jQdCBb0NBeP4LrKwoZRU16mj54lD97mcF2lU=; b=TwmqFXBftpFhp7Pv4HzQGoO
	OhjfusGwvNulkg3DqckPxmHCgenSpHEW/gBAcme1WUWggJx/YqfTZdXJ/LXsfTaK
	mUb+qsAW54zz/Sio/5SeiALkDrCzN1kzrH40Gw96QNGy6S4JM3d741zEw8BLr0Pw
	6d1UUtp8OEKbcVRZsyFdtWRuXgCL8gzm+ka1KmcYoUq5+bP1wq0cQGXOjc/3amgm
	yjFZ/Pke1IB7CfbyOWwhm0Xd63KMVUHazVzKPjFdK0oAwkLhkQDiKt3wYrK9tNDF
	I5Bqg4tcL20RmQm2BAQ8cMrRe6ULEE4ZAHVY1R0rfFT6ZkoV1yy/DB2LEhXJhwQ=
	=
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41gex54je2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 13:57:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZS3ImdIXdh1dfZk2Y9Bo3RmDzjYGLzbegO8f4+VkXLjU+pTrp0isFTn7IxsTbxeZVAVFo7HTDnMo+AxF9x7I2Hx+tkJGn/LWaVp9DFPIXzL0Ush1XTD9fmyshdKXPvRVDeyamEV/vTPHQXq2NdQEttvs9qf6XNfS5IEJlF5gjiYjRvL7h722LlH6v+gHDhxbX5C4TDRYQnpUHXbeKufyUyyF0GdytZuU2U5VzcbGWtzyMR0Yj+TQW7WVhHHtjqJ63qVGQfULLWuQhIb9C7s+Uci7s5iFuMMyEJKxzteJUsiIHCI434PA1r2m8eNnvCbrMMcNj0IFHv2HoBR0kTSKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iy/7IkjQdCBb0NBeP4LrKwoZRU16mj54lD97mcF2lU=;
 b=qjoYpkymdprvWWyMKc2bh7UZ0fllsUTX38MuwSEXFNSVfWjYb5fyWzZ9HEZmw2gFZd7oLlv+SpCAeP+0BtYubgD3lKfnAccy3tzDEXOYBGjCHGmtzyNnvOh6g56zGO096tdlhH9ksa9ys0a9Evrp27FT76QjZ/DKSWXLWXeGS7sUO2AwusHpd3w3YVaJ5uwWBcoQpp532AH20p0gpHX2QQiSxE63iICbzxdgftJ8N47YR5VW8pO2o2cDRHl82A1CCbFE4ImOrs4alzZ7b0rW1OihDT+es9amM+7AUt1RLLxSnD7tvKW1ecfzwXAPuc4E+6HoazrjkNoViWVEf9bwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from PH7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:33d::27)
 by SJ0PR13MB5381.namprd13.prod.outlook.com (2603:10b6:a03:3d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 13:57:37 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::52) by PH7PR02CA0008.outlook.office365.com
 (2603:10b6:510:33d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 13:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 13:57:34 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48BDvW98007648;
	Wed, 11 Sep 2024 21:57:33 +0800
Received: from NAB-HP-ProDesk-600.. ([43.88.80.182])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 48BDukko028151;
	Wed, 11 Sep 2024 21:57:31 +0800
From: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc: yoshihiro.toyama@sony.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
Subject: [PATCH 1/2] dt-bindings: probe-control: add probe control driver
Date: Wed, 11 Sep 2024 19:53:18 +0530
Message-Id: <20240911142319.3435746-2-nayeemahmed.badebade@sony.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ0PR13MB5381:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09c7b0ab-61f0-4aa1-acff-08dcd269b063
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZmYE6K73AziDuo8XYT15gtcb7l7eONLEXaZVfB9qTKSD2P2ATp1lRxTSBmRv?=
 =?us-ascii?Q?tqOI/obCe7WZiMZRyu2slu1P+rfHKLKrp9lrDqf9yYytXBysPm3kOrBDREGG?=
 =?us-ascii?Q?nJJHoFNU9gsCVb57vcU3aVaNqJNbExteoQUgvLW8E84C+TgVYVVkwkXtJMMv?=
 =?us-ascii?Q?vym6qdEhJJmlAXi8c940/ZqMpYWj9/8vCb52g6N82TkzsuH0pa0Rf2jmvnKJ?=
 =?us-ascii?Q?hrFLK0CvIL7yI1M31gwc82MmXVk4+UmCD3iKXLubk5XkhAzfnN6tI39RmRGv?=
 =?us-ascii?Q?hMnlfL5rR4rsdIBNU4t6PLMZs+taWF6LrLp+hcttGYkULji5xeXhfMOLbqB/?=
 =?us-ascii?Q?fZhvmZPkbPwlxKA/UkN8QzZCz+D5DKKwvw7g1Jl//x0w2SMW2cpeKGqHeWtd?=
 =?us-ascii?Q?VVVN3/pk8XTVrLSGrKUB3NqCLBiP+jWVlPeaWtpJqMUWhcPhLytdCitz/G0W?=
 =?us-ascii?Q?aXEhf5fRxWhOoTmYYLypsmgrgGx6R1VD4VEfqrUoE9cmfELahKdsXqoW30HE?=
 =?us-ascii?Q?1q6tE//6GUJCLiDgSnqSkQvVuPJXKypd7yjrlGKWRhiXfhPXT07DXPeuVwVV?=
 =?us-ascii?Q?c0OSAnyrP9HBfp/cmJDbFtvwjcNvibn3p/22de1nl0ZVp3CMF/0n093Bqjjt?=
 =?us-ascii?Q?F7HWyx/3MBciajmyYgpFuTDusauwe+SqiaMfPXmk2FVCnWXsiCvPV/RjdAOV?=
 =?us-ascii?Q?CUmX5K2mEF7dj0EfOSx4m4Y2NaHcJnFlIGAJYmKVp5RJctbLVviV5wWZYdgX?=
 =?us-ascii?Q?Q4F1FrcopEJijdVXEbxO9yAG2FH66ibuWT7Asd8vGCIinIoPVOdZ22afxG2c?=
 =?us-ascii?Q?Q052VnFQXzkfBcCerbHzzjXXfW/k0tViJtujWTPX+yJdKGPIJWNrQJfE4Jb2?=
 =?us-ascii?Q?NYrAxeJy83W6tLWd3GX+WiEoqQNAj5u2ZfWZf/QICgbrFBSJYwNP/CDVl7TR?=
 =?us-ascii?Q?/tsUcqXiQmRVZvX0uVe2QG+JzVJFYeUKsW2sgKLbPCkdRfHMpVWoRop+y52t?=
 =?us-ascii?Q?qVuQDOTp6VWiKBZaSpaPG9rbljYy/8/Xd5HOQ2aJ5md9vBTEazNvl1o7EQqi?=
 =?us-ascii?Q?XMyot282lZs3HeLAuH/dfjSCMOHm8B6260YxflctHFaBU1StJMYXCWe6j/34?=
 =?us-ascii?Q?QVAIAyQB58zEG78tUfCwJEWWKidSZWc3T0xt1+HbVsR1ALz1li1aPpkiIrdB?=
 =?us-ascii?Q?nF73bLHW6xGWNvuDmjqAyaMn4REQ/7TX3UC+eW59ipFJJmDhLWcD0kWGySXX?=
 =?us-ascii?Q?Xg4KTCg/VsgwTtF9H+WGtr/1ZA6WuG51NEBy0rm5rZ0fs/mWCMta1H9vhiu/?=
 =?us-ascii?Q?QuqcLSM85KTpGqb9XtwXZGvTKqAZ5d50WsbtTHM3HAXAeYNWc1kGGPztmNoH?=
 =?us-ascii?Q?atxNYBUIss+L9+Gl+Wc7Wcn/yxCu?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R7BUF43S4G0PS3roImmBtQ0QmirdCSQGYxyqVwqYVE18boAgqlezmmBJmvtMsRm6PH1SpL7O7KcGxTpk49urdY5iq39qjHH5KQg1jKk86k/vY2z78dxhAhYzAX0Q7oOMnWniGcpQ0Vxi6a25a/mhz03iVCnYtJoN7PoyFETSob5BJzXpWQR5m1gbTjer7V7eqhIaa55LSFtG8ExMpA27AmAZRmLZQ36NEOVVQrrDCK/1yPFSTKCgxL+MpKXPLKotdzdvZA2PeZRKlT4B10s7kRXl+wUa+oGJ/5LgJeKd5lH+NwmsJdl2RlRcRj/7ZzjG0qmWCargfNXOEd61YyXoULyL5+WB6SPJ8RtvHLZpR4sHbpfdQXdBAC+a1YVZMjXhvbgqnSniJgWdNV/b7XjXxM0JWov4eelOdLRA/J9mjA/jg4ufQWNGQo9D59otMk120nicnE/IrnjHFDAO2tzRczFOhBLM/Uvto5FldZHZgCXboHor0oLGURyqGH/yQ54f29u2xL8YYFVJO+oM0Xf1DGiBz69lDCRxb1aqp/DvRXovJVE+Sq109aTyjGJxGlWwePnDe1DUv4T9xW9ZTMrzAl2lTxraiObtd66jZfVOL0HRd493fF5nZfDNkIFgjIDc
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:57:34.5926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c7b0ab-61f0-4aa1-acff-08dcd269b063
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5381
X-Proofpoint-GUID: kGdNI6nGoOAA-5yianRFt8YV6Ekzw8FB
X-Proofpoint-ORIG-GUID: kGdNI6nGoOAA-5yianRFt8YV6Ekzw8FB
X-Sony-Outbound-GUID: kGdNI6nGoOAA-5yianRFt8YV6Ekzw8FB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

Device tree binding document for the probe-control driver

Signed-off-by: Toyama Yoshihiro <yoshihiro.toyama@sony.com>
Signed-off-by: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
---
 .../probe-control/linux,probe-controller.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml

diff --git a/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml b/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
new file mode 100644
index 000000000000..1945a7a5ab3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/probe-control/linux,probe-controller.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024 Sony Group Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/linux,probe-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Probe control device
+
+maintainers:
+  - Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>
+  - Toyama Yoshihiro <yoshihiro.toyama@sony.com>
+
+description: |
+  This binding is for controlling the probes of a set of devices in the system.
+  Probe control device is a dummy device that can be used to control the probe
+  of a group of devices. To have finer control, the devices can further be
+  divided into multiple groups and for each group a probe control device can
+  be assigned. This way, individual groups can be managed independently.
+  For example, one group can be for pcie based devices and other can be
+  scsi or usb devices.
+  Probe control device is provider node and the devices whose probes need to be
+  controlled, are consumer nodes. To establish control over consumer device
+  probes, each consumer device node need to refer the probe control provider
+  node by the phandle.
+
+properties:
+  compatible:
+    const: linux,probe-control
+
+  probe-control-supply:
+    description:
+      Phandle to the probe control provider node.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    // The node below defines a probe control device/provider node
+    prb_ctrl_dev_0: prb_ctrl_dev_0 {
+        compatible = "linux,probe-control";
+    };
+
+    // The node below is the consumer device node that refers to provider
+    // node by its phandle and a result will not be probed until provider
+    // node is probed.
+    pcie@1ffc000 {
+        reg = <0x01ffc000 0x04000>, <0x01f00000 0x80000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        ranges = <0x81000000 0 0          0x01f80000 0 0x00010000>,
+                 <0x82000000 0 0x01000000 0x01000000 0 0x00f00000>;
+
+        probe-control-supply = <&prb_ctrl_dev_0>;
+    };
-- 
2.34.1


