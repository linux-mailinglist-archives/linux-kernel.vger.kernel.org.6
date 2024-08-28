Return-Path: <linux-kernel+bounces-304275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A32961D13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19461284742
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FC8143871;
	Wed, 28 Aug 2024 03:41:05 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BA13D53A;
	Wed, 28 Aug 2024 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816465; cv=fail; b=Qhy+EPcZl5LdzOG+41AWcAuojBwzyXUDypOXOfeUEIKjUC6zwdCyZvM5ES8aodvl5Zh6knYVSVW60M70q1pUiU3E0A8/VQP0/8smXV8T5v4Ao5z7kI+hYRJq7AFkbXsvQG/vl+PinWAmEt5i4E5G2GTn2R9Xe52svdtgbcJGI60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816465; c=relaxed/simple;
	bh=1/dvDeshHivRc8uTF7nRkOtFijejqtmcQYBvg5hIRhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2oCCwKiteXbkCS7lV/wDz47F9Y3zHqgbjBt08ZwWeN9chxkKXfKsPoTWpaa058eHI07416ZsXHxeJQnU5n2pxovpEbVTjSCwethnOMWHdQDs/WNdYYb9f8jgfXGKSbTM3Tfk8ntr/HYUEYjhrJV/rm7pGB30jwVndfXwTfy8yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZycN9GFrPWNolEmj+Uqwd6zO415yGA/fJaHlkk4cAPJivzr+JNYfFnTOzfmE0gaPniIh14Ws6ouA8VHUUnspggFEwLyaJdrI9poi3xFQoQOaYZBrK5J8n4nm/60wx8bm3crWVylXfJjqRZ/RO5fLJhiyPwBbsD10DOr5xlxKyj4X5sgsIaWUQxFIH5a0IZvcIUwOcrx8jb1xN9OPSkJOxD7WZmWjBrJV3Uck/yVbZ8bNNXc+FZxOzqa2QFoEp+3VhWaxvJtWHclCf0zQayX49xkP98CSrRT0pP9ieCU+hGFUjWNPWFmhAT0+W1xj0WFy9gFSNjrkHNmxEwR1qqKiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0umvK+fGsMQqK0f4X8LiD7RlhXtEo+nkDeoNjhSMm/0=;
 b=mtAmiWrNJ/dyJWC/STxL+NF5DtdJDh110YktgQC1zt7B+gI5dNANtwD8ITtjYGNqBnZGfxj4U0lI44LMOiKq/6LfXek82YoLuQi96oKpqnG2CJ3F+VR1LLK+ZA8ZbjD9isHuHSvjo6AMUEVOPtEd4V2UOpT1g2ua2PtA20WpaBMeJJq3KHUPMu36Rn6HHBC0a+zCvK7UThPU5fLaXLmWiGrDGqenh6b2ECJUGIfcXTafdHpQmHd6hnagqI8SbpJNl7REMucACEZtx6QR4d8W+tn1Aqlqox6145lU2U3Lm09VVbYipeLQ7qX9ln2+lKlWQdcuSdpQlLEf3AylxlZT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by TYSPR03MB7977.apcprd03.prod.outlook.com (2603:1096:400:47f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Wed, 28 Aug
 2024 03:40:57 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%4]) with mapi id 15.20.7875.019; Wed, 28 Aug 2024
 03:40:57 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: marcan@marcan.st,
	sven@svenpeter.dev,
	alyssa@rosenzweig.io,
	robh@kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	dsimic@manjaro.org,
	conor+dt@kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nick@khadas.com,
	Jacobe Zang <jacobe.zang@wesion.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH v12 1/2] arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
Date: Wed, 28 Aug 2024 11:39:52 +0800
Message-Id: <20240828033953.967649-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828033953.967649-1-jacobe.zang@wesion.com>
References: <20240828033953.967649-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0185.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|TYSPR03MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 745c3762-8a09-4ef1-5f65-08dcc7133a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oVJwSxjbZysHIRQA+hU+VvAwU2YuF95j/9pEmsxEs75qfAbYDd/i3jDoXfAo?=
 =?us-ascii?Q?pOQcBOWfm+VFYUx+hDu+UNwstpXmklkfLGA29PEYUFiDppb0bnjl7Zz9SpU/?=
 =?us-ascii?Q?2rpOmxRTaQc9f7tYj5omRFPLi+CiaTqVIZ8SLxmY7BHRKohnYukNtRQDL9D9?=
 =?us-ascii?Q?F7tVXs1PBZclHtQx4i/H+O3GfVGkSttc4FszKsnBQQ8oSNPqN2JcvrZR9FlC?=
 =?us-ascii?Q?I5b88ZjrBCnvA16iIgUkrrX8VqsD8l0z3sM7CgyP7USxqu5fLkqwpEmmIm3v?=
 =?us-ascii?Q?6W26izK31V1QK0xGqATHkWO78klWahHh9Qu0uWB+Jq2O70OGjcQ+KYp9GpEP?=
 =?us-ascii?Q?B6nxFvX4UGPnX8hHqxc31DtWw+IU/njbDpGVMGjZ93etRAWjG9ibOkLNNxAq?=
 =?us-ascii?Q?iet7qdR7P6d5xFpPPcycy4nYL6audE4ixPGcJ7YilF89CMBlRoeJ76Q9CMFP?=
 =?us-ascii?Q?tu5dhD6l+5UCF6UhUndYEtpW0yeuiL3VWNPbxQa0fqXDbjymsemBFBdF4iFI?=
 =?us-ascii?Q?r6XEpqkYrbQV+eX+L+TB0tMhrAYbb15mdeuKaIihQMvAm4lEzWTHisB8Wvn+?=
 =?us-ascii?Q?1XiqWKRLUD3E+RcTC1g3GGElquXUXAuTX04Sh6ZQHCDw2U4voy1iz/Pq++So?=
 =?us-ascii?Q?pfUgTS/PMqx+aDgAWakNMW2IlXIHzD5kfj3TJ0yCKh3h4cIgMUwPFB2Tz9OZ?=
 =?us-ascii?Q?TInSE7mZ6yzNlya7ufQaRL2ab1iP2z07JsSIbNuZgczwvNBSIjTOLdX2dAFv?=
 =?us-ascii?Q?7WajNCaRXeoCwAgkaAWiJez2+2jmrHNW3V5wUEreNCAD3ogUsE/xJVajGrTH?=
 =?us-ascii?Q?HOGyt9FLbFjvqPtURJgHU2PBJovH86wkISqJ0zXXB/LVc0dsaE8Sh53CjHfI?=
 =?us-ascii?Q?mCs4uTh4VRLB3tS9oPGlpVb1LUO50DVrZGxRCO1UKBeexYGXqM1JTISkl78A?=
 =?us-ascii?Q?JoEYR/vYxTcx+QU3VL67WgOik8RdZVwLKqNqHWTFKdWyPvbgMOt8oOatMdrq?=
 =?us-ascii?Q?k5Ay6OO97BMIkvrYJ4CmT1GsocVkATmds9gx8NtaSO4luYz23GK3XhmDs/3a?=
 =?us-ascii?Q?wdlIzxPhcuBNivLoAuKn2KL0d4M04hRoKnO82ZKQ+qERkZYxjNpyYCsEP2tY?=
 =?us-ascii?Q?F7JzC9c3FmNESgHqyfdYk4qDKDLHKJKq+Cs0EI95g4UKOrnVTKP9v/BU2DvD?=
 =?us-ascii?Q?po1TGTg2QZqG0thQLSckXQt7NyrEyjghk8CZ598p8wZ0DnJgtd+vi8fMUA1/?=
 =?us-ascii?Q?gr8UfR/v8pq41WHeydV7ddz6X1HkZs8z8uEYiezns/h0AF0VjgydHL/WBqLt?=
 =?us-ascii?Q?ysnB/mn26Mudow58r7mqInmb/V2YhqiomKaFQx1tosARiAJzLz2DfmoLS/MZ?=
 =?us-ascii?Q?+A3P+L7AdCSK2iWKZ20BkMlfXDzvttKMCxC7v8KNBz8pa9sIVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7waTfCrTslruicIQ/YmVd89w2uFtSM6cKrAWufUSNXn/HAafoiv1VOta0RN?=
 =?us-ascii?Q?DYL1AKpkX5ciZgn7AWVnIxK1vOGj4yaRm5yFqP5MQe+y7rWSsmm7X4fzR84d?=
 =?us-ascii?Q?Ym5D37TC/9nd+d2hPR3oSJCy9Xxg3m2Nx1X1qlHDPxa7PsZXEnZiL1HNsdrJ?=
 =?us-ascii?Q?ZIjqL6k1/3qFpdiLcIvIwj7Jpwxi84aWawaGoUdYWQbTS2chj+E+q3HUTKJK?=
 =?us-ascii?Q?GtX4WYiwdhcr8uw6nLae17T0t2GPosY9TE4H52AqcAXoGX4z3UnhmZmEyA/a?=
 =?us-ascii?Q?nX8T3efg+W1bO+xtKsbD/XXlr8gpIFp4OlsBTsfW5vJMgy7zcVkdMgI/rEOn?=
 =?us-ascii?Q?1RkduejiykJ0Md4JCQrfNa9xZVCHukKfJO4oSOup5CRsuaM31ePzTie32yFG?=
 =?us-ascii?Q?PJ6QwUQ4ZWP7V/Wn2DzcBO9K+F/+lWGNRzSSSdNW91EHYXHceF985UWOEMES?=
 =?us-ascii?Q?JJYfU3INPojOeAZCEXEbS86ky9/UvN61Hk5NOQDUb4AyDx10GEtm7GpaOGZV?=
 =?us-ascii?Q?PrGm+DjlEUc968pbDmjSnzeu1VH/7myX1suGZgtpscqRj0LxDfYP6GvkZPgu?=
 =?us-ascii?Q?PxztMPSo7qdWNY5ORu9fDKs09OPJtNLKPskB3M+okZrc0boNrRS7IW42hPjt?=
 =?us-ascii?Q?mIt9U/p5WPlpT6FeNVyUttHXc4rWZywFwtOAOsaHEzPVUZbbyO080Sd2t0VI?=
 =?us-ascii?Q?JioCl6jlC5bwMH3gKKkxOAMpGKUxNMSFmWL59o6oCEQsB65w2sSY4go/1vHN?=
 =?us-ascii?Q?Q59dwnQakIUOtgh0ucK6N5TrLoCFXWZbvFYttuF6c4ONIHUc0+QthJDyQgxR?=
 =?us-ascii?Q?tzm5wPJQYWFWOnsImuFZANqCVaaDwWdXr5GxkKiMZXx7JCh6sJ6LUiSCaczE?=
 =?us-ascii?Q?MuXhvww7u/YaaCC0/54qE39hlsi+JHNnsHrMr3SB1rsneiTkiSIKqqY/iYZD?=
 =?us-ascii?Q?26d58Rc0kGKQX6a9p7Y/oAYoplcwS6DIoWSmBUlKOcIT8fIDg4jZ9x9yOWaW?=
 =?us-ascii?Q?obwCKxeSPWjd/OpDzP9OvNomp9DE4fqAE6aK+7wnK0E38Ruzdj2Mb5yBC5nv?=
 =?us-ascii?Q?iUgeHfQZSu4eA6BfynGn6NGWF2VJ/ttmAYmuVGvMh/WIoDrYUaFTcqQMMFZw?=
 =?us-ascii?Q?AIjKmuQvAogPUhcBlVM2J/S7gw6lB7yBexcf1zzH5sgltdBuBHo33n0qdE5J?=
 =?us-ascii?Q?r2exTsuUuo+Bf4cQ3nzJGO20JnHKR8Iwcz0ygv7d/XYWmbn0YvlNxwPwGfnC?=
 =?us-ascii?Q?G5rQ6smc/P/N3dexWbexMqW/R162XqpFLkeKU1ypiA5sjtT1nm/iEz1AUq3O?=
 =?us-ascii?Q?KTxWsYS43WVcgbdfCZLR1pobM9yUZtISaG0CaTUy01L/fh0f1bhBTZhmaJnt?=
 =?us-ascii?Q?DmhOhhwRQsxjXCsQCJqg3c1RiRIQY2+V4tr30UgKubak+jSOGhChHZDYq4X2?=
 =?us-ascii?Q?RBds/M0VdB61uVafaoiXFbBTvEoxPYpLN6g57/qJuLgX6PDV86tW8UPXSJCI?=
 =?us-ascii?Q?/mo6ySKcc/lUlMnAFRJ2rJL5ehzey/bjObGng5UY03SrOLcadLyGWnTMishd?=
 =?us-ascii?Q?nINlLv5lFMdzqxyaTJNTbNkECbmk+rbqfwutKRn+?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745c3762-8a09-4ef1-5f65-08dcc7133a27
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 03:40:57.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xB29lSIuzOx0XHECqEOm1KbuDld7rvsTbXJYmvQk/F+LMQRiUxoSWE4p1wAG8Ch2KgDu7TX8gf0uzo12bmKD9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7977

Khadas Edge2 uses the PCI-e Ampak AP6275P 2T2R Wi-Fi 6 module. The
pcie@0 node can be used as Bridge1, so the wifi@0 node is used as a
device under the Bridge1.

Co-developed-by: Muhammed Efe Cetin <efectn@protonmail.com>
Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../boot/dts/rockchip/rk3588s-khadas-edge2.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..3d0f55c123d92 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -283,6 +283,22 @@ &pcie2x1l2 {
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
+			compatible = "pci14e4,449d", "brcm,bcm4329-fmac";
+			reg = <0x410000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 &pwm11 {
-- 
2.34.1


