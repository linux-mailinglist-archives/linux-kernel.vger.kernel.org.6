Return-Path: <linux-kernel+bounces-202218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363F8FC967
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6A31F2509B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBC91922E7;
	Wed,  5 Jun 2024 10:52:00 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2100.outbound.protection.partner.outlook.cn [139.219.146.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1218F2F3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717584719; cv=fail; b=fO/Aacn9JqIIFaEx/a5+Dqtr343jpC7a1BbOYfLmCnyweLuBOBqVTIo4nfJwsh3qfSpj80x2SYjfDeFN3/KfMf2Xkxi1UyHxmvWuetR7dpacmjHcrtGtyUo19YBSBNiP6pKe4mwgQ9GHTYmdgExbL9+cGwrNMIWowXFyNoNSFMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717584719; c=relaxed/simple;
	bh=X8mU+BFJVhzadKrxAiTWr+j2iubxqf8A9NkTmK5zLqs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s6yB6eqpXH07gLdr7MQYwUFC0kCiYLFoXo/kup9lXM+dqIX0ggmh8+gIibSyD407xyq5XWHHr1Yh4rwoj3Oj1vsyQ1I4d9mxt3ekvjbbYPCfID1dmb5gSktR+gRO6WnQfbsqflqZDmJMtKrcrpfjn2ZuWwXTJUug4qrDl207oPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSNeJ9fJBfpuvny2TpB+5yWsFBxvfG4xfH+2io/7qIt5V5d/LVF0cCU9EUq2jUV+HiZfv2DpCkWWjqIWSSGSg/UDyoDC6gSmKfqyacAue24U0Gm/g8+54ZF/JeTn9oYm3ISb4bXgTyaAv1q0KAdnrGTrImp2VX6p7zX3TWtUkzjLz0FF5KmxfiTWk+A1LB4mV2i6t3Mudwh5YFlOYxzkiHhDz/zq3w6ui7uYoiZTICZcOWvWCJWNFZTQSPY78iVTp9vlSBHKp/zm/62exNKt7pHlI1BbzATf4Vawzal9MC0kR5wB4OmYodjFCwowRc5f5/xFnMipOjKQgBVipIf6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXD+ynwrgiwMFwhjM0g/3kxVIaoYegfEqya7687XTBE=;
 b=ClLuu4XdQjDxnemOLoXcvh+UDTIGW6mcr131Uf7TzpLWLQ9j2g2hW5xsF5rEaOeiCKsiCCqLUIGkz6f9yqklSoylfEOs+GYr1IumEfass5u/peewqPgiym7LZ1Q7T8t3/ZYdffdO12YDD2M/JMWfDPEFHPUbiR0fMzR56L6AkimUvxFVQcaDKBA0cvLgL+dy/8o1FcPDpNmflrFM+Nj2TnCZcimeNdiW9EdwnCdvcSKu/kGYMHalTwPMs33dc247USy9dsELWzmxywfpIA8TcsucbzI484Sy84rq70C3vI66afEGQRbdR8nBK5UuVIunMtPPiGMdK8pPRug9yhWOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1322.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.43; Wed, 5 Jun
 2024 07:17:08 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Wed, 5 Jun 2024 07:17:08 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] riscv: defconfig: Enable StarFive JH7110 drivers
Date: Wed,  5 Jun 2024 15:17:01 +0800
Message-ID: <20240605071701.13737-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1322:EE_
X-MS-Office365-Filtering-Correlation-Id: d25c8b3d-50ff-4f73-63b7-08dc852f82ed
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|41320700004|38350700005;
X-Microsoft-Antispam-Message-Info:
	rSpLgzsf5hXzS1ef2wgrNGMYJN+FLOUD8aSRSw5BqxD2rKJGeXQ4ts4JgS5yt3ZiCsZk0JMvOQCKA06Y9paObl/HIvWG+O3NR9A8xGILk2k2qCJjpZCFg2oUq+t5ayRNLDTS9d3fOKE4k4fMi4iED7btrwEknfqzuH8/ZjSKXsDxtrh2v3AdLOeGTXfBKPMn1I0eQo8AVwMmY0eN5p+bBQtiwUKIUabRDbSXRzKb76TCQIuk1xRBEdBqMAkcb+5fm7QalgkClbaUDN5Fs5QNS9GWb71shv9M5X4TZTQkquLCxWiYgAxZi6Su35LhoIJ9VBe3esfUqpxnQYlol9hRzLoh1YDqCXTd9L8ARtQdTrjmt8IAamMRIjBVB76r367Pspo6ZS9wr9Pe67AeGYZ3pfkBljGUD6JvQmsvO2eXViRtLM2SpjN104+Zg/w+I2btTAz3NS53+dx+sS7G4E6C66OKaI7wzyU+3i17HBHVvPYSNKKRqyR3YPWlZfQDSfc2rSndbwPRPrCDexDmPRNfqOwLAwYTSudA2px03vMUSbtS7BLIiYBtTE0ONLAmO2u13eC5G3bo7fefcKUSsOYKNSd5mKzppEkuRE97qaHW6GAGxO9MFmJ5ZN0LXn4hNe/u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(41320700004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mx7qbCIsgFDWpxnGGsfwFNrFhEZErPdX9MsK3MA0rBSPucdEdeFI7enn6QAo?=
 =?us-ascii?Q?3vGAS59ut8AYIpky3gSOTF7G85VQ9tk+0vxlUP4y8dE5DYOdny1k5MK/o58n?=
 =?us-ascii?Q?5+foQFSuCyPM8dc/1KdjdtpEv+AAMwBddMrhHCjw/ZlvtfRfHeKSLbiwmtL9?=
 =?us-ascii?Q?/QvD9R79KIpCjmux5GyX1HwcQKssOmYkHmX0CGXBOU1nCfRsAUgTKfQms4LD?=
 =?us-ascii?Q?uEF1BMwqrAfI80UDbjHl9JOR820BYo3IcelVtF8Ys2WjLpBlaUBjcGqfgQ6E?=
 =?us-ascii?Q?Uttmn/dN0Ml7CXFeapb6BYTrOoD7RF7Z/xgGcDCm9Hl7IXmc+WPv13EXJVSu?=
 =?us-ascii?Q?idfVinojmgoYoUrzZrsrvatuUAZuI7ba3JFxRjPGb+L5R6vBDpPVAWmr/Lkz?=
 =?us-ascii?Q?stb8vRzWGbwMoQM8cXxFLB5gFhLJL0SNlf7mdHuZbNCsvLhnJGw+D4pX0qpz?=
 =?us-ascii?Q?I0w39t+D+TUtdJc1Neg5NZRS/frJsNPgln5ZwwAk6JOWqcHR2+HtpQ/kDzcb?=
 =?us-ascii?Q?UzccVy84l2BuXr3qoUY7lUqAE7CiJM7g9iHYf0MsvRPnNbmU4FYW2+pQcctr?=
 =?us-ascii?Q?5cVuU+5iOBIOYUKCm3338BQJBIrgZl/irFhoJopdPYRYmJRWlBrpVJ4+PjhG?=
 =?us-ascii?Q?lx+mbpgt6jBU7UN9Nf/AHh9sdTejKk4u940LwWwjZw2vLMhoxw7yRAlwAGUH?=
 =?us-ascii?Q?bcwdyhVTxr45+HRL4iWx/XN2Q+1pQa033v9eAQUrfY9EOH4yboLi7do6XaAU?=
 =?us-ascii?Q?s3XJt7ngArSuSZioy26oGt4zmlD72a4QuNdB2Sng7k/NWBuJqe+JCbjM9kgM?=
 =?us-ascii?Q?173ljemGmAwAbma3kJJirX9C5ZdL5rkTDezVGCNJ98sN3E2AJTEU7fbqbJUn?=
 =?us-ascii?Q?pC1pLaLRZ8EMLGMZu+ubm5TVba0Oija/xHAItZEwhOQJrYpdQgxhxi2fh1Ax?=
 =?us-ascii?Q?UXrXLDRl5i2z9z3HLqG1VyGv274f4HVwpmDbr9VHG/Zy9gsvCbiUJy0IY7B9?=
 =?us-ascii?Q?2/5U2KPHG5PRsEbKhJ5g2TcegjbPBmY6+VEjUK0w+PSytxkLsxlUfxe0XeRH?=
 =?us-ascii?Q?SILClVa9mfk54jLDejRzIBT8nEkkBtBuqCc5GfxoTt3jKozlAY9pMVXTchZ1?=
 =?us-ascii?Q?7U6RGz33FvW0Bo3BmJfmeCKhw/a/ciKYd5L6cqh7to2m+xC+1/gckzyE6GDH?=
 =?us-ascii?Q?VuXWNYEVtEpgHcdHt6ugmk7cpWJa74/LVX/Na7564QwU2U9j/DEc0BKWCmgG?=
 =?us-ascii?Q?uxI/PPE3hN/PGBgW7wetNXJkpSdf7onf28lRcVlBCJqHI+lzk5nZGIpEM2QX?=
 =?us-ascii?Q?DlKAtt8TFUNXryVw4/TT9qwUDtYg0FlHob48vFd9M4dvrkOf22MdmYax+ZxC?=
 =?us-ascii?Q?yz0f9qixw9QQxbfwZvV6PbaEGC4ItDbaVBg1ziuW3nEfDD+iMem+COerdnx0?=
 =?us-ascii?Q?27MA1275WmjEgtAlVDW2SwPHywqgteRK0jRZwgezmV61XPmDNlazMqnbVk6z?=
 =?us-ascii?Q?Qh55JUOuXCMZJ/oigNIJNj4xbdA2gzLCpXwSXB/gwpoVcgHf9dYHug/q8rbu?=
 =?us-ascii?Q?YY+ezzt7Qfi1lmOtIfCaQvU6rp3XkdzfTcrbjGzeiKZ9Ae2mEwBCTLrFG0TC?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25c8b3d-50ff-4f73-63b7-08dc852f82ed
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 07:17:08.7316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKVw9ISFhDkEHWvlLIiGVke+xFCs0sXG47qz2A7VB+3YsaTlYD4GzM6n94e9tmAgK9y6hntX8Gkhw5PBKjged2MiGAcSM+NucdiBwtPtUSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1322

Add support for StarFive JH7110 SoC and VisionFive 2 board.
- Cache
- Temperature sensor
- PMIC (AXP15060)
- Ethernet PHY (YT8531)
- Restart GPIO
- RNG
- I2C
- SPI
- Quad SPI
- PCIe
- USB & USB 2.0 PHY & PCIe 2.0/USB 3.0 PHY
- Audio (I2S / TDM / PWM-DAC)
- MIPI-CSI2 RX & D-PHY RX

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---

As more drivers of StarFive JH7110 VisionFive 2 board are upstream,
add support for them in riscv defconfig.

Changes since v2:
- As the JH7110 PCIe driver was accepted, add CONFIG_PCIE_STARFIVE_HOST=m.
- Add CONFIG_MOTORCOMM_PHY=m, which supports the ethernet phy chips
  on the board.
- Rebase on the -next branch. 

Changes since v1:
- Drop CONFIG_STAGING=y, CONFIG_STAGING_MEDIA=y,
  CONFIG_V4L_PLATFORM_DRIVERS=y, CONFIG_VIDEO_STARFIVE_CAMSS=m.
- Change CONFIG_SENSORS_SFCTEMP as a module.
- Drop CONFIG_CLK_STARFIVE_JH7110_*=y, because they are not critical to boot.
- Update the commit message.

History:
v2: https://lore.kernel.org/all/20240506034627.66765-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20240403060902.42834-1-hal.feng@starfivetech.com/

---
 arch/riscv/configs/defconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 12dc8c73a8ac..6e10039c5c42 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -110,8 +110,10 @@ CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCIE_XILINX=y
 CONFIG_PCIE_FU740=y
+CONFIG_PCIE_STARFIVE_HOST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_SIFIVE_CCACHE=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -143,6 +145,7 @@ CONFIG_RAVB=y
 CONFIG_STMMAC_ETH=m
 CONFIG_MICREL_PHY=y
 CONFIG_MICROSEMI_PHY=y
+CONFIG_MOTORCOMM_PHY=m
 CONFIG_CAN_RCAR_CANFD=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_KEYBOARD_SUN4I_LRADC=m
@@ -155,24 +158,35 @@ CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
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
@@ -184,6 +198,10 @@ CONFIG_SOUND=y
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
@@ -197,6 +215,11 @@ CONFIG_USB_OHCI_HCD_PLATFORM=y
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
@@ -246,6 +269,9 @@ CONFIG_RZG2L_ADC=m
 CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_RCAR_GEN3_USB2=y
+CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
+CONFIG_PHY_STARFIVE_JH7110_PCIE=m
+CONFIG_PHY_STARFIVE_JH7110_USB=m
 CONFIG_LIBNVDIMM=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y
-- 
2.43.2


