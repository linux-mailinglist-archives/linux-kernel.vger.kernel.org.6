Return-Path: <linux-kernel+bounces-303848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BBA9615E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7BA284B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9131D3180;
	Tue, 27 Aug 2024 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="so3Dzeoi"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF71D278D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780994; cv=none; b=a4baY6exNskLxyA8l7lIGQ12an5vIgx4pg++YHCJOKUa/iuntf0U+kUJ6h4A3DJOtjDpqrS4I6tatybeNnSiMIVHGkY69XMHgATfD7FXshE0SJD/ckuQb03I8lXol0yAxha1tqUU3i2f+zO13dM/5RGU6Ll8Mbdr1pQ9tK3QsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780994; c=relaxed/simple;
	bh=u4awTpnV7YURceS3KFqRVbd6JqkfXPzfJETQQiIZRFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Inq1Dw0DessCTBn1f0Hou9qsJ9PihWGjYCRkHK0VmVblYMpYVl8urDeCEE5v6PCW7sOJecpd3T3lel5xhrT3afmOMwJ/iusdaIxvy3+CEfVWCZSDkhwg3gNLluc0zbFNN6wS0C2kFJeDc05h6qQADR09sW4DUg1NqO2KFQqIJfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=so3Dzeoi; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 00D7112000B;
	Tue, 27 Aug 2024 20:49:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 00D7112000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1724780983;
	bh=LMWlmKygHa3RXmldbNnQGuSV4kTMdOw4VTFeO4Tjzbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=so3DzeoiwNbmQ5KGeviXdAduidNrmAhJ/Rj/Th+5paxRQzkQHvFf+erMRvFC7xbz1
	 O2gs+8D7Vyy839aYh75O5TwRC3Una33bDTGWsZU/QzQi2/JTBNc3Te/q88rEGhOgls
	 dY25vIeArZn+FCETjHqZsUjHW0pKj+kgw6cQcXe4V9E1eQGBZu+OVCVCZTg3aSNa+G
	 /wF27n0/1VmIpup5BAFOGrLq60Z4IJHEAaBqrUngnXHzNwA69RfBpjOFlB9yOd8ZSf
	 5UP2aeDl6FddNiwPgwNIbV8sGBorr0tyiYfALo+EnjP6j8fsujkQmt3uhV9MHv7th8
	 y+MHABu3yd/0w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 27 Aug 2024 20:49:42 +0300 (MSK)
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Michael Walle <michael@walle.cc>, "Mark
 Brown" <broonie@kernel.org>, Chia-Lin Kao <acelan.kao@canonical.com>, "Md
 Sadre Alam" <quic_mdalam@quicinc.com>, Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
	<avromanov@salutedevices.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<kernel@salutedevices.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: [PATCH v2 2/5] mtd: spinand: add OTP support
Date: Tue, 27 Aug 2024 20:49:00 +0300
Message-ID: <20240827174920.316756-3-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187372 [Aug 27 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 27 0.3.27 71302da218a62dcd84ac43314e19b5cc6b38e0b6, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/08/27 16:21:00 #26445643
X-KSMG-AntiVirus-Status: Clean, skipped

The MTD subsystem already supports accessing two OTP areas: user and
factory. User areas can be written by the user. This patch only adds
support for the user areas.

In this patch the OTP_INFO macro is provided to add parameters to
spinand_info.
To implement OTP operations, the client (flash driver) is provided with
5 callbacks: .read(), .write(), .info(), .lock(), .erase().

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |   3 +
 drivers/mtd/nand/spi/otp.c    | 232 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |  56 ++++++++
 4 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/otp.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 19cc77288ebbc..60d2e830ffc6b 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
+spinand-objs := core.o otp.o
+spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
 spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 807c24b0c7c4f..2cb825edd49d0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1111,6 +1111,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->otp = &table[i].otp;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1292,6 +1293,8 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
 	mtd->_resume = spinand_mtd_resume;
 
+	spinand_set_mtd_otp_ops(spinand);
+
 	if (nand->ecc.engine) {
 		ret = mtd_ooblayout_count_freebytes(mtd);
 		if (ret < 0)
diff --git a/drivers/mtd/nand/spi/otp.c b/drivers/mtd/nand/spi/otp.c
new file mode 100644
index 0000000000000..d459f811f9c04
--- /dev/null
+++ b/drivers/mtd/nand/spi/otp.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spinand.h>
+
+static unsigned int spinand_otp_npages(const struct spinand_device *spinand)
+{
+	return spinand->otp->layout.npages;
+}
+
+static size_t spinand_otp_size(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	size_t otp_pagesize = nanddev_page_size(nand) +
+			      nanddev_per_page_oobsize(nand);
+
+	return spinand_otp_npages(spinand) * otp_pagesize;
+}
+
+static int spinand_otp_rw(struct spinand_device *spinand, loff_t ofs,
+			  size_t len, u8 *buf, size_t *retlen, bool is_write)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct nand_page_io_req req = { 0 };
+	unsigned long long page;
+	size_t copied = 0;
+	size_t otp_pagesize = nanddev_page_size(nand) +
+			      nanddev_per_page_oobsize(nand);
+	int ret = 0;
+
+	page = ofs;
+	req.dataoffs = do_div(page, otp_pagesize);
+	req.pos.page = page;
+	req.type = is_write ? NAND_PAGE_WRITE : NAND_PAGE_READ;
+	req.mode = MTD_OPS_RAW;
+	req.databuf.in = buf;
+
+	while (copied < len && req.pos.page < spinand_otp_npages(spinand)) {
+		req.datalen = min_t(unsigned int,
+				    otp_pagesize - req.dataoffs,
+				    len - copied);
+
+		if (is_write)
+			ret = spinand_write_page(spinand, &req);
+		else
+			ret = spinand_read_page(spinand, &req);
+
+		if (ret < 0)
+			break;
+
+		req.dataoffs = 0;
+		copied += req.datalen;
+		req.pos.page++;
+	}
+
+	*retlen = copied;
+
+	return ret;
+}
+
+/**
+ * spinand_otp_read() - Read from OTP area
+ * @spinand: the spinand device
+ * @ofs: the offset to read
+ * @len: the number of data bytes to read
+ * @buf: the buffer to store the read data
+ * @retlen: the pointer to variable to store the number of read bytes
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_otp_read(struct spinand_device *spinand, loff_t ofs, size_t len,
+		     u8 *buf, size_t *retlen)
+{
+	return spinand_otp_rw(spinand, ofs, len, buf, retlen, false);
+}
+
+/**
+ * spinand_otp_write() - Write to OTP area
+ * @spinand:  the spinand device
+ * @ofs: the offset to write to
+ * @len: the number of bytes to write
+ * @buf: the buffer with data to write
+ * @retlen: the pointer to variable to store the number of written bytes
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+int spinand_otp_write(struct spinand_device *spinand, loff_t ofs, size_t len,
+		      const u8 *buf, size_t *retlen)
+{
+	return spinand_otp_rw(spinand, ofs, len, (u8 *)buf, retlen, true);
+}
+
+static int spinand_otp_check_bounds(struct spinand_device *spinand, loff_t ofs,
+				    size_t len)
+{
+	if (ofs < 0 || ofs + len > spinand_otp_size(spinand))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int spinand_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_otp_ops *ops = spinand->otp->ops;
+	int ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->info(spinand, len, buf, retlen);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_otp_rw(struct mtd_info *mtd, loff_t ofs, size_t len,
+			      size_t *retlen, u8 *buf, bool is_write)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_otp_ops *ops = spinand->otp->ops;
+	int ret;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, CFG_OTP_ENABLE);
+	if (ret)
+		goto out_unlock;
+
+	if (is_write)
+		ret = ops->write(spinand, ofs, len, buf, retlen);
+	else
+		ret = ops->read(spinand, ofs, len, buf, retlen);
+
+	if (spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0)) {
+		pr_warn(1, "Can not disable OTP mode\n");
+		ret = -EIO;
+	}
+
+out_unlock:
+	mutex_unlock(&spinand->lock);
+	return ret;
+}
+
+static int spinand_mtd_otp_read(struct mtd_info *mtd, loff_t ofs, size_t len,
+				size_t *retlen, u8 *buf)
+{
+	return spinand_mtd_otp_rw(mtd, ofs, len, retlen, buf, false);
+}
+
+static int spinand_mtd_otp_write(struct mtd_info *mtd, loff_t ofs, size_t len,
+				 size_t *retlen, const u8 *buf)
+{
+	return spinand_mtd_otp_rw(mtd, ofs, len, retlen, (u8 *)buf, true);
+}
+
+static int spinand_mtd_otp_erase(struct mtd_info *mtd, loff_t ofs, size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_otp_ops *ops = spinand->otp->ops;
+	int ret;
+
+	if (!ops->erase)
+		return -EOPNOTSUPP;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->erase(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+static int spinand_mtd_otp_lock(struct mtd_info *mtd, loff_t ofs, size_t len)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	const struct spinand_otp_ops *ops = spinand->otp->ops;
+	int ret;
+
+	if (!ops->lock)
+		return -EOPNOTSUPP;
+
+	if (!len)
+		return 0;
+
+	ret = spinand_otp_check_bounds(spinand, ofs, len);
+	if (ret)
+		return ret;
+
+	mutex_lock(&spinand->lock);
+	ret = ops->lock(spinand, ofs, len);
+	mutex_unlock(&spinand->lock);
+
+	return ret;
+}
+
+/**
+ * spinand_set_mtd_otp_ops() - Set up OTP methods
+ * @spinand: the spinand device
+ *
+ * Set up OTP methods.
+ */
+void spinand_set_mtd_otp_ops(struct spinand_device *spinand)
+{
+	struct mtd_info *mtd = spinand_to_mtd(spinand);
+
+	if (!spinand->otp->ops)
+		return;
+
+	mtd->_get_user_prot_info = spinand_mtd_otp_info;
+	mtd->_read_user_prot_reg = spinand_mtd_otp_read;
+	mtd->_write_user_prot_reg = spinand_mtd_otp_write;
+	mtd->_lock_user_prot_reg = spinand_mtd_otp_lock;
+	mtd->_erase_user_prot_reg = spinand_mtd_otp_erase;
+}
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 555846517faf6..8099f35f0e051 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -322,6 +322,43 @@ struct spinand_ondie_ecc_conf {
 	u8 status;
 };
 
+/**
+ * struct spinand_otp_layout - structure to describe the SPI NAND OTP area
+ * @npages: number of pages in the OTP
+ */
+struct spinand_otp_layout {
+	unsigned int npages;
+};
+
+/**
+ * struct spinand_otp_ops - SPI NAND OTP methods
+ * @info: Get the OTP area information
+ * @lock: lock an OTP region
+ * @erase: erase an OTP region
+ * @read: read from the SPI NAND OTP area
+ * @write: write to the SPI NAND OTP area
+ */
+struct spinand_otp_ops {
+	int (*info)(struct spinand_device *spinand, size_t len,
+		    struct otp_info *buf, size_t *retlen);
+	int (*lock)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*erase)(struct spinand_device *spinand, loff_t from, size_t len);
+	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
+		    u8 *buf, size_t *retlen);
+	int (*write)(struct spinand_device *spinand, loff_t from, size_t len,
+		     const u8 *buf, size_t *retlen);
+};
+
+/**
+ * struct spinand_otp - SPI NAND OTP grouping structure
+ * @layout: OTP region layout
+ * @ops: OTP access ops
+ */
+struct spinand_otp {
+	const struct spinand_otp_layout layout;
+	const struct spinand_otp_ops *ops;
+};
+
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
  * @model: model name
@@ -354,6 +391,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	struct spinand_otp otp;
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +417,14 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_OTP_INFO(__npages, __ops)				\
+	.otp = {							\
+		.layout = {						\
+			.npages = __npages,				\
+		},							\
+		.ops = __ops,						\
+	}
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -422,6 +468,7 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @otp: SPI NAND OTP info.
  * @priv: manufacturer private data
  */
 struct spinand_device {
@@ -450,6 +497,7 @@ struct spinand_device {
 	u8 *oobbuf;
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
+	const struct spinand_otp *otp;
 	void *priv;
 };
 
@@ -525,4 +573,12 @@ int spinand_read_page(struct spinand_device *spinand,
 int spinand_write_page(struct spinand_device *spinand,
 		       const struct nand_page_io_req *req);
 
+void spinand_set_mtd_otp_ops(struct spinand_device *spinand);
+
+int spinand_otp_read(struct spinand_device *spinand, loff_t ofs, size_t len,
+		     u8 *buf, size_t *retlen);
+
+int spinand_otp_write(struct spinand_device *spinand, loff_t ofs, size_t len,
+		      const u8 *buf, size_t *retlen);
+
 #endif /* __LINUX_MTD_SPINAND_H */
-- 
2.43.2


