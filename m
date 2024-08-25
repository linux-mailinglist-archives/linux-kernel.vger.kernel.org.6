Return-Path: <linux-kernel+bounces-300356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539D95E2B7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B251F218BC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45B61FFC;
	Sun, 25 Aug 2024 08:35:29 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB04A5F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724574929; cv=none; b=nfP3mS9sGo1zWu4IN5SzhLX/m2bwlohO2I0G01MRDG1yLz5+Yi0TNpLo/7rkt12xhoWnrUl62W+AwgZgZ0qrtHZbbWtWiXOXbw2sFGcJIbSzYC/fxVfGS3h5Vk+HSjZJFTkehheQhTt+kbpyeSLopBaafd377VrX+u+JPJ7HTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724574929; c=relaxed/simple;
	bh=4wrlrF+jQs4JcflconAry3T2NvzOwZR+VqeoKDXqCx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoVY3coqYSsXu7RaWKTqSM6LjLBGUfKZVD8DKf0mcRi1PHLt40R0GOqT5KeY21O6VAJaLF+IFJ1XiMaYQGPVtZH9IgxesCDs0KzlVTQQpfW71Q5GjrP9uSryNnNd6vxNj3ozQgVTRjnJspfoolQkaCCRS0KipYEqQ4YmX7yPW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ws6Sk3RzCz69JS;
	Sun, 25 Aug 2024 16:30:30 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D3D2818007C;
	Sun, 25 Aug 2024 16:35:16 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 25 Aug
 2024 16:35:16 +0800
From: Wang Zhaolong <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] mtd: ubi: remove unused parameter 'pnum' from add_volume()
Date: Sun, 25 Aug 2024 16:35:15 +0800
Message-ID: <20240825083515.4074081-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500010.china.huawei.com (7.202.181.71)

The parameter 'pnum' in the function add_volume() is not used inside the
function body. This patch removes this unused parameter to clean up the
code and improve readability.

This change does not affect the functionality of add_volume() or any other
part of the UBI subsystem, as the removed parameter is not utilized.

Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/attach.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index ae5abe492b52..fe9784c90ea4 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -393,8 +393,7 @@ static int validate_vid_hdr(const struct ubi_device *ubi,
  * to the allocated "av" object in case of success and a negative error code in
  * case of failure.
  */
-static struct ubi_ainf_volume *add_volume(struct ubi_attach_info *ai,
-					  int vol_id, int pnum,
+static struct ubi_ainf_volume *add_volume(struct ubi_attach_info *ai, int vol_id,
 					  const struct ubi_vid_hdr *vid_hdr)
 {
 	struct ubi_ainf_volume *av;
@@ -576,7 +575,7 @@ int ubi_add_to_av(struct ubi_device *ubi, struct ubi_attach_info *ai, int pnum,
 	dbg_bld("PEB %d, LEB %d:%d, EC %d, sqnum %llu, bitflips %d",
 		pnum, vol_id, lnum, ec, sqnum, bitflips);
 
-	av = add_volume(ai, vol_id, pnum, vid_hdr);
+	av = add_volume(ai, vol_id, vid_hdr);
 	if (IS_ERR(av))
 		return PTR_ERR(av);
 
-- 
2.34.3


