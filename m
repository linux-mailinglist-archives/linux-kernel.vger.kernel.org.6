Return-Path: <linux-kernel+bounces-261837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45D93BCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54625282865
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69A16EC13;
	Thu, 25 Jul 2024 06:54:09 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2135.outbound.protection.outlook.com [40.107.222.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714016EB44;
	Thu, 25 Jul 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890449; cv=fail; b=UPzyLXCc6YvaLNzBGhZ91/YXbEFxh3pWIKJIKLN20qHrnoM8w4xW7cQ1HGPtEf2h3T9D4qsNAus+XvhuXRIbLdRKPhvwFMSmHCtHd6Bf7T7/NJqHqw/CsQw/rROPgWOvSpGXq6SjD04or15pULJnipMOC5AVgL9LcCaciut+AH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890449; c=relaxed/simple;
	bh=2bXa5dLbUqnB7PYr+/2KTgT0huM2vi8FVKmGj9pV2/0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eMCfnMK6CuLoDl32oq0Yl9m0EV0AcIXdvUu6d+wu4ehUeBVY9jDMufXHHO1owmMfIr/xVFmkVvbgqXqVZvpvXLgjwEzIDL5yNvKdQ8PXducioCDDVhYrw4rVJChDHpNqDOCUk6q/yVb+B0S4KDisY2/vjV2Dj9bpeRayrANOiiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyStVw/JsF5BtQMRXb3OIrRZ7yTBlcz1IEjphK0U3SxRp9IlpU2xCmsb+CPrS2cD2CILV8PIDIHTv4WmqqiBF3B26n7tpJoHWy8TXDivH5W9bwzJwTWTx5ak4BIKu7zOYKf/FmyOD6oIdTXESpQIE18ydHJE/4cs45Nt/lgNo+FTcUz19W6zn1ax/dFDapRwQIhgOw8h50hPeaxWInfBvreNdp2PLvelOO4ZXqJ4x9biC34m2Y/lChh9O3uKMwXgIeyjb3pN6uIiZxrONiMIrSHGbnmOjRRpBlTNo+eggVVdZAAddov4znjzbedWIilpk62lj9weiPUYwKxwQFk9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sACp/BLPjVBpLnplI3xPN5ej+7DYUFsFQg6kEpMLwfQ=;
 b=RGlQho2oR9t80IKSXqdz8eiZeBtKjlJByJf3/jkRsTF5Ys6JZJtOGRrykntcPNmUTti23/i2+bLDqXYIHV1Q0OyN30zfqN0r8CE+2dWjLZix5DaXUPFbN8iqaIe53hN4ZWefVnefWF5vt9bbcICddstBl9hJYDq/+agi9CfkjTGP+f9HIhQ5lMbWnmZKUth9WS4HqRgqyBoP/AN+0ZGOq6uWyXDJgPELKH6WUv4t/KXzWUmpzIfoGDwUGDP4UsGYflkGt0dsprUxK0JBhqd56kpNHF0wEa4ySJE1YFPcegJRb8/Y779F5aN7+AIQcnIN6PoQxu/wxptteebNLpRS4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN3P287MB1446.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 06:54:03 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 06:54:03 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: krzk+dt@kernel.org,
	shawnguo@kernel.org,
	festevam@gmail.com
Cc: tarang.raval@siliconsignals.io,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Ethernet Support
Date: Thu, 25 Jul 2024 12:23:41 +0530
Message-Id: <20240725065342.9308-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::20) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN3P287MB1446:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2afe68-de51-4853-9999-08dcac7691de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ea5NRjCxkVrKeBH+Ine4FvWcDW6AiOJCQDmJgWqS5F/5+pPdN+fXrxdiiRG8?=
 =?us-ascii?Q?/mcsOEehXQTz24rGwC4obgpoNFBxaqDE+XBWCPNMR10dG3i8cXuw5wyf9Agi?=
 =?us-ascii?Q?3EwUoG1lyhMk86ViPhpPoV70BVGhPaXBamRzUT2nldSiU9pJwxZZumO2Yx6n?=
 =?us-ascii?Q?va4EgWrHAcDelMtgnCcRTx6fXdmKtrICN0AKurjXKVHzn0YBaR4CG862W6je?=
 =?us-ascii?Q?ULecfvO6Wt/AEQTjz7/c2h63ia9VSR+vVq9G2b+dFoeYIrfcvuwMssjPk8CY?=
 =?us-ascii?Q?54OtzFB/Ihn/0F0xYm62QpYuLD1EuLpjqJrrZC8BD3JJiFzcYRKPcLD7+iBs?=
 =?us-ascii?Q?n05ffKk6kcE56lDZRar9tloJTCGwHfqSjb98GWv4DbqVEv7FjKxpqvCElpKf?=
 =?us-ascii?Q?Nbg5TLs1HhhdBF++IzSta4hIaLhXTbcKzAWVabtW1ErwMZZ4XyxRjul7DWOf?=
 =?us-ascii?Q?4G+WjnVObB/uxcrQ4RkfyTlQg7wCxSlmzSngUxkdPcihvzQkz96yji73O7X0?=
 =?us-ascii?Q?4vkO9QtEcZmMNLJGwyGSPDQnV51sIXV0tlSQNueqL2ZE3TjpvPjjFZfdBhY1?=
 =?us-ascii?Q?ZSQSgm9aMZpQ9Wb8c8aTE3Nr9vBZsww8DgqsNIKZ9YbTrqkhyWfyVr7leg/l?=
 =?us-ascii?Q?JnLuPPPC6uKBou5gJPxxJ1Vq/Hu3ksjIB12gQrfqMH4xWkLe9ypjBfSqYDAy?=
 =?us-ascii?Q?PNo+72wxAK8GVhZ28csHNvscss4/EXqFUlf2gnoQhOv2eGxSyAFdhIjg4cvu?=
 =?us-ascii?Q?isfpRqcAe/t+Zd6DT2k3CZzRf3NMQZPoO7IaOHLykYks7RJuLt7JvNzij1gI?=
 =?us-ascii?Q?Znc6FzDlGe/S5FIE5f+CtSQDRqiRwq9g4xeyay10PXn3dXmzEdTv/TVVAsSZ?=
 =?us-ascii?Q?RTuJe3NvzBgE3ZOZkp4uNc2Qru6uHTiLMzblsA0CjpGrryNwDHgjdnlR0/1b?=
 =?us-ascii?Q?0++waiuHrxxO+0/95i+x9vnbZvU521TeUIp0dctHTUyW7eEXEJkpdpJXYDW4?=
 =?us-ascii?Q?Ssb8VQbjg/bQxzcyDxCqdOmVzYW/oPQ3F6PcktQH2p9xeMSZo7kzBkAkVcJh?=
 =?us-ascii?Q?g0rf4S3nednnKqu4gmw9agQas+d2qxKAwf15Fmmit4iXvKaIO2pLxV2oCy21?=
 =?us-ascii?Q?VXuHjGslXU4eX5uSgnY6HiFh40OJAZeSrtmfYairoeRzVsrzrGZxMGh9cOu3?=
 =?us-ascii?Q?AIw1BTXEVi8pht9Z8P9x4clt2IVfRIyWGKsrROH1szc1lK01cwHR/Uwcpx/o?=
 =?us-ascii?Q?s5Z3E6xV/t7U5fvan55isHYn+7ssexpEhZRPHy6dIlqyqHAb9gpIbG5KTkiQ?=
 =?us-ascii?Q?fTMpKlJlu88M4inAqpgYiTfp4ar2mJDKFYWnrBS0oldmOO/RoWlELOFBTac0?=
 =?us-ascii?Q?8JcAcDYwTrQPEJ/oTzYU4j18Dg09dkBU1oYt3KuqfFTCum2Whw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XKvwpeCP8j0CUpRm73bLdXddD9It+HfFKYd+Z8oxPPouw486F36s336eQK6?=
 =?us-ascii?Q?8Hp2gYKp2LdSAnM9DdrMIIoXPn65X39BVLt2l4PTTpFp2wvJ/iXScrtHDUPY?=
 =?us-ascii?Q?dijWsZ/GZXBifzrtVhhdKoNXFwhJDmOYlAq8uIxtuMFKaXDcNnLx/LASkWhw?=
 =?us-ascii?Q?3VufvYhnr5puAs3c9GEiKDQYbuoB0JxBFvJieesN/2/oEvmodxN9kOro5UkG?=
 =?us-ascii?Q?XunntW30uvr03vZZ2rVZoBGDHESP4rCS3telRo3kndllTKLlP+GxM6DuV5qI?=
 =?us-ascii?Q?RVQkRGz7RM2ynObUA8Xgs9uLc7nHvdVYnRSkoQxBUVHcRSAKejgGRnG/888I?=
 =?us-ascii?Q?s8OGWj9hyvJHfqL53QV388WGg/s4ciMi2bAQ+v5zp4lyCsmvxAFiHEp570yh?=
 =?us-ascii?Q?SwcYTWyAI925MYXTXiy3eyU/2NrHwn4Ex0ita2ul37pAuWVyn+vLQtHtNqrK?=
 =?us-ascii?Q?oWOBLJl/TTnaCnsslloSyiv9jb2ssFnVyxLe12x8HxfhhnTDljU7jchEYUyV?=
 =?us-ascii?Q?FWRfvDNahfVc3LKizXLkyqzY/F+JY9QNgsbdFy9KV6SYsX8ryo56OJItXOEM?=
 =?us-ascii?Q?bt1tLsYpVt3ReoEJr/EtofVA5njbA8QvsY+FAv3KlY8q0WzfpScZyXzWF568?=
 =?us-ascii?Q?o44QfE+nabDCNYwWhfVHCQyD8ltLOtJrhfjf7dStrmv24S6weX2uOjgkH3TP?=
 =?us-ascii?Q?ooNHQYfQrkAbFCNUML7MiTQjsFxooNAhk5LezXGZ1Wy++7WXYcRUhvSXiKgT?=
 =?us-ascii?Q?UZMPhDYCRQH0euO18eHruIEX8XlcSxITvNwouIukje/Bo/Z+2qXQgY0oxN06?=
 =?us-ascii?Q?efhxZh6ngmWKAsH926U+4b3R/L1Wrni2INqcZGnpfgCvpfpBdZ32IASLavcU?=
 =?us-ascii?Q?KbWo2i/v7/vmBbNt0u0bepMRf7k9j6p6JItP95Jhw7DFmWWaDD/DN1EROy/q?=
 =?us-ascii?Q?3wBSKrOysdMbqWrLl79pGAMlMko55m/NlKzNVRHye/UZqfrywyJ8nOjlD0iO?=
 =?us-ascii?Q?nSTjp5iWoRGDxjXLf+vZJGsnNWGhbSVRAu+/XmfgUOROKoWZjOjEI1PtXFOP?=
 =?us-ascii?Q?kOBkXDUIuUuK1wzFmzirFqDfBSfFakMpjP/SPAapkN8Zu2MxMFLtKiHnT06q?=
 =?us-ascii?Q?StdIbIKWO0nCGKGyrgoUOwrZwlgkChDf4VPQs9uBMdoexTQTyuxtsHwZ8hjF?=
 =?us-ascii?Q?O6fXWyPRo7Q1xDFiCIqS/jNWQRndtCK6E6CZgk/z16LrAD24OVKtReJvPFkM?=
 =?us-ascii?Q?5WumW14m/8Q4WLOiXJ7sfUfWIXfLI61WhsOt5eEy5ERthJa5mtQ/e4VhWUuP?=
 =?us-ascii?Q?tikm9odmc1sUbaBXmcnDJuQ6EKX3emlX3LDzXknkngkePrFqnIDFbCdD9/Vz?=
 =?us-ascii?Q?HjwV/tKZ+oeTdVXoMkqipujAXcIQzts7rYljDlRWw/gWar3UILHDawFgrrgg?=
 =?us-ascii?Q?i30kpx09E3oQXh3TzDolYkiEhvPIExRmuEMDfwfrsWl+dqgs+swQciXIuTYC?=
 =?us-ascii?Q?IazBi0A25u2L+YSaFHsgcOHOkKxqw+V/eD2mDd/f62uiPGnV9TBXufpMrad3?=
 =?us-ascii?Q?pcNsPmcboIh72jjlnKKefxnc5XuA+pKqUjNkuV1DAb9NHD0xSyRjhM79MTTy?=
 =?us-ascii?Q?uEgVbb5OjUlRfxjkIPOr4Gk=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2afe68-de51-4853-9999-08dcac7691de
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 06:54:03.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F4uUdNxtjiWK1LgDdLYiJvl7WHUrvOGSjQnrWVht+ZlqI7peO8KHFuyiWXMlaSx+65fPgXF6Hvpaff+e9a8CDfuIhZODjV856z5go4j2YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1446

Change in V2

	1. Add Board name into subject
	2. Remove below properties
	- at803x,eee-disabled;
	- at803x,vddio-1p8v;

Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
---
 .../dts/freescale/imx8mm-emtop-baseboard.dts  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
index 1c4e4d175989..7d2cb74c64ee 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -11,5 +11,53 @@ / {
 	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
 	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
 		"fsl,imx8mm";
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@4 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <4>;
+			reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			vddio-supply = <&vddio>;
+
+			vddio: vddio-regulator {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+		};
+	};
+};
 
+&iomuxc {
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0x3
+			MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO               0x3
+			MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3           0x1f
+			MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2           0x1f
+			MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1           0x1f
+			MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0           0x1f
+			MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3           0x91
+			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2           0x91
+			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1           0x91
+			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0           0x91
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC           0x1f
+			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC           0x91
+			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL     0x91
+			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0x1f
+			MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22                0x19
+		>;
+	};
 };
-- 
2.34.1


