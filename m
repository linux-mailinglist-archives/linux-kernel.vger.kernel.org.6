Return-Path: <linux-kernel+bounces-414066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72DA9D2297
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77CC1F22DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083A19AD8B;
	Tue, 19 Nov 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r3NghBTb"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47E19B59C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009201; cv=none; b=aNlnaYyfZXPyE/F+zWxt9HKdrB5o3jEOklGvTU1t4SNK4nXfFJaalm2AolV6R1a/qS7N1rEbD4q2bDw6stAS7Fxvt1e6PCSbUzffCqFODYgAt2dwlzHRMiTMfWAVatUAM1MQGLJOrB8Kz8/yIo6H562cS4EpUi783vNCcbHKMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009201; c=relaxed/simple;
	bh=+Otzp0MOV8YpCaDQo+tJyOd8mMvAwexU5Hn6htmtJZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O0JqB9LCZcIRAlWtAIPZWu6BK9uu3NYdy1xEF/2ltkB7Kw1Lk4GCBk64krXaK/4C1ApZ3QpO0LYa1gn6lADdHU+g5i0YIe/0JalhGXXRgr0ArZKUUFBROkLY6MQhHp2uicmQl5gCo0ne/nmrHggwwsC2qDvjRtI+V9vUt44CobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r3NghBTb; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3a9696eca65a11ef99858b75a2457dd9-20241119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LyU2YPdB1kr8XxqEwlHtntSAmk6XMOArrT5KicpwMfQ=;
	b=r3NghBTbFN4VIIDC1hSjmkjRgnisFAlw255pkVMWhmC0cLg/e4JN8n+R6Vobs62LvbrFwMEX0OpqZLNIoV3yzFrMSFpXQF5ob+aX25aLQuWzNvWIkiK2ZxWLApxObfeO2yojc4BcLIeyNP2pw6IaalrfVNwWNDle5yB4GSS9HdM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:2cf9840c-2212-4b14-9e2d-be760955b042,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:464815b,CLOUDID:457e5207-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3a9696eca65a11ef99858b75a2457dd9-20241119
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1059109493; Tue, 19 Nov 2024 17:39:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Nov 2024 17:39:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Nov 2024 17:39:50 +0800
From: Sky Huang <SkyLake.Huang@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle
	<daniel@makrotopia.org>, Chia-Lin Kao <acelan.kao@canonical.com>, "Cheng Ming
 Lin" <chengminglin@mxic.com.tw>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Pratyush Yadav <pratyush@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
CC: Steven Liu <Steven.Liu@mediatek.com>, Sky Huang
	<skylake.huang@mediatek.com>
Subject: [PATCH nand/next] mtd: nand: spi: Use write_cache first and then update_cache in write operation
Date: Tue, 19 Nov 2024 17:39:49 +0800
Message-ID: <20241119093949.3014-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.994400-8.000000
X-TMASE-MatchedRID: Grs8OcNgfTYAc7Km7SS5rLMjW/sniEQKZj7cdTNjJqrSson97gLrTB9f
	0PZQRw85DwLdtHQx/o9yKzLF6OyLjjHoq5wq7Ry6A5rdNgLWPkIz9evPqUqyggJJmsCdNLQG9wE
	vJvmkUrYXgylTWKbaIoLit5KSZa4MDnEaSBk1PhBbuDP8ZuCmXp3n0rxnhHdW33Nl3elSfsr/iO
	OUPB/h/jn/lGhGJBfpjjA42R3Nyx008UV4fwLv3+G5dRZCgxC3c3ewuwbSaG6iXe5nNnUYt4E+B
	y7AERtbwX0f1lPumDh+6n5OByhL/2Z3TdeUr6dv5O5PclyYqqp9LQinZ4QefPcjNeVeWlqY+gtH
	j7OwNO2J8YJgRrgXF0PMs1c7EX2ofGtDRuVm5TUST3X2z7WLVb3I6B4tbPu2
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.994400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0FD9FABFDC989E24D22AF3B9448F7958B296713C98C66F5D0B7AFD44AF1603992000:8
X-MTK: N

From: Sky Huang <skylake.huang@mediatek.com>

According to discussion with Miquel Raynal <miquel.raynal@bootlin.com>
and Chuanhong Guo <gch981213@gmail.com> on FORESEE F35SQA002G patch,
Chuanhong recommmends that we can use the following sequence in
spinand_write_to_cache_op():

x1 mode:
02H(program data load) -> 84H(random program data load) -> 84H ...

x4 mode:
32H(program data load x4) -> 34H(random program data load x4) -> 34H ...

02H or 32H commands will clear cache buffer on SPI-NAND and load
data to it. For those SPI controllers which can't finish transmission
in single step, 84H or 34H will be triggered for the rest data.

We observe that some current SPI-NANDs, including FORESEE F35SQA001G and
F35SQA002G, must use 02H or 32H to reset cache buffer in flash before
using 84H or 34H. Or users may encounter program failure issue. This issue
is not always reproducible, but it may occur and cause system instability.

This sequence should work on all SPI-NANDs nowadays. I also check with
Foresee that the sequence can solve the above program failure issue.

On my test platform (MT7988), SPI driver is drivers/spi/spi-mt65xx.c.
And I limit MTK_SPI_IPM_PACKET_SIZE to SZ_1K to simulate lightweight SPI
controller which can only transmit 1024 bytes.

The test step is the following:
- mtd erase /dev/mtd2
- dd if=/dev/zero bs=2048 count=1 | tr '\0' '\xA5' > output.bin
- mtd write output.bin /dev/mtd2

Before applying this patch, write operation uses only 34H(update_cache):
[78.937720] OP code: 0x34, addr val: 0x0, data nbytes: 1020, data 1st byte: 0xa5
[78.945297] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st byte: 0xa5
[78.954251] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byte: 0xa5
[78.962966] OP code: 0x10, addr val: 0x300
[78.968816] OP code: 0x34, addr val: 0x0, data nbytes: 1020, data 1st byte: 0xff
[78.977233] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st byte: 0xff
[78.985124] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byte: 0xff
[78.992527] OP code: 0x10, addr val: 0x301
[78.996981] OP code: 0x34, addr val: 0x0, data nbytes: 1020, data 1st byte: 0xff
[79.004416] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st byte: 0xff
[79.012031] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byte: 0xff
[79.019435] OP code: 0x10, addr val: 0x302
...

After applying this patch, write operation will use 32H and then 34H:
[ 5380.911269] OP code: 0x32, addr val: 0x0, data nbytes: 1020, data 1st byte: 0xa5
[ 5380.918889] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st byte: 0xa5
[ 5380.927836] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byte: 0xa5
[ 5380.936558] OP code: 0x10, addr val: 0x300
[ 5380.942411] OP code: 0x32, addr val: 0x0, data nbytes: 1020, data 1st byte: 0xff
[ 5380.950831] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st byte: 0xff
[ 5380.958722] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byte: 0xff
[ 5380.966129] OP code: 0x10, addr val: 0x301
[ 5380.970376] OP code: 0x32, addr val: 0x0, data nbytes: 1020, data 1st byte: 0xff
[ 5380.977810] OP code: 0x34, addr val: 0x3fc, data nbytes: 1020, data 1st byte: 0xff
[ 5380.985424] OP code: 0x34, addr val: 0x7f8, data nbytes: 72, data 1st byte: 0xff
[ 5380.992826] OP code: 0x10, addr val: 0x302
...

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
 drivers/mtd/nand/spi/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b1df7f627161..351bd14d8e06 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -506,7 +506,10 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 		nbytes -= ret;
 		column += ret;
 		buf += ret;
+
+		wdesc->info.op_tmpl = *spinand->op_templates.update_cache;
 	}
+	wdesc->info.op_tmpl = *spinand->op_templates.write_cache;
 
 	return 0;
 }
@@ -1037,7 +1040,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
-	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl = *spinand->op_templates.write_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1060,7 +1063,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 		return 0;
 	}
 
-	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.op_tmpl = *spinand->op_templates.write_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
-- 
2.45.2


