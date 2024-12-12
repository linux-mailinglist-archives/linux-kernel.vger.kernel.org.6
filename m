Return-Path: <linux-kernel+bounces-442822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A09EE274
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929D21889AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4FC20E6EE;
	Thu, 12 Dec 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZJKwGNvk"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486920B1EE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994974; cv=none; b=eUMCmznX/kyP6RZgnwr1SCnHFvTbgj5APiAPixXDmqGV7ysRUy0pEiXOPJ3XALkFpZ1YyPaQTUoLMV6/ZA4+mfQZ9nv0B9ivAYPugAmX3Y/veSrN6Dms7tCf02afw6OYSRYP0rURoRpJwuvqYe3Zhrqx9OMhtJ3OnXn2Pk8lDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994974; c=relaxed/simple;
	bh=E+v+XbrJvdmUv7/phcNG3CZ46CGEA4Xq2rdSFIK6e40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5zEohT++57jgBSdXwjD5QCnxx/TwruIoAva7DSdpmc6QxndnsVivXnkKslXmgmAixwQDstP1bgzXdu8eQdfUH8th9jW3NYjvZXOL6ALM7gM+KctFkd1Z4IZC1lxpC45x/uzJs3dTiJ0PfZ10Jid+4zVkU7QisRH9eVbXQQZSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZJKwGNvk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b849cc82b86911efbd192953cf12861f-20241212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=axvJlHiBR2zkbU+O3koSZ3ET0NsXqwruLo6eqUrj9fI=;
	b=ZJKwGNvkU/GyPkSeEtYc0qHr7kwaT/OBq/q9QXlJo31dpS1mvRaCNjQK291oPqXtUgKNrvwagzggRdIhPA15TIdQWcb/Lfb7R3IlZ+xPdzygh9D654zjbPZ4rDnkfL+lH8EqEErRQtv+UB0KHOSDppxZFmRs3zjUGopnm5UH/Pg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6e61750a-4714-4be5-a9b4-eec9b8eefc64,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:41410513-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b849cc82b86911efbd192953cf12861f-20241212
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <defa.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1968622210; Thu, 12 Dec 2024 17:16:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Dec 2024 17:16:06 +0800
Received: from mbjsdccf07.gcn.mediatek.inc (10.15.20.246) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Dec 2024 17:16:05 +0800
From: Defa Li <defa.li@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<wsd_upstream@mediatek.com>, <mingchang.jia@mediatek.com>,
	<yuhan.wei@mediatek.com>, <hao.lin@mediatek.com>, Defa Li
	<defa.li@mediatek.com>
Subject: [PATCH v2] i3c: master: Improve initialization of numbered I2C adapters
Date: Thu, 12 Dec 2024 17:17:53 +0800
Message-ID: <20241212091818.8591-1-defa.li@mediatek.com>
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

For mixed buses, in addition to the i3c alias, an i2c alias can be added to
assign a fixed bus number to the i2c adapter.

This allows an alias node such as:
    aliases {
        i2c2 = &mixed_bus_a,
        i3c2 = &mixed_bus_a,
        i3c4 = &mixed_bus_b,
    };

    /* assigned "i3c-2" and "i2c-2" */
    mixed_bus_a: i3c-master {
    };

If there is no i2c alias for a mixed bus, the i2c adapter numbers will
remain as is and will be assigned starting after the highest fixed bus
number.

    /* assigned "i3c-4" and likely assigned "i2c-3" */
    mixed_bus_b: i3c-master {
    };

v2:
  - Modify commit message and code format issues

Signed-off-by: Defa Li <defa.li@mediatek.com>
---
 drivers/i3c/master.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 42310c9a00c2..92223e0b6e59 100644
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
@@ -2497,7 +2497,15 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	adap->timeout = 1000;
 	adap->retries = 3;
 
-	ret = i2c_add_adapter(adap);
+	if (master->dev.of_node)
+		id = of_alias_get_id(master->dev.of_node, "i2c");
+
+	if (id >= 0) {
+		adap->nr = id;
+		ret = i2c_add_numbered_adapter(adap);
+	} else {
+		ret = i2c_add_adapter(adap);
+	}
 	if (ret)
 		return ret;
 
-- 
2.46.0


