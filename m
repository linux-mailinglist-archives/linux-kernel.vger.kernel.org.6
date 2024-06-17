Return-Path: <linux-kernel+bounces-216663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFCC90A2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514EC1C2137C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FB0180A64;
	Mon, 17 Jun 2024 03:06:30 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E117E44B;
	Mon, 17 Jun 2024 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593590; cv=fail; b=EkFJOLKF2mRX2NuMCgjv8ACGqMKHiKFikjVwssQiyyFAQu9n0R7vR8f6DKdYqXEy2xuQUG09A0rEtkJmGCcxXmw/8CAj/jWFMv840sCrlPU1SCL2wlxJhf1omVdloEn0MHy/3fYxqkr1yJ/GcqFYRvWNPVLozPV5ucNh35pn+mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593590; c=relaxed/simple;
	bh=Yb2JPbTXoksiwdjsygTLOA0JEgqwzUuQUvw/C2ACfFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIjBwfiJJlePPLjMNJ3wdUfpo2xcksYW5bGsismAvlt0soHJainAGxg3RwwiNbkePQxQkNAsUcWUV73YONplPZwZbPCmclKcq9/+jcM0p8yUF39g7j6AR5Km9VlWcExUqHpCglUobzlllITlkWsdw4zlFF3JuyCeOHNn+nSaLVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzY6kM8jBePuFEuP1nFaM4fM5YhrvYeJ+fQUEKXt5RjT/rL1BFBnnafvwTM+S1eslqvVZB1wX9QiffFA8NMJCy/vOqrbTD1PVJ01OtZ5w/AzAGbx3Pso6nyqzdn11icURyxTTGPTowOkv+OWy7CxHfDYkpGm9egoIVXopV7lSZsWAg9fMnZcPpx+G4ngP2zc4QIL+kRr1hxaLX474ATI5Qihb0w1v0L/+/s0oQ2bY9NC5Jnf4E8T5cZjRXojZEFWsWHPueVntnKwXfxSl4iixBSwjPVUXBBHW6fs69xK8ocdq+XiS7pe7vL1SFBXu8hGuFiMRWCE5uZp4+ZZ0cRXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFwsyf1hkdKdaz4QTwfikc0ykmFvd1jglofoX+YanY8=;
 b=OStR+R3V+UH/nEbAP/dZK3QGKC6Byb+PThkArjj7VHZj9tP7U7dd3zC6cFSilHP7/m2NHSjVA2Sr8ZZYn+Qs5bwTSP+g+lEZqoVii3L16gIAl9vU5+Jn1aYMf7Fn2UXX0PeLDgBKMuUxOduRYjp5SuEEwY9tRwdNFqZeodDocJfrN7NWiHL4tFemaxhqTGCSAakC7mxVFeftGd4TwG+7Muf0Apa6Qnk3TvUkfnOG0uvKcUNahehoGfu5sBy28KfGN3wRuBN+gGeYBRIp6RssbvC6l+MQYfhe7ebCf78RFvKRUCsajl/ubk9xB2hN0itk4lMQsY7ykuJD/YoWjXrEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8001.apcprd03.prod.outlook.com (2603:1096:820:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:06:27 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 03:06:27 +0000
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
Subject: [PATCH v1 3/5] arm64: dts: rockchip: Add HDMI & VOP2 to Khadas Edge 2
Date: Mon, 17 Jun 2024 11:05:35 +0800
Message-Id: <20240617030537.3112356-4-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: 562502ed-8a45-4f8f-81be-08dc8e7a7a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ixMqbSdlV0ashFyjtm2j5mWzBvYRqJBz2lANZ7+V1HPF9ZzMKw6tnkfmslf?=
 =?us-ascii?Q?quHEUhB5UWtCB5znXgFqrrg8iSlNeS2hiXBpavKF0YnQbOwpvfntCopc4Zxu?=
 =?us-ascii?Q?Mdue/Qcy6cSxOrROf+NzTlIfldfdn9q+IH5aAAugrGDoXSysIj3L1U9Yvf1Y?=
 =?us-ascii?Q?0wFMMVY09/dDA2eQmav02z2jho6LuQHE/BC05Itph/ybtsv1J5miGrFpozmM?=
 =?us-ascii?Q?wkOvMLd8hJIXUF7zZzpETYcucce47mZaEmsEO0nFDngOvkZd5xJl1bmCuDle?=
 =?us-ascii?Q?v7DvPy6cPU/G+4SCDgCIJfNEZlZTgyy6n/SG3VYCbe/b7BIefxjlLR8lVBj6?=
 =?us-ascii?Q?62rXhRXVwq3s6FsY+MClXlJ4XQc9ChCq6/0ZeBO6AxdzxMUm2uwKkn30A/qr?=
 =?us-ascii?Q?Dbp+jeey/hKGEEPzZ5lfMYfK81VAJf3Voh6KkTg3J5V27Nly+/mRtvUSepet?=
 =?us-ascii?Q?ES7Mbp8dSOf/zkHQpSUIgMULwqMyZUrqwGyS6PEEe2dtE/7HlVIkruKp067i?=
 =?us-ascii?Q?ouRh0jFw/LXbPRcTu2c1iBGMWl6Hmk7eToWr5qc+uKQ/TRfYbxgxsfBq8cnz?=
 =?us-ascii?Q?eb6pA/k3cTgelpvF4LNKd6ISxTxoPP6ZwV2+g4+J4Q/vN7Q2cOLiFGms2DY7?=
 =?us-ascii?Q?P0UsHpmm0qlXNX0JP2Jwt/GHsNDDp/EU3OLg/wlTOS6Y3T5Px06crC72MJcn?=
 =?us-ascii?Q?35b4krvoUpW+DOr7NxdgqodjbbC3Mcga36pFBvjZH5hpEFRdE33Bk54ZskkB?=
 =?us-ascii?Q?d7vfhxLbTWKeawRsd4mupbO0Chv9wsKSC3Zarnr/HoB3UsmjE5/2rQRKDevY?=
 =?us-ascii?Q?+/6Rhef4/yCTd6zFfiAshxOHzY6y539D/QY+A/3tPQaGx3aR3zmYVmZg8XKn?=
 =?us-ascii?Q?dJiJrX3qOFJWm0uTpJzp/sNz39lIKtlem/caB5ip2t/wPvH7vl+u1qazLlYP?=
 =?us-ascii?Q?vOpilcbIHq0NFjXeL3Y6lPh12MgxW6J3eIdX40SCOUpKisWUatNO7CouQlc/?=
 =?us-ascii?Q?gwC8bGBkICHcmeG1oIJDvgAl822MK2t7EZNhO+/pLe2MOgyX9nByTB4NyCwC?=
 =?us-ascii?Q?BSDuHQs1Ckfc7MlmnXnfxRstILvZL//7VoX6ZRqOgxC2wVg+C25EXIo9yhHl?=
 =?us-ascii?Q?u0aBGIno9cmqkGVSE0FKidypx5AbrSRVQiYDqVrxtaDRkUnFaT0Nnj8zyPUm?=
 =?us-ascii?Q?UoZiXIjHQLQ3YUK8pDXglLztpKKYD+ldP4r/l7z0JBKdkAI/fkJ7u9zWvct4?=
 =?us-ascii?Q?RtG21X2cA/0I+WEqOCH90R2PpAxfjYOvQ2o4lBxH2BPo6rAUXzEO/8ULNkrs?=
 =?us-ascii?Q?6PDvMzHtT7od9enk286cM30YG1earH0AJrrThhrE2B29bOg0YsVBdoWX8BFI?=
 =?us-ascii?Q?NXjCQR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4OE4p9p0Zsd9N+2Nt9D7vyJz4SavJ46caW2IuKONrg+XNpNRwh8Xr3WLafD?=
 =?us-ascii?Q?vGenu1AlsS0KKpjKKoL7lt8vdGtRV0L0OIT4f32qhzBfn3icJOu3MB1YuV5J?=
 =?us-ascii?Q?6200Hi6dxBs1EIQQ/XX4CZeYiQ2aw5ayGNiOKTeqgsFqISdnu7+JP4VC3F08?=
 =?us-ascii?Q?SYY/YYuv793596ISeNK2dkFp44DdyRayaZpfC+6lBLT0TFfO/wnHElFmPJX7?=
 =?us-ascii?Q?XRYOozxgbJftpbatbANGvM29wW0x2UE2CQrzTybB5PxiBPb8Xq0mlUHSBF/B?=
 =?us-ascii?Q?6PtLP4gN9ee7pTNIlHXJu2Uo4BGFm/YWz4a0yal4mb76NKdOONnRs/kjFu4C?=
 =?us-ascii?Q?mIbq8GsQrPR+CJDDFpaEPuu3xNxBgeE9MX//IYvYP3C3Y+SY0Ylq0cEtL0W9?=
 =?us-ascii?Q?SxSwp498VsZcfRhIizjoDaB3a1Ur6QHdhIPHQpGQCq02mJBAOhACx3br+ovu?=
 =?us-ascii?Q?dcnSt4GkMC9n3ONPcBgxWLVm65LC5Pf6s0ukax6ZV4XQP8tWr6uYWggOZVTa?=
 =?us-ascii?Q?H22waz+OYQo1/G4dC02vINMRT9Un8FNkphS2ta2lYSh69MRwSotnRQWCYDAM?=
 =?us-ascii?Q?ngs7go+zQ6O7DAcmw3E3A2tuvUh3sSCKCKp1vJe8fg4C3nfTs9B9Yq/rJcfS?=
 =?us-ascii?Q?e+Aym0mG9HsoXng9sZo3hRct7y1nuSLSF4pcjBwv7Duu2ffPJUl3vXZVuQ5w?=
 =?us-ascii?Q?xuln5SpfqMEy86jPYJ2DL48P+uBqANjzV8X7QqqRs3asAAghlAS+2iCQ11j6?=
 =?us-ascii?Q?1T8CUwCjp2XaX53z4bUXC8A5k5+a9myFSD/wusIHvTCANWPZ+389w4kEMnpv?=
 =?us-ascii?Q?+JJ11mXeMDvaVA0KQHX/SOG8LDtfgwQTib0jeRShtw54MkF00VZZdQfM3OeD?=
 =?us-ascii?Q?uSWb1Gf1aHfyP4CfC02PjPOmoxfVvO0dN5CjQC1TcKNOZ2k0dj9I/giat5mq?=
 =?us-ascii?Q?KBIcH6ftufMNkSdoB17AquqFB+Og0+biheWR6LrZclxsBTPsifc3qlG2HbiT?=
 =?us-ascii?Q?d/PmjMUJq93L2AB5vHqs4j4ZiwiMnk42ObtOlBeqg0E9SUfEQlYwAUxhqSt/?=
 =?us-ascii?Q?GtZdQIGi19ZySNheGIRNc0UlZ8s/5sLFuG1FR2jtGU+8jwJArWUAaegj/f0e?=
 =?us-ascii?Q?44M6jMQ8Ynd2M9hWuhYKq5tCCXfzgTK98deGNWT83TV0kH12AER0FqUsKC8E?=
 =?us-ascii?Q?A/KZkv+X0JKaYcrRzC/GenXgIY8NjiKFXwODRTRur9C5Xh7vW1a+UiIennRu?=
 =?us-ascii?Q?jxe0u54R9ouLR0snj5zHkElGmkO2H+E1/cQccj7qjgFoc29fons3thfIiGMj?=
 =?us-ascii?Q?21Nrx4J5HHNfd2LYMwtgrWrRYhPLb57u27QVN3ELh6EZ/O5jn3gNNjKM7kaU?=
 =?us-ascii?Q?nDwxeXgoN3+OGU1cDgmR7ymoV8f+xXf3ShaT/zQvzTnLbLRjq4jxd510aRD4?=
 =?us-ascii?Q?wRWfATutKvXbrGfFAp7reivQiT979By7+oWA0MRMZ4RNX7/mEJViJRH0p6VS?=
 =?us-ascii?Q?bep0sVWGyjLCyzeUn6vFero5MEgXyr7YTvsYtyv3+G5EuT1dqJ7zv+/DPnRE?=
 =?us-ascii?Q?fh6CJOYXSGsszmByw1S+JsKvDt1XRr5YtFvr9kankevY1EoA10IJpssZex17?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562502ed-8a45-4f8f-81be-08dc8e7a7a57
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:06:27.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8k4Mv+LT5IIlUvVSpy8s5xdfoYNdEQ/NA+DGj1Vw8jvX0r+OtEOQWoT2BUDn2IjiJdCmxfUNIRxBV1EtEe/tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8001

Add the HDMI, VP, VOP nodes which HDMI function needs.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index 3570578d225b9..f8bedc5e05fbf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -7,6 +7,7 @@
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/usb/pd.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -827,6 +828,7 @@ usbdp_phy0_dp_altmode_mux: endpoint@1 {
 };
 
 &usb_host0_xhci {
+	dr-mode = "otg";
 	usb-role-switch;
 	status = "okay";
 
@@ -851,3 +853,37 @@ &usb_host1_ohci {
 &usb_host2_xhci {
 	status = "okay";
 };
+
+&hdmi0 {
+	status = "okay";
+};
+
+&hdptxphy_hdmi0 {
+	status = "okay";
+};
+
+&display_subsystem {
+	clocks = <&hdptxphy_hdmi0>;
+	clock-names = "hdmi0_phy_pll";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&hdmi0_in {
+	hdmi0_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi0>;
+	};
+};
+
+&vop {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi0_in_vp0>;
+	};
+};
-- 
2.34.1


