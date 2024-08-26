Return-Path: <linux-kernel+bounces-301085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44C95EC28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B0E281361
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A456713BC3F;
	Mon, 26 Aug 2024 08:38:07 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2127.outbound.protection.partner.outlook.cn [139.219.146.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034773478;
	Mon, 26 Aug 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661487; cv=fail; b=aBcUTyhDGU34MPbsEE1N7VxdvPHIiTCjRf+FrRYVU3uFTphvPk7U5mIBkrqdq37ZP1cMeHB74mIqcA16gOdcrlFNKtbyn9EmIblbQJfOQJ6a/9B0WemoLr/BblkcCVHmDoO24PklPjhMlM+HnPSS0paDRZ6Ols4RS3UnxAg9m5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661487; c=relaxed/simple;
	bh=2INJWO1EOu9Kj4a+djvbOO8cRA0VnxuUT1WKNkZnruM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ON3qabz9Od93+x7w0k3286XrUYxS2jGLfk+PdgasefmwYzQdYZmBFpVaXajom7fMerQJsFiy0dmRSK1/Z9eM+cvVhBZfbOp2VRLhNrfX6tBrPT7gQSY/h+9XvJVyT7fnsn90o2zoT0YrzS1KJP0UwBXVy+dzX3NrYWjOgxIkp/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEVr2qki5CvoAd8C0RT2+ZLNjnditUAMoTnZVqLupbUyf3MU/SYJoha0KdAdqUpKStxXsNSZ5VAjK5jWx3dOJygfABTgoC3unoG3AA7ZuZo84kEucn+z1GKQeoBcBlWc1sM4bkWPjpgx9sdi7DphOqE8TKrM8zQZKNzrrnX78ZtMfZE2QvTtwDdmqrGMZ3Xx3mFK7e/L/axJ6qXKmZebv8IJgJExoy1mfzu1dVxf63V0JlpwV+E0zVdhowTmYa9QvobDmJoGCIAa5+dZUOpUYlk2qrLC/V2wZRSsgqvOrwBncY2fP7BNtQ4Hfxck94wHzPsDJ0AN8WLfiIMBDyDBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJqYAXd5SOhFH243ODmeD5Tlvoo4s5sjbnOzsx6EnYQ=;
 b=bsPo57p9+ujckCP8bu/PrwDdIGjzLcdDJbl9H1SIOddnZnXKiaIahl9dBzyAQU4OksyUQhkS0DUL98iSf5zDQIi2IZ9omWhN2SvuzEQoAEwlAfeWaWfR2QGM0A5AQxQZUFH8/9VB6ibzxqwEtip/dNsM4lZhXlEq/nev5PZX3KVF3nNAkSyEzJwvqgnAHSe12x2AY80xy9Wf4+MDxQIW6qOWiBKwrqLSxiXPuFVO0j4D7ONntPfZpGMw44VXGmqpJsyaX6JdGsZJJyBGOyI8DfcTdmXFaHRZcq7wGyzVv/yAayk0mAOtAZG0S5Hib+3QrtSDYcV0/v2LyC3OOhc80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Mon, 26 Aug
 2024 08:04:40 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%5])
 with mapi id 15.20.7897.021; Mon, 26 Aug 2024 08:04:40 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v7 2/2] riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz
Date: Mon, 26 Aug 2024 16:04:30 +0800
Message-Id: <20240826080430.179788-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn (10.2.0.72)
 To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn (10.2.8.138)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1034:EE_
X-MS-Office365-Filtering-Correlation-Id: 4753fa66-a48a-4d8e-cb43-08dcc5a5bc5f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	ynF57+Lmn0VAcig1u52PwfNUTd5RScf0a5qUCkZ52cc13zukTKx/68+ZMfXEeTSu+6lxRS2dGtVLTZkF3AsZNf7LaH1PAfnZWpbAdrBWm1etPIqdyOIMNhMrAxQ40Ae6WE4X3fCfl8A6wZm42/9212orYdqFAx3+fAP0w15GpXeHCLeSnNyOJuFJ/4qv5UQqMn2VASlOUtSWwWbc9kIHe2HFDR6P7Dtn4mxlVOYsGdAGz8OKfMf3Hf4WGFSM6xr+/g3Kgh0UwaWYnDms7iZkCrFhXJyeazzB7Q23GJeD0wH1jBqKyLMbMxQizbiDKuysMwWuMk50zfeVEl2WluLRwdv/JZBYFbTmgz/mwaHD3uAm4VHcOB3+ErbwvQncPI1+2psWnvIXCfz24emZrpdN7PWNvLwTt74stAZaWVNHwipA1vwVbkozS2Iv2EuCOjkdPCaVCyi9fyPENOj09eBpLO9EG8/OT3LtOkXn762KHQ2uAY1YsAuproeexHIJtOHs3DphO1B76VTj2tUIHpOA92wONTWAAuMv3NXPsZUlpTTTEcn5ZjZtgCy+0+/UR/1mMpCrJKnoak25TGUolYFlhQriRqKlSlVmd0O4yPlIeA+QoSkx5H+VAeTj6nFO3Huz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8FaydVAitVal9BeQDU4Myp37I+zGkjPlEieWnG+6LUmaagHLyDldljQEMNe8?=
 =?us-ascii?Q?XjBHvbnpyFjZCySbyTEzcxZxKwZqES07IFO5hrPJKXPBHDNoRJpRKedszJBs?=
 =?us-ascii?Q?u7InSUzvTiEhXeRaHn3dM4kyEh+0y5xhd9J2iXVKQDPcimFQFOhdLwaoopu3?=
 =?us-ascii?Q?87BpcYOX7awwv9ndzhnSkPM7hz/hieqgYNXq2OIS4U9kRgSZC58749N00mgb?=
 =?us-ascii?Q?g3SmUOiiXE1KSsdoKkIWXnOJNXXaFI68hFrlOdPURA6jvUDs04NT5RqaZCRD?=
 =?us-ascii?Q?eExrkAst3YVyeQhg5PqiMiiir3e2coAire/xb66CiG4tb4gzS+55wkoDZDuc?=
 =?us-ascii?Q?gqWQPPnwZFr2Okl4Wu1Dj2xQ7ikqY0n/5rf68Vmv3SqIeZUDUQPZioAjXl/u?=
 =?us-ascii?Q?oe7maJjTCTKjyw31+2vskwjTpHvEi7rPJKMlbhJEpJCr5My0CQnuJFcNZzqV?=
 =?us-ascii?Q?pbyLpK+Bxy6KqHbidGODdvQbjOdfOJ970xFSNOR2JuBIBO0qGUpy17BCId70?=
 =?us-ascii?Q?7/pIyHHeISsO0RgmJGfi3TNl18lkhDNBea10VTDZVc1O3BgJoRQEvsSbrww0?=
 =?us-ascii?Q?bVXgd9FDVNuzlFlN9JbfDxfmWw00GUwE5Q+AAuiY5VNDXgwM5xgOp8F458yo?=
 =?us-ascii?Q?rruKFP/QOi3r5UaURCSMI1KSXav3EMHkhCHBbl/agONmiOFZyUw+e1zF7s55?=
 =?us-ascii?Q?aiGsV5huQ/LlN688bZp4FiFj67rtPT4Hvq8dZCddgvN//cRdAxOPDLH8pfLI?=
 =?us-ascii?Q?2bGu4XCa9rql6lP+tYOdSjR/2gMp2SATF1zTBCdzADhh1/zxTY6Kw8iwoQOZ?=
 =?us-ascii?Q?W81Fh8FN42iHf6ZZupB8b+3WLEqkExQjEDuGCcTUrABymHUm4JjhrFmkrYkB?=
 =?us-ascii?Q?+I+iYGgCW7f5kJpnA65/oXq1NaW9fF+75vibB16h2qNxsCEy09ZzyXdoHmE4?=
 =?us-ascii?Q?z+4SQ4cdp1eYo5VoTXCTKe9dQMlSQpo3isvXrmON46ZhR079z/XNjvKxPV0Q?=
 =?us-ascii?Q?rkz3FxokutcIhp+3uk/TcmZM631o+asNVBSUyUegmYOPlydyPgqOnFNqzapc?=
 =?us-ascii?Q?gRMJHs3zJU0HabhueDB5gbDNBVPMLrBqkpjMcXwMaqmAWc/G+T1wp8T6BeiF?=
 =?us-ascii?Q?z2R/At+oWcYE1tocFEdevdeE6WULKS3Q/an/lOUimri3zcOujxTFw14HDqu0?=
 =?us-ascii?Q?5KezVzofkcx2sPzeOCdBfphdiSzPdxGGm6exTWuR4QSQHRHcEONnW66MaDbJ?=
 =?us-ascii?Q?bYoks0+wovGppPqv+RWpCus3bcvOCHY5GRgBqDZwiAAS5Hj0OW69cIK7X2rG?=
 =?us-ascii?Q?uPzTDRHThXLyl0RK+P++4CzKIETQD2nNjALJCv4U8JAlw7OmtZtVF07ghUTY?=
 =?us-ascii?Q?jWJntICpYFEgOEBSJ65KVC4XGs7SZtpKbwNx0wHwZh/YkJA2G9cQPJgwpMAQ?=
 =?us-ascii?Q?Mt835Ho/FMLg27AjVsgH8q5/5bLH1KeiOfiOV0TOfVF8yniIc31E8sFWmNwW?=
 =?us-ascii?Q?seGKHgj9nJyYMJ+CeGgwepcWr2nUVfr6oQD4UMopk3KC7998JlwQnF3lDjeF?=
 =?us-ascii?Q?oxRaqp4J4pSIcnwfucLQa7EednUxchNotdmMYR8RPslmKw1YRt8RZQpVRbkl?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4753fa66-a48a-4d8e-cb43-08dcc5a5bc5f
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:04:40.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OL5jBzv8BEbTpa6fO8M4W7jCDTKZF4KrhlSkeGNIQufO8Qkz+s4RRYYNf4wkJC+cBpFAQMLQMfEOO4duxXMptQVEZWE0/LjZaqfvOYL4bG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1034

CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
But now PLL0 rate is 1GHz and the cpu frequency loads become
250/333/500/1000MHz in fact.

The PLL0 rate should be default set to 1.5GHz and set the
cpu_core rate to 500MHz in safe.

Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index ca2d44d59d48..c7771b3b6475 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -365,6 +365,12 @@ spi_dev0: spi@0 {
 	};
 };
 
+&syscrg {
+	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
+			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
+	assigned-clock-rates = <500000000>, <1500000000>;
+};
+
 &sysgpio {
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
-- 
2.34.1


