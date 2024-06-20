Return-Path: <linux-kernel+bounces-221957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7062F90FB15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29737B21750
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E6F182AE;
	Thu, 20 Jun 2024 01:57:35 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3714290;
	Thu, 20 Jun 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848654; cv=fail; b=h7ilFujr4vb9a7fjJ7jMgw5yN70DHNCvXEwzXtbJ22BXb28TlcNyn43/HXWfYFpw0QrKYnQqi1F1abb3ghvZjBBieplwzEbc/cdaq3A4zwUot+q/x2xi5wlqeiH3mAFMSNYKqU2wkL3uNJYDQwF5vDSEG7zfYgPD1eecZRXWedk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848654; c=relaxed/simple;
	bh=NS178prCXOtwmxt6y2TT5silxv+ZFee5cXyG9KY7BhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvWYNImM6ys7sdSxP45pkDUR666P447nbMPcnisInjOhG6XljI5KoK3Wgy5dRNAnpSp4VataahHXDkBF4oby0SMMFaPiNeeJJ0PaIt2kMyDm3U4nACKCmSryMaUxAbEQVfO/6+Q/yHJ6XwtgPKvf5bAmE6jclpy/XZcg7GeEYoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtyUvSH+KGXuGHxhUxbrgXTRVa+irRwQXuDxjccQvefeXEstIb2f/Jd87P6tEouqSOExuXUttJQumK1/IwPyjPYRuAhxncxxqDR7MlqZxoO3dUa23j/D+9F48K/d7u+Z0agQmLj9qCwtarkv2Ya94vqvuI4Dea51wE5LAc1DhFAY/NkV8TaAA1zAqjYKs+UJSfUusuVVSah7wZCJdbUB3ZzkhokUDzCHzchSKDova+vpCJlk8WMYrsCbDuarMUzaUojrSJG//yklvfE7TQcjirwfUD+CCYHtAqy0e7mcvHXGm/2GAykYPZea9DwQrbj5DK6Rrr/ilW8s7Fd4HAb49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ0PjwTt+XVTAG30Lrlbaz2psNI9OBOx0/bFuNlSJpY=;
 b=hgdrRxxWHFkB1BnDF2bzt7DiGS45m1KC8bzXHkq3xXOxhaW+RxJDDJ0F2Cwv/fQYjZd7h2xrtY3GwKFrxBzu2wVtvW8VJefrJWj42MD5s1o8hJDNcwzrYwgV3/DsZrZeTPhRvw4KEnEhpKDljDW25p6uL0FxQJGlqtloNDWQoFdBHTYJSR/oe7u6f/qfGAvNe2qUWHj3f1tlmgx1Lh9xyB2udv0SLXzpM0wzQfJIQoLvvfX05cO/ZXmM9NXuenQ+44eoH9Cdlw6rARtQ+JlroNHnXtmHcpq2bj7pKSjjXH/gM/7XGkSHOmyDhfKbOKpOBOui98zEHoVB4fNH40Wq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB8078.apcprd03.prod.outlook.com (2603:1096:101:16b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 01:57:28 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Thu, 20 Jun 2024
 01:57:28 +0000
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
Subject: [PATCH v3 1/2] arm64: dts: rockchip: Add USB-C to Khadas Edge 2
Date: Thu, 20 Jun 2024 09:45:35 +0800
Message-Id: <20240620014536.4019524-2-jacobe.zang@wesion.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620014536.4019524-1-jacobe.zang@wesion.com>
References: <20240620014536.4019524-1-jacobe.zang@wesion.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To TYZPR03MB7001.apcprd03.prod.outlook.com
 (2603:1096:400:26a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB7001:EE_|SEYPR03MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 665cc770-1ec7-40df-7cff-08dc90cc56ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|52116011|376011|7416011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OcgOSc/f05R5CYEtwCF9nqmRTL/LT+SmZBUCUnuXzrDTQFDY0f9ZvhgNtkkd?=
 =?us-ascii?Q?ckI4kad4LzI+bY066MXAiC/RqOezisgThGNbTdzzbDYZYkmhultwF0hA1eit?=
 =?us-ascii?Q?BWLSQw0e4dWJJZa3OhaBn3s/02Ag3w9+CQGSRygrRbbiAF6WYPukEpYpCHE3?=
 =?us-ascii?Q?7RZMEZyNMZ1YGMMFLQdq2N+UWRcI4hphvXG9lkuikEEUtk6Q9PTrUvT39OdU?=
 =?us-ascii?Q?bsWfZ/lJlk6zPLJPnY0L/8hfJ6fctaNuuaPdE/rSWTIikk9aGirem+0aIrPo?=
 =?us-ascii?Q?Kbycu7Wb++ntzJ29qrywse3KoNr+0OkAidGRr1H16J1htv80JEFiKIskalxX?=
 =?us-ascii?Q?B22elGMCut6FQohcGzv1yoDw29+7oqfHq56J85/sGiPYqgra3esrjeR+uTgq?=
 =?us-ascii?Q?QcdO/eUPY3v8ZPt/kwslstLffwnjLCvJ1UxFzuwnfdTQs0/JIj531gdBzteI?=
 =?us-ascii?Q?DTKOg0BlOpeac227VjpgzK8gxbeZ9ZnkS+quUS4rnn11prY/q/jYPZcAbM/2?=
 =?us-ascii?Q?1bNln/4Lv4KghvZ1x7nn6ARLGv9PkAjgxslLzLAGZMJ9Lh/4YmPJJhHyy3wS?=
 =?us-ascii?Q?pwZRB2aJw5uSVCcgyKgylnOvvz/bUxhMbOsTGcR6lez9nWW9cGMHsZCWuyA5?=
 =?us-ascii?Q?6WdnhedOoq8Dk0RcEP7uJ7EHyyA8t9pTBZK/qK7rjDyg9v/CL59mF0lOFbOS?=
 =?us-ascii?Q?jw/6NUDHLn5OKROXjIpyBDqUpqduIHPp1h+Z1yY3U2fr/biVOw20hSOJ11By?=
 =?us-ascii?Q?1VnmVg7YNL2LLjusanokH+2gMqcuhSn9DYwNbtP1mtnp44yUtym01nsLSz9y?=
 =?us-ascii?Q?z6TnSidDoryicGhCIusrV02ZUl15CuSgmjBkO97Z/LKi3SF7ZRJCvt5yFXdP?=
 =?us-ascii?Q?/qxuUPULYIYpzM9szBSmx/XWlz62jw0kEItJX7a6/NK+VDuhUR/nGfUVWUHP?=
 =?us-ascii?Q?OpZXMOky3nQkr3ayBhtGyA/FFDPZRJmoEeSss2fRRaQmSAoT0sZq6TTOkr8f?=
 =?us-ascii?Q?lnWLWsXFVLiAVZFLyxoqUotr8GliCyrNtbvw7idJTBa7RHL7UzQSvq27ph2t?=
 =?us-ascii?Q?JmIWns0YcpyClfbuE5aJ/eF3xTFBpVQnZvYfLIcoZ5MlpZ8QV4BW6d72feXK?=
 =?us-ascii?Q?KO96JrMDhrctoA8uvNfdhoBsQHKwPKyJ6lIa7MqoDvBGGSlgqJTCcimKBysT?=
 =?us-ascii?Q?ytnzbdABAo4zsAkPQg2frNH+6C07A9JUn8/H6fKMnvJP8N9ycpH+NsnsBvis?=
 =?us-ascii?Q?mt4emxWawPSZDVH6/URcMWNPX0TRdUrs3VxhToBqYAwJ8n/kAGikpIMUBGkf?=
 =?us-ascii?Q?Ogmrm2rB0anFavdLwHy4kEq2l6a/sLZ1EkA49Wka5UIKMGA2NyVX9f6Jt1NZ?=
 =?us-ascii?Q?FKQpf+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(52116011)(376011)(7416011)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LX5TRXiQ/R5VwDSAxyn/OtDfHGg71eL4dbMcGRSTrF7cZjUrm5+m87P4PY0/?=
 =?us-ascii?Q?qUSxLGBCtYMdAfjw4ZGLGBf3EZ8aSCtc8g6SkPTML3k9E8JPZhMbPBmgZskD?=
 =?us-ascii?Q?0AbKw8lIUPBd+xQwEK+RzaOKEkxtkrS3+8xlIlV1wxSvQKTD06XPuLhKMa1U?=
 =?us-ascii?Q?4GiV6fSG56BOJoPJZAryhFAWK5y9QSzDxSuYg3+lL6++vRoW7yrk52Xblkqx?=
 =?us-ascii?Q?IinvjVarghupbahGxGyO9M2+VQlwpYah8WFS0ZU3zTxtlFU/LakDgrmzucta?=
 =?us-ascii?Q?dxsEHL9Za4rkQgKH6d1bWQQRYKA9VQTkWCMhtHnUBByBHueaw4zrQqwwIegZ?=
 =?us-ascii?Q?L5kYVqU3X865+eLX3/UzLUG+b3AqBMP5K3MTBNk7n/WG+wR8pOOguEwIZyZF?=
 =?us-ascii?Q?F0yDy10HgRC4Ci2h7zSrGUcYE3d6vlMTx5/q/s2WGKZ6oDHmQw/UadBJtp8D?=
 =?us-ascii?Q?tDz6UCFc4WJLQU2lyxAOtCI0nZIcwUAcHQCPJF6Qi5Eyw1i2LmA6DVWf9Dsg?=
 =?us-ascii?Q?D6IZqnFwvlK7utHF2cTQ6BlfNNe+SoH1njum/BQgmHd2eAmpDf8xVK5rDiDk?=
 =?us-ascii?Q?ml0yHghSKJ4cAGKz4ZBbi3LV8uPfnMz8dGnTd3TWfsHDLlzFhDvpkYde0axk?=
 =?us-ascii?Q?6ivBmTouPrxGMmjexx/zMsjml0DE6xi98Bd0UAekeYaJD/HTxeFEJAKfATW7?=
 =?us-ascii?Q?9B3Hm4JAM4C+xsiTuTYu0dnuFsvr3zwvLKK4ZkMYYfrgdiwhkdQdSiqat0at?=
 =?us-ascii?Q?JDKo4vi+UJdKV1UbfZAsuzEG7AYK6AEC2AMWcxYx4MBNxwNKyjxjFyk56tnW?=
 =?us-ascii?Q?vE/mRcZuRkChoSH7F5dkO6wMaezRKYT9dL9L0IhaGHRJ/fq/eKe5QfaKvFOX?=
 =?us-ascii?Q?WL4LmhnXQXDtXAdWBEl/Au3LT0BcYazEyKn4qGkptK004rX3Tqt1pGHZ6jSk?=
 =?us-ascii?Q?dHZ162iRyynX4Pxo+PkapM59vKVDhtD5x80uSRKqnHqoAwVcrKT+lXWuYu35?=
 =?us-ascii?Q?OevLINIOwc3uwHuLtIc1jFHboz9QSCLZaRM6Ody+ONC3h7pTFXd2+aYK2LDF?=
 =?us-ascii?Q?SNKsh2x4zb8oSGwOJannS8f6XXYJnD+O+Gtrdzuvfue1z5D60jcLxxgKgYQj?=
 =?us-ascii?Q?kfGWdq7A57MSMozypHIvLiExXu2XV8gmxnzrGfVl75Gqya8CYx1r+x5x3Bco?=
 =?us-ascii?Q?TmF98uA02WWxrPVKXjG9B15liSd7a7g/I60EYJppCU/l6z63SA2vKdFnfwDz?=
 =?us-ascii?Q?IebMUNrLRtQ7dB3yU7csEyMlRB7canKXy55uCjQNeBuIXLXA4Q2QSiS1d42P?=
 =?us-ascii?Q?N1KXty0pX1h5rxm7WpFeCBiTI7VmWbjPqsQWS2bheH4/F6aAEt4ArjV9yAcu?=
 =?us-ascii?Q?ikWPQXWLpb65RSpD3TAZvtjLiyz/ZL3Lp2oZ9+z6GZWBnWs7RPMZC9QUoCvd?=
 =?us-ascii?Q?Lv5KPlhA1j6nE4YJIbqaCuClGbrbnZWViPcX8ompt11frvzUzjfnS86c+oyn?=
 =?us-ascii?Q?mg4T83KMKVeHsGBk6LPW1rXR5nNqvF88Wx0O53+8NJDtr8ny6kyRy1Xv4ux/?=
 =?us-ascii?Q?9jKtpV8LxkIMsJBSuiOCJpIDgEOCne9WfmA/g3ga?=
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665cc770-1ec7-40df-7cff-08dc90cc56ba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 01:57:28.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJoCHa2kpA+rwMNhW0t7bBy8MZYJSDk2a+4zxYcaFdQFpOzVSYX66Ptt44tJgCj7CcqSlZ05qF1APuZp83ZknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8078

Khadas Edge 2 has 2x Type-C port. One just supports PD and
controlled by MCU. The other one supports PD, DP Alt mode and DRD. This
commit adds support for DRD.

Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
---
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
index dbddfc3bb4641..8c0bc675690dd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
 #include "rk3588s.dtsi"
 
 / {
@@ -112,6 +113,18 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 		regulator-max-microvolt = <5000000>;
 	};
 
+	vbus5v0_typec: vbus5v0-typec-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus5v0_typec";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&vcc5v0_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&typec5v_pwren>;
+	};
+
 	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_1v1_nldo_s3";
@@ -224,6 +237,56 @@ regulator-state-mem {
 &i2c2 {
 	status = "okay";
 
+	usbc0: usb-typec@22 {
+		compatible = "fcs,fusb302";
+		reg = <0x22>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <RK_PB5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usbc0_int>;
+		vbus-supply = <&vbus5v0_typec>;
+		status = "okay";
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "source";
+			op-sink-microwatt = <1000000>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+			PDO_FIXED(9000, 3000, PDO_FIXED_USB_COMM)
+			PDO_FIXED(12000, 3000, PDO_FIXED_USB_COMM)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+						reg = <0>;
+						usbc0_orien_sw: endpoint {
+						remote-endpoint = <&usbdp_phy0_orientation_switch>;
+					};
+				};
+
+				port@1 {
+						reg = <1>;
+						usbc0_role_sw: endpoint {
+						remote-endpoint = <&dwc3_0_role_switch>;
+					};
+				};
+
+				port@2 {
+						reg = <2>;
+						dp_altmode_mux: endpoint {
+						remote-endpoint = <&usbdp_phy0_dp_altmode_mux>;
+					};
+				};
+			};
+		};
+	};
+
 	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
@@ -256,6 +319,16 @@ vcc5v0_host_en: vcc5v0-host-en {
 		};
 	};
 
+	usb-typec {
+		usbc0_int: usbc0-int {
+			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		typec5v_pwren: typec5v-pwren {
+			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	ir-receiver {
 		ir_receiver_pin: ir-receiver-pin {
 			rockchip,pins = <1  RK_PA7  RK_FUNC_GPIO  &pcfg_pull_none>;
@@ -681,6 +754,14 @@ &uart9 {
 	status = "okay";
 };
 
+&u2phy0 {
+	status = "okay";
+};
+
+&u2phy0_otg {
+	status = "okay";
+};
+
 &u2phy2 {
 	status = "okay";
 };
@@ -707,6 +788,43 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usbdp_phy0 {
+	orientation-switch;
+	mode-switch;
+	sbu1-dc-gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_HIGH>;
+	sbu2-dc-gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbdp_phy0_orientation_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_orien_sw>;
+		};
+
+		usbdp_phy0_dp_altmode_mux: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&dp_altmode_mux>;
+		};
+	};
+};
+
+&usb_host0_xhci {
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dwc3_0_role_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
-- 
2.34.1


