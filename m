Return-Path: <linux-kernel+bounces-371315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248979A3992
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6C71F26163
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96631917DB;
	Fri, 18 Oct 2024 09:11:00 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2107.outbound.protection.outlook.com [40.107.239.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739B19067C;
	Fri, 18 Oct 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242660; cv=fail; b=Musd0aHsBpo5G+3luouNDCWG5VP/2gIQMS1WhMtPRJNL8vZy5/6tRbFkPS4yso5Ef0lssWSV+yBzDqwgl4hpw0CMaI6BLNmyLt5KCRhgE+G4PL3b8gxPNB12+34VZ8ARJ3/VhDPw17tawwiyC58Ha7yYmWOAB+bGc/4/kYZjfyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242660; c=relaxed/simple;
	bh=J/flYsOgJUj0G6rXUlfOECYJaBVjX6ow5ZZl/06Y/D0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=vEc7/ldITesI8rgprgOY31rE03lIZOI7kwXuargWRIuMxTABt+UZPMq0GxE5bkCAeslg6S9CdWUXOVeRpm2KgqyXTlmvG4IXMbE2rMlJmtKsS9mo18Oh7MpN8GqXQ2kmYvYBAY5ywIqlOWXiN2R3Vui0eeS/MY5ZBdT4q32qys8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1GjCeG1d6xBXrWk5aaPO3n3PrNxX7SPYocVjZzeYos9oYmiXZdYZr75X4nFOJy6tDrCMFzYA/JqDZPrUYuI4Lj7/T44dkSGzsdEYAx65L18qOY70a3+LiQzGa8RyhZ/C5TVO9aF8wpBhdFDNCf6uyyNz//ROdJJDEe6962tqpm8DkJHJh6s6kTh0Bu/FdgOr+j1JaGrJa7yNfmAEV3poX7a6yI6mjhiZ9yCC7u921jX+z7KMO/LInOXr7OB3tCtmtnWUFfXIcH9tUf86IQUYvCBwTcBM09PkqpaSIe1WF60r0ojuR26XRSrZaHaLS1+HTmVATyIBLGWR7qywtIvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmEIUXJRKtF8Ahtpn23Lmuug5XzuX5Rxi4YKRcSL59A=;
 b=tLL9NnYUDJ6a1N96NaeqwfUNkZP710Pbe+xZpUWQQrwgIEs58k5NGDkNzMrjjqTrFc3y1mrj0A9f3A4tThtP3peFWaRlEFt00GZ4mRUTPWfiyLBiBppsEs+p41rqIPVlwJa8NwY9eQJZSsy+lPLMQI8BS4HrthfU+2FybAoPhmyVHcp64Z7b3qPUAfAQCD0kgC4FLaxZZfL6WwYJqmLBhYHUdMenNjgyHrCvIYi9gE+hM46uOwEP9QtE4ns/TE4P12szbsQ5QLR2M60lb6655GrIEenfM+tjjl4RxsvLE/LehrJQMp0woHc1PDSyX0/eGD9lWhWUqws+p5oGxfWjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN2P287MB0738.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 09:10:54 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::12a8:c951:3e4b:5a8a%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 09:10:54 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Michael Walle <mwalle@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Add support Boundary Device Nitrogen8MP Universal SMARC Carrier Board 
Date: Fri, 18 Oct 2024 14:39:26 +0530
Message-ID: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::7) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN2P287MB0738:EE_
X-MS-Office365-Filtering-Correlation-Id: f257e9fb-93d5-4428-aa1b-08dcef54c542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cdx3AZbpWd0QOPtphC3gkcNX8WGCFhCEuAs2EE8QdIpHB+f3JPgoL/fOPhwI?=
 =?us-ascii?Q?Yuk7ELwmYA0EIc6XXHS4b6buqi71iOz2sNywLdrXDA7KvWKJvYHCRRir5wNH?=
 =?us-ascii?Q?fIPGBTp8FKXLio0ZaRQXE/wXzwXUrt+DDsuoBYarTwEWxZfT00ujd5KNPa+7?=
 =?us-ascii?Q?kgntvh7xTcnBvWQX9+5DjqhftD7xDswK/tAO/j/khfvCqA9MohCH80ySAlAR?=
 =?us-ascii?Q?S81PdqEYyy96RKUFz98A3Hv8fPMRpJNXMRJoS9CT1yoOUsWVhEFUxyYG6Aoq?=
 =?us-ascii?Q?yUrV8htFbcpDKC2Jd2/KOC8vgJTMKy03SxmsdzOjG5ezYbslwgzhFkV1aC/l?=
 =?us-ascii?Q?wBgogj+AMuB76D8YckJJ8dC/w5D1bdirDxhcPO6O+Kh7UCn83LOf8hwfOwsg?=
 =?us-ascii?Q?5ukMxQNkvgf5d6ZpBsprqgVy/wW6OksJsMAGwlnOjkOPi8/bI51/U4bmk1FO?=
 =?us-ascii?Q?qyXSJYZ+WjMYr0uIEBmjeV937ci4w4S5MAQS2C+KAbZ2FH5pXHeU9ro/kbNa?=
 =?us-ascii?Q?j77pz18+pckGH4flep2Vw7Euoizt5XJRBmZtEOHzvDLy+h1L4cdTkcfKciJo?=
 =?us-ascii?Q?eP/yCildUscA25ZWEJjTF+TFst/l3YTeEIszxmjbz061rue9wbAEXDHNtcMw?=
 =?us-ascii?Q?YWWPTV9TsAKWP2OGFZVcwS9/OqygJ6eUA/nYKEiG3l1mTwoutKXZvZcz8/gZ?=
 =?us-ascii?Q?zz5ghQ9IDxvBPhRBHwbTW+w6U6LavVrRmf/M1J5fUoUsJMPCMNArumUO+hhK?=
 =?us-ascii?Q?OE2fLL9yzHuRliPMK8hZCJ1l3HQVdeU1giJ728IMd5Mq+30/elrNwt8k0Jtq?=
 =?us-ascii?Q?N5A0FAvU4QlCLQOvSKwATu+B5zLWYpio23I0ZmY0KEVyYsbbW+aKHct55zRy?=
 =?us-ascii?Q?/SFQKQowOa3a4yy2iE+R4Y3+wOOdXVw6iPMUIuvyqlJ4+AVCzhDZFPUiHZJ0?=
 =?us-ascii?Q?thCSi1gg4Ms2xPUnRH4v2sEJK7/b73UNWcnXI4HjMf9BC7KEEVnKIzQHBvZ0?=
 =?us-ascii?Q?o0BFbYbH4i/wk/F2CHdNI+iW2n8HZc/TuZb/gvn47j/DHlYgv6/s76X2H4/n?=
 =?us-ascii?Q?f6KngkTF+INOkQrGaOeWCP7E5+i3MzNHI0O1VftsY7QtcNxlumUHRvOEitJv?=
 =?us-ascii?Q?TCYhHQbxx+Mh8g4iaedHHK0yUV5oqVL7eTFM4kEx3KPcJmjISm8TRfLDxibi?=
 =?us-ascii?Q?XFwMxROWZdFz/lc8CBEb9I3UEXMtyaeLO7hJ8StwgaId8o8Ou9dV2KC48zai?=
 =?us-ascii?Q?/M+kTcd9V7JqzfA17EfbeHIYvWlFAF3C8DxDHU9FlbDssQHzmQsmfpKH+CUC?=
 =?us-ascii?Q?hOjDBVP1PfjjxLvXv/LJWJFGB5DnNTzpKUB9L0N1MY859WlM7mJYugFSxWwN?=
 =?us-ascii?Q?cJkiPWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fkKYPJ3jReNcgAHmJwyZCog5Vm2EtrHe6iHMsuLAU5/12sBbuy5Lb9584e0e?=
 =?us-ascii?Q?9+scyKxQ5i1wA3Hqj/TqTH+uebxK0Zp/XhiH3/w0pFHBbTzy7bzPwnRjmDf9?=
 =?us-ascii?Q?Ykk2/7XMwqvHhlXeLfJLIUeCn8/oOZhNxVV4nLcOdQ09j/JhnMCHoW23r/mu?=
 =?us-ascii?Q?OJQSbIJTaGXMsIDMSlG2Ge+M3zOY4TaPKBdDzSoGjoFT5vAhMVFrho3JfOf2?=
 =?us-ascii?Q?c9L7iZi4CeRN+idBifwl7Ax8ZhR6Lv/JylMBaKBq+IjgQjejux/J3jes7TFJ?=
 =?us-ascii?Q?6PHwsZY/rk0PGGJ0QyrHeNteUr6PWDk7NBCupFRT4HB+RZFdA4rb9l09f5qA?=
 =?us-ascii?Q?XWgcolI/CwF2AOS/0v2BAtpZ33Sru0JWPKlXAB72CLEHG2pMuff+FHODKVYV?=
 =?us-ascii?Q?LS2I1NDFTESgLj+LmoAozHU51HGrOtNS1ZG0tXm+i7JO2F3lOZQUQfGhJ0cc?=
 =?us-ascii?Q?rAzmn+PwG5vbMFMavtwf/4Lm1cBp18gotn3dhkXrTS563qkhELoeUgiyZPja?=
 =?us-ascii?Q?y29mkeyli2P+3aXiU4xhoKDP+N624GMa9cbm+o2NKzI8SDh99NwHGqT6liy4?=
 =?us-ascii?Q?si65C5k8xqarEn/uLvGQhjF6311WpffOLwnK3yOphQOHEGdtQAoVM4jOkBCZ?=
 =?us-ascii?Q?BSqeIWXBP8cuOmoJvj0r+u+noX3QEffiOXqgWY5T3NNOv47uwzvaTWmlyLaI?=
 =?us-ascii?Q?48SUqCA403CBt2orTiklkwSEiFN0dBC2d5Uox6M9XjbXnD2B8tUNcZv/1run?=
 =?us-ascii?Q?M5ou/XxZ8XuopddwjvoOIDAhwTDGZ8r5iGLeT9JzBN88nq+oeUyC7mYQVEMF?=
 =?us-ascii?Q?gKISA7nAzdm7fIRWRAfsBguwcE60aE6Tt6psfBGOJo/U6T8bXP6FDJEMaGXf?=
 =?us-ascii?Q?PACYrjr69cTaOb59o7vjOHBP2rIhhDTUYTW9QayJ0qXP2nspAUzYaFbBmpv+?=
 =?us-ascii?Q?WfrO8myFqWwcHP30K0IZld8qyF+7VkyhSXvESBsisw0h46+A2+xBKrrNEAy+?=
 =?us-ascii?Q?KoJNW1Mds6R/LpnHkSa50Pe0uV5cCEhzJXT4tBQKEBin8Wo6RfY0+t5xTQlb?=
 =?us-ascii?Q?6WD0cEOU7JHoKVEBcXi4v1P+g4aTdG9LXa30dWNlDtcAm9xGncbTbdP+V+BW?=
 =?us-ascii?Q?GcMG4/BL6T8LY6pxRQlby57e9NRHVUFpTexSVHaVIhm2bm2cOD5MKj7NsjQC?=
 =?us-ascii?Q?zXlkMS4EbxSv8UBCFtECjBFMuo8ftuK4UhJCkcIKsL9tEYq+pcdPzbM9BK0r?=
 =?us-ascii?Q?JCSDxWp3OJ1mGpjsGClw30/6c0UZIP1iwsm+xM438C9/b4gaeAUM+2jmblzR?=
 =?us-ascii?Q?d6BmOtgk8hVTgKJvUFF5w6CcWsoGM6KJzX6ohyLyLiqDYyl33TohdbXkS4cq?=
 =?us-ascii?Q?hyGXuJ6WnEHY+A4d0q/10y2sVjH04540akwIx2ZAuNY0+Udai5xJbsmqJ25i?=
 =?us-ascii?Q?z65m+cOgIncb+sYygJ1VLiaUnJ8Ce1qoEjNuEVqMy6M8kea1k6V4uWK+mwRM?=
 =?us-ascii?Q?ksiPeIbSGxQtkwBhXO4SScKAUF7NGnT2wDVq/brlWdleXWrk2hEul7+0wMv9?=
 =?us-ascii?Q?V06HG+doUxKZJCaAZmkZaXp60hBjAA3XseciX6a5L8oNaWgTcfS2Jl9UQfmn?=
 =?us-ascii?Q?9yCG7cPuga0+GAcacEQMYBc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f257e9fb-93d5-4428-aa1b-08dcef54c542
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:10:54.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYZIDK2HgzsxO8BYu15TN1lJylYvtn3TQq7/RCShu/+IZBMtHTM0HHraIGXhIILpjtNRk+bv6FkU78OGhLMvj59sg+IEpX6YhSf+lEA1tjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0738

Add initial support for Nitrogen8MP Universal SMARC Carrier Board with
Nitrogen8MP SMARC System on Module.

Bhavin Sharma (2):
  arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC
    Carrier Board
  dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC
    Carrier Board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 349 ++++++++++++++++++
 .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
 4 files changed, 373 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts

-- 
2.43.0


