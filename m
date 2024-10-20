Return-Path: <linux-kernel+bounces-373252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82A9A5458
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BA11C20B22
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C3192D73;
	Sun, 20 Oct 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WldJ++BG"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B0B674
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430921; cv=none; b=l5Lc7FDV4L4fSssonKgfvtY5WLAKqGLNGjfq0t+dJDZcR66IH2y8ThwqNv61/bdCrUYn3wP0uRQhdt51fN2nf+zoHpsYNMKFpxjNG3e8kDHxxwXjZRP1doi44B+hG2hrio6/2SmPVjkiJgdRdXvVGmYrBeZYPOcpcqAqFxRgbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430921; c=relaxed/simple;
	bh=F10NV8Mm0rSSx0vO59N28DC9rjRiUF3fSnPwl/i0Xmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9nBGR3sHCpnVyGr2Jhzee0KP8gVWB6mAWrJVzFpYmuy4JZgPpMXmxF4SZa378okDvVYIoly/GSPS7KIkTDCYsVAnM3aNyrBLqTk4By+GN0EJ7R4gnu6zEX/wOWIIawmJpX3tg6wAHhWRUOtGu1kLHjDzJzU9XjEaOkcrrTRPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WldJ++BG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3299278c8ee711efb88477ffae1fc7a5-20241020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u4Q+MpwvDdBjqr/mZ0lChqQSwuAsSECFSr3oxS9NmH4=;
	b=WldJ++BGMIeqr7QJZLXsYfFpempzCIrhA07pdDrI7FO7eS8EAP9rMkb/CxMo9BOR6n1EzamikZ6fnVonM5Ghvs7et9p1mEDuFvf9UExHzIYduQeggV6SJ5rxQz9tGxDQW4R8tj7UOq+m1h5H847mxqdrS1aCrZZaxWtXw5HP8uk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:bd26795f-542e-4c15-ba61-2835e2966dfb,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:1fbf130d-1043-475c-b800-3262c01ea3e5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 3299278c8ee711efb88477ffae1fc7a5-20241020
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 54362067; Sun, 20 Oct 2024 21:28:30 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 20 Oct 2024 21:28:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 20 Oct 2024 21:28:29 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle
	<daniel@makrotopia.org>, Chia-Lin Kao <acelan.kao@canonical.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Cheng Ming Lin
	<chengminglin@mxic.com.tw>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [RFC PATCH nand/next 2/4] include: mtd: Add CASN page definition and related structs.
Date: Sun, 20 Oct 2024 21:27:20 +0800
Message-ID: <20241020132722.20565-3-SkyLake.Huang@mediatek.com>
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
X-MTK: N

From: "Sky Huang" <skylake.huang@mediatek.com>

This patch adds CASN page definition. You can see corresponding
table in CASN page application note referred in cover letter.
(https://github.com/mtk-openwrt/doc/blob/
main/CASN%20Page%20Introduction.pdf)

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 include/linux/mtd/casn.h | 191 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100644 include/linux/mtd/casn.h

diff --git a/include/linux/mtd/casn.h b/include/linux/mtd/casn.h
new file mode 100644
index 000000000000..65ebd23c17c1
--- /dev/null
+++ b/include/linux/mtd/casn.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 - Mediatek
+ *
+ * Author: Sky Huang <SkyLake.Huang@mediatek.com>
+ */
+
+#ifndef __LINUX_MTD_CASN_H
+#define __LINUX_MTD_CASN_H
+
+#define CASN_CRC_BASE	0x4341
+#define CASN_SIGNATURE	0x4341534EU
+#define SPINAND_CASN_V1_CRC_OFS (254)
+#define CASN_PAGE_V1_COPIES     (3)
+
+#define SDR_READ_1_1_1		BIT(0)
+#define SDR_READ_1_1_1_FAST	BIT(1)
+#define SDR_READ_1_1_2		BIT(2)
+#define SDR_READ_1_2_2		BIT(3)
+#define SDR_READ_1_1_4		BIT(4)
+#define SDR_READ_1_4_4		BIT(5)
+#define SDR_READ_1_1_8		BIT(6)
+#define SDR_READ_1_8_8		BIT(7)
+
+#define SDR_WRITE_1_1_1		BIT(0)
+#define SDR_WRITE_1_1_4		BIT(1)
+
+#define SDR_UPDATE_1_1_1	BIT(0)
+#define SDR_UPDATE_1_1_4	BIT(1)
+
+struct op_slice {
+	u8 cmd_opcode;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8 dummy_nbytes : 4;
+	u8 addr_nbytes : 4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 addr_nbytes : 4;
+	u8 dummy_nbytes : 4;
+#endif
+};
+
+struct SPINAND_FLAGS {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	u8 has_qe_bit : 1;
+	u8 has_cr_feat_bit : 1;
+	u8 conti_read_cap : 1;
+	u8 on_die_ecc : 1;
+	u8 legacy_ecc_status : 1;
+	u8 adv_ecc_status : 1;
+	u8 ecc_parity_readable : 1;
+	u8 ecc_alg : 1; /* ECC algorithm */
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	u8 ecc_alg : 1; /* ECC algorithm */
+	u8 ecc_parity_readable : 1;
+	u8 adv_ecc_status : 1;
+	u8 legacy_ecc_status : 1;
+	u8 on_die_ecc : 1;
+	u8 conti_read_cap : 1;
+	u8 has_cr_feat_bit : 1;
+	u8 has_qe_bit : 1;
+#endif
+};
+
+struct ADV_ECC_STATUS {
+	u8 cmd;
+	u8 addr;
+	u8 addr_nbytes;
+	u8 addr_buswidth;
+	u8 dummy_nbytes;
+	u8 dummy_buswidth;
+	u8 status_nbytes;
+	u16 status_mask;
+	u8 pre_op; /* pre-process operator */
+	u8 pre_mask; /* pre-process mask */
+} __packed;
+
+struct CASN_OOB {
+	u8 layout_type;
+
+	/* OOB free layout */
+	u8 free_start;
+	u8 free_length;
+	u8 bbm_length;
+
+	/* ECC parity layout */
+	u8 ecc_parity_start;
+	u8 ecc_parity_space;
+	u8 ecc_parity_real_length;
+};
+
+enum oob_overall {
+	OOB_DISCRETE = 0,
+	OOB_CONTINUOUS,
+};
+
+struct nand_casn {
+	/* CASN signature must be 4 chars: 'C','A','S','N'  */
+	union {
+		u8 sig[4];
+		u32 signature;
+	};
+
+	u8 version;
+	char manufacturer[13];
+	char model[16];
+
+	__be32 bits_per_cell;
+	__be32 bytes_per_page;
+	__be32 spare_bytes_per_page;
+	__be32 pages_per_block;
+	__be32 blocks_per_lun;
+	__be32 max_bb_per_lun;
+	__be32 planes_per_lun;
+	__be32 luns_per_target;
+	__be32 total_target;
+
+	__be32 ecc_strength;
+	__be32 ecc_step_size;
+
+	u8 flags;
+	u8 reserved1;
+
+	__be16 sdr_read_cap;
+	struct op_slice sdr_read_1_1_1;
+	struct op_slice sdr_read_1_1_1_fast;
+	struct op_slice sdr_read_1_1_2;
+	struct op_slice sdr_read_1_2_2;
+	struct op_slice sdr_read_1_1_4;
+	struct op_slice sdr_read_1_4_4;
+	struct op_slice sdr_read_1_1_8;
+	struct op_slice sdr_read_1_8_8;
+
+	struct op_slice sdr_cont_read_1_1_1;
+	struct op_slice sdr_cont_read_1_1_1_fast;
+	struct op_slice sdr_cont_read_1_1_2;
+	struct op_slice sdr_cont_read_1_2_2;
+	struct op_slice sdr_cont_read_1_1_4;
+	struct op_slice sdr_cont_read_1_4_4;
+	struct op_slice sdr_cont_read_1_1_8;
+	struct op_slice sdr_cont_read_1_8_8;
+
+	__be16 ddr_read_cap;
+	struct op_slice ddr_read_1_1_1;
+	struct op_slice ddr_read_1_1_1_fast;
+	struct op_slice ddr_read_1_1_2;
+	struct op_slice ddr_read_1_2_2;
+	struct op_slice ddr_read_1_1_4;
+	struct op_slice ddr_read_1_4_4;
+	struct op_slice ddr_read_1_1_8;
+	struct op_slice ddr_read_1_8_8;
+
+	struct op_slice ddr_cont_read_1_1_1;
+	struct op_slice ddr_cont_read_1_1_1_fast;
+	struct op_slice ddr_cont_read_1_1_2;
+	struct op_slice ddr_cont_read_1_2_2;
+	struct op_slice ddr_cont_read_1_1_4;
+	struct op_slice ddr_cont_read_1_4_4;
+	struct op_slice ddr_cont_read_1_1_8;
+	struct op_slice ddr_cont_read_1_8_8;
+
+	u8 sdr_write_cap;
+	struct op_slice sdr_write_1_1_1;
+	struct op_slice sdr_write_1_1_4;
+	struct op_slice reserved2[6];
+	u8 ddr_write_cap;
+	struct op_slice reserved3[8];
+
+	u8 sdr_update_cap;
+	struct op_slice sdr_update_1_1_1;
+	struct op_slice sdr_update_1_1_4;
+	struct op_slice reserved4[6];
+	u8 ddr_update_cap;
+	struct op_slice reserved5[8];
+
+	struct CASN_OOB casn_oob;
+
+	/* Advanced ECC status CMD0 (higher bits) */
+	struct ADV_ECC_STATUS ecc_status_high;
+	/* Advanced ECC status CMD1 (lower bits) */
+	struct ADV_ECC_STATUS ecc_status_low;
+
+	u8 advecc_noerr_status;
+	u8 advecc_uncor_status;
+	u8 advecc_post_op;
+	u8 advecc_post_mask;
+
+	u8 reserved6[5];
+	__be16 crc;
+} __packed;
+
+#endif /* __LINUX_MTD_CASN_H */
-- 
2.45.2


