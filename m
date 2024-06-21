Return-Path: <linux-kernel+bounces-224213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD02911EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF0E1C222EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299216D4DA;
	Fri, 21 Jun 2024 08:38:05 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E3916D4C0;
	Fri, 21 Jun 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959084; cv=fail; b=qcAPHx0O2N3/TMHEzE2JAx+WG9jaRRwuvPS3K4RT+dzsyK46wrQvBkusngz9he21TUJcI3HqJYavi4psGyG7GVCHhPoDoU3cbid9oEHUypoh0MWxRxaiVcYnTSkvdw0IDK9Qd5KdGfTI4/vsl8BK+8kV+cAoR0BXbir9G5tKHKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959084; c=relaxed/simple;
	bh=jk4YqONRlLd/ZTRt6+rq1IdWfzLiHTyXVxpc6hyM18o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pPdsdx3twcvHz3evXmjzdPCtzbIyS1DxL2fBPRCyISyDnY4D9UkF7GpYJiXnZbNeHHNrcL8seb1F6U7CqjFG/TJZTpWt9s5Tp1D4YVLka80usgPPiRIuJQNE1Vhcu/2wOdB48VvGqT7zWi5oHTIuK2O6hUUr6mGBhSXUX1Nwvw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8kyhaHPlFMTQcrrmfFx4QcYJ4F5cHfky1JFnlUMDIABT8CqgkXh3/Ld2Azcao1aIOgN4aCut6H5vsw/TFSMSUxlir7CEoIDu58s56r9RHYxEIb0afQSZaVFd7rhPWhJGmH9w28ze6fW0xELScBOstB2QwiSJIeIWjVd1T/Xo6bv74BAE9y+deY+G4DsN3Vs7J69bZYtjGT439f1pDUAWqhnzG/sl4UWaqslvu5hfZPwLYspHW0fvflb8tjRMSLR+telMMts/zXmREHkiQZmDt6h8CSx/a6NOpUD7pSXLexeg47mOv37R3P8vzsjt988fReHDZ+a4bsp88CEqu1iXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLN9PMi2bg1NnGytX7U+EEKBVgE6AzZaqyWzo2NyW6o=;
 b=LecaceDDnlg3JYtWrtNJp+Tvn0YhdlHcmiC+UF60CS3zquEE2zLAfDW9kM6HySERWwUDF27dSIYFvG/a0VJ2GwzlTnPHTQw3EueIMXuCQcN/SIPKsNr2j8lby9AL9uZ4j901Y03f+BSbTt1GQt13T1Y7WN31YPixDRouNGDIFCnzB4nYe9XDQ1OoLWAylLZv5MISbH7akw7hO2yvD9Hobx2QNBRdhgZN6ZPG6Htqax3vQeP26s5or1KJKd8uQ0u7Ry7TV0XPvQjbJSunrJ+wMdzsM8md4tUah++21frDISfFGtUyAfQrZWK17PIx4/ZnLZ1mVLZeMhqMrQKYqwYKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0751.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.33; Fri, 21 Jun
 2024 08:22:43 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7656.033; Fri, 21 Jun 2024 08:22:43 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v2 1/1] riscv: dts: starfive: add PCIe dts configuration for JH7110
Date: Fri, 21 Jun 2024 16:22:31 +0800
Message-Id: <20240621082231.92896-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240621082231.92896-1-minda.chen@starfivetech.com>
References: <20240621082231.92896-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0751:EE_
X-MS-Office365-Filtering-Correlation-Id: 200d668b-4206-4f19-f830-08dc91cb52ce
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|7416011|41320700010|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	CmxWiZWb0xKPYM2cLEyeZWzpc9++RoG9NZpz+tw/qPRRjWkDRGAV1pVRiYMbOOQ1pOQPrzqopywIEpd6jJ3zNxJqjQu7qNk6GqVPX/UDZ+Q39+m3zjuDaNHI7cQEumDtoWcx+DU8YQgrcmeJF+a0jMp9mBWM3SvTuvc8M+PttVckbCz+hZLirTTIj5adXZYM3ZxSuii4O9C6XyCBoeHZwmggeRWnIMjfE7r6ef7xPySGvPQrRogSL17fQad+iPyzFuA9CB0fRbg9ma9lm82icwSnpAXbGN6AVDBpWFubv459nkMEXmPeh1aPwT7u7CVokxZNdUz6MFwyoDQ2pdqN3fDJTUjO1PDqD1Utxadj1TztKfbABxFra5mO3+hYvRls2WpoCzpDDUvfCoVJu90bjuVhyQzsGHXeVuf+acTd6/gTGEge3FEpKYTjtQZMUC1NCjss5HFTqrDiWn/550Oann/4ZLQRtz/QJ1q05ofgSQK7+KHn3ks3eHgCEmidOwzm1+POXN0EAKvz2qMhlMuwWBT7e4ag8YcxNuntLEl1rrnlX552PL1Phm79xNE7MlFtwP4ykz16jmvlYkJT3cwCAp2VzRTA4P917QQFQegKFImAtg09lNgBoOlQmGXwlIPJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(7416011)(41320700010)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hc6cS7C0h9W/CYF0ggOFHwIiVorwwwMi+BGxhwET9oy4tpTOR2ONedkdei0x?=
 =?us-ascii?Q?L+7Yrilyt5V7uWfZ1oTT5oeaN+cO39f4RYHebjY11PNL13YRJweeuRZtkIiO?=
 =?us-ascii?Q?ecOY+ZTIvWCnwdmEquizMTgHvnkk2EpZSMn2rN87BQ1I3lNvotL+DsnVHDqD?=
 =?us-ascii?Q?N5Sxu7YIg9y/Xth2vH3Rt5/0+R4QF1J0VL9ZHZmddoUZwUcvNB9kAH0Cu2uW?=
 =?us-ascii?Q?vaOSKryerwE06CRdSUDV+eIIXpCEzUFgzUWbGQu0Ln4YbL2I+hURIud+m/1r?=
 =?us-ascii?Q?ushwxPoQKcCs7UzYN7Szuq7FJxUabZQhqp0vgAsGnu35QVFZXb40+nhl0FxW?=
 =?us-ascii?Q?LjrwlVlzc00HX6qcB3TIJd69y56wG6374wkQFtl0VuUouZXcN9Ef6NkUt1LD?=
 =?us-ascii?Q?2h5S7g97/usoAa5eV5/84rDw4psRH/sXdZ8a9sf24PZMv+m9/zVGk82lxqyO?=
 =?us-ascii?Q?xBkO31Rihwq7bR7JPnZaHj7xDxXiGC5TC37XCy1G2D4sYSu+D5ZH9IxV5DZY?=
 =?us-ascii?Q?9SABDuzErX42uGvjidRg4GuPtRsEE6D59h2ZDa3WVrr3nFGsnAh3yvi3sto9?=
 =?us-ascii?Q?npwaXMdVyqd1r1KKqajYUnSk6iVJEEeTF7QUbK49jmrCSmiY9aMcd/+eHAxk?=
 =?us-ascii?Q?DWUrzdods+WpppLzc51nbPcokx6aQpSS8vQOq1TfncqMR+DoQo4plUV1XUqp?=
 =?us-ascii?Q?/rb48vkX/Bs2XWcWEGJTXyUJdKEdvwuB/oSRFetVGzp7Do/wsHBbpyHaFrDS?=
 =?us-ascii?Q?m0nvrCeyOrs1CxNhNO4/gaIN9REOm9Lp7RsuwAY8hoNwQdAtNCDOIAJxwjwf?=
 =?us-ascii?Q?2XQmv75VR/KZ9hR1XBUott8MRAwNopA0QEjI5V3UZzXzdqHJXqTOynJw2mUW?=
 =?us-ascii?Q?W18tSaRoDnWZ7c5/7fSXTI0eemx58tB+z5baBQp8Vq/QyH1+tTkxW+h4xWmw?=
 =?us-ascii?Q?ChT3piCCLDqXT5BFNWOXXKKUG335ofl9bFqLgx2YqjxtG09WQxB5/UanWsRL?=
 =?us-ascii?Q?hVhqvznY9rCWaD5jsjRKBgMNgLSPKQZJml6DTxtrG/kX3vW8v0YH4wYyBDKC?=
 =?us-ascii?Q?8kS5QCRae+gIppeP4y9NCwD2eWGSrP6rIUd+F1bPBYFo7+FAFciMk/9eCG/1?=
 =?us-ascii?Q?a4JF7q5yvmXut9lqAXc7UzG34cnbMrQqaTXNwav4KovDKGofcpTUKYqWMeX4?=
 =?us-ascii?Q?K4umoKY/fUpcYdZCAgSdjm4gqLX+qYPiML70qV/VvOORONsRBk7U4GH/xHc8?=
 =?us-ascii?Q?g714Cndgxhxy2fCGWXpWHhR1uREGJvIS5cjsajNYWDVJnPgnTUpB9hLXv0Wm?=
 =?us-ascii?Q?YIlggAHYgsQq4KpH9mkM3zfQqpYh/kWxV19+wvci5f8th7cKND6aD+eHUvZL?=
 =?us-ascii?Q?NmaR4n3/wlahxwUYtc93TKNkynKCa6Wv01UK1QGvNXOze9YTnfi7gcB1BW0f?=
 =?us-ascii?Q?PaOjd+aQ8x7ZEQcookUQS07kN/xS/tokSdVG/FP69Kaa6xvi0QjL94cki8AQ?=
 =?us-ascii?Q?7nq7JrxfPNRZPt7J2YvnxBH/itXVAFa2rAwxfQ+RzLWQvTu7ZfIHQ+jL9tmH?=
 =?us-ascii?Q?xKh6po8hmPnGyWVWr8ZiwDYQaDsgL2yKXjpg40fzgDdMUSJaFcwdexWW6i/u?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200d668b-4206-4f19-f830-08dc91cb52ce
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:22:43.4590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTUqBLOf3F2Gk54wwBEYDuMBHSIAy3PIk3Gaj2LGKdPDUjZG8gj01diVMqKtN6yyElhATrIBB2Ib52NPi+esoiG7IZLL3ldc7lOClFbc+kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0751

Add PCIe dts configuraion for JH7110 SoC platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../boot/dts/starfive/jh7110-common.dtsi      | 62 +++++++++++++
 .../boot/dts/starfive/jh7110-milkv-mars.dts   |  7 ++
 .../jh7110-starfive-visionfive-2.dtsi         |  8 ++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 8ff6ea64f048..f91abc660ae8 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -294,6 +294,20 @@
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>;
+};
+
+&pcie1 {
+	perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins>;
+};
+
 &pwmdac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwmdac_pins>;
@@ -476,6 +490,54 @@
 		};
 	};
 
+	pcie0_pins: pcie0-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(27, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(32, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pcie1_pins: pcie1-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(29, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(21, GPOUT_LOW,
+				      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	pwmdac_pins: pwmdac-0 {
 		pwmdac-pins {
 			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index fa0eac78e0ba..5cb9e99e1dac 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -17,6 +17,13 @@
 	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
 };
 
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
 
 &phy0 {
 	motorcomm,tx-clk-adj-enabled;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 9d70f21c86fc..18f38fc790a4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -32,3 +32,11 @@
 &mmc0 {
 	non-removable;
 };
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 18047195c600..5ac70759e0ab 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1214,5 +1214,91 @@
 			#reset-cells = <1>;
 			power-domains = <&pwrc JH7110_PD_VOUT>;
 		};
+
+		pcie0: pcie@940000000 {
+			compatible = "starfive,jh7110-pcie";
+			reg = <0x9 0x40000000 0x0 0x1000000>,
+			      <0x0 0x2b000000 0x0 0x100000>;
+			reg-names = "cfg", "apb";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
+				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
+			interrupts = <56>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
+					<0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
+					<0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
+					<0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
+			msi-controller;
+			device_type = "pci";
+			starfive,stg-syscon = <&stg_syscon>;
+			bus-range = <0x0 0xff>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_AXI_MST0>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
+			clock-names = "noc", "tl", "axi_mst0", "apb";
+			resets = <&stgcrg JH7110_STGRST_PCIE0_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV>,
+				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
+				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
+				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
+			reset-names = "mst0", "slv0", "slv", "brg",
+				      "core", "apb";
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie1: pcie@9c0000000 {
+			compatible = "starfive,jh7110-pcie";
+			reg = <0x9 0xc0000000 0x0 0x1000000>,
+			      <0x0 0x2c000000 0x0 0x100000>;
+			reg-names = "cfg", "apb";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x08000000>,
+				 <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
+			interrupts = <57>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc1 0x1>,
+					<0x0 0x0 0x0 0x2 &pcie_intc1 0x2>,
+					<0x0 0x0 0x0 0x3 &pcie_intc1 0x3>,
+					<0x0 0x0 0x0 0x4 &pcie_intc1 0x4>;
+			msi-controller;
+			device_type = "pci";
+			starfive,stg-syscon = <&stg_syscon>;
+			bus-range = <0x0 0xff>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_AXI_MST0>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
+			clock-names = "noc", "tl", "axi_mst0", "apb";
+			resets = <&stgcrg JH7110_STGRST_PCIE1_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV>,
+				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
+				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
+				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
+			reset-names = "mst0", "slv0", "slv", "brg",
+				      "core", "apb";
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
 	};
 };
-- 
2.17.1


