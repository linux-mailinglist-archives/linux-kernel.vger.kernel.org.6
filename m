Return-Path: <linux-kernel+bounces-373254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83109A545A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E935D1C20E7E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9467E192B99;
	Sun, 20 Oct 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SQC9+Cvn"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5BB674
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430949; cv=none; b=GqtNYWPio+Jk7cEbXn7gdDV8s5R68ANNAkUd74b+Px/cBEHRJECGT8fpe7W3CUU8RKMmV+7Nqclqnm4IcvUCqClw5WvqJeU7RWqXA6aCjWOAonqgAzGWcSUQLzqPiwBhsXpWwyjcVvdPoeB8gXNNv+dTNhdOGsMlQhGqCoHPi0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430949; c=relaxed/simple;
	bh=uTr+p262V66lyjnEN6erpoWB9MCGAeLUbU9TVdQj8PQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwSDvbljo6Fc8hl1KFxDQ9ef32SS6OsBFj3j3p6O3AdfIa9MvCrEZ646XOiDSTCMv6Cz4NSW7wvVqOWf6Po53T5MNhfVAgPr0EJPWBcE0hWQ/bqialiKCvlHW6Rd3hNBgNclImVWIDhqPXiJ6GtRv4FPkKXz+V3zOsT43rQiDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SQC9+Cvn; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 458bf3388ee711efb88477ffae1fc7a5-20241020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ICByNUPg0Iy6Y7kVIRAl7dHZrrdeU90KoDn/qQyaETA=;
	b=SQC9+Cvnz7/+an9Y0ByBPnBcsR9WkIdcEtInQSZU/F5GanvH6wLVIsqHSAbGO1YkF5fBE5ONhIhT9VJ6SWG0v8GTN1Ru04OU0CYu+3OQ2auewF8GgvbT86bk+RdC8jfXpDal8b/0Qq0cZWS+EBnfJQX/YaNv3Q6SLQ2qOsn9LoY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:e392eb61-615e-4602-b34e-8331f5ac8443,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:fd255925-9cd9-4037-af6e-f4241b90f84d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 458bf3388ee711efb88477ffae1fc7a5-20241020
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 208300156; Sun, 20 Oct 2024 21:29:02 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 20 Oct 2024 21:29:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 20 Oct 2024 21:29:00 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle
	<daniel@makrotopia.org>, Chia-Lin Kao <acelan.kao@canonical.com>, "Mika
 Westerberg" <mika.westerberg@linux.intel.com>, Cheng Ming Lin
	<chengminglin@mxic.com.tw>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [RFC PATCH nand/next 4/4] mtd: nand: spi: Add CASN page support
Date: Sun, 20 Oct 2024 21:27:22 +0800
Message-ID: <20241020132722.20565-5-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.444200-8.000000
X-TMASE-MatchedRID: /bKxxJqDGVcwE0n9oAwkPXtItsHAduPxBGvINcfHqhdNZ/CnTeI8lmEj
	qlizhhlNpJ0OYMrT0yma/3zDweDPK1SU1d+VJ4IjGVyS87Wb4lyscK/K2DlvjsA0eOJZYj7tx+W
	T4fjiMGeFuNbf28fb6Lrw3PfJA6xhZz86fqAj7POEJ5wBUYI5/ZnaxzJFBx6vXCmcAC8DBrPQ1I
	IT+AWI0blK18H/cd3hp8qiS2HjSrPM2WV/gPPibLE3FpMbg63SKVrLOZD1BXTxxaAXDrCns0Z3u
	pZH64zDo+u9XRmCBoTuKpag/ZE3vbPmM/zWNUUfEdFsavUQKAeYZJKiXhR6LUYx760ONDcWhzQH
	k5Qv+7VS2oPdDIIOObiW/VRR7ZTRZ1otclUep4/d+fuf9kcaplo1rFkFFs1ayGbI60ZH8Wb6rx1
	jnOZw+qrnKAj6elaaIp2nL7ZFABfMHUInqqZ02s36paW7ZnFo5Y0kb0hqatzRziMbBeTI+R6AtY
	tAKdbYZflHUyH8MzPv6gcLh2moHiBPHVH0QwOY9Ib/6w+1lWSjkoGZwmjMNpsoi2XrUn/JUTdY/
	mdfTXtJKW4mDlJsMcK21zBg2KlfyMdyHKes7lse67lDQhMclzJ9Yj2F3cvEMgX+XpjX0UPPTy7H
	7An6Fg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.444200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 91FD138A61C70715A0CA3900CBE42C26709F1E28979A36A6B50440177768D9C72000:8
X-MTK: N

From: "Sky Huang" <skylake.huang@mediatek.com>

This patch implements how CASN page detection works for
SPI-NAND and how CASN page interprets ECC information
of all SPI-NAND flash vendors.

Probe flow will become like this:
* If CASN page exists, check its validity.
--> If a certain CASN page is valid, we will know the SPI-NAND
    device's information, including memory organization, flash
    on-chip ECC engine's design, etc.
* If CASN page doesn't exist, switch to reading ID

spinand_dump_casn() can be moved to sysfs, debugfs or something
else later, I guess.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/mtd/nand/spi/core.c | 741 +++++++++++++++++++++++++++++++++++-
 1 file changed, 729 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4d76f9f71a0e..7d7408e00b5e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -9,10 +9,13 @@
 
 #define pr_fmt(fmt)	"spi-nand: " fmt
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mtd/casn.h>
+#include <linux/mtd/param.h>
 #include <linux/mtd/spinand.h>
 #include <linux/of.h>
 #include <linux/slab.h>
@@ -20,6 +23,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+extern void sanitize_string(uint8_t *s, size_t len);
+
 static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
 {
 	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
@@ -200,6 +205,63 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+static size_t eccsr_none_op(size_t val, size_t mask) { return val; }
+static size_t eccsr_and_op(size_t val, size_t mask) { return val & mask; }
+static size_t eccsr_add_op(size_t val, size_t mask) { return val + mask; }
+static size_t eccsr_minus_op(size_t val, size_t mask) { return val - mask; }
+static size_t eccsr_mul_op(size_t val, size_t mask) { return val * mask; }
+
+static void spinand_read_adv_ecc(struct spinand_device *spinand,
+				 struct spi_mem_op *ops, u16 *eccsr,
+				 u16 mask, u8 shift,
+				 u8 pre_op, u8 pre_mask)
+{
+	u8 *p = spinand->scratchbuf;
+
+	spi_mem_exec_op(spinand->spimem, ops);
+
+	if (likely(mask <= 0xff))
+		*eccsr += (*p & mask) >> shift;
+	else
+		*eccsr += (((*p << 8) | (*p+1)) & mask) >> shift;
+
+	*eccsr = spinand->eccsr_math_op[pre_op](*eccsr, pre_mask);
+}
+
+static int spinand_casn_get_ecc_status(struct spinand_device *spinand,
+				       u8 status)
+{
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+	struct CASN_ADVECC *ah = spinand->advecc_high;
+	struct CASN_ADVECC *al = spinand->advecc_low;
+	u16 eccsr_high = 0;
+	u16 eccsr_low = 0;
+	u32 eccsr = 0;
+
+	if (al->cmd) {
+		spinand_read_adv_ecc(spinand,
+				     spinand->advecc_low_ops, &eccsr_low,
+				     al->mask, al->shift,
+				     al->pre_op, al->pre_mask);
+		eccsr += eccsr_low;
+	}
+	if (ah->cmd) {
+		spinand_read_adv_ecc(spinand,
+				     spinand->advecc_high_ops, &eccsr_high,
+				     ah->mask, ah->shift,
+				     ah->pre_op, ah->pre_mask);
+		eccsr += eccsr_high << spinand->advecc_low_bitcnt;
+	}
+
+	if (eccsr == spinand->advecc_noerr_status)
+		return 0;
+	else if (eccsr == spinand->advecc_uncor_status)
+		return -EBADMSG;
+	eccsr = spinand->eccsr_math_op[spinand->advecc_post_op](eccsr, spinand->advecc_post_mask);
+
+	return eccsr > mtd->ecc_strength ? mtd->ecc_strength : eccsr;
+}
+
 static int spinand_cont_read_enable(struct spinand_device *spinand,
 				    bool enable)
 {
@@ -1149,6 +1211,242 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
 	return -EOPNOTSUPP;
 }
 
+static int spinand_check_casn_validity(struct spinand_device *spinand,
+				       struct nand_casn *casn)
+{
+	struct device *dev = &spinand->spimem->spi->dev;
+
+	if (be32_to_cpu(casn->bits_per_cell) != 1) {
+		dev_err(dev, "[CASN] bits-per-cell must be 1\n");
+		return -EINVAL;
+	}
+
+	switch (be32_to_cpu(casn->bytes_per_page)) {
+	case 2048:
+	case 4096:
+		break;
+	default:
+		dev_err(dev, "[CASN] page size must be 2048/4096\n");
+		return -EINVAL;
+	}
+
+	switch (be32_to_cpu(casn->spare_bytes_per_page)) {
+	case 64:
+	case 96:
+	case 128:
+	case 256:
+		break;
+	default:
+		dev_err(dev, "[CASN] spare size must be 64/128/256\n");
+		return -EINVAL;
+	}
+
+	switch (be32_to_cpu(casn->pages_per_block)) {
+	case 64:
+	case 128:
+		break;
+	default:
+		dev_err(dev, "[CASN] pages_per_block must be 64/128\n");
+		return -EINVAL;
+	}
+
+	switch (be32_to_cpu(casn->blocks_per_lun)) {
+	case 1024:
+		if (be32_to_cpu(casn->max_bb_per_lun) != 20) {
+			dev_err(dev, "[CASN] max_bb_per_lun must be 20 when blocks_per_lun is 1024\n");
+			return -EINVAL;
+		}
+		break;
+	case 2048:
+		if (be32_to_cpu(casn->max_bb_per_lun) != 40) {
+			dev_err(dev, "[CASN] max_bb_per_lun must be 40 when blocks_per_lun is 2048\n");
+			return -EINVAL;
+		}
+		break;
+	case 4096:
+		if (be32_to_cpu(casn->max_bb_per_lun) != 80) {
+			dev_err(dev, "[CASN] max_bb_per_lun must be 80 when blocks_per_lun is 4096\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(dev, "[CASN] blocks_per_lun must be 1024/2048/4096\n");
+		return -EINVAL;
+	}
+
+	switch (be32_to_cpu(casn->planes_per_lun)) {
+	case 1:
+	case 2:
+		break;
+	default:
+		dev_err(dev, "[CASN] planes_per_lun must be 1/2\n");
+		return -EINVAL;
+	}
+
+	switch (be32_to_cpu(casn->luns_per_target)) {
+	case 1:
+	case 2:
+		break;
+	default:
+		dev_err(dev, "[CASN] luns_per_target must be 1/2\n");
+		return -EINVAL;
+	}
+
+	switch (be32_to_cpu(casn->total_target)) {
+	case 1:
+	case 2:
+		break;
+	default:
+		dev_err(dev, "[CASN] ntargets must be 1/2\n");
+		return -EINVAL;
+	}
+
+	if (casn->casn_oob.layout_type != OOB_CONTINUOUS &&
+	    casn->casn_oob.layout_type != OOB_DISCRETE) {
+		dev_err(dev, "[CASN] OOB layout type isn't correct.\n");
+		return -EINVAL;
+	}
+
+	if (casn->ecc_status_high.status_nbytes > 2 ||
+	    casn->ecc_status_low.status_nbytes > 2) {
+		dev_err(dev, "[CASN] ADVECC status nbytes must be no more than 2\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spinand_check_casn(struct spinand_device *spinand,
+			struct nand_casn *casn, unsigned int *sel)
+{
+	struct device *dev = &spinand->spimem->spi->dev;
+	uint16_t crc = be16_to_cpu(casn->crc);
+	uint16_t crc_compute;
+	int ret = 0;
+	int i;
+
+	/* There are 3 copies of CASN Pages V1. Choose one avabilable copy
+	 * first. If none of the copies is available, try to recover.
+	 */
+	for (i = 0; i < CASN_PAGE_V1_COPIES; i++) {
+		if (be32_to_cpu(casn[i].signature) != CASN_SIGNATURE) {
+			ret = -EINVAL;
+			continue;
+		}
+		crc_compute = nanddev_crc16(CASN_CRC_BASE, (u8 *)(casn + i),
+					    SPINAND_CASN_V1_CRC_OFS);
+		dev_dbg(dev, "CASN COPY %d CRC read: 0x%x, compute: 0x%x\n",
+			i, crc, crc_compute);
+		if (crc != crc_compute) {
+			ret = -EBADMSG;
+			continue;
+		}
+		ret = spinand_check_casn_validity(spinand, casn + i);
+		if (ret < 0)
+			continue;
+		*sel = i;
+		break;
+	}
+
+	if (i == CASN_PAGE_V1_COPIES && ret == -EBADMSG) {
+		const void *srcbufs[CASN_PAGE_V1_COPIES];
+		int j;
+
+		for (j = 0; j < CASN_PAGE_V1_COPIES; j++)
+			srcbufs[j] = casn + j;
+		dev_info(dev, "Couldn't find a valid CASN page, try bitwise majority to recover it\n");
+		nanddev_bit_wise_majority(srcbufs, CASN_PAGE_V1_COPIES, casn,
+					  sizeof(*casn));
+		crc_compute = nanddev_crc16(CASN_CRC_BASE, (uint8_t *)casn,
+					    SPINAND_CASN_V1_CRC_OFS);
+		if (crc_compute != crc) {
+			dev_err(dev, "CASN page recovery failed, aborting\n");
+			return -EBADMSG;
+		}
+		ret = spinand_check_casn_validity(spinand, casn + i);
+		if (ret < 0)
+			return ret;
+		dev_info(dev, "CASN page recovery succeeded\n");
+		*sel = 0;
+	}
+
+	return ret;
+}
+
+static int spinand_casn_detect(struct spinand_device *spinand,
+			       struct nand_casn *casn, unsigned int *sel)
+{
+	struct device *dev = &spinand->spimem->spi->dev;
+	uint8_t casn_offset[3] = {0x0, 0x1, 0x4};
+	struct nand_page_io_req req;
+	struct spi_mem_op op;
+	struct nand_pos pos;
+	int check_ret = 0;
+	uint8_t status;
+	int final_ret;
+	int ret = 0;
+	u8 cfg_reg;
+	int i;
+
+	ret = spinand_read_reg_op(spinand, REG_CFG, &cfg_reg);
+	if (ret)
+		return ret;
+
+	ret = spinand_write_reg_op(spinand, REG_CFG, cfg_reg | BIT(6));
+	if (ret)
+		return ret;
+
+	memset(&pos, 0, sizeof(pos));
+
+	req = (struct nand_page_io_req){
+		.pos = pos,
+		.dataoffs = 0,
+		.datalen = 256 * CASN_PAGE_V1_COPIES,
+		.databuf.in = (u8 *)casn,
+		.mode = MTD_OPS_AUTO_OOB,
+	};
+
+	for (i = 0; i < sizeof(casn_offset)/sizeof(uint8_t); i++) {
+		req.pos.page = casn_offset[i];
+		ret = spinand_load_page_op(spinand, &req);
+		if (ret)
+			goto finish;
+
+		ret = spinand_wait(spinand,
+				   SPINAND_READ_INITIAL_DELAY_US,
+				   SPINAND_READ_POLL_DELAY_US,
+				   &status);
+		if (ret < 0)
+			goto finish;
+
+		op = (struct spi_mem_op) SPINAND_PAGE_READ_FROM_CACHE_OP(
+			false, 768, 1, (u8 *)casn, 256 * CASN_PAGE_V1_COPIES);
+		ret = spi_mem_exec_op(spinand->spimem, &op);
+		if (ret < 0)
+			goto finish;
+
+		check_ret = spinand_check_casn(spinand, casn, sel);
+		if (!check_ret)
+			break;
+	}
+
+finish:
+	/* We need to restore configuration register. */
+	final_ret = spinand_write_reg_op(spinand, REG_CFG, cfg_reg);
+	if (final_ret)
+		return final_ret;
+
+	if (check_ret) {
+		dev_err(dev, "CASN page check failed\n");
+		return check_ret;
+	}
+
+	if (ret)
+		dev_err(dev, "CASN page read failed\n");
+
+	return ret;
+}
+
 static int spinand_id_detect(struct spinand_device *spinand)
 {
 	u8 *id = spinand->id.data;
@@ -1180,7 +1478,7 @@ static int spinand_id_detect(struct spinand_device *spinand)
 
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
-	if (spinand->manufacturer->ops->init)
+	if (!spinand->use_casn && spinand->manufacturer->ops->init)
 		return spinand->manufacturer->ops->init(spinand);
 
 	return 0;
@@ -1189,7 +1487,7 @@ static int spinand_manufacturer_init(struct spinand_device *spinand)
 static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
 {
 	/* Release manufacturer private data */
-	if (spinand->manufacturer->ops->cleanup)
+	if (!spinand->use_casn && spinand->manufacturer->ops->cleanup)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
 
@@ -1293,37 +1591,456 @@ int spinand_match_and_init(struct spinand_device *spinand,
 	return -ENOTSUPP;
 }
 
+static int spinand_casn_ooblayout_ecc(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int sectionp;
+	struct CASN_OOB *co = spinand->casn_oob;
+
+	sectionp = spinand->base.memorg.pagesize/mtd->ecc_step_size;
+	if (section >= sectionp)
+		return -ERANGE;
+
+	if (co->layout_type == OOB_DISCRETE) {
+		region->offset = co->ecc_parity_start +
+				 (co->free_length + co->ecc_parity_space)
+				 * section;
+	} else if (co->layout_type == OOB_CONTINUOUS) {
+		region->offset = co->ecc_parity_start + co->ecc_parity_space * section;
+	}
+	region->length = co->ecc_parity_real_length;
+
+	return 0;
+}
+
+static int spinand_casn_ooblayout_free(struct mtd_info *mtd, int section,
+					struct mtd_oob_region *region)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int sectionp;
+	struct CASN_OOB *co = spinand->casn_oob;
+
+	sectionp = spinand->base.memorg.pagesize/mtd->ecc_step_size;
+	if (section >= sectionp)
+		return -ERANGE;
+
+	if (!section) {
+		region->offset = co->free_start + co->bbm_length;
+		region->length = co->free_length - co->bbm_length;
+	} else {
+		if (co->layout_type == OOB_DISCRETE) {
+			region->offset = co->free_start +
+					 (co->free_length +
+					  co->ecc_parity_space) * section;
+		} else if (co->layout_type == OOB_CONTINUOUS) {
+			region->offset = co->free_start +
+					 co->free_length * section;
+		}
+		region->length = co->free_length;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops spinand_casn_ooblayout = {
+	.ecc = spinand_casn_ooblayout_ecc,
+	.free = spinand_casn_ooblayout_free,
+};
+
+static int spinand_set_read_op_variants(struct spinand_device *spinand,
+					struct nand_casn *casn)
+{
+	struct spinand_op_variants casn_read_cache_variants;
+	u16 sdr_read_cap = be16_to_cpu(casn->sdr_read_cap);
+	struct spi_mem_op *read_ops;
+	const struct spi_mem_op *op;
+	int i = 0;
+
+	read_ops = devm_kzalloc(&spinand->spimem->spi->dev,
+				sizeof(struct spi_mem_op) *
+				hweight16(sdr_read_cap),
+				GFP_KERNEL);
+	if (!read_ops)
+		return -ENOMEM;
+
+	if (FIELD_GET(SDR_READ_1_4_4, sdr_read_cap)) {
+		read_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PAGE_READ_FROM_CACHE_QUADIO_OP(
+				casn->sdr_read_1_4_4.addr_nbytes, 0,
+				casn->sdr_read_1_4_4.dummy_nbytes, NULL, 0
+			);
+		i++;
+	}
+	if (FIELD_GET(SDR_READ_1_1_4, sdr_read_cap)) {
+		read_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PAGE_READ_FROM_CACHE_X4_OP(
+				casn->sdr_read_1_1_4.addr_nbytes, 0,
+				casn->sdr_read_1_1_4.dummy_nbytes, NULL, 0
+			);
+		i++;
+	}
+	if (FIELD_GET(SDR_READ_1_2_2, sdr_read_cap)) {
+		read_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PAGE_READ_FROM_CACHE_DUALIO_OP(
+				casn->sdr_read_1_2_2.addr_nbytes, 0,
+				casn->sdr_read_1_2_2.dummy_nbytes, NULL, 0
+			);
+		i++;
+	}
+	if (FIELD_GET(SDR_READ_1_1_2, sdr_read_cap)) {
+		read_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PAGE_READ_FROM_CACHE_X2_OP(
+				casn->sdr_read_1_1_2.addr_nbytes, 0,
+				casn->sdr_read_1_1_2.dummy_nbytes, NULL, 0
+			);
+		i++;
+	}
+	if (FIELD_GET(SDR_READ_1_1_1_FAST, sdr_read_cap)) {
+		read_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PAGE_READ_FROM_CACHE_OP(
+				true, casn->sdr_read_1_1_1_fast.addr_nbytes, 0,
+				casn->sdr_read_1_1_1_fast.dummy_nbytes, NULL, 0
+			);
+		i++;
+	}
+	if (FIELD_GET(SDR_READ_1_1_1, sdr_read_cap)) {
+		read_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PAGE_READ_FROM_CACHE_OP(
+				false, casn->sdr_read_1_1_1.addr_nbytes, 0,
+				casn->sdr_read_1_1_1.dummy_nbytes, NULL, 0
+			);
+		i++;
+	}
+
+	casn_read_cache_variants = (struct spinand_op_variants){
+		.ops = read_ops,
+		.nops = hweight16(sdr_read_cap),
+	};
+
+	op = spinand_select_op_variant(spinand, &casn_read_cache_variants);
+	if (!op) {
+		devm_kfree(&spinand->spimem->spi->dev, read_ops);
+		return -EOPNOTSUPP;
+	}
+	spinand->op_templates.read_cache = op;
+
+	return 0;
+}
+
+static int spinand_set_write_op_variants(struct spinand_device *spinand,
+					 struct nand_casn *casn)
+{
+	struct spinand_op_variants casn_write_cache_variants;
+	struct spi_mem_op *write_ops;
+	const struct spi_mem_op *op;
+	int i = 0;
+
+	write_ops = devm_kzalloc(&spinand->spimem->spi->dev,
+				 sizeof(struct spi_mem_op) *
+				 hweight8(casn->sdr_write_cap),
+				 GFP_KERNEL);
+	if (!write_ops)
+		return -ENOMEM;
+
+	if (FIELD_GET(SDR_WRITE_1_1_4, casn->sdr_write_cap)) {
+		write_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PROG_LOAD_X4(
+				true, casn->sdr_write_1_1_4.addr_nbytes, 0,
+				NULL, 0);
+		i++;
+	}
+	if (FIELD_GET(SDR_WRITE_1_1_1, casn->sdr_write_cap)) {
+		write_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PROG_LOAD(
+				true, casn->sdr_write_1_1_1.addr_nbytes, 0,
+				NULL, 0);
+		i++;
+	}
+
+	casn_write_cache_variants = (struct spinand_op_variants){
+		.ops = write_ops,
+		.nops = hweight8(casn->sdr_write_cap),
+	};
+
+	op = spinand_select_op_variant(spinand, &casn_write_cache_variants);
+	if (!op) {
+		devm_kfree(&spinand->spimem->spi->dev, write_ops);
+		return -EOPNOTSUPP;
+	}
+	spinand->op_templates.write_cache = op;
+
+	return 0;
+}
+
+static int spinand_set_update_op_variants(struct spinand_device *spinand,
+					  struct nand_casn *casn)
+{
+	struct spinand_op_variants casn_update_cache_variants;
+	struct spi_mem_op *update_ops;
+	const struct spi_mem_op *op;
+	int i = 0;
+
+	update_ops = devm_kzalloc(&spinand->spimem->spi->dev,
+				  sizeof(struct spi_mem_op) *
+				  hweight8(casn->sdr_update_cap),
+				  GFP_KERNEL);
+	if (!update_ops)
+		return -ENOMEM;
+
+	if (FIELD_GET(SDR_UPDATE_1_1_4, casn->sdr_update_cap)) {
+		update_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PROG_LOAD_X4(
+				false, casn->sdr_update_1_1_4.addr_nbytes, 0,
+				NULL, 0);
+		i++;
+	}
+	if (FIELD_GET(SDR_UPDATE_1_1_1, casn->sdr_update_cap)) {
+		update_ops[i] = (struct spi_mem_op)
+			SPINAND_CASN_PROG_LOAD(
+				false, casn->sdr_update_1_1_1.addr_nbytes, 0,
+				NULL, 0);
+		i++;
+	}
+
+	casn_update_cache_variants = (struct spinand_op_variants){
+		.ops = update_ops,
+		.nops = hweight8(casn->sdr_update_cap),
+	};
+
+	op = spinand_select_op_variant(spinand, &casn_update_cache_variants);
+	if (!op) {
+		devm_kfree(&spinand->spimem->spi->dev, update_ops);
+		return -EOPNOTSUPP;
+	}
+	spinand->op_templates.update_cache = op;
+
+	return 0;
+}
+
+static int spinand_init_via_casn(struct spinand_device *spinand,
+				 struct nand_casn *casn)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	u32 val;
+	int ret;
+	int i;
+
+	/* Set members of nand->memorg via CASN. */
+	for (i = 0; i < 9; i++) {
+		val = be32_to_cpu(*(&casn->bits_per_cell + i));
+		memcpy((u32 *)&nand->memorg.bits_per_cell + i, &val, sizeof(u32));
+	}
+	nand->ecc.requirements.strength = be32_to_cpu(casn->ecc_strength);
+	nand->ecc.requirements.step_size = be32_to_cpu(casn->ecc_step_size);
+	spinand->flags = casn->flags;
+
+	if (spinand->flags & SPINAND_SUP_ADV_ECC_STATUS) {
+		spinand->eccinfo = (struct spinand_ecc_info) {
+			&spinand_casn_get_ecc_status, &spinand_casn_ooblayout};
+	} else {
+		spinand->eccinfo = (struct spinand_ecc_info) {
+			NULL, &spinand_casn_ooblayout };
+	}
+
+	spinand->advecc_high_ops = devm_kzalloc(&spinand->spimem->spi->dev,
+						sizeof(struct spi_mem_op),
+						GFP_KERNEL);
+	if (!spinand->advecc_high_ops)
+		return -ENOMEM;
+	spinand->advecc_low_ops = devm_kzalloc(&spinand->spimem->spi->dev,
+					       sizeof(struct spi_mem_op),
+					       GFP_KERNEL);
+	if (!spinand->advecc_low_ops)
+		return -ENOMEM;
+	spinand->casn_oob = devm_kzalloc(&spinand->spimem->spi->dev,
+					 sizeof(struct CASN_OOB),
+					 GFP_KERNEL);
+	if (!spinand->casn_oob)
+		return -ENOMEM;
+	spinand->advecc_high = devm_kzalloc(&spinand->spimem->spi->dev,
+					    sizeof(struct CASN_ADVECC),
+					    GFP_KERNEL);
+	if (!spinand->advecc_high)
+		return -ENOMEM;
+	spinand->advecc_low = devm_kzalloc(&spinand->spimem->spi->dev,
+					   sizeof(struct CASN_ADVECC),
+					   GFP_KERNEL);
+	if (!spinand->advecc_low)
+		return -ENOMEM;
+
+	*spinand->advecc_high_ops = (struct spi_mem_op)
+		SPINAND_CASN_ADVECC_OP(casn->ecc_status_high, spinand->scratchbuf);
+	*spinand->advecc_low_ops = (struct spi_mem_op)
+		SPINAND_CASN_ADVECC_OP(casn->ecc_status_low, spinand->scratchbuf);
+
+	memcpy(spinand->casn_oob, &casn->casn_oob, sizeof(struct CASN_OOB));
+
+	spinand->advecc_high->cmd = casn->ecc_status_high.cmd;
+	spinand->advecc_high->mask = be16_to_cpu(casn->ecc_status_high.status_mask);
+	spinand->advecc_high->shift = spinand->advecc_high->mask ?
+				      ffs(spinand->advecc_high->mask)-1 : 0;
+	spinand->advecc_high->pre_op = casn->ecc_status_high.pre_op;
+	spinand->advecc_high->pre_mask = casn->ecc_status_high.pre_mask;
+
+	spinand->advecc_low->cmd = casn->ecc_status_low.cmd;
+	spinand->advecc_low->mask = be16_to_cpu(casn->ecc_status_low.status_mask);
+	spinand->advecc_low->shift = spinand->advecc_low->mask ?
+				     ffs(spinand->advecc_low->mask)-1 : 0;
+	spinand->advecc_low->pre_op = casn->ecc_status_low.pre_op;
+	spinand->advecc_low->pre_mask = casn->ecc_status_low.pre_mask;
+
+	spinand->advecc_low_bitcnt = hweight16(spinand->advecc_low->mask);
+
+	spinand->advecc_noerr_status = casn->advecc_noerr_status;
+	spinand->advecc_uncor_status = casn->advecc_uncor_status;
+	spinand->advecc_post_op = casn->advecc_post_op;
+	spinand->advecc_post_mask = casn->advecc_post_mask;
+	spinand->eccsr_math_op[0] = eccsr_none_op;
+	spinand->eccsr_math_op[1] = eccsr_and_op;
+	spinand->eccsr_math_op[2] = eccsr_add_op;
+	spinand->eccsr_math_op[3] = eccsr_minus_op;
+	spinand->eccsr_math_op[4] = eccsr_mul_op;
+
+	ret = spinand_set_read_op_variants(spinand, casn);
+	if (ret < 0)
+		return ret;
+	ret = spinand_set_write_op_variants(spinand, casn);
+	if (ret < 0)
+		return ret;
+	ret = spinand_set_update_op_variants(spinand, casn);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void spinand_dump_casn(struct spinand_device *spinand, struct nand_casn *casn)
+{
+	int i;
+
+	dev_dbg(&spinand->spimem->spi->dev,
+		"---Start dumping full CASN page---\n");
+	for (i = 0; i < 64; i++)
+		pr_debug("0x%08x", *((u32 *)casn + i));
+
+	pr_debug("** Dump critical fields **\n");
+	pr_debug("signature: 0x%04x\n", be32_to_cpu(casn->signature));
+	pr_debug("version: v%u.%u\n", casn->version >> 4, casn->version & 0xf);
+	pr_debug("[Memory Organization]\n");
+	pr_debug("  bits_per_cell: %d\n", be32_to_cpu(casn->bits_per_cell));
+	pr_debug("  bytes_per_page: %d\n", be32_to_cpu(casn->bytes_per_page));
+	pr_debug("  spare_bytes_per_page: %d\n",
+		 be32_to_cpu(casn->spare_bytes_per_page));
+	pr_debug("  pages_per_block: %d\n",
+		 be32_to_cpu(casn->pages_per_block));
+	pr_debug("  blocks_per_lun: %d\n", be32_to_cpu(casn->blocks_per_lun));
+	pr_debug("  max_bb_per_lun: %d\n", be32_to_cpu(casn->max_bb_per_lun));
+	pr_debug("  planes_per_lun: %d\n", be32_to_cpu(casn->planes_per_lun));
+	pr_debug("  luns_per_target: %d\n",
+		 be32_to_cpu(casn->luns_per_target));
+	pr_debug("  total_target: %d\n", be32_to_cpu(casn->total_target));
+	pr_debug("[flags]\n");
+	pr_debug("  0. Have QE bit? %s\n",
+		casn->flags & SPINAND_HAS_QE_BIT ? "Yes" : "No");
+	pr_debug("  1. Have continuous read feature bit? %s\n",
+		casn->flags & SPINAND_HAS_CR_FEAT_BIT ? "Yes" : "No");
+	pr_debug("  2. Support continuous read? %s\n",
+		casn->flags & SPINAND_SUP_CR ? "Yes" : "No");
+	pr_debug("  3. Support on-die ECC? %s\n",
+		casn->flags & SPINAND_SUP_ON_DIE_ECC ? "Yes" : "No");
+	pr_debug("  4. Support legacy ECC status? %s\n",
+		casn->flags & SPINAND_SUP_LEGACY_ECC_STATUS ? "Yes" : "No");
+	pr_debug("  5. Support advanced ECC status? %s\n",
+		casn->flags & SPINAND_SUP_ADV_ECC_STATUS ? "Yes" : "No");
+	pr_debug("  6. ECC parity readable? %s\n",
+		casn->flags & SPINAND_ECC_PARITY_READABLE ? "Yes" : "No");
+	pr_debug("[R/W ability]\n");
+	pr_debug("  read ability: %x\n", be16_to_cpu(casn->sdr_read_cap));
+	pr_debug("  write ability: %x\n", casn->sdr_write_cap);
+	pr_debug("  update ability: %x\n", casn->sdr_update_cap);
+	pr_debug("advanced ECC no error state: %x\n",
+		 casn->advecc_noerr_status);
+	pr_debug("advecced ECC uncorrectable state: %x\n",
+		 casn->advecc_uncor_status);
+	pr_debug("CRC: 0x%04x\n", be16_to_cpu(casn->crc));
+
+	dev_dbg(&spinand->spimem->spi->dev,
+		"---Dumping full CASN page ends here.---\n");
+}
+
 static int spinand_detect(struct spinand_device *spinand)
 {
-	struct device *dev = &spinand->spimem->spi->dev;
 	struct nand_device *nand = spinand_to_nand(spinand);
+	struct device *dev = &spinand->spimem->spi->dev;
+	struct nand_casn *casn;
+	char manufacturer[14];
+	unsigned int sel = 0;
+	char model[17];
 	int ret;
 
 	ret = spinand_reset_op(spinand);
 	if (ret)
 		return ret;
 
-	ret = spinand_id_detect(spinand);
-	if (ret) {
-		dev_err(dev, "unknown raw ID %*phN\n", SPINAND_MAX_ID_LEN,
-			spinand->id.data);
-		return ret;
+	spinand->use_casn = false;
+	casn = kzalloc((sizeof(struct nand_casn) * CASN_PAGE_V1_COPIES), GFP_KERNEL);
+	if (!casn)
+		return -ENOMEM;
+
+	ret = spinand_casn_detect(spinand, casn, &sel);
+	if (!ret) {
+		spinand->use_casn = true;
+		strscpy(manufacturer, casn[sel].manufacturer, sizeof(manufacturer)-1);
+		sanitize_string(manufacturer, sizeof(manufacturer));
+		strscpy(model, casn[sel].model, sizeof(model)-1);
+		sanitize_string(model, sizeof(model));
+
+		spinand_dump_casn(spinand, casn + sel);
+
+		ret = spinand_init_via_casn(spinand, casn + sel);
+		if (ret)
+			dev_err(dev, "Initializing spinand via CASN fails: %d\n", ret);
+	}
+
+	if (ret < 0) {
+		dev_warn(dev, "Fallback to read ID\n");
+
+		ret = spinand_reset_op(spinand);
+		if (ret)
+			goto free_casn;
+		ret = spinand_id_detect(spinand);
+		if (ret) {
+			dev_err(dev, "unknown raw ID %*phN\n", SPINAND_MAX_ID_LEN,
+				spinand->id.data);
+			goto free_casn;
+		}
 	}
 
 	if (nand->memorg.ntargets > 1 && !spinand->select_target) {
 		dev_err(dev,
 			"SPI NANDs with more than one die must implement ->select_target()\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_casn;
+	}
+
+	if (spinand->use_casn) {
+		dev_info(&spinand->spimem->spi->dev,
+			 "%s %s SPI NAND was found.\n", manufacturer, model);
+	} else {
+		dev_info(&spinand->spimem->spi->dev,
+			 "%s SPI NAND was found.\n", spinand->manufacturer->name);
 	}
 
-	dev_info(&spinand->spimem->spi->dev,
-		 "%s SPI NAND was found.\n", spinand->manufacturer->name);
 	dev_info(&spinand->spimem->spi->dev,
 		 "%llu MiB, block size: %zu KiB, page size: %zu, OOB size: %u\n",
 		 nanddev_size(nand) >> 20, nanddev_eraseblock_size(nand) >> 10,
 		 nanddev_page_size(nand), nanddev_per_page_oobsize(nand));
 
-	return 0;
+free_casn:
+	kfree(casn);
+
+	return ret;
 }
 
 static int spinand_init_flash(struct spinand_device *spinand)
-- 
2.45.2


