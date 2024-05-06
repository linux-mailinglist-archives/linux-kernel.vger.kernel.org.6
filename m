Return-Path: <linux-kernel+bounces-169282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC618BC648
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7307C1C21706
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC343AB2;
	Mon,  6 May 2024 03:46:49 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2134.outbound.protection.partner.outlook.cn [139.219.17.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206364594E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 03:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967209; cv=fail; b=ZdnOxX+6I25OJk9Ea5xLa0h7jhZfl6JSUcl3FqIUk7RrbkQxX/b2odkZ5InQBpuzTmSLqgyw7JRTBjCF1UXRkCFZhVSaZtB3XcXzhYvTTu0I3TCsFOpMp3SCwqzZicFL/ifl5XiNSmTK9CGuwoN9MKB+/zfVH1JBxwgagk1qYL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967209; c=relaxed/simple;
	bh=ujm4y3QKcY3L9Cf4hHa/U5fukmMQV74WdYfPnzWkjIg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rEiUeraZgAUB0dAfmNBIFM+hjjG8I2Xac+ZGBgI47zEHjPY3qk1iM4TSOhpifN8wNXvMcnEjO6jx9noExvK6ok7FZ9MMPHOU6tKXuHDnOsnxFCxBZXz/+9OnvPUL+OQfghKtvStwVvjMo4/e5y5P93qaqO6BVoAyk1GvkGxeJF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIMltynZ8RjYggWvxf3aJ2ZWfAjlqa8KRdr0nqsoMJ73+AqNPA1HKP+4W0lEO7pUZpjrsWhVU5rKDSE1DPOEhjI7WWduB3GgvDm1HYMzpMM5pqcP+JX+Sr9uENWTTj5Znvh7/BhGySSXw26oB+oyiieq1bFzFQm4AIRuRY9lEpz1MdCVi/6WTnwxnkKukv8tJgOelCqNX9awb+8xK7zkyB4PQrFFxy1UjmBsbaz3OTOtZ2c3UPT6EiznlOBJDsyX679odkK8iUSGXrlFl8MFemXtOMHd0c32gkQGkURQ0zhyncdSBdonfVFPNs+lMkeZ3bUgtJj1CglTi2z7x1YqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRkMAT594ErfcQTEKOQpEEQ0QpyuxVO1GSg6pauvPME=;
 b=fkTr+ZQ/g+CvXdOAowiYHx1kMTF9lOBKEy2dmVXQJ2bRDfWVlxSFb4wPrdLQefUslQkXUp4gX3ttEbUUrf1Yh8UplAy2719J9PQNHtFTVUeDZ4qotIujiKmMmkLF4HojPXDhNYyWWMzyZY5AeHnVZVnIjFyYPovcwLPiMaW9pKjDf6f1QHB+rwIuSCtIWcs2Poc6xfVn9TmRRcZMhxr/bnCkUxj5WL7emZAPBSJrweyqducq6NxHnR9/pMS8uHMWV1LqpE3UX6HvN5yzrOh6zm2c+Zb50xSa7WhlwOf5c2Gdfo1KchkZ53LRlSyO1ynj+OarWbXdowSmIsvW9XmD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 6 May
 2024 03:46:35 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Mon, 6 May 2024
 03:46:35 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: defconfig: Enable StarFive JH7110 drivers
Date: Mon,  6 May 2024 11:46:27 +0800
Message-ID: <20240506034627.66765-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c8bca7-c205-43fc-03dc-08dc6d7f206c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d8wGKPSmhwgsngRSnG6R2QrdpPvxWQysqa2L/kTVcOxVCSvWNETtNrPnv2pc1GNraH8G4YCuozcUkKfxSg4s4k5gBACWlYgy2xYisETuJJWY2VWWoaqEit3YN2P65kAw5MmpPESovbwPkalpDSOwDncLvNozJHqasHwKTYHmgAK17XwIQnINCmP+j31dicbxpN9JY+ypOXkV7M5+vZ4sBsaRkS7jvo+qco57r3vhN6e47XNPr7Jnz01hVHO8ayF0WMxq/2oQfmH+AqqPmUBmUEoVjrIOKOkIxg6DhV0rvI4CZm70O1ZIg63u82hO9DdymQVaKJZp8CbqNG0XgiQSisfkh+np3Fhe9nx2BXP+xLugqOBpIgB5ImOboWMqDwSxEslyWwGMBPZbHcG9e4LSra4E5eqx/LGSx4esux813grXYwiRlr1CIrAdOxMSJv/LYj/CoIolWqTNlErupNU+2dTLpT0a6kzfSg8rH1lxK0B9GD+NAmhCgkrJkYFoz8gpDWdCtB1BGn5swa7cfHFDzOJYKC1lfg796F+9x7yqgvLoH1ykVdzzDZCVMFeDqYyyEsuXP4JsWD7Qrx3eEokwlPvVKigN3St7fLlhUHdrTl2Bw/eMx9BZEFU8Jt+v0UZZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lcRA+UKMxrr/lG+2qBXmtlVK77yX4bM2fr0T/Z7ckMeReeku7OgI2GTvGx+d?=
 =?us-ascii?Q?g51lyyz/ZEXJ6UJ/MLTZqCgg4hyMFTttF2vusY6NiZAxeXuLRXjcOzmsobom?=
 =?us-ascii?Q?Ii7TMuvNk9epGHV2OUvHea0wDzEivOR6OLtGiVofcpOJwpDcO91XiEpmaL6T?=
 =?us-ascii?Q?PJxmJt1xFnFJbLErFNJqqDr1BXZD9OefNLbRgZPYq2pkFtqHyAa2KlRB8rK1?=
 =?us-ascii?Q?CnJUyl8MFQj40XJO5myghdMYnvjiuJ7cAYMSMH+t2wo6q3z0LdxBEy170gko?=
 =?us-ascii?Q?Nig0qV4/DZJvjepo8FEQCMR6MeEzLuzoLpz6Nbt33YaqydKkbNZuk+UXkd3Q?=
 =?us-ascii?Q?wHQR6BKKZEfNDXytvZrIWuPBkXh5V8TaQVv2q6jX7KBAZ7v/0U6SbehcVFad?=
 =?us-ascii?Q?/QpnhT2JOh08UM8WA0dJ4mWLYvCYk8g7/vIo06Q2/yqC891pCm8g9Nqx/NEt?=
 =?us-ascii?Q?XnVXP/JlLMw8SCAqEuAHT3PxAhNISIZgdyhH1LPh9cNsFpRP/TF0aFK0/DtA?=
 =?us-ascii?Q?5IojWgnFVw0lqi7uejuXEpv90KZuDvEsQ06+m4hZ7x3U12Bpu+k9RAInUaIK?=
 =?us-ascii?Q?sdC9CqbkO4oL2tsPQt1wGr5SuXKfiI60Cw1RhkuJWUrrhnc2wnJ/50hiq5z9?=
 =?us-ascii?Q?65qJEXz2bMytmmKamqa9sheUKi7WWONwpzhDaHxRl6R/XGcDHfSENrEF59Kf?=
 =?us-ascii?Q?4al4DlGLcTIGn7tjlnnDxN3jFGgivsBSBHeWnVteI4LhKbJL5bRKx5t3jhxD?=
 =?us-ascii?Q?g1mu5ov+C77qLGkiHNdfHwpVodjDUZj1tqyv+H4pnAlrZz+RbBjIu6EjpD9G?=
 =?us-ascii?Q?MAF9mNNkhFZE3tqIAQB5XcTnDNGAlRBmDR70bH8yva/plA4qTnofe+BZ1+kH?=
 =?us-ascii?Q?K1zz2dnE5DGFnnjhGaTUS4MMi7Q6dsCt8nYk8FCy+vKRD0P+7e6uiDbN0uLA?=
 =?us-ascii?Q?9QmvUaO3MnU3iP2PvcRQxmadDpuSUhV+W3x1w2oh+WYukAsqi1Xr1VwjaUKQ?=
 =?us-ascii?Q?BhNjv63DZzTvFlemeCkcn/gWS4cpnjAkG5Z+FBkGatBSrwM2n7Sy6Ii6azrA?=
 =?us-ascii?Q?m9WZhSYyHTrbU05zJLWpCaUeBzpf/xYNHEiNw2D5X47onKp6yZtGFhaK/6LC?=
 =?us-ascii?Q?dgtJSaoWVbW8Br1JscSP5LpoPNtJep+LxmaaHW4WBmAqMKTLYPWwPFBIuIti?=
 =?us-ascii?Q?QhOzSq4mi8yRCCTtZtmTM5E0fPXLFCGNaESKkMnUulu440cha1bewJjtIpF7?=
 =?us-ascii?Q?H4LBiWqEhCWbsRC5jO6t34gHjYfc/PzeoJkIoNUkeLaKDSc9DYuWSrYseOwT?=
 =?us-ascii?Q?72hjR7lSDTjTQ8bBDBKJRfahuFtNA9vwTJCkntVseEMnlnV5djeqLH0NSgFF?=
 =?us-ascii?Q?iPjBk6Hr1Pj9TWCSaxvkgsmgiTeuutCiRevuab2x/gkH8xHY5CAYffwUT3Uk?=
 =?us-ascii?Q?yyBWQ23E/gfrlNbMmHw6nS0oyhijt1x+/eLeSp3LshlCJDCjfW52aCJOR+2Z?=
 =?us-ascii?Q?GQSmRasjMXBVS8s6xnU/k9hSOGn2/YJy9mItxXM7TzbSfEtmUNMLmAmwedfb?=
 =?us-ascii?Q?8YS7+fq4q7OT/hE7XdCgjaK7oHpQiompn8jaswtRnLXEzZXyVlHzzBp6GIa1?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c8bca7-c205-43fc-03dc-08dc6d7f206c
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:46:35.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivIz7awbNyxDv+GELJ9OV1bdq66U41GR/nNrCLZ3yU3x41KAkVz7kBEj0JLIEpd/xcUKFVb2ccG04VLe4bDyGWPAEwyyQmfgEDFQDJ808Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227

Add support for StarFive JH7110 SoC and VisionFive 2 board.
- Cache
- Temperature sensor
- PMIC (AXP15060)
- Restart GPIO
- RNG
- I2C
- SPI
- Quad SPI
- USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
- Audio (I2S / TDM / PWM-DAC)
- MIPI-CSI2 RX & D-PHY RX

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---

As more drivers of StarFive JH7110 VisionFive 2 board are upstream,
add support for them in riscv defconfig.

Changes since v1:
- Drop CONFIG_STAGING=y, CONFIG_STAGING_MEDIA=y,
  CONFIG_V4L_PLATFORM_DRIVERS=y, CONFIG_VIDEO_STARFIVE_CAMSS=m.
- Change CONFIG_SENSORS_SFCTEMP as a module.
- Drop CONFIG_CLK_STARFIVE_JH7110_*=y, because they are not critical to boot.
- Update the commit message.

History:
v1: https://lore.kernel.org/all/20240403060902.42834-1-hal.feng@starfivetech.com/

---
 arch/riscv/configs/defconfig | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc0ec2ee13bc..2c8e80b57edd 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -111,6 +111,7 @@ CONFIG_PCIE_XILINX=y
 CONFIG_PCIE_FU740=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_SIFIVE_CCACHE=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -154,24 +155,35 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_HW_RANDOM_JH7110=m
+CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_MV64XXX=m
 CONFIG_I2C_RIIC=y
 CONFIG_SPI=y
+CONFIG_SPI_CADENCE_QUADSPI=m
+CONFIG_SPI_PL022=m
 CONFIG_SPI_RSPI=m
 CONFIG_SPI_SIFIVE=y
 CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_GPIO_SIFIVE=y
+CONFIG_POWER_RESET_GPIO_RESTART=y
+CONFIG_SENSORS_SFCTEMP=m
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_RENESAS_RZG2LWDT=y
+CONFIG_MFD_AXP20X_I2C=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_VIDEO_CADENCE_CSI2RX=m
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
@@ -183,6 +195,10 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_RZ=m
+CONFIG_SND_DESIGNWARE_I2S=m
+CONFIG_SND_SOC_STARFIVE=m
+CONFIG_SND_SOC_JH7110_PWMDAC=m
+CONFIG_SND_SOC_JH7110_TDM=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_USB=y
@@ -196,6 +212,11 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_USB_CDNS_SUPPORT=m
+CONFIG_USB_CDNS3=m
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
+CONFIG_USB_CDNS3_STARFIVE=m
 CONFIG_USB_MUSB_HDRC=m
 CONFIG_USB_MUSB_SUNXI=m
 CONFIG_NOP_USB_XCEIV=m
@@ -244,6 +265,9 @@ CONFIG_RZG2L_ADC=m
 CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_RCAR_GEN3_USB2=y
+CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
+CONFIG_PHY_STARFIVE_JH7110_PCIE=m
+CONFIG_PHY_STARFIVE_JH7110_USB=m
 CONFIG_LIBNVDIMM=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y

base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
-- 
2.43.2


