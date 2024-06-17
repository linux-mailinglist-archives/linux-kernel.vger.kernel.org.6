Return-Path: <linux-kernel+bounces-216665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAA890A2C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9E41F21BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCC184122;
	Mon, 17 Jun 2024 03:06:36 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2090.outbound.protection.outlook.com [40.107.215.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5243181CE4;
	Mon, 17 Jun 2024 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593596; cv=fail; b=fzPXAn+B0Y6iFHTHNHmlBpJoA5VU1wx/WJRoZcyIj0cg0uzlGqfdmJD18yj1wkKT4kzNGi14PjeoqiCR4xcug/mq+QN19WhYGz58cEZlr5QBR4/m62zqhTdof2TEuW0x9DA9sXCYAshjwinURLWW1PkAo3wmxn4HiSPqGFj+zjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593596; c=relaxed/simple;
	bh=2oBWIi0RvXrw5q60hpEsdAHoXR8NLVuTJyw9uEzxPh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=feoqDPMCIC8c5D4cCqtT4MELuuyL6xaku8iAh7gJlSICcgItzi1hvE4SB+MiOi4gA7qn3mB2C0fIwTvAmPx0efHRucbxdNAUeV9iwxb77spLTTgvkfU/1aozW9hZsC71xVI2cu1FcNP+udLuiXbFNIFbb+onm30/by5iV2KuogM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWoiiIalKEimLDA5VjUuoyeG5QV+1aYt3OQoF6K10Vd9y1jZWG8aSDAURIlVzoADENtBuCiEq9bvyKUg/1TWQOn6v8bO5kmtLTYGkgDKepowKhTnp+F4un9hN/3NB4pRFyrvYauf/P2g84hrrc7yybYeE1bgR/FWqoj5EVI4+21XqLuyWQlvbiekFcPIqnl4WAuf/xFpbAujro07lO2jXAGwLhVz6dIE2iiukrofhacpt2K40MIzPnT7yWmMC7xyscn+s2kbw7Z9yTM3g1URNmpXk2ZPtlFitvYWaL3aAn1TiCcWH1e4nEauxJTYQcbfIWxygnmLqi6zVwLK2MrIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPkpeSh/EdH3GIoVfq3PVuAd+950f8uiuR/32KMh2J0=;
 b=bdlhV2VlgcNyNPjM7rvsX8NexnXDubNUUooHLkrqqeI931r4mygcRHI62OVEN6W3JfKF4ZN2e2izLd+nE1CST4L+SsvoaMznCoPZUxPS8EB/Cvql8yLSt2pUOlQSNBG6lTG9uqMKxwM448hx2GLZ5jj34uw3xNLnixVskkoGZFV4pUBmx6JyP/tSNZek5hkE8hkDKTbuxInwvViZBcmePx7YGjZbqyKiwAdsqnQ8nC97PZ7HM/rSlrcr0AXF7YYrNbwNqs2S3IqCbowdvGK3nCve/kyoYCGKQa1rb1lc0bp1Dv3WGSxfXLi95UMsahHBbLDWTYBhakuzBRUqAH+9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by KL1PR03MB8001.apcprd03.prod.outlook.com (2603:1096:820:fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:06:33 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 03:06:33 +0000
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
Subject: [PATCH v1 5/5] arm64: dts: rockchip: Add cpufreq support to Khadas Edge2
Date: Mon, 17 Jun 2024 11:05:37 +0800
Message-Id: <20240617030537.3112356-6-jacobe.zang@wesion.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2080625-729b-41da-6c7c-08dc8e7a7ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|7416011|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UTBTw3DLA9FpSjSmIWIV3aC/mp+WBqv3xriuiWe5+G2RAEMRH//HdjFiaW4c?=
 =?us-ascii?Q?uJjoZ1Tj4bnmqe/IPQvMdG2dFyE8tOyqw134ByG3HyNnekkbm3H9rxtyqeqd?=
 =?us-ascii?Q?RbZmc9AgBJh9O0qRLPtXrnbf/tiAUs9YII5oHUa93fQdcQUhGbt1ehUROdZe?=
 =?us-ascii?Q?tIOGEqL42NWDRoQ0SixlzVW+8u74dZJ/PecPXIS8SIg10A1XpIj5TS/Q0LCm?=
 =?us-ascii?Q?QnbBvWgtXyE9tO1WV6MalwmwCciVqQoUgV0ljdmbrqUWSTCuNg7td5ejygt8?=
 =?us-ascii?Q?Oh5ERLwKcHUmp2LdtlsdtQAZoTIE6eQaoRah80zljKyj8FyZhcwWqUUzqlxQ?=
 =?us-ascii?Q?Wub/LoPimPYk+Cjl6SDRrFIlyES9QF9PvRlJEukN/UUZbbgiZbsq2I2HI0zJ?=
 =?us-ascii?Q?wQhYy92sUIjnlvevCVR10yxuqQRWlPFkZynWfw2zOowlL55YdQXSbJiFQLO9?=
 =?us-ascii?Q?qJFExt/VgMveCb2ooJwPgcxxnRZvUPhTNCE/Vh9lTmBf+gJ3yAmQrcgVv7qW?=
 =?us-ascii?Q?PXNRVoXwgIWItIqhwv4z8j8XiYMGdT9uWEIi4Af+//tIbtkxq/jXs6/m0xZ4?=
 =?us-ascii?Q?XuMJ6dEAkqMHmdKEmj/W1FbMo/K+lZYl4tJj4ctR0/qAL/iwqcuAxMWO/HD3?=
 =?us-ascii?Q?ZkfCFcQeYjV2GlOAsTGu7sgawoWQQ7RKOW0yJcahBA3wiZ/ONOKd1j+Y5wgL?=
 =?us-ascii?Q?v7cFvjl+TCOOftgvfdqrdObrsQUyvowJy3d4Ttii4EV5CoDHdi3QbKpx590z?=
 =?us-ascii?Q?jP98h9GkZTNWHwRE1V1S1Wizg+w/feRWNPyQ7COCaZND1Z9t0hlNt4s/AlGh?=
 =?us-ascii?Q?VeGlzJ6ZmluUjT0PB3HpkY38QbNK8MIY066I22eZ+c4z9PC4HLH2czDgRuta?=
 =?us-ascii?Q?3nKhojHGSv5aydgTAK+nX2yY/5wkfR3zd7rDjLXWtOlFcKH8/5GL2dXiEamF?=
 =?us-ascii?Q?/Vhc/41KpoM/LqRzB1hEFG09EvoDGmrnuoLdkiO243Jf+S4yGJgpCngdSatl?=
 =?us-ascii?Q?4RAt9AM/rLGKoHLWRrqtKJwqaAITAHNnKRsIRhszEmIH4AcV8YDJY6H9nzfm?=
 =?us-ascii?Q?jPMJq14HgrG9+zRMKhCBq8dKNdUoPLN/thBPItDXIt3XOemlbSv6glezBZGu?=
 =?us-ascii?Q?vVA1uPHwkf3tnQxvJXPqtiOKym1hdRwRntds58ntrBHfNZT1vkih4R3s3bgV?=
 =?us-ascii?Q?0c1FzVR1w9ZUXxgxPOGk0OF1K1w+/CvmLki1PhPIl1+0HWSbQXoyWoY6G3z2?=
 =?us-ascii?Q?5c6/Vz3c+JNKEar6UTpCAsRK1k5v+A4gbOoiaGK6apR+leHATUxydcRePEe2?=
 =?us-ascii?Q?wVtxaeEQ2CVKCNkEDb5kUDHvKtZNla3wDenuppq6XQbiGVLUYaAP9nh2iMNC?=
 =?us-ascii?Q?BF8swOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XUpksFkEZI0lnaivtwRlCOsRXYCS5cquNDzGa3GP3lfF/1beCID2qLXq2iWm?=
 =?us-ascii?Q?u7T78w+Q30ZSmH7sOZYdPjFjOsPzVEo5tvd+2VdqUbAEcAAuO2AhmOi5QBXN?=
 =?us-ascii?Q?kFKC9ZMYNJ0MiLESEIcvElIKYxy/Yr0fzppd80941UKUpre9Cygl+2nx0LZa?=
 =?us-ascii?Q?+jk+H16vJnbqzNg5PDAUGWKDICqMrH4ogQDsDY+tOlwtI3c39Q/vnZLF0epE?=
 =?us-ascii?Q?MRq7mspBuvoVoRqf+0inUitYO+gdssAM/T8z6r23jVhm3dmhBo5+3/EnhS7u?=
 =?us-ascii?Q?tmaetD3d7ydFi8bGhuE/4/+cLuk366LgzkDFpNSYpMkoEnW/6zTwmLTsXbod?=
 =?us-ascii?Q?5QE5RRqFTEU1bJFm+fLtaNapXsokNqUqr/1RL+JoXIyFp56cNfsA1CaUj9/E?=
 =?us-ascii?Q?xLqQGUqVHN08ikwQEpMROISMwo7VGqKS7nSuSlAj9hf1BGFi/GHeazkcQ5Gu?=
 =?us-ascii?Q?8zclMmKEERMcG3mtuFTU+P5GCdBhKipqfnw0Ugw6nDFQbg/tPE90TYSc+8U0?=
 =?us-ascii?Q?NLW5ZACWLBEyBth+s4Ygl7I9TxFUvAEobeAOqi7wXKYbW5IGAMi47RD9uyWr?=
 =?us-ascii?Q?XAkGY+oFf8c+9riAEondV4LmfffH4BK191DmPQ7VgQVtprQlf8Ug8WTaQQZM?=
 =?us-ascii?Q?88/D9kgKNNOLsEdvKi8dBamxCi9RGrHKjtQX7Z2ETiiaBAahl9NEjHhY00L+?=
 =?us-ascii?Q?7C4+XbTCVz1/nX5dAuKrFruEQVO3bJF/zQ1WTG0HM4YE6HeuKUhcwSfnKozv?=
 =?us-ascii?Q?jMPS2IvMvzLCFkq/Uvl4iOPVL2Oscr/6Rod3gMlyrWdpEPLOge75JTKEREj6?=
 =?us-ascii?Q?5+zuLEzj3UCmW5OpOKukzc06mXF03U3FCAS/9ovbL5MgBNUWTxfXWAuUMnc7?=
 =?us-ascii?Q?exBRgpRwYwkRifoc7hd0B8VObrEOCekPoPhk9/wbqE9MrjP34S1THonPKOy0?=
 =?us-ascii?Q?MdeY7JmypXjQoL79mjyILx8uDJGV9Au/dYgy70rmOd7a6j/Y9iVcs29UsDSG?=
 =?us-ascii?Q?OzTZHIMG6OFiP7U+1HwetFzkIl54PDqsdSzg1W7aNwrXPsPK6OGJ5LozjpKX?=
 =?us-ascii?Q?VPKCkHT+XZo33nIEvl4SuOGhjjQrejlTaeLs1W2CibA6dNJClFaAPx1NZ42n?=
 =?us-ascii?Q?/XuYMWAUBSHTx2you46p2zkS3hvD2qZ5cRPiiyAMdP3AJ420tXe5l0mD3pTX?=
 =?us-ascii?Q?FTh9rHR/5iPZfq0SH+ubpPRkC4ym0XsJ5S8QZAlxrLy8rqF0N+nMljS1Q2tj?=
 =?us-ascii?Q?VJqIxuwsYcTzov3K0fmPymK2o8AZNgJi/BjUKngJI2ZGsAnLLr4w9agyaI+Y?=
 =?us-ascii?Q?mfnWjGiWSgujff1iRNcfG032SNgC18Gnf8EFlMDOs5jeqLka+qNMDYufPuKS?=
 =?us-ascii?Q?spdIEbcP4AkxSe80w7sgfG7qTYr6f/4008jYtwT2S22wigZNh6SFElCvkN20?=
 =?us-ascii?Q?UQYnidJ+1YY6QEBiclXISZke4Mu/pDD4ZRK/4+zCZbaXLhuM+FJOv4btd9MH?=
 =?us-ascii?Q?VWF+xSV0GjxeSUUo3vTmBqHRBPT/pAJ/nlA6F6Qoqs0pxrJ870oXSTl9WzrC?=
 =?us-ascii?Q?PtwvTCD94gDU1vflhNniAF4Lpq0n4xvTYRvgkoA/Wjx3PlGTPaKzEHY5GiYg?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2080625-729b-41da-6c7c-08dc8e7a7ddd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:06:33.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2GSoVlfs7oTdmRFwhBda4qD+iibGiFuM33hE7gVwHbsfBZMMk9mNQaQbhhl0wygC3lCkW10/sB5VcUAlfW+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8001

This adjust CPU nodes on Khadas Edge2.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index cdd5f124e3069..04796265f4b7e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -160,34 +160,42 @@ vdd_3v3_sd: vdd-3v3-sd-regulator {
 
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
+	mem-supply = <&vdd_cpu_big0_mem_s0>;
 };
 
 &cpu_b1 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
+	mem-supply = <&vdd_cpu_big0_mem_s0>;
 };
 
 &cpu_b2 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
+	mem-supply = <&vdd_cpu_big1_mem_s0>;
 };
 
 &cpu_b3 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
+	mem-supply = <&vdd_cpu_big1_mem_s0>;
 };
 
 &cpu_l0 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &cpu_l1 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &cpu_l2 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
 };
 
 &combphy0_ps {
@@ -208,7 +216,7 @@ &i2c0 {
 	pinctrl-0 = <&i2c0m2_xfer>;
 	status = "okay";
 
-	vdd_cpu_big0_s0: regulator@42 {
+	vdd_cpu_big0_s0: vdd_cpu_big0_mem_s0: regulator@42 {
 		compatible = "rockchip,rk8602";
 		reg = <0x42>;
 		fcs,suspend-voltage-selector = <1>;
@@ -225,7 +233,7 @@ regulator-state-mem {
 		};
 	};
 
-	vdd_cpu_big1_s0: regulator@43 {
+	vdd_cpu_big1_s0: vdd_cpu_big1_mem_s0: regulator@43 {
 		compatible = "rockchip,rk8603", "rockchip,rk8602";
 		reg = <0x43>;
 		fcs,suspend-voltage-selector = <1>;
-- 
2.34.1


