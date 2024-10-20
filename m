Return-Path: <linux-kernel+bounces-373253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5649A5459
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3011C20D33
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447B1192D73;
	Sun, 20 Oct 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jpyzAVCH"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2EF178372
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430930; cv=none; b=punMosKJziFF5FmUxZKfwRUHelQqaVchGVy2PhstQwhCQJEODKChBC+x8Mc9ijKipCaWKJt7ZoGjsITlcOyTWWUKZkJSLRMDkNVQw/Kp8u7G7KJWsr3cb0P3L4vIz2WlL190PtwbRyUM1vlKPRD/Dz/YMoZ1mkEcfx0Bltzw9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430930; c=relaxed/simple;
	bh=7Hk2wBpYm1bEYEDi8D/w8p85p7kOvvVUUA9tuUvbRWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqZHeQw6jCGfmtxL25BNLZxOyrZ8w482KW40GAcMlB4C51YPJmTnqcjkFa5QfgybZTx7tZG0WXgf9i6gwGEcl6I+/5rHHYf0Fht6HmTjD6T7Vwr3dVoqnjnuk9/ug1x3KnVefuSiUokhziLMTMVKl+cXs789Ctsq1hteUuK1AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jpyzAVCH; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3ae223e48ee711efb88477ffae1fc7a5-20241020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2G1oHhlieHVhAY567gkNMmzlsnu2+sPvTe7p5o7ZsNk=;
	b=jpyzAVCHpGKDVyz8vX5qobQk0Iy/BG/4AZxBSHZzpLF6NiWwCoPA1CY3Jgz8U5ZOfSsT0tvaXCY0kvBTQyH4yyAsk0IzDtkEbXhTw6x8s1L3mIpnt7G0FNjZ2FfeG/Fbv8eVkJRfwYBftE6e+ARw0CE1OTGhow+KHp60/tUgeWo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:f4d8e727-18f6-44b8-b3cf-f3a23d0ea666,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:94255925-9cd9-4037-af6e-f4241b90f84d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3ae223e48ee711efb88477ffae1fc7a5-20241020
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2108882854; Sun, 20 Oct 2024 21:28:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 20 Oct 2024 21:28:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 20 Oct 2024 21:28:42 +0800
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
Subject: [RFC PATCH nand/next 3/4] include: mtd: spinand: Add CASN page related macros and flags.
Date: Sun, 20 Oct 2024 21:27:21 +0800
Message-ID: <20241020132722.20565-4-SkyLake.Huang@mediatek.com>
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
X-TM-AS-Result: No-10--2.446200-8.000000
X-TMASE-MatchedRID: oCsWEly1aNNM4VjZ76ar2LMjW/sniEQKmX+W7bzPOQF+YesuCgkiXJpx
	JPA5ZIe+2lO9wdJIjwWwYEHOVohSR8a1KU/oEEOPogGd8wIUGIJo3Yq5PCwLAhL6MU7t349bo7e
	vliYi17DYcB744kzEdqnConkZyCes/Y8bXtyBbJB0CDjJ3XioBPBkYT/50xzWf7dwGsQvXvzIrf
	3gn7w8oqP8wcVXpl7OgzXM/1S8rGibGHSBj+j5Wd35+5/2RxqmCv3j7wdXxBibKItl61J/yZ+in
	TK0bC9eKrauXd3MZDX371moSn0VOL9msMtG43RP5Oy4n7TTsM8D5mBwNiJFK4Dro/jMlndlBrNs
	Id/ubdefkcesyQmuoXXWg7RXgpNfEi71zuMNe2ygzDosNXeeAhdGg+ZY7eN6THB2Q+oKru8MTI3
	4nyF36MJL1aANdU8Knqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.446200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	7EF0422110CF8F2371BA6587828AFCBCFFF5F5E629928B88ECDE63BE23BB0CB12000:8
X-MTK: N

From: "Sky Huang" <skylake.huang@mediatek.com>

This patch adds SPINAND CASN page manipulation macros for
SPI-NAND driver to use. Also, some important flag bits, like
SPINAND_SUPR_CR(continuous read), are added to show the
SPI-NAND device's capability.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 include/linux/mtd/spinand.h | 100 +++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 702e5fb13dae..de97994c357b 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -62,6 +62,59 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_NO_DATA)
 
+/* Macros for CASN */
+#define SPINAND_CASN_PAGE_READ_FROM_CACHE_OP(fast, naddr, addr, ndummy, buf, len) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
+		   SPI_MEM_OP_ADDR(naddr, addr, 1),			\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1))
+
+#define SPINAND_CASN_PAGE_READ_FROM_CACHE_X2_OP(naddr, addr, ndummy, buf, len)	\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),			\
+		   SPI_MEM_OP_ADDR(naddr, addr, 1),			\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 2))
+
+#define SPINAND_CASN_PAGE_READ_FROM_CACHE_DUALIO_OP(naddr, addr, ndummy, buf, len)	\
+		SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),			\
+			   SPI_MEM_OP_ADDR(naddr, addr, 2),			\
+			   SPI_MEM_OP_DUMMY(ndummy, 2),			\
+			   SPI_MEM_OP_DATA_IN(len, buf, 2))
+
+#define SPINAND_CASN_PAGE_READ_FROM_CACHE_X4_OP(naddr, addr, ndummy, buf, len)	\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
+		   SPI_MEM_OP_ADDR(naddr, addr, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 4))
+
+#define SPINAND_CASN_PAGE_READ_FROM_CACHE_QUADIO_OP(naddr, addr, ndummy, buf, len)	\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
+		   SPI_MEM_OP_ADDR(naddr, addr, 4),				\
+		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
+		   SPI_MEM_OP_DATA_IN(len, buf, 4))
+
+#define SPINAND_CASN_PROG_LOAD(reset, naddr, addr, buf, len)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x02 : 0x84, 1),		\
+		   SPI_MEM_OP_ADDR(naddr, addr, 1),				\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(len, buf, 1))
+
+#define SPINAND_CASN_PROG_LOAD_X4(reset, naddr, addr, buf, len)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x32 : 0x34, 1),		\
+		   SPI_MEM_OP_ADDR(naddr, addr, 1),				\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
+
+#define SPINAND_CASN_ADVECC_OP(casn_adv_ecc_status, buf)			\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(casn_adv_ecc_status.cmd, 1),			\
+		   SPI_MEM_OP_ADDR(casn_adv_ecc_status.addr_nbytes,		\
+				   casn_adv_ecc_status.addr,			\
+				   casn_adv_ecc_status.addr_buswidth),		\
+		   SPI_MEM_OP_DUMMY(casn_adv_ecc_status.dummy_nbytes,		\
+				    casn_adv_ecc_status.dummy_buswidth),	\
+		   SPI_MEM_OP_DATA_IN(casn_adv_ecc_status.status_nbytes, buf, 1))
+/* Macros for CASN end */
+
 #define SPINAND_PAGE_READ_FROM_CACHE_OP(fast, addr, ndummy, buf, len)	\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
@@ -312,8 +365,11 @@ struct spinand_ecc_info {
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
-#define SPINAND_HAS_PROG_PLANE_SELECT_BIT		BIT(2)
-#define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)
+#define SPINAND_SUP_CR			BIT(2)
+#define SPINAND_SUP_ON_DIE_ECC		BIT(3)
+#define SPINAND_SUP_LEGACY_ECC_STATUS	BIT(4)
+#define SPINAND_SUP_ADV_ECC_STATUS	BIT(5)
+#define SPINAND_ECC_PARITY_READABLE	BIT(6)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
@@ -406,6 +462,28 @@ struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
+/**
+ * struct CASN_ADVECC - CASN's advanced ECC description
+ * @cmd: Command to access SPI-NAND on-chip ECC status registers
+ * @mask: Mask to access SPI-NAND on-chip ECC status registers.
+ *	  ADV_ECC_STATUS->status_nbytes | CASN_ADVECC->mask
+ *			1		|      0 to 0xff
+ *			2		|     0 to 0xffff
+ * @shift: How many bits to shift to get on-chip ECC status
+ * @pre_op: This comes from CASN page's ADV_ECC_STATUS's pre_op.
+ *	    After reading on-chip ECC status, we need to do some math
+ *	    operations if this is specified.
+ * @pre_mask: This comes from CASN page's ADV_ECC_STATUS's pre_mask.
+ *	      This is used in companion with pre_op above.
+ */
+struct CASN_ADVECC {
+	u8 cmd;
+	u16 mask;
+	u8 shift;
+	u8 pre_op;
+	u8 pre_mask;
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -464,6 +542,23 @@ struct spinand_device {
 	u8 *oobbuf;
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
+
+	bool use_casn;
+	struct nand_casn *casn;
+	struct spi_mem_op *advecc_high_ops; /* ops to read higher part of advanced ECC status*/
+	struct spi_mem_op *advecc_low_ops;
+	struct CASN_OOB *casn_oob;
+	struct CASN_ADVECC *advecc_high;
+	struct CASN_ADVECC *advecc_low;
+
+	u8 advecc_low_bitcnt;
+	u8 advecc_noerr_status;
+	u8 advecc_uncor_status;
+	u8 advecc_post_op;
+	u8 advecc_post_mask;
+
+	size_t (*eccsr_math_op[4])(size_t, size_t);
+
 	void *priv;
 
 	bool cont_read_possible;
@@ -539,3 +634,4 @@ int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int target);
 
 #endif /* __LINUX_MTD_SPINAND_H */
+
-- 
2.45.2


