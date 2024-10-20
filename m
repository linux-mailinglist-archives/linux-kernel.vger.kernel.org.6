Return-Path: <linux-kernel+bounces-373250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C9F9A5456
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC7A1C20D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4109192D77;
	Sun, 20 Oct 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XnSJato9"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A5B674
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430858; cv=none; b=F5gElp762pHv5x1IMJ34BHONDpWUy9IEKQpcjt9kiK1LL3BHYLWrdunAC0LzJXVS2Ps/icYoNIvjMpqd3/1KlK0e0cRysn4l+kAASpBqb7tALhcTi42dUgShIJn3hi4ds1LqgFKyXt4Qkgca9q/EwIyOLN/R9mB9r/EgG/1vxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430858; c=relaxed/simple;
	bh=QFkLcqiV/3W0vzldAxLbJLvTFAecQxEKLXi72/SCBpo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oA1cA7hME0MjYuFNZfq2o4RYHIQvxITGDacVHeS4DWJ7SNN3t+ax389GrQQCIIicigqGeex2on4X84/c3cYWDalVT0SMBr7WR0iKsfrc+/wXxMkQuqgYaruZGSTLkv3zgUoDZ0zms1/lkVErjDCiHOU6o1H66RceLv1A9//dxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XnSJato9; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0bcb100c8ee711efb88477ffae1fc7a5-20241020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xgv59uFY/bRi9k1+Qc9CuwJ5ULI4vYv5ePGUW0MUTIg=;
	b=XnSJato9bHSTcLfBZOa4p+FCo76bSAv+OgbsSDEa7SKYcpKXVvRZqWQNMUjMJk8uU1bDgl4rtNancoLfYZyVR9/eh4q4zNkacge+mA5E1shyz2jpBvrhmTBzARPccMxQW1rqC5hj5ryCztMTSc6+gOjL+vCpuy4Tfz/tjcCf+ew=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:23ada87d-3fa4-48ba-a5c1-e6a96c9c6cf3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d2bd130d-1043-475c-b800-3262c01ea3e5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 0bcb100c8ee711efb88477ffae1fc7a5-20241020
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1504900301; Sun, 20 Oct 2024 21:27:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 20 Oct 2024 21:27:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 20 Oct 2024 21:27:24 +0800
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
Subject: [RFC PATCH nand/next 0/4] mtd: nand: spi: Add CASN page support
Date: Sun, 20 Oct 2024 21:27:18 +0800
Message-ID: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: "Sky Huang" <skylake.huang@mediatek.com>

Hi, this is Qi-Ze Huang(Sky Huang) from MediaTek. On our router platforms
chips, we have to quality lots of SPI-NAND devices and are eager for
a standard so that we don't need to maintain trivial flash ID table
anymore. I also noticed a talk in 2019 Embedded Linux Conference,
Memory Technology Devices: what's new, which mentioned "ONFI for
SPI-NANDs? Maybe, maybe not".

So earlier this year, I proposed a bold idea, CASN page (Common Attributes
for SPI-NAND). I worked together with top 3 SPI-NAND market share flash
vendors and other vendors to integrate CASN page on their SPI-NAND devices
including but not limited to:
[ESMT]
F50L1G41LB
F50L2G41KA

[Etron]
EM73C044VCF-H
EM73D044VCO-H
EM73E044VCE-H
EM73F044VCA-H

[GigaDevice]
GD5F1GM7UE
GD5F1GQ5UEYIG
GD5F2GM7UE
GD5F2GQ5UEYIG
GD5F4GM8UE
GD5F4GQ6UEYIG

[Macronix (MXIC)]
MX35LF1GE4ABZ4IG

[Winbond]
W25N01GV
W25N01KV
W25N02KV
W25N04KV

A document of CASN is hosted on github(https://github.com/mtk-openwrt/
doc/blob/main/CASN%20Page%20Introduction.pdf) So I'll try to keep it
simple here.

With CASN page, we don't need to maintain SPI-NAND flash ID table anymore.
Currently, it's integrated in 3.3V SPI-NANDs of small density and it's not
JEDEC standard yet. But it should be able to handle 1.8V and can be easily
integrated by flash vendors.

I believe this idea and implementation have room for improvement. Hope to
hear you open source community's comments soon.

Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
---
Sky Huang (4):
  mtd: nand: Create param.c to do CRC check and bitwise majority for
    Parameter & CASN page
  include: mtd: Add CASN page definition and related structs.
  include: mtd: spinand: Add CASN page related macros and flags.
  mtd: nand: spi: Add CASN page support

 drivers/mtd/nand/Makefile        |   2 +-
 drivers/mtd/nand/param.c         |  52 +++
 drivers/mtd/nand/raw/nand_onfi.c |  43 +-
 drivers/mtd/nand/spi/core.c      | 741 ++++++++++++++++++++++++++++++-
 include/linux/mtd/casn.h         | 191 ++++++++
 include/linux/mtd/param.h        |  20 +
 include/linux/mtd/spinand.h      | 100 ++++-
 7 files changed, 1094 insertions(+), 55 deletions(-)
 create mode 100644 drivers/mtd/nand/param.c
 create mode 100644 include/linux/mtd/casn.h
 create mode 100644 include/linux/mtd/param.h

-- 
2.45.2


