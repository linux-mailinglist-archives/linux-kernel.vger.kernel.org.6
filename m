Return-Path: <linux-kernel+bounces-433344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A709E571D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EEB284CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44C219A61;
	Thu,  5 Dec 2024 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jDTYYX2u"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E5218EAD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405257; cv=none; b=fP3Itm+e5Oc4Mve8v15/mm5ip0zpvUc9zUuYCOcfRgngqewLLx/TjEnPIDYR/0z2Yq8QLkIk6lHxj4x5hCJK3TjQuj4gjoQDIRWqHTBjEawjIPIoAzaQFAxjf92GkFQ3khhdKy5VVsFehm4jOzlxqBayzs0u+BTGENx9Kz9YVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405257; c=relaxed/simple;
	bh=SVyJKAObJHq6toM2zS9LouHZmdIC3Ik+jdnb12haUZQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KnmdKUJEV6WlCui2L5sUbBtVEkiYTgHvgazptayGj6486p2fv70E74FoGe5NpB1zuracZhkQ77RcOdU6JXKlJFrAfUDLKSgrOEGmqQ8QMuOqE+BMiJuLXpar6sYbJJ/OfszgQ7G/CYXdYioIiIKrawquyv46ptgKu7qmWZP3VEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jDTYYX2u; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ad370038b30c11ef99858b75a2457dd9-20241205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FmxWE5EhzoSWDAXa4b5JycP7gjDtMkh2D/HJuqalzuU=;
	b=jDTYYX2u4z0aMU0NwYRKyqB9TwlaOOBwm366a0BgVxxVWsSYnc2D9QWyHQ0LbmpR+4XnvopMZLq2bSTZO6vKxeV+IoqvAoMcZTukSePeEamMZgck02fclVJ+DVduAbCm4ygaQ9a9JUOzR13fNNkvv1EEMJvoKh75fN4B3ewxyxc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b125b73a-e548-42a3-94ee-5096c7928c44,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:58657d3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ad370038b30c11ef99858b75a2457dd9-20241205
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <defa.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 215151407; Thu, 05 Dec 2024 21:27:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Dec 2024 21:27:28 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Dec 2024 21:27:27 +0800
From: Defa Li <defa.li@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, <mingchang.jia@mediatek.com>,
	<yuhan.wei@mediatek.com>, <hao.lin@mediatek.com>, Defa Li
	<defa.li@mediatek.com>
Subject: [PATCH] i3c: master: Improve initialization of numbered I2C adapters
Date: Thu, 5 Dec 2024 21:29:02 +0800
Message-ID: <20241205132934.12110-1-defa.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add logic to initialize I2C adapters with a specific ID if available,
improving device identification and configuration.

Signed-off-by: Defa Li <defa.li@mediatek.com>
---
 drivers/i3c/master.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 42310c9a00c2..a838cdbb897b 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2486,7 +2486,7 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	struct i2c_adapter *adap = i3c_master_to_i2c_adapter(master);
 	struct i2c_dev_desc *i2cdev;
 	struct i2c_dev_boardinfo *i2cboardinfo;
-	int ret;
+	int ret, id = -ENODEV;
 
 	adap->dev.parent = master->dev.parent;
 	adap->owner = master->dev.parent->driver->owner;
@@ -2497,7 +2497,14 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	adap->timeout = 1000;
 	adap->retries = 3;
 
-	ret = i2c_add_adapter(adap);
+	if (master->dev.of_node)
+		id = of_alias_get_id(master->dev.of_node, "i2c");
+
+	if (id >= 0) {
+		adap->nr = id;
+		ret = i2c_add_numbered_adapter(adap);
+	} else
+		ret = i2c_add_adapter(adap);
 	if (ret)
 		return ret;
 
-- 
2.45.2


