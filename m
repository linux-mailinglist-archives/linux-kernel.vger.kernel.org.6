Return-Path: <linux-kernel+bounces-399043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358C9BFA21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 835B7B21263
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC820E037;
	Wed,  6 Nov 2024 23:32:10 +0000 (UTC)
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021097.outbound.protection.outlook.com [40.107.42.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD806168BD;
	Wed,  6 Nov 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935930; cv=fail; b=gSgywZC5kxcl1VQ9K7H7cRhHjBGReJIc2NXa1J1QEahBCBcTqTFwPZSoXO6Dyg8TqoJt72N+TcNK0L+qxGihYai6djqg0JyStle0WN41pB1T9KArnIaNrCPyk83R3q+Blic2dFmjkshSQWFyctwjzuKZsWegwwzX81HmfI3p55s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935930; c=relaxed/simple;
	bh=UP6AAvhJlxmhxR+gAreZcTH0iirgdVZsTKEp5rjtuzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o79FAvNxx1oAG7Br3iwx42+NpQThQ3CGWXfy+Z3kxYs/RU3OFTHDAT0rhCTMbvZqFCttbf5O8AzPLVVCA5Cq1n2HpTfZXlAim9NomOY6Hgc2WRj8vrkGJ1iM3hMnTr/9AZCEfru6VdgO8ynjDcJ/SduNZA9x2DkLVrrwsbSl7rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irondevice.com; spf=pass smtp.mailfrom=irondevice.com; arc=fail smtp.client-ip=40.107.42.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irondevice.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irondevice.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo65ebUajrREwrfA26LKZCSPI3pegIgA6m35Kyzcvqtj/eD22q/6mznmwUHgzAbWtJZnDhLyD4As0YMlVC4DZqa6qaVapqJY1E/sBhelNNJbUkQvGC/kM8n+lkS4/XMzaID6v3zHiDFdK+zqEIobv2ZvnMkdXH72ygEDPNu2dMZnpXmsAQFDfiI1ZHNNX9+pTzSjolYmitlm/qFz6CLJAcRt2QBzw0etpn/NpUsaXNyaTILbE3jL5TQ3wMjJ2aF37sKd1Wfyqsl7zYA6aKUhxPTmR9WvGGGQjsNyv6CXC3893QakxBpOAA2fIUgvl+SSUly5YeMFFApDotqtb9/MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSiwdPcl04WqmzjJwr9sGBvS3Zk/sGEnuMEjYZ00tlk=;
 b=ubF+1U4/7DovFb94YXJSaVqKwtn4CNVKL47G9/IhR8axfVT3hhPME5HRCPPYN68JFo49UNTVQpJiFysWMrglD7bEV0GsMJM6zt7UPXe/LVahgx//ohl4+6yOOuQV+eL0Smr8yuIM096tWy6Fl1piLNF5pAvwHOvecMWUG7t6ELlG1wh2Jaunax45vhFupEOn0mXdVptENSXraUpMdtVOzqj3wt5+fesdW0W0Jpty0JdClPPon31s7iOLLBjlKNfRSHO+Aoo3QNdIsviKc9g5nf0HjaZjrwHNEmJr6/brsamhsPofXWM6/LEHbJiqck81PYgw2WvhK26xEEyz3SUD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=irondevice.com; dmarc=pass action=none
 header.from=irondevice.com; dkim=pass header.d=irondevice.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=irondevice.com;
Received: from SL2P216MB2337.KORP216.PROD.OUTLOOK.COM (2603:1096:101:14c::11)
 by PS2P216MB1362.KORP216.PROD.OUTLOOK.COM (2603:1096:301:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 23:32:05 +0000
Received: from SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e8d:9550:c46b:2756]) by SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
 ([fe80::7e8d:9550:c46b:2756%4]) with mapi id 15.20.8137.019; Wed, 6 Nov 2024
 23:32:05 +0000
From: Kiseok Jo <kiseok.jo@irondevice.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiseok Jo <kiseok.jo@irondevice.com>
Subject: [PATCH RESEND v4 1/2] ASoC: dt-bindings: irondevice,sma1307: Add initial DT
Date: Thu,  7 Nov 2024 08:31:44 +0900
Message-Id: <20241106233144.9283-2-kiseok.jo@irondevice.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106233144.9283-1-kiseok.jo@irondevice.com>
References: <20241106233144.9283-1-kiseok.jo@irondevice.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0217.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::22) To SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:14c::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2P216MB2337:EE_|PS2P216MB1362:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3d0e1f-5829-4832-75e3-08dcfebb3921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j9LMl3NUIY9ay+imcTS9k2r3LNuMfq3BErP0YiUT4yfHwrFU97RXfC85D6Xn?=
 =?us-ascii?Q?JijOJJeAxoMe8BQb1gTQcvQs5Zw7BMjzdS2xuWn6OVt8WvMDAFVAeYPN0fsi?=
 =?us-ascii?Q?QW60jNpKI+OMhXhoPUB84hLeIg3D6RyQ2ToYHbX6KD+CJgJqW0TQCW+Fe988?=
 =?us-ascii?Q?q+hQlmtaL2cxdSXmbO0z8tp4u+Hq5NDorqhzb4g1q+FdaM9CC+cdxdzXzjx0?=
 =?us-ascii?Q?MTJY+2lNLTkabBmZeiUUogsi/COttfph3K2KFxgqJvm59QfL+AT/bhtYWARL?=
 =?us-ascii?Q?G6nqcWWbe4pLMsTFTbYcGSaqslNGt6612ba45Jr/bURMT0rKJjBVPwsOZofx?=
 =?us-ascii?Q?mjfblL6ERETxXR2m9l6zFTdrlSmdlB07dC76tYaC8nguFLTeZ+174ENooB0t?=
 =?us-ascii?Q?Ncw5KJ7oYpjOUHp8CJcotk/9nANmxsvf0wfI0SBbpOvthDH/psdSYJ/9ItmU?=
 =?us-ascii?Q?FoxoItJhgws5b8web3bRj/LzZjT0krSjReaF1szOLCxh4wBCxK+zXpJaoTzL?=
 =?us-ascii?Q?+qJoEku4r9edDovKfjfaPI/1wt/QqXWHcenfqlLSfGprwFJwbKNZXzqCYBpS?=
 =?us-ascii?Q?XMWPPYu47vLojlw0Mz2Tn5dHn27Z3Y7j7F9u3W/YqNZTc9hvVaXC1O7utbwV?=
 =?us-ascii?Q?BQDPLDaMD18SQ24etOMDfmc/qIz4p3GypM/LdFpQ51UpyqmPHKerSUtn48sw?=
 =?us-ascii?Q?12ScfesBa41Q8Lp8fU/YergbK1CmWwJZAS2Rj3S3/so4jVfrORrSYvSpbdia?=
 =?us-ascii?Q?fuvHrpWaZfYr5dTIg4mE8c1OG/YydaKcQBQmH2Z/XI6QoelFNKTsT8w2PsIv?=
 =?us-ascii?Q?StsUFiZ/iVA9225nXKuiW8zvzJoakuwnnTpGqsH7nVLeV7q+PWlbdO67/mv5?=
 =?us-ascii?Q?8J5b/vdV5/bfCQRDP4xnW5crlJll7eui7+hXMTEGe6//qw8kiBD2A7paMwif?=
 =?us-ascii?Q?hR9sUTFvwXYBdXPmB2zqPJTB2XxEPm7vFKZJBaryj6D+d7wdXnLGIiFrbmFb?=
 =?us-ascii?Q?iXPQerDpprwDTRq2xR91cz5qPyAuwS3nVv1PdxcWalSUDs7P6o7TQeyqHFyT?=
 =?us-ascii?Q?qvI+XqaID4p0B7t7szNqFG/mb0ARBNoO/JQwJdNfSYlwsrGQtOqGrvyALTod?=
 =?us-ascii?Q?0X836UjNhZli/QygSdkwyJ0fjDpOXT/YL413NXr+9zJY4Kd0mkiOPl4hbi6v?=
 =?us-ascii?Q?V8Jgb8NFH3xduK7z0DygtCa3RzdCvcN1TluPElr7mHqYmfdWrZNJ1hbcKc2w?=
 =?us-ascii?Q?Wpa8/zKC19CDMRrN9WJ9UN2qvz2/m2MTGKDUKP/DSEsc4V/QwdQSOyRfMmx/?=
 =?us-ascii?Q?Mv5NV5LFxeJYASEqAGPsMfYy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2337.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRhpszfCc3vhbHhyH5qwcQNbhpUOpIGnmwNQqNqzcCiRQCMw0XFFDwBYSYUE?=
 =?us-ascii?Q?+4grZrwAKSzmHLppHkNc1kQOU+m9YTd2XkllM0E98mh0kSj7GO3pO7RaRvSE?=
 =?us-ascii?Q?WZ/TQhow7XbaU+qcEqk1wzJrZzCZXHVO+N+UadodPjG32dNjiN93011tdRHK?=
 =?us-ascii?Q?fl9mSqkHgzhE4Fv+8WAaKXBZ65tCJQT3Z9Y7HqMEWavbWQgkyZlSP+H4N1F/?=
 =?us-ascii?Q?lq+G3PMFIJ5ilPkj8PM1tiI0ffqvSVLi7y9QxWEeaSe63oeb1HFGPKM3DJaB?=
 =?us-ascii?Q?TsPHt9b1UzWbxJhHtedzLWg3G7m25movfHBWscaDfM4WOCm3kvxOYQR2VHvB?=
 =?us-ascii?Q?1xX72L018lGlqB8UyasflCA7s08bLyL1Qi1DQUF3zMdkNfIk80D2LRe+CdJN?=
 =?us-ascii?Q?NkJY1VIm15CGErLEiQeJl9Tmsr07evn40A7dbkRUCC3wPOb8t/s+IjijlXQb?=
 =?us-ascii?Q?MV+lZ3ff5gwkUFaLpaMI4yjPj2EBz1JAOEiNJ0iUPEk5IKv/Xx4f/bJ8gVA5?=
 =?us-ascii?Q?17Akx8iGjA35yQ1PQpcVUE9SRlNQ8GqcWfbFHsxft1ZWW4tyTjx3tCHVy8rU?=
 =?us-ascii?Q?yM+GPioSTTjXTxPwoWTypGLUanZ5r9VPPqEO5Uwm6It77P4PyaDAR8faY1MN?=
 =?us-ascii?Q?jRioPqUT28hhkUsyiP1w6IZPz7MrgKK4vhc0eQjAkzvWjPuRaynppSNSeuZR?=
 =?us-ascii?Q?s+KHjftjQIxgaLAf3Y0Vj8GYubEQu/w3JIZrdN8e+HdureBux8DT+wEi/2+c?=
 =?us-ascii?Q?of3BPmvp7j6QhGPc+c6Q78TujMtrrszzZz7qA8V63mBigZd6ZvQQiNoOVDUh?=
 =?us-ascii?Q?eyGMY0v+Shhm8u+PiJODCO2Lcz+aisSf0/q4CkcvDHsH7Wpu5T5GmWi0qkSK?=
 =?us-ascii?Q?Zy4IFqdohAnrP1O5z5CqFj2wL/N4UGsmA4o0ebcpAaziXo7xpPi/SvTWLTOL?=
 =?us-ascii?Q?8gPjl/LcdpEiDkTTR7LDmDPQ3YCgGSDDQm7eeAv6iE8XFCaVzMdfy8ETkXuV?=
 =?us-ascii?Q?r1Q0ogJ/TjpOdNVfY5eAnUT9frEd8pcLDT5hg6xywaYpVR3L9hhK2cPTJbzq?=
 =?us-ascii?Q?bdheHmuUuubCl4xFG3HYbyeVeimQhzVyk0/rEPB11uStN39dj8O114yXEKh/?=
 =?us-ascii?Q?z13BtOWkYAw33DluzIwK4/vcXFeAh+p2cMsIjO5NyUBC6bAaaDvwx0oMDDt9?=
 =?us-ascii?Q?FUoLFR0t7+X1djqFauEqn+pOBg4JYRFrTw0L7l7/CltW6qQOUqGALmKNWfgL?=
 =?us-ascii?Q?pUY13+rHfY73SY9QhXpCeoVgJG7H2VKzXz3VETYBxd5S4M2NdogT4AuwjU5u?=
 =?us-ascii?Q?q3UT52Hru8kJlT3SM/EtA2smNp2up7DVDTHymSuXW4An6pS0HMVU9v74HQxg?=
 =?us-ascii?Q?EM4mWC559qoGOEi634ql8rhRd2Rka3BoIfoCkXwaQ9nGCVQmeG0vYeTNTZzd?=
 =?us-ascii?Q?BG4RfRAQvGmnaIxHmTSS/pKNUwC4PeyflXYqmChDeaNsPmdM0gPA6AnwGR34?=
 =?us-ascii?Q?tgN9SUL97oUra9f5SG4+86OM2T4BznizMeDuirfj+f2alXDGr1i4/WPpKg3b?=
 =?us-ascii?Q?aOSICIQPvA3rFdBl1p+tkF57PGiHYBQUSq6/buF0?=
X-OriginatorOrg: irondevice.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3d0e1f-5829-4832-75e3-08dcfebb3921
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB2337.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 23:32:05.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b4849faa-3337-494e-a76a-cb25a3b3d7d1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxTpWI13Jmm731QhsD0gSVAqnZSLZSoVZU0RkhCYAz35bmz3Wh5Ace1x1XRrDax8gW0yahS7vjWalLE9eslCra7kTroOHHkQLteL8QYqzB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2P216MB1362

This adds the schema binding for the Iron Device SMA1307 Amp

Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>
---
v3 -> v4
 - Modify to fit the character-per-line format
v2 -> v3
 - Remove ABI documents due to the removal of sysfs in the driver
v1 -> v2
 - Add ABI documents for sysfs
 - Remove the interrupt property as it is no longer used

 .../bindings/sound/irondevice,sma1307.yaml    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml

 .../bindings/sound/irondevice,sma1307.yaml    | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml

diff --git a/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml b/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
new file mode 100644
index 000000000..1e2a038d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/irondevice,sma1307.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Iron Device SMA1307 Audio Amplifier
+
+maintainers:
+  - Kiseok Jo <kiseok.jo@irondevice.com>
+
+description:
+  SMA1307 boosted digital speaker amplifier with feedback-loop.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - irondevice,sma1307a
+      - irondevice,sma1307aq
+    description:
+      If a 'q' is added, it indicated the product is AEC-Q100
+      qualified for automotive applications. SMA1307A supports
+      both WLCSP and QFN packages. However, SMA1307AQ only
+      supports the QFN package.
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        amplifier@1e {
+            compatible = "irondevice,sma1307a";
+            reg = <0x1e>;
+            #sound-dai-cells = <1>;
+        };
+    };
-- 
2.39.2


