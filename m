Return-Path: <linux-kernel+bounces-328307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBA39781D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC40C1C21F28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A41E0B8B;
	Fri, 13 Sep 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="f2qyPwqK"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2087.outbound.protection.outlook.com [40.95.54.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18941E008D;
	Fri, 13 Sep 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.54.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235683; cv=fail; b=rrYT/ivBLUNdgt3XAY0f2sEDBGBjL1I0KriHgKDmgfCpHXxmwTky3dhsmvcxRrUDPjIVK0MtkFAms5eilE/VFF7n2IkU8kc2NIl2YLFlfjnSHimXHNK/BdFYjiSKdMDamOwsSvR2JiLZ7vk7r9KQ+hhW1Bcv3OQv8TIRsfWQaGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235683; c=relaxed/simple;
	bh=HxtHT+lh7P+mu0HZBa+yw8sq3aLSyvtXJfmRiQaQIJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFGuigpPmDKKdLa280ZJegfr0grWFpWnYqrAmdOyfvXjqUklmlBgIAaW64wPo9w3ZfyTa4ntvaXboNy4NcsuxG6so/cTTsmewJP0Eg+AUbvD924RYNmkTz/yfTsEczSIqqHE8zCsjkKeinbmiQL518Webj3sia80Bz8ucj5LMkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=f2qyPwqK; arc=fail smtp.client-ip=40.95.54.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
Received: from SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) by
 SEZPR03MB8382.apcprd03.prod.outlook.com (2603:1096:101:21f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.19; Fri, 13 Sep 2024 06:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elCyHkojbI/z9NcyxaWvw8xrMfofl77yOQ1o3IvJBE2iN88EOkZoVK8l/tAYYoebVC41RSRZb8VVFJtrrFiWFGDbKptEJm3Wy8s5Hp0pzPQ0QidY6qaPGo32KCNRukP+Qp9BXVr6iyCfjsGAy3w8MqTq3EcxmYYjMwPjt70mvYIz3u5bN/IlYXkwLmL1lWkDG2I5aPVP8rklC7iHEKOmBpNNTEkhBzr0GbTY+QvkxWSEFG0L3QiZ7FHUOJ6S4puwas6oe/GBTDdCOj9uyzq9nilpl0C/UiBXSgTJ0PGWS8M6GcWBHO8DtP8B5b4ONDKn/FyjBekuWZsNRRlVObDfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpMR6qv6JfKvXmGBithJY0XJ7ElRCqqOb8zsavege9c=;
 b=j2BFOJTHAgemVXGxB02U4zSrFJC0gC3n3vukS/4F1IMChPQX/r2sbEsVBUZJQa1XZ3dUcKFtaC1z4pYMCkQ1MSLQngoL6cAbyw+Q7HLO/phTfsARH+lQaZVXj7j66Zk2tPmfd9sVJWsvQFqVnX37396uv+l4iE9B86lZ8QX/plUqP+q06tTb/EUHUHbVOu+xlX0E8vf2h/hjtD6LOGntDLRpsEzYBtOji2YHI1qM2YXoM8ZQknM0jb8A0wg2F6G1CAZ4cifuwTmMvisW/J55kVk0EPKW9DCtH5WDJsPyvi2OwzdAXqygsQWe3IxdwntgqGDPHswVVI+tCkKt7SAZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpMR6qv6JfKvXmGBithJY0XJ7ElRCqqOb8zsavege9c=;
 b=f2qyPwqK7BM4Ut8qDt0F/hwFMJFNqeNwIqnkFXdN3gFJJ8UG0231XNiqZmOmJ0wTDw6of6JeisO2ovG/EdGL9NQWc+IL+Cm2IONwrr0dSyQleCmuB5dZ48glOrF2C9zMldN4Wi2JbzuMDEGU6Ms69+ssMfajwLhbOW6PRAtP2Dw=
Received: from SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) by
 SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.23; Thu, 12 Sep 2024 19:10:46 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::3e) by SI2P153CA0015.outlook.office365.com
 (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.9 via Frontend
 Transport; Thu, 12 Sep 2024 19:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:10:46 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:10:41 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:10:41 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 03:10:40 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 15EED5F5B8;
	Thu, 12 Sep 2024 22:10:40 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 021B3DC0800; Thu, 12 Sep 2024 22:10:39 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v28 0/3] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date: Thu, 12 Sep 2024 22:10:35 +0300
Message-ID: <20240912191038.981105-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	SG1PEPF000082E1:EE_|SG2PR03MB6730:EE_|SEZPR03MB8382:EE_
X-MS-Office365-Filtering-Correlation-Id: 0daf0209-f5dd-4059-ac57-08dcd35e9b47
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|35950700016|48200799018|82310400026|7093399012|7416014|376014|61400799027|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OEdCM3YwS2tHU2swckdmSS85NC9Wc1FpMUswK09UTGRSTit5czBIcjcyTXBp?=
 =?utf-8?B?Njc3TDFGblF2di9Pd3NpY3FoN01Jb2V0bCsydWE1WXh1YnZIV0Q2RDJtSzJN?=
 =?utf-8?B?V0dsWFFzV3dIUThLOHZiT2NSVThTaWh1bEN1blpRQ2FnRHNEMDJPaVh5NEFF?=
 =?utf-8?B?STVCcjJUWGhHNG9TbWNPM2t6cDFMeVphQXpPOEZvMEE2K1FFY0lCVFZqZmhS?=
 =?utf-8?B?NkQrSExNT1NBRXUrMEhEaTBCNFh1VFFOejFjOEUyR3Y0T00yRmZ6S3hnUFVU?=
 =?utf-8?B?elBDZHZqanAvcmN2TFp6dnNQdVBtSEh5NVBuYVBJcmNkU09DZE9ZVTc4eFhZ?=
 =?utf-8?B?akVHdTZLN1I5WnJiOFQ1a01uZDhDVFE2YTd6MzFPUGtlTEx5c1dWOENTNDd4?=
 =?utf-8?B?NGNhclU4RFFSeE5zOVc3R3daMGxtQk96cVpJVythQnNxc3IxVjRtWDk4MEFK?=
 =?utf-8?B?T3VZQ0puSnB6UE85dUIyaWc2WCt4Vlh3UHRmRUdxSzgrZ1JXWWgvVGRCdzEv?=
 =?utf-8?B?T3d4VzNiaDBkZHI3dC9wcXIxbFBNcWhJYVZJd0hpK0w3UTRTSzBNUWM4Smtm?=
 =?utf-8?B?YnViZE93dWJZcXFVNmMrczVvb2g2VThiS2NxU1FZTERmQm1NSVNra3hQUVAy?=
 =?utf-8?B?UEdFVVBjVDgwVU5sQ1ZnZEVQTE8yUUZLZUlTSmx2akljcm9uUUxXZFN6aVYz?=
 =?utf-8?B?dllPV1NyZllzVCt2cmg1Vkxtano2YTFnRllQa0E5cHBrMEpjZ0srYll2UThx?=
 =?utf-8?B?Z0VlRG9PR3BhUWtZNWRnSHBuYUJWZXBDd21yQ3ZWek4xSFRuTnVRb3VTMDFW?=
 =?utf-8?B?Ny9lZGFwVFFIRlVDNFFKenFZZU9PcU5KL0kwWU85OSthUWp2TFpjM21TS1ZU?=
 =?utf-8?B?Uy8wd3pqVDBKZDZmZk1sNG1pNXk5ZkJheUNUcDJNRnlIWmpzbkxrTXV5Ympt?=
 =?utf-8?B?Y3BDVUovTjFNWldWbVZGdzZTeDB5NHJ6RHZKdDM2SExjTlowSlExeEloVXYz?=
 =?utf-8?B?Q00rR2Q0WVlNL1NUZTBxWmdjYW9sMlBRbzlDZGhvUC9hZG1RWjJ6V3RyaURs?=
 =?utf-8?B?ODZaWFQvTUUrc3F1RG9pZlpVR1RaZmVNMlptSVRGdkdVSzR3TFV3SktzdC81?=
 =?utf-8?B?N3VxeHdTK1VKbFFKcHJIYjJxR1M3OE9rMUZRdFZNeStmUEN1UXVxZFhuUjRH?=
 =?utf-8?B?RmlDUGI2eW5BTXh4RDNHVDZCUFp5dGdBSHp6QWtEbHJzTUN1YnN2MzNYd082?=
 =?utf-8?B?VmRiVWpOV2w0bForb3pYenptc24zS2tEcVNVUnQzM1JEeWNuNEJyUlJqb0Js?=
 =?utf-8?B?TlNvWXBFa2xwRkZLSFkvRDNrZnQxeGk5UHJtcWtEc2dxNWpNUlMzdXlDZ1M3?=
 =?utf-8?B?YmgxZzQyUWlTNHlReWhWNmFkODlrRXM2bUZOLzFEVjY2d3hYL3NrZEkwa2JU?=
 =?utf-8?B?c0M5OTZtZzZTRlc2UWVBMnRGK1FpZzlmQTByeFBuRVVtaW5Tb1BpL2kvOGty?=
 =?utf-8?B?ekt6K2hYTlFiVzZQUWlGeG80cEJDR1h4b2o3SjhSa01BOG81S3lkYUJBTHg4?=
 =?utf-8?B?YUN5d2h5NXFWWkxBMUF1WmMxN1pKbHp3Z2NCN2c4S1BzS3pjVnBMQUtWQThX?=
 =?utf-8?B?SWdIcE1Nb2tnK3JlWGpkV3VyRVoyWWdNMkMrTXN4V0owUTlxcEFZNjczcHUw?=
 =?utf-8?B?TStnQnc1c0JMRStQL3N0ZCtNdmdvUnIrWjI0VkhOS0VlUEN4UnlORGEvdGta?=
 =?utf-8?B?a1VlQkhFSnVkUVZSUkdiTWk2NVNXMkRyN3kyM0xMcHF1WjVYamNORWhsRmVL?=
 =?utf-8?B?Smk0YUcxY2dXSHpkQ1B0STRyMzhjNE5qL1A4dC8wb2JZNGh1b09MSEhoeXVR?=
 =?utf-8?B?Mk5UajZ5S01lcm9iM0c4SlJ4cThheVFXT0pIaVlNL3ZGUDRIT1p2SDlHa2J5?=
 =?utf-8?B?dDVMamIySmNGUzlrTFM2bXdlODFNV0QwUkllcUJ5TUQ4eHBzS1BoYVI2akly?=
 =?utf-8?Q?n2ZbCe4ibLDShw0UisRotjb3QwiEec=3D?=
X-Forefront-Antispam-Report:
 CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(35950700016)(48200799018)(82310400026)(7093399012)(7416014)(376014)(61400799027)(921020)(35450700002);DIR:OUT;SFP:1022;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:10:46.4226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0daf0209-f5dd-4059-ac57-08dcd35e9b47
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6730
X-OriginatorOrg: nuvoton.com

This patchset adds clock support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family.

The NPCM8xx clock controller is created using the auxiliary device framework
and set up in the npcm reset driver since the NPCM8xx clock is using the
same register region.

This patchset cover letter is based from the initial support for NPCM8xx BMC to
keep tracking the version history.

This patchset was tested on the Arbel NPCM8XX evaluation board.

All patches have been reviewed by the maintainers, 
the clock driver can be applied :-)

Addressed comments from:
Philipp Zabel: https://www.spinics.net/lists/linux-clk/msg103946.html

Changes since version 27:
 - Use inline function in container_of.
 - fix missing return in the probe function.
 
No Changes in version 26:
 
Changes since version 25:
 - Add select AUXILIARY_BUS to npcm_reset kconfig.
 - Include <linux/auxiliary_bus.h> and <linux/slab.h> in reset and clock driver.
 
Changes since version 24:
 - Keep clock npcm8xx dt-binding to avoid ABI break.
 - Fix kfree parameter.
 - Correct reference.
 - Modify commit message.
 
Changes since version 23:
 - NPCM8xx clock controller using the auxiliary device framework.
 - Add NPCM8xx clock controller aux device registration support in npcm reset driver.
 - Remove unused nuvoton,npcm845 clk bindings.
 - Remove all string #define 
 
Changes since version 22:
 - Modify commit message to explain broken ABI in dt-binding
 - Using regmap parenet regmap memory therefore remove use of npcm8xx rst-clock patch.
 - Leave npcm7xx rst node as is
 
Changes since version 21:
 - Since using regmap instead of ioremap replace reg to syscon 
   property in dt-bindings and dts.
 - Add reference clock property to the dt-bindings and dts.
 - Using .index instead of .name in clk_parent_data structures.
 - Using string where any macros are used once.

Changes since version 20:
 - Using regmap instead of ioremap.
   the clock and reset modules are sharing the same memory region 
   and cause failure when using devm_platform_ioremap_resource
   function, this version uses regmap to handle shared 
   reset and clock memory region, in case it is approved I will
   modify the reset driver to use the regmap as well.
 - Using clk_hw instead of clk_parent_data structre.
 - Divider clock definition to one line

Changes since version 19:
 - Remove unnecessary free command.
 - Defining pr_fmt().
 - Using dev_err_probe.
 - Return zero in the end of the probe function.

Changes since version 18:
 - NPCM8XX clock driver did not changed from version 18 only build and tested under kernel 6.6-rc1.

Changes since version 17:
 - NPCM8XX clock driver did not changed from version 17 only build and tested under kernel 6.5-rc3.

Changes since version 16:
 - NPCM8XX clock driver
	- Using devm_kzalloc instead kzalloc.
	- Remove unnecessary parenthesis.
	- Modify incorrect spelling.

Changes since version 15:
 - NPCM8XX clock driver
	- Remove unused regs parameter from npcm8xx_pll_data structure.
	- Using index and clk_hw parameters to set the clock parent in the clock structures.

Changes since version 14:
 - NPCM8XX clock driver
	- Remove unnecessary register definitions.
	- Remove the internal reference clock, instead use the external DT reference clock.
	- rearrange the driver.
	- using .names parameter in DT to define clock (refclk).

Changes since version 13:
 - NPCM8XX clock driver
	- Remove unnecessary definitions and add module.h define
	- Use in clk_parent_data struct.fw_name and .name.
	- Add module_exit function.
	- Add const to divider clock names.
	- Add MODULE_DESCRIPTION and MODULE_LICENSE

Changes since version 12:
 - NPCM8XX clock driver
	- Use clk_parent_data in mux and div clock structure.
	- Add const to mux tables.
	- Using devm_clk_hw_register_fixed_rate function.
	- use only .name clk_parent_data instead .name and .fw_name.
	- Modify mask values in mux clocks. 

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 11:
 - NPCM8XX clock driver
	- Modify Kconfig help.
	- Modify loop variable to unsigned int.

Changes since version 10:
 - NPCM8XX clock driver
	- Fix const warning.

Changes since version 9:
 - NPCM8XX clock driver
	- Move configuration place.
	- Using clk_parent_data instead of parent_name
	- using devm_ioremap instead of ioremap. deeply sorry, I know we had
	 a long discussion on what should the driver use, from other examples 
	 (also in other clock drivers) I see the combination of 
	 platform_get_resource and devm_ioremap are commonly used and it answer
	 the reset and clock needs.

Changes since version 8:
 - NPCM8XX clock driver
	- Move configuration place.
	- Add space before and aftre '{' '}'.
	- Handle devm_of_clk_add_hw_provider function error.

Changes since version 7:
 - NPCM8XX clock driver
	- The clock and reset registers using the same memory region, 
	  due to it the clock driver should claim the ioremap directly 
	  without checking the memory region.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.

Changes since version 2:
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.

Tomer Maimon (3):
  dt-bindings: reset: npcm: add clock properties
  reset: npcm: register npcm8xx clock auxiliary bus device
  clk: npcm8xx: add clock controller

 .../bindings/reset/nuvoton,npcm750-reset.yaml |  18 +
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-npcm8xx.c                     | 430 ++++++++++++++++++
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-npcm.c                    |  78 +++-
 include/soc/nuvoton/clock-npcm8xx.h           |  18 +
 7 files changed, 552 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

-- 
2.34.1


