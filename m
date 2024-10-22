Return-Path: <linux-kernel+bounces-375863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4B9A9C08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6457BB24695
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854D915666C;
	Tue, 22 Oct 2024 08:07:59 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2113.outbound.protection.outlook.com [40.107.239.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7771514F6;
	Tue, 22 Oct 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584479; cv=fail; b=HQl4carmbe/wRFjQa7maOv8DowGfNKxE5gbmCaGVUcka0ZlnIlwp4zPLfKnURlVP6jZ/a4QRoFBq2hwE2NjmMymHcaDtOx1Fm7FTxqHwB8916Q6j3v6uszmJr+X35+PJaxZtWHh4wHHDFaaDtzx0S5hFsPFN2ow8xVAfiCMvJl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584479; c=relaxed/simple;
	bh=lAAjuoKiQb4YyL2Gs9/f9Uo5QWLH0h69GUqpTASY158=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a8tkMAWNuBilUt9OiW7MyX7VTtoQf5iCfD/nEeMzT2O3+8uOlA+cylYRh8Bb1bXAficBp9xKwwPjHItxFMGMEmPLkqJehajg5RHYItBdKAzq53OgUz477/VSIr+fLD/JfB9XLXRs7Ys2MfEvriO+z9d9mlH6Ps+zRGEZATTcyWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFJ8LL2K2wDto+61w0UaAlFrTQozxWJmIwEz4B5o4nToetH8J+QOGt4X96LuUGT3QxFlxlqwSrEOtF+F/y6ygA7fPW57S6Q1Cz5vdX4p53XKMcPw/KqeO0GPQopvYy+xWBrDiHcXrBjCtpidtSaJke4uR2VIB4o0d8Jpm9GLS42X+MhQICe5UEX+17xcxsg1zbW3eKistmNE7KEtVyLS9uVJf4mVfY0RcoVskLtKlCQyrOLEzlvFjwn1qtlzUYWk2G74zjOnfmYG8b4yRVP10zM7/xVN4lO72oi1LrW7f6s2K87zUENAfnPw3yP5LkvsinNPitvwdyoSVmK7lqZLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYY6HycvDYNr0qDeuMZeidwqEjHE9ISHsKrNHLsN778=;
 b=a4t6/vh+phsl9chCeV/ymab+b8nX0quIMZ62MWMGJbpSztsCFhdgxcUd7AVh9oHXWpbeyOIa9I/cDLa1xXGtTK/hbRnEbuoOaq0jOqTENgl64l5xOsLOx338aG9sjRYDk2rFGUubw3JMjlbVvW73N4GEnR1ulybLms+wmGAXP/oHdkt0N7onC25EHlaCWa/UvOxmnfYyLJem1fJEmZQoraFn4Kn9/PZ+VBjCETlNB5czjuGff6ApFch5JUjHSuT3VieplFoTC5xGJD1Cprik1oZyrORM/X1pq1GBvEgARgmY9QnQC97H+0KptlJzdQYkxAT4wG7ceFzk1hm5FPv6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2P287MB0824.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Tue, 22 Oct
 2024 08:07:53 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:07:53 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] Add support Boundary Device Nitrogen8MP Universal SMARC Carrier Board 
Date: Tue, 22 Oct 2024 13:36:12 +0530
Message-ID: <20241022080645.39536-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::16) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2P287MB0824:EE_
X-MS-Office365-Filtering-Correlation-Id: d1da40bb-528f-4e21-88aa-08dcf270a0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6zuGpol9StMX0Db/FIHfG+v3Vyhpk0jXMBC7awkNvJMZneNBIuIYMmFifMCn?=
 =?us-ascii?Q?k+/KKjK30rKAXSEYTa0Fc6SkWzy1OAxETJtZX9iX9ngVTqm5HESRZBJ/I5xK?=
 =?us-ascii?Q?KIpO8KA4P9QEIpoQoZnFt4hKsEN6dDj/NqMXB+Shli4fXFOuUuYTvO6LJk+l?=
 =?us-ascii?Q?PNRpa67pjbeEprc6gjgoLLIj6kPlD5KdGSC/UKP/zy67ztnpvJ6mCk79rr39?=
 =?us-ascii?Q?Lftg4r3jvSf4h0pqdvusg9aD0jNHJId4Si418VxJH/g/ziYwrhWbukqLjuuG?=
 =?us-ascii?Q?K3m+JCDOA45kHYKXsAu9XZIYTlW8yygCe5QepWjYPjzDJtXIw/L65L9yw08t?=
 =?us-ascii?Q?ZZc00OxlqY9wxLXzXISFgCCFPJMTubM4PSFVaWi1y3u2N/RBVdkzG1oWmiyV?=
 =?us-ascii?Q?8DHJ2l9rljdlSh9CYab8SfM2EJLhOYE73rHZwD9c0fIg7cWp8cNytCCwmEUy?=
 =?us-ascii?Q?3Ai69g2CFw9Vc6qv7GWcU566HIDYFKqSBBBat84fHMKITwOtSwK4M5wfB5Ba?=
 =?us-ascii?Q?7krGDCTEK2chkyPCpO8p7KAt1HMSEBcHNo8VKeODrH3vc4Ra72Ykcbyd8WRC?=
 =?us-ascii?Q?tD32qFth3Za54iVu+5HYNiQKT4jkkqukEFo/wpSgIZTjxzPeI32GfZGO02oV?=
 =?us-ascii?Q?3DCCNdb9lwS+WPY2PadS54JhDl0tYYSJZJ7Ag3jkBckUsPyat7uciyQGcRk9?=
 =?us-ascii?Q?8j2DqpAhqmPX7xMD7/nUOnalZDSRXE8N1rhrWQoQ/luBgwAwX10ZrajIA9o/?=
 =?us-ascii?Q?yBYyct4EYVEbC1diRtArjiNTLhgVfLMQlyne1vu2G8HYI95mYHKzmEDoFrqt?=
 =?us-ascii?Q?qaH8mUgMn45Jojy1a9SSwRxIo00N/3e4HgzD4oPFRmd737sZT33kTobGxgO5?=
 =?us-ascii?Q?D3ww4hgOli/HDo3TaKknC5yuSjiQKKt0fVIxEbbC3WxV3PHGBEB8REODf/N3?=
 =?us-ascii?Q?YerM3wp4A46CASZG4M/dJri7qah/JycCrHqjvT3WM/TyeMGREMKzN6z2hZvs?=
 =?us-ascii?Q?ca+ZtOF1stywrEq3ji+715agMX8v89owiua0X45DMDWOq3GW7Nfwak2uhizG?=
 =?us-ascii?Q?S2ptxjxzNeyE2X7ziUEDETd36zCqlBZ+6JnuHlF9dUTT9RY2qkJ/oj/xKOVc?=
 =?us-ascii?Q?aCA4nDZbf/Kyz9Ei2HXtMdpNb2geClLcAXel2IF59uT6TkuicFi0WP5MUwdI?=
 =?us-ascii?Q?IphNDkBEejCAnThF09qAtLPI+yxIHJ96ccbt96h4m4uOx2pt3BAaHXPWD7H+?=
 =?us-ascii?Q?leVfvfOi0mIjq9iOeDK2h4bXp0b6nGvS37ZbUVsMKxQ+BnM0vuHtcrBQr7B1?=
 =?us-ascii?Q?tZbUG0FAiJofO7iYN+I2wgbzOYdRfBHqxuH/0BcQw9kHm12w3ceIQ5MtF92E?=
 =?us-ascii?Q?n2qiazc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+L6pq7QXlXlUQjDrHpJ+JlQGBkR7ycQQszGDlVWSmo6btiJxDNFDUSD3jfhY?=
 =?us-ascii?Q?4dBwtiFpxNjTzDVmgACL26vfQolVQudMiQrlZKT/FG2mDCyOiVJUG0/gu3XX?=
 =?us-ascii?Q?0hzKgu6xVzELSqPbgGczZXAadjloFsoV5xvqRI5Hy4YXsj3clMOpqT/5w2XW?=
 =?us-ascii?Q?gotz0+0TKFiyUe29Rqnb4w4u237lEWSMXMJm+4SLTLToixA8qXhxYNOUPstZ?=
 =?us-ascii?Q?IVPld+M35xdPlGxycTyKakpQBlJZXtsRo6Qk2yesK3ffQFaZGSFjGzQoUcj5?=
 =?us-ascii?Q?F7EZxXClB+PhalBGPWM/7dh7vyG94f0djGYFS8lwnc+cuFlL7L+sUIHD3uFh?=
 =?us-ascii?Q?5kyNCs/SbAZGtYt5I2JN3+rgtYFse85peGa9t9O1kRccamamXboWeGtJDTbl?=
 =?us-ascii?Q?QtKAzv8yKgQ+yyr6iIKkNmdTEQrTkwGvJigLY3PcB54s/y6p97IaqeKyPyAL?=
 =?us-ascii?Q?f6MetlWYSQVpFlp3pznHGxDGyBWYv322xE7NAx4OmZR3zpNjcS63qyxnAl26?=
 =?us-ascii?Q?i1yNwvqUwEKB3BK6p70gDzVR8H/GXwTk6XQe8GtsivN5satUo81AW2xa75JQ?=
 =?us-ascii?Q?gCydTrI9tWWAEmbHxo1kTDvBWvBjyGpxOcIvEI1h5OMS+SikvijRoJHkDUxo?=
 =?us-ascii?Q?ekSmNCF8i7F6t/HAcJw7tc9JL4RzwB/z2uE2eaIAd8L0tYrdrBasTDhGOclq?=
 =?us-ascii?Q?/QeXX27X29QEiJ/FgMVokKWhhTAybnma3oFGKTz60asErC1heasYPhXTr1yd?=
 =?us-ascii?Q?9O6AeLEkLrS4OPYIE9LiCGHM6vFzq8IkOklxroQozA3DGY46jbr6je0hycxo?=
 =?us-ascii?Q?2wVwTDsSSNurzb47WQ/6ePxtaqTnsJCszztqBZhpV2gWcZJH4605kYM7icsk?=
 =?us-ascii?Q?LrKg6euWBWV4CF4GXTjk8pmzAgwAouV0DmldZ8xS4OK3TO6wkXRTXRasWxLL?=
 =?us-ascii?Q?lE+T5cc6sYzt4fifSyqQQBP8ne0xl0HSfivjgizcJQX+/ogR8DDa67jwzENP?=
 =?us-ascii?Q?xVNITJPGx/GuFJgabanRZ1h3vEvYLXcds6Cl7VtpC27vI4k37SNyZoahbhaH?=
 =?us-ascii?Q?uhtgK77j2JOia31zgNUdM3RNdNlLvBvet2nozZi3ZFZL3916OpixfXNOLXoU?=
 =?us-ascii?Q?1c33k3mX/Hgg9HfQf62MG187KHsCHfGB0gBg4rpghWrGEaJd06W6+QxiRNro?=
 =?us-ascii?Q?S81XdfWbqIrQONSg8Vy1AtDIujWXCng5xuM/37oiS001Tzq5sZs8tzeFfBGc?=
 =?us-ascii?Q?h/Jkk+Vo+FG3XtXSPE4IVZTEcveuioAnErV5hMcPO02QSycGEzmzAJaGxCLA?=
 =?us-ascii?Q?IorvXEbs1tYlMNWMh0l3r7ZE1aAVjh0DFmDdzDK/1Og0qD+xcUc76+F0FhMV?=
 =?us-ascii?Q?e2bRUT0qpvzkKFEnzVgHQs4RDAfw+Hf/9anCN1K99BaEzDwhzdPt9E9Pk8ER?=
 =?us-ascii?Q?bd3mgCIDI/70tOInhQ4idtUQfkSqC+FJzMlBeItnQxfF+ZMOhl18Xj2wUad1?=
 =?us-ascii?Q?8Y98X7xEagxo6AJOLm7CK6+DK2q5yUnfNKukVp2t5206tuIHJEeNvzY6bIS7?=
 =?us-ascii?Q?tHQRG3TRAW6fri9mVBUw1b6gcPaYjvPQRZIJhmrq/jDn8dlW2DioHDrRmENZ?=
 =?us-ascii?Q?1I02w0UACTD9srozcY4UPPc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: d1da40bb-528f-4e21-88aa-08dcf270a0d0
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:07:52.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04Qi5hTW2mjRinmjBx2xYcOJxkF2Fb9fXxocK7pP6hQWpx8gw7osao8Q40DqkJ4RQc0Y6UaHkf1W1ndKbsrMqfAOtj5Yazg5PvbE4h+KxWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0824

Add initial support for Nitrogen8MP Universal SMARC Carrier Board with
Nitrogen8MP SMARC System on Module.


Change in V2:

in patch 1/2:
	- Drop Unneeded line 
	- Correct the indentation

in patch 2/2:
	- Add Acked-by tag

Bhavin Sharma (2):
  dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC
    Carrier Board
  arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC
    Carrier Board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 348 ++++++++++++++++++
 .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
 3 files changed, 371 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts

-- 
2.43.0


