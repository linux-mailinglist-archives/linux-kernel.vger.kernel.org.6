Return-Path: <linux-kernel+bounces-216664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5C90A2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39D0B2219C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93E181CF7;
	Mon, 17 Jun 2024 03:06:35 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD1181CE1;
	Mon, 17 Jun 2024 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593594; cv=fail; b=lqww5UjH/fbPBAfCkObcPhxOhh1AK0JjcBkKbzlOYK1DbZDNl6DtpozPHQ1dV6A+CIC+MAamXyVGcAvfuANK+khV+KUH0DcLFA60ihBfnDVhdyg+BIh36piJDui2Waxs+CRUzjshP3LYDxNVbMJcjVYpripshU7CMoUaGsM2QsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593594; c=relaxed/simple;
	bh=wjM9BFSb7XfNd/waasqgb3uahy+TVUgcWelMRhZurng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9Td9m8T2P4n8Oa34Vrrgrkg1BKGgGdRui+J69MmF4gZut7kXGXRzcORsSPguu05T8/kvQY3c7yA/b3nfenDuROB4vSZQOrsjiD9oSM2kuYyP84uGMApw2/xIZ0FYr4E++ZYXt6D7ZlgOUQKKrNwO+4Ob271Asr5UkOpfh7OGzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqfxlq+D5kYTUXmafj4iW3kHeId9UygGZBk1baHeV1m7RK7lm2US8Vi2s0j5gn2PzKdc1nnmKTx+1S1g83b2EIt2UMcb1ET69WaGnVDvVonawA5RR5Bbpf+70nIMBlcDXYjz0HH5VZ1SKn53dtcstpuwZ5G7dbIBko5oYXFH7okDNoxol3vIq/zmctP8mNXnI5wR/mYQSrWLUIG0xoxggyLSLkqc3tcccJVzJ9Wg0MKxnbLhZWcBM/y0oT99yw5s8HSnu/SPxeJCBGU/ODhjUl2318APNl4HqQY7bv/uMPE09FR3luEUdpbBegfEjACOVDW6ny4tm8ihkzmei/CEaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCnVNL27q1EwocllmDblvXml4yVAuAodLoxC4QLj/oQ=;
 b=QVyeljpPvfgli9RvlATD2nl2Bl9nH9AK9nrY89T7eSxwsN90zKbRvQdagVgiTcOPBbx3qHx7zL/trTWH+JRAh1aOtdE44oQG4zjevBCL0vrOLS2QltJMcHXuk1Z5njmzFV+jvt7nKKZHXI/yXyNHk2YrYR/MwoCO+o6RXbadDMiqeitNPDCbop4kqlSXCBFjL2uWPVXeOuCvTpjnbb6d5zoDvSEaF3bd3ryF0ECSRkuLnEWTS3Jn07+6bQS08Y7m/6nycBL8MqmSHlvTYkFHgYadI+5Vecl2aD7YR0WLmlsgU8ggO7/6mqrAmgGMd7yPSzo8rlv9xW2WyjFwTkDH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8001.apcprd03.prod.outlook.com (2603:1096:820:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:06:30 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 03:06:30 +0000
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
Subject: [PATCH v1 4/5] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Mon, 17 Jun 2024 11:05:36 +0800
Message-Id: <20240617030537.3112356-5-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8cf7838-aacf-4291-ac65-08dc8e7a7c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6dQ6poiI9igHtvHPAm1T3lV0nhdSfBikCc/QBjzmeyeSDHTGHHj2rjuScciI?=
 =?us-ascii?Q?TqAiNMczOX7Fmbc/KuGS+1Gkc02w5s82BurRgGFxdFAExCIJoRHKMuO0xWYG?=
 =?us-ascii?Q?GdaWbSyqYZB3AFucPTmZ7HVz1HEcgpz0DJIXqAt9aK1kuWt/excssM6H5ZEu?=
 =?us-ascii?Q?pCITnkrmjzy2/g8+djv6AtWdCFZGyVtqG4Swy68B3z5xOQo+9yEnQaifCXL2?=
 =?us-ascii?Q?nOnD1I4wP8KI5BlvHRUw2j3IExq1E8dGvubKQRsj1GMa70uRQ/x/pfdjXk+h?=
 =?us-ascii?Q?U0hS7ZkccZYYCFOO9LKqVT46Vy2NI5k9T1wyvAd5ZQGfkuGFa4qJE/LJx22I?=
 =?us-ascii?Q?nl+uY4TInMY58WioVZSi+InHzK32fywRrN7pnUSTg4uwTnvuatnym15tZBiW?=
 =?us-ascii?Q?nu7Eanxt0Nzs/72XQVoGk2zmCMgkZd1o6+JK3cCcRhict9EVJLoF7p4KFYFk?=
 =?us-ascii?Q?qY8Ai4UneXtWHssMOlNxPC+/s7G1eKrOAAQzv7qnahS9PSy1RTLkESHuxhon?=
 =?us-ascii?Q?rp/dleYPl6aCCH8KINMU9bHA1J/iofhVHZ+kV66bEudNO8W5oJMvnrpj7RTV?=
 =?us-ascii?Q?ua6DJkdv2MuBVG5cVMTMN5yf6o+4Bp+gvhsQWwKKCeoumFl/rKCoRwifhaJ9?=
 =?us-ascii?Q?Ybjn2F3oKKVf47pDQEMHjXAgumrdQaApqdZ7ZAd+sdCITGKZ6M4mifd6eOh0?=
 =?us-ascii?Q?Rtd7nIdXJ9yohMHj29oBGvNRsP7ffw5j+B7pJ7d5UvyiTrrOl/zYlQ22ha/O?=
 =?us-ascii?Q?bYxLif+Ht4S7qigjEdTMVuoTXo6eM7NUW+QHkksl4qRe/1X7JbwgTZCbk9GL?=
 =?us-ascii?Q?fYrLDINukGu8BQ93bF+2pfV8k+GSOT1lbxePwVxgaWaL6S2Z866ERUeZ4tlH?=
 =?us-ascii?Q?rPPK2n7LQ50lJcfLUtMzkD8TrzDD5QTjHub8TiBOzjH4qAPxZJ8Kl+L3sDe5?=
 =?us-ascii?Q?8QYh2xQ82O1jEyTK/tdu7KQ2XIHVs393PERpioUzjHK200ZLtnSWFP48Ahvo?=
 =?us-ascii?Q?jl90E9XFsIiVFpbTLMF4XrNA0vLIawwuzH+V8w9ncypg6jCVjDr88X15o8GV?=
 =?us-ascii?Q?xLS+g5j702K20HSQe12Ebj7MJYCPi4ZukqbOti5pbgncant/q8i3QFWqNGTl?=
 =?us-ascii?Q?/v1TfZVENf33PAuJXQS4rasS1Ylfdx4PPJbECewXbpm8OoWFH6PX9HhGfsm3?=
 =?us-ascii?Q?mHoo4Gg0wu19iGzEbTaNOSlc3H/sUFldR25bbTGbpsVEJeGGqOCdCoWvvcDD?=
 =?us-ascii?Q?jfr03VIHmLP1HIUJlPlc22TcLSDuqAh6UyYmxylETZYGuATDv5RCwfNtp4nt?=
 =?us-ascii?Q?e+QFkfom/OIH2WQDkqV17Oj7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkGnNrg7E7q962eGJedYLATBKnuyJBuKiLzV9MM3jDNESyP5UZUOY+P60do1?=
 =?us-ascii?Q?Ue4F4jVVZgigElX3wbRzEjC0ZKuCbMY+2UmAN0YffFiHioZ+CHFh1wNgIcuV?=
 =?us-ascii?Q?HMah687d8P1u0zLrAoXTeONWkEzlunNqH1LUMTH5XFqzHZFBKkmZJ/+fpvUg?=
 =?us-ascii?Q?jUPu9szZ/lYlN7U1jKsf90F3Ahoa4y+qYpFW2yWREpTWgIyO914oAcIw0DHC?=
 =?us-ascii?Q?2XQhXIkYqcOtVo4o029iXf1Rbi4d4PauvRLE0u2nlkxFhOrV4LuggRhojeMu?=
 =?us-ascii?Q?v90HJb/cU9Brp6BYdg2RManyGQKvSpW82k5AOaa4PV9QswQpSFcv0bDybIdH?=
 =?us-ascii?Q?XxqxyTJckq+KlvgrZzGeozY4Q/K1rhCwYBpe6h1sXoUb8B2ppQ/fGtGL3dI5?=
 =?us-ascii?Q?ZW8TkwpB+QKzBgPxjYoKg/AE8/NQegqUy0dWRTdgS5EAaarWGk0jMaXkCx/o?=
 =?us-ascii?Q?GnBWa1j7cuI+8dDl8EjC4CR5orSn/CBbT79VMrnfJEWsnueQaeWsszv/M0oS?=
 =?us-ascii?Q?plZ5lhWL8UsTQzNBBLAqTm9v2TvouyNolQgLoJqoa9sng+iffsq9QOUF9DcF?=
 =?us-ascii?Q?eZnrgdNtEyx6XpxOg2f5rnW7Z+ctnybuwAtJZ9TxmoG9jgdCtVi4jcHh6MBW?=
 =?us-ascii?Q?7LMDzIl+zYDenCaNr6rGF/1fafsUJHD/t4vCwWI83Iv6xJOqTGFTKiqmsZCi?=
 =?us-ascii?Q?eKQkVzqHJcHj8CzdjcPoRGYiFuZV1vh/PrlqdHMv02P6/XAM08axCV4HM28H?=
 =?us-ascii?Q?125+IMeX0rTIOp2g91Yj6v6fGphiYXjKhXV5Xm02rF0fD62xqHrt+dY5ytRf?=
 =?us-ascii?Q?lt7N0aVsvb79s4/V+I322VTqYR80+myl1TUS8x5jSio9S8RbOk+Wlv4ir4gR?=
 =?us-ascii?Q?RGtIWYyqjYXSPPfltJ8gBhUT3YhOVXjtC5+pDfqjVCrmTZy6y8AEhlgDpNrc?=
 =?us-ascii?Q?FV/GYKlO4dSR4wvreBJa0aMklHN4Nzd2MBfWQDMpekwatex6o4NPVIy0g5Vp?=
 =?us-ascii?Q?9xPmEusU3Xzuuna6Zwr8YVBfyxKKvhQOwX47z6YdjtMc85jW7l7R6KPjuGGB?=
 =?us-ascii?Q?NwL1JK8WEbePB0zR3EIw4WyCCWj3xVwTFtGcbB5uKWAAxCSWpRWNcqxfcMY4?=
 =?us-ascii?Q?YpHE4zEMhsA51pXYAEwDjJzmP1XkHymIWGjF2yQ4su+x7DHoic25taoElTj/?=
 =?us-ascii?Q?gkLkY9+zvOsdOiQhRedtphxjDlvMWLZjirgcWM1k8LlD4Duik3RdEv5j53MS?=
 =?us-ascii?Q?OmtsHU61ua3nN1UA/QzLdSTdUDbElDu+ut9bitIV8yXu20KCioRvo5SmVJrf?=
 =?us-ascii?Q?Lkzc7pdKeuSdVq0z1HgpFW9RH+2c3FaIXR7Ue5/HqJEVxwWu3qKXA37orLY+?=
 =?us-ascii?Q?oXIxWRz0WiU0YLGnBngd/SGadLgHAdG4Ia1b/m8z9l0WLVS7q9Fu7ORGe2DY?=
 =?us-ascii?Q?ZV/rLXpqNGtdFI98AOLfA4hm886w8xOWcU+tP0Uk1V9mn1R14wKLuXiUQYJV?=
 =?us-ascii?Q?2f6ZHAm74dDcemvdN/j6J31ZvuPwjbOBYTfi7e5F/iyY0f2zhHHPX1CG6uAI?=
 =?us-ascii?Q?+sGsT7o0JcwYKIMU5iZdr3ScSohdDDrPDtBTpQVcA8HFykd7agTtrYhYjfSr?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cf7838-aacf-4291-ac65-08dc8e7a7c0f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:06:30.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ds6Xad2S7RLF21epqPskOJARIQ/pHQ1yxvp7Pr4j6RLLbyqXLzdmcSkHjRaGIzf43DBPOrVPE9EW4OJ+fBEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8001

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. Add "pci14e4"
prefix to vendor-prefix.yaml and "449d" to brcm,bcm4329-fmac.yaml

Link:https://lore.kernel.org/linux-devicetree/20240617023517.3104427-1-jacobe.zang@wesion.com/T/#u
     https://lore.kernel.org/linux-devicetree/20240617024341.3106240-1-jacobe.zang@wesion.com/T/#u
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index f8bedc5e05fbf..cdd5f124e3069 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -365,6 +365,23 @@ &pcie2x1l2 {
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie_wl>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x400000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x40 0x4f>;
+
+		wifi: wifi@0,0 {
+			compatible = "pci14e4,449d";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "32k";
+		};
+	};
+
 };
 
 &pwm11 {
-- 
2.34.1


