Return-Path: <linux-kernel+bounces-216797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D9E90A6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D8B2BA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59D18F2F6;
	Mon, 17 Jun 2024 07:11:37 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6218F2C9;
	Mon, 17 Jun 2024 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608297; cv=fail; b=rtJfQLq1/CSMfVppek7/MYWDaIoMCRBNQbFjcyBYNn65/r718OB+8a7jBhMPRjyc+dVXJR7rBIET2ObBfob9qEhBLa5mLQnICc+Xj44jATNV/4gyMCQjT5N8mAstHI+6wUlX9hpJz179kd7mBkfMOg8eEzKQyfY7NSlmYgOSZm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608297; c=relaxed/simple;
	bh=e9lFtz8LveADwpE7RAv/Q5Fgb/nJDBQrav5dz9JVU2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucu+IMdpRJ5okfs2JF9cT2B6h0Mk4S5fjG1b4/IJcf/S0vRMahrFqsFJSo1AMYlRY/bXZZWiPb8Ighi7ex6PlVEDavgVQ5y4iVidE+E48XfkkU3LXAm8S8VIpXzuIQYcvZwqfR/atDp+tQxe3mvy2npSapZivxEmwpFoKxsqgNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnyEDt7NhwvPkeyUdu5FJWi/sYTExtYvH4qVCm/RWEIzgOG7bOTkQmczuCEHw3YTcnIIv/3JIe9xyVmuYuTRO3NFK9eQoL68+xoCB5J8Mb3C0GUARNwUkjk25uQNV4vgCgLOWx/PsesqbNvwTk0r486CyIs/XHw6gvrtGA8aP9MGEW56Wuyri1hVtcCIYSPZQs1vDWt+sEOB6WSzoV54z46geRtaR1VKgsSIeSys8jc24+XW3sdyWVBzZMUPqgEeWfjXx4slLLC8FTmi2uVb2tMsuGMYaFATp70j4l45yrZgwGWJ2ElMKp92VxxfU2TLALRl9KKZohW6kQ4wU0IdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdohYTFo2KeXcULLPV5gG9Ay2vgv53DUdn2Hd2Y2074=;
 b=JQKydYGI+cNN/kglTZ1VmRrNqtRbHbtGlBu7coobwYeTwh/Y3u9jYpcKvXUHxF1H+s+f7mxumCET2jDAUzBXUSj7iKdHdoWcM5DT9YEXdbvwkz2CX1x1H5JUQFhv/MO8QIKC8WVfPoV7uDx5xduv20IDGtaRpt1Iw8b3SPnmkJRBtFZ5gy18DkwjGr9SdMposzg3qg+mcoH3HoMQa8iOJdNGygIdQLpOPqHvWWdKnW9+nhy5xBQ6LUza1NBpqsfrzvDM0n5geAZIaarCyBHsezgygfuBxBvN0IxT+jDckjIDk+F2+V2AVa+Z2BHRWX08W/9PEpEfIkh+lIjlI2Rm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:11:29 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 07:11:29 +0000
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
Subject: [PATCH v2 3/5] arm64: dts: rockchip: Add HDMI & VOP2 to Khadas Edge 2
Date: Mon, 17 Jun 2024 15:11:10 +0800
Message-Id: <20240617071112.3133101-4-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617071112.3133101-1-jacobe.zang@wesion.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9c1b09-bf21-46b6-0572-08dc8e9cb5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|7416011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7pb1ClXdj4IiGnt/pl5QUvhHNwIqiY16t5ZC1HPvsX8lkVcEero657lqpC6T?=
 =?us-ascii?Q?hkYG0CCbNKGqIZp9AdHIsQ18NxirSKX2zpruO0moluf2JDnAyhVlB1DmnJQe?=
 =?us-ascii?Q?YrTCTkCXu6D5MrpEEeQpjUpYEudWNCfcahKuQzS/UXXu1XaDRO4MjE2jJqxy?=
 =?us-ascii?Q?SUh6rq4eK2ZC8p56oq6dBe+pvKHZRyL+oG9zCiaA4cHLTpyFhUOC0BizrmpS?=
 =?us-ascii?Q?TvhYWRZtqy7XJa3E5TxswKTyG6q6L+w3O5LroTd7pSDnFJ7fm2GOSJ3DwWK3?=
 =?us-ascii?Q?HuHI41+6z9o1sy2+M7A7hyFYubR7OqkQkIgAFkd8IIMKP/K/ALqfunR+EMFd?=
 =?us-ascii?Q?OuTB1bGYEoLbvLEvuZP4SFyuzYw8REbriEj6ElxX6/ReWs3CmLqbSEyyygjc?=
 =?us-ascii?Q?ceJWSPGrxxcHlmSjqVc139eDOChDF34GWo2r1/oksf4Q6dtOCyaEhkm2DmTx?=
 =?us-ascii?Q?Me8F0/S6N0uXGFmjzc/PAHNe4Ctg6R++NAMBhRS5dZv16kW/uLnVM7oGZmER?=
 =?us-ascii?Q?D5Jb2MFotz3/RkW8HVm9RKJk0cuJ0tSXHld+6ns8uM9eMXikX2AIKb9jKMnS?=
 =?us-ascii?Q?5Vv88oYZLWKSQh5wrVaRvoiPb91JBHCOAaIIaRTucZMEI1oNGM6gT6vnzZTO?=
 =?us-ascii?Q?+5tKGgqiZotleFAiR47PmbwNlx5h7h3K06KQs6CAeZwO4zJBsL2N1FtHzZt1?=
 =?us-ascii?Q?IRhJ+Bhs/HBa2n88G5XbMkHWu1eH/SfmoRcGuWJLtdKlsZmdlrRw0I1H/jP2?=
 =?us-ascii?Q?UFjeKRX46/Ua2nVmFCjfBDBXp+3ffrIj4Vpc6mQNtZ+a8JR/wICZPoFdzHde?=
 =?us-ascii?Q?XUaDNtgN2QLNxiqPG7sjxYWUpMa5++g5B2+Wyn1Eev3uyQ8+ci9Xh70mX+uy?=
 =?us-ascii?Q?sLgVYTK7byEoZXgCn9MXPY2iVAdIBtY/3eUfdcu40T2QdJTUnuE13qtb+3XJ?=
 =?us-ascii?Q?hQAvoA+bbvGSBiG2j52Ws6n73Cfkd7lTs6DZHz5+Usp2yYfQKcxm0eqYd7/y?=
 =?us-ascii?Q?Ah8AzXVWoCmbggaHdsp/YJZJJapqR239JJOom3Q05SoLAhO4FV/YgJOxq2U0?=
 =?us-ascii?Q?XqPs8fsOevWpDEGuh5aECu9asEdYmRME46tYx7KsmenmkMjuxrA/peQZ3Hnz?=
 =?us-ascii?Q?iDX6j06SylIP2GorW7nQhe5lLB/O04XZ4y9+Ti9EJ1AnwShwzR7FJwwh15l6?=
 =?us-ascii?Q?wMXiD/kq7AjsSlIyl2IzAtdweygsibVd2JhVLVyIhV5+OvpvG7ClHnpcOwp6?=
 =?us-ascii?Q?8qjS6lTFKy0NE8K0s4LIVHDfUe7TMtfZDe9gqbHTLd7mY7lFurhyuT3j8ckX?=
 =?us-ascii?Q?G6uGdxWlFzg8xhTwe8gWBYAx7mZ+dRq6GsvqJ31h24XyaLIXSiAtxuQARn+6?=
 =?us-ascii?Q?SaDuNd8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(7416011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hxyWN63KmJ9KfrIx2yfa3NSgg9G2ncuAmzbxMKy2Fm9Ja+6dDsUC6P/mc1aA?=
 =?us-ascii?Q?Dkg8TjTp+mt2Od6e7HimHb62SGAxMoUPQL5p2ottn0jjhL0yiUuJVj7l3iyx?=
 =?us-ascii?Q?UxvvM1afAwOxmJ7kQej0EnZFHghh9TtldlPPT1DTBm5N5mxCTBZe7EFTBJSj?=
 =?us-ascii?Q?EGhZcbRvt+9VkMiSDEUVKGa7c9MEByS69rROUSeYAxxy0NLsyqXIZ9wg/kZi?=
 =?us-ascii?Q?uKFGlO+jopm2ezEyfNA54VKwQsVmWPEROPHY3j4XBpxuosuR8giK4rvObmFN?=
 =?us-ascii?Q?Xte1DAigMTSnNJVae5K52PkUy8BFt33T9hNVD989GFu0jefjJwWRl9dWWruT?=
 =?us-ascii?Q?Tgptka5Up5KraBjjA4llmwUrtdTkUFI4qrZ31xEIgJYIeS/TP8ehoPJfHBE1?=
 =?us-ascii?Q?ESm8WlkotFNzM4hjNJ8N0ZUG0/xyNE4zFOjacM3EM6ZOVH4nwXeFjqpyD5EV?=
 =?us-ascii?Q?Mne7rgEk3s755HQlO2ZkV6h8meeNxepke0JuBKG5eYUttfc7DiIwA6VTW3Yw?=
 =?us-ascii?Q?Yhv8JDxD5LwWq/Pw5zzpiIny1iuQjqSm8qOm4HXYTPRI16WeFK7H0G9Br3Fv?=
 =?us-ascii?Q?K8GyBaxnMs9jFPLgDk/w5WOGOiX7yNQVFm3nxP3svztJ1ioekRnmbbmkxC2H?=
 =?us-ascii?Q?PlUr7JqSBzd14SjLr0rDN8WQhuoMDQHtr8pxEEBK+ON/xHlECa3mcWBlRmMD?=
 =?us-ascii?Q?JNU15MmkGOZZtbh1FXWJarKeSRsmcriEXgMohVwlETnTwdAkfN2YRdhr165S?=
 =?us-ascii?Q?4w+RVF6+WBM67czP1qiQnElF0AOgIPxeuLE+s4unFfgG0YpL3XNnrQaZVDc5?=
 =?us-ascii?Q?uTcv0WwMNvPUDfbGVdXebKlfxp7zx9tnO4zUv7n2y7r5rWu/VsgvzdV/+no2?=
 =?us-ascii?Q?GBV31plXC3haGfSt195YY3aG35tJdU0Iu5bucKYCWq4UFkvq4JPajr2YTTJT?=
 =?us-ascii?Q?ClGPBHESHhmNGQfmeEYRLVPr9lzmETIkw5n//Hg1JKw/TUs0bEZlN3W+nCwV?=
 =?us-ascii?Q?LrqIixJro74lz4rSYVaKpsTpKeP2+Dkk7wB2e9YNZTi3h5M90TZeSxAEz0aw?=
 =?us-ascii?Q?C9qmos6bSL5oK7cpDJkLmfCKsrtVglmcxTQneUMvhSnbBuZeBnXvrwg+xHKW?=
 =?us-ascii?Q?6Ybck1YZqyKIofPLh+9dHQUcI30PYHqFhs3Nw8otbo3YeLwAMN3Oseruwr+n?=
 =?us-ascii?Q?Lcezak4I5fJ7GotXwwtDfSKE7TVg/XKjoAStfp96RD28+6ux0MD/zudMojKx?=
 =?us-ascii?Q?k8F82yNaAoBPEcqkIniJKc8eoCPiDydMAgns4ZyhftD6k9a9qIRtRCsXM31A?=
 =?us-ascii?Q?124iDmHLGmojbfNIbr1fU2cadw1J58JYHyIKLCj9iRNEpwJufyt2+t8n4VSR?=
 =?us-ascii?Q?FsQezQ7fhGfygARZoraiMjMyKi7uobdW2zXs1CNrArVvHBoRiei3vP5i0aan?=
 =?us-ascii?Q?aF6FtDquJHCYmCC/yZluh7CVi+eh4kcDO6sY3tjoo2d2UxErR1ZrK2leiNZt?=
 =?us-ascii?Q?QCwpby+RJR4ER9kawUZCNS+y7Z9SLycNE3eOHidLdV4Snv31Pou8S9dEkUDJ?=
 =?us-ascii?Q?jwwRsB5MiUjhy/A5l+9RS2wVvmlNRFjj6tMoVgO7HjXKk4IwjK6D9Wy5OHdG?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9c1b09-bf21-46b6-0572-08dc8e9cb5c3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:11:29.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa5O1lxJFfVkiDB3tWrISfZt9wN+1BRziGSg4E4GDg4xYNFRsod4YDxSOB+tYi1GmT5BhtMXc55F4hB3akErIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968

Add the HDMI, VP, VOP nodes which HDMI function needs.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index a82f10312eacd..233bab17bffd2 100644
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


