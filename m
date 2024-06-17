Return-Path: <linux-kernel+bounces-216662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 144BA90A2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873741F21136
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757917E476;
	Mon, 17 Jun 2024 03:06:29 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131317C9E9;
	Mon, 17 Jun 2024 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593588; cv=fail; b=uByJFibWbjyPhKszrS5Yw3MqiFBiL596aUquaTV7MFSRT48Nxp/x108n4eNgwwvUlPOAVE6AqB3GlCaZzOAzX9CoOTnU2ukSiTgX4Ss7nlSYqxZAk3R3xFJuziEv+C7vfYLm9FuoohJrqP3cpr9uyOioRYMILm7HF6H60UH+7JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593588; c=relaxed/simple;
	bh=cC+G8MAyTxG8iwx5LLu0y7nG6Q2Qaaa6d0OqUASBfe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bc1uzWw1x8/SnVMRtPYYb6udcdME97N88B4Ms44usqlUi/+R+Wh36xzQV1cw+IpcDRUwd1B5Pbg3o5puQOK4cwMVOHY//ZNNspxDR55PIfQyXC2gMclY6lqUXtfjItEqPh/DUbMSV8ZwpkHKJ4r5Lpt0JJE5tBIYi2dC0VqwrUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R54olXRGhaZqgAwrT/yWkcKb5M+wGrEV8p7sKJy4S95/8CPobqjYsRvOIp4+VeDN2moXBPoj0EI67hgPFWGd6AfTQvP1VG2E7vGHTvGpKV6zZxXqK4QI3gC7YzDFsbPXqe3rGHvC4YmQbJ7J58D92r5dgHGPc9fSNNl+FDLHEzaUy1tSKPWwy11ezaLWlyb42aG9nCdhLNlp9sJSDO8HQcCVUGqf623VoPhwotLj0fbdIO3yO++KFYIg/eu/1oC0IXGwMa9dfzXpNM6mJPSukVtusYNbKyGx0A/7AvqTNNJHS5Ye1pjpEpJSqSBYdBigNmWWmgKl6qwkDvVJgxgv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVw2NgDohpQBFahPboLSS8bU10mCoNlgnT9lJAK7tWY=;
 b=VArHqbBYhvQiIhZ1vhyRIovnjETZ96RghlwbruYhmFeSI71L8bKPi2QTar1q2ZBsrReMs5ZaxXRf1ovvghqRQpOdx40qCRIMY71TIAsqFoCK43np9/Afee6leLVwjhl/z9QqvQEmL1ZNaObgJPaHTmxjtpaPT3GvJRDftwS/z7+v+HZDEVCuc9C3nGveD44uz1FFQjpHNjzu/aw2NgUhU9dcdIIaBO2tWDWetHOUVBY7CCawezCcg+R8Y81h1541ccoAWB2ntGHjXVCMIb9m2/4LPP6e51KZU6QfplUEKByRcWYJOCZ44s0u3FKOaZQWd2N1QmCPafrxCk8+A8o7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8001.apcprd03.prod.outlook.com (2603:1096:820:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:06:24 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 03:06:24 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: nick@khadas.com,
	efectn@protonmail.com,
	jagan@edgeble.ai,
	dsimic@manjaro.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jacobe Zang <jacobe.zang@wesion.com>
Subject: [PATCH v1 2/5] arm64: dts: rockchip: Add bluetooth rfkill to Khadas Edge2
Date: Mon, 17 Jun 2024 11:05:34 +0800
Message-Id: <20240617030537.3112356-3-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617030537.3112356-1-jacobe.zang@wesion.com>
References: <20240617030537.3112356-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|KL1PR03MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ccf8aac-084b-452b-73b1-08dc8e7a789a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lngn91gb+gCKWtrnI5bNf2rIXoGZDizm4EVEa8PI/UvPShbZHFuenbTjki11?=
 =?us-ascii?Q?xtkVry5d/0ZlVr+JyV1EbmxDNoGs7E8gp59j8/GC5XPkH70iA2uTC4nj7CDE?=
 =?us-ascii?Q?eVsB/bX3BMT71iZzKImnWn3fsGm6OqtEFqHm4Ruih9iruSsLzYr9+Z/3TI7l?=
 =?us-ascii?Q?NXnfE+fR0Ze6UiVhiUnzQYUtVB1gKyelOI9uuINaxMggS5PbglwiNJlpwVv+?=
 =?us-ascii?Q?Ml0uL6Uc4zQyJx4AV+ZP9xJOxcbOQK1QRQ74f0ag0t9bRE2T37j8olygngV5?=
 =?us-ascii?Q?+047rIluVd2AlZ78Banm7ccoehkDNFTjnZXBGZo9wPwovENX+SvxzuINxqz8?=
 =?us-ascii?Q?MNgg9quUzhjiGiEdGfR7Ef6nkm/oh7vSWXfvPEF4Yl82Dtvg4X0yeXgWVkSO?=
 =?us-ascii?Q?CixfXRkcVuqs45QyX82gaaxCYWxnSzLTEcxzCFbM9XKK6WWN/97n9wMMF1ic?=
 =?us-ascii?Q?uvfhHkvfBeBRcSkwv7XlABJjPKq2puExEbzXnaC6n+mwJPQM5ZWtt1Ut4fSp?=
 =?us-ascii?Q?G5eiWiJt+B3iPXIsH5ZwPhwll5ZdkXdkB1O1ndtQyF14s0cRiTU8NELCLKiA?=
 =?us-ascii?Q?/0nacUEFxGEdXbvQTpLjHl1yyL5ulygzUviuAi7lt3kSIwbaTBMJjwgIa9yW?=
 =?us-ascii?Q?4PaYFe0OqmSFXEaT/BmGwqEvf0HV4HtsDSzJsdRqPPCanEldExTYkfrhpyFw?=
 =?us-ascii?Q?zPmUW+SQBlzWrZ2n0zgw0ht20obQJP9R+eIMRQBXqo7pab92zqCAOVsmvY35?=
 =?us-ascii?Q?5o8SOWB3Ii7fj6Ux2K5hx0VkM/fsLjwvRp6plDglKP86t3WXDqb8C3LUn7r5?=
 =?us-ascii?Q?IP4gCpAzOwS3Gx5Vh5nfLwHhIadPbCIrbLsflcsAlWm6FswR3iLB8ur2bVNr?=
 =?us-ascii?Q?3pHSKO3Lu5efTkJ3ao9y6avznKLWYgCYByoKDICSOajvTaG4a9hqvP8nsM2x?=
 =?us-ascii?Q?WdOruQE3/ze2kF1f2wKeaGhLlFXQj22tJVHkaF6OdH8tputKOyBF1RBhu6uP?=
 =?us-ascii?Q?PbbcjYt6SjWvbVuXzTWI11uBkipcTWbJamx53ZWzEugJkL9XJVcQsex+2vPj?=
 =?us-ascii?Q?UUw2TkcCtfwItIiyp394fdhkHavQIE8fb0g/WxaCCqlbQb6WsxkXBQpylcif?=
 =?us-ascii?Q?73AIhmL6xUd6nMNA/sCDhvG1vTXmSRGN+8rGF50H857AY5Fwg7j/ZJU1Ap5n?=
 =?us-ascii?Q?EyKk37fvqe838QrXz2IBacjIDms0OdqVM6nLWRIb7YGQgF1B8lZy3TdHHy8U?=
 =?us-ascii?Q?4S0TivmnmMOHHs/vm4b5c7KnY3WKof4PuzVIkzy0weJebmGbiQBQVYohPczH?=
 =?us-ascii?Q?sGgkq3x5lxOjDvVUv5yLLYRit79Yc7HH4QHBAzH4GTgi5799Rf1D0dwnZ64p?=
 =?us-ascii?Q?R080tF4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OI+VyJJzAJ007z4rgn1u2qTYFXxDbLadVszGl4XnRBxdyJUhbe8LPRACIl4q?=
 =?us-ascii?Q?1Eyf7UmG1LAZYbclUsvAgA8apk+RjYpAZB5XnHvEV2x/ZRAzH2uLiOMmsdwy?=
 =?us-ascii?Q?0YMvLIDl8r0qFevQ/h6fZXAe6Dvvb90R6ohr9tvQ9r+fdSDeIYtQZfHhvTub?=
 =?us-ascii?Q?92RIlf/XJNldUagTuZ7ZnSq4Sr01X7/HApbiiusP4WC72I5S3AtyuNjnLQoi?=
 =?us-ascii?Q?G6DOsCt+I8TFogvYA+SHnqT80dy9/ibj/OmGT0KLCEb+3McRYOuLhiNyPPII?=
 =?us-ascii?Q?l7++W694It9DWo9c5RqLwMh+YKaAr0lOA+E3/gsim0aWHKWXpmblbWrxJ+6q?=
 =?us-ascii?Q?dbbetO/Q7wx4Ymm0d00ac/Pj3h0OBs25AYrhyQ9W62KJRXMQH7MkQQGqBEyJ?=
 =?us-ascii?Q?EgBECeWUQ4shswoPvcdFJn6PWUDU7+Av6Q4lH0laRKpaEvFGu9na//7X/zng?=
 =?us-ascii?Q?uuI3BHhzjxaSV/M7ZgQlVUQEYP5oc0u93S01pAwZJI0I9qwLKJT59Gu9Ssfc?=
 =?us-ascii?Q?tJOPEiiLxTK6Ad/6xmpDZCyIytAgW2RG6+pphm+SOercSlBKsGcY2e3MNaMf?=
 =?us-ascii?Q?MrlCOLzC70+X3pUVHIjjX/U/X5NekK34mTgFaOgzRh70DLuYgtx96Ivg3UUS?=
 =?us-ascii?Q?n4ddIS4iCwr3SWqLmnjyRVh/VSGSVz356SKOijqj6Pyu76diqozv47bJ+3Z0?=
 =?us-ascii?Q?waPTTbVrlil1PAZu4sNf9pZM7sB1oOE66dOeUFsXVPaSbx5shOEHg7Rreg3U?=
 =?us-ascii?Q?DnxO7C74HmzBfn5e6bpx/jSDOLEvegO9Xu6/5c8r7NTyyNCJ5iNJAqLRUH+n?=
 =?us-ascii?Q?ztJD4ed3np1dUe5bQ3UTcGYldGyQH6eJamzr90vATnq2f9yrhk3J1m9p+NAQ?=
 =?us-ascii?Q?wAh3k9abyMA2MMjMSpMjsVoCFmZBBv/SKeptTvliB4L+6gQPvfkJIpItJw9T?=
 =?us-ascii?Q?031hrcHHizMpT8xzQmNIcAWMfew0R7okfSeCI8KLHb5Q/FjIBtwbN1kf1/Y9?=
 =?us-ascii?Q?AzANUdvih4aCvcPGA+lS4GQmhheP3X+WlKlMjs4GN+E5xl7a97g48UBLPQ51?=
 =?us-ascii?Q?ouh9CJDrJf8DpEwpnEtlZ3GurQDfbpu/GSq/HqqsQd2MM3wSdRjX08VYTTRv?=
 =?us-ascii?Q?/7EdHxJkCqsQleq4B5/N5KBHkYyops/WpFIyxvWo9hAUEsq8UyHjojuLs8ko?=
 =?us-ascii?Q?ckB9OFWKJeHPkYfB4YeE7T2PP62nHv7N0FgjlqcJ1deSRoo3oeq8D/JibJJ2?=
 =?us-ascii?Q?T5j5scDleEMcG9uHEEaJ3HY2ctFeGAieYyS7IIV8fDu3f97zwvvRl3RdKdO1?=
 =?us-ascii?Q?HYQEbb42Kvj1TFcJbGoCwzebS96qdM8cBFVdY0pcWSLDWZD5gFBOQU3rI8IW?=
 =?us-ascii?Q?CUYMNlfLudF0N5/f7y4y5bxD19uotSxouL8xwQOuDYfy9jTngPOHLJ6jO80o?=
 =?us-ascii?Q?aRRgelLoHylB74Jd2U8b9u+BekyGkezpObr81A/LNAi9iU3tJYLbARXHz2am?=
 =?us-ascii?Q?SuCTy4O6SKspNtjmYKksDq+ecuQBWzPQxZAjcy4b+HZAc8pm2yyPwgkk7348?=
 =?us-ascii?Q?t3TAKM9bha/Q992lVHFcEL250zyU7jwD9KVBr4EsImqXlgnbOiGAnGUM7IdJ?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccf8aac-084b-452b-73b1-08dc8e7a789a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:06:24.1376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr3pIglHmd/gEC5VokNWpsyCJqqlnwr+7bjbWCs1/q+L6f559pYRwCWb0GFom9C01Lg3RVu1qHHiDX0igSDsaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8001

Add bluetooth node which managed by rfkill, bluetooth and
wlan controller on Khadas Edge2 was BCM43438. In uart9 add
RTS node in pinctrl.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 9c2678905d236..3570578d225b9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -77,6 +77,14 @@ blue_led: led-2 {
 		};
 	};
 
+	bluetooth-rfkill {
+		compatible = "rfkill-gpio";
+		label = "rfkill-bluetooth";
+		radio-type = "bluetooth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reset_pin>;
+	};
+
 	vcc3v3_pcie_wl: vcc3v3-pcie-wl-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -750,8 +758,15 @@ &uart2 {
 
 &uart9 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn>;
+	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn &uart9m2_rtsn>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reset_pin &bt_wake_host_irq &bt_wake_pin>;
+		shutdown-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &u2phy0 {
-- 
2.34.1


