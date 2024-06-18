Return-Path: <linux-kernel+bounces-218517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500BA90C134
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61D0B20F14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D71C8F3;
	Tue, 18 Jun 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l70Y7W9G"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44F4C6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673542; cv=none; b=IA3fPogXg8awoKfByNJoh+2x484tl29qNZRlLM3wtt9YuU5Bqol6bsXKLCZW5HePRJDrIrmxpgWOKf3W8HRiGurp/y+ObsaXRy4+Flc85ikKv39g8U2JXuqoBCE2KhtEu4O875lzyGjjTYb9C20k+blTMc5v1lTVunH7P8gP5dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673542; c=relaxed/simple;
	bh=chvuyFV0t0ahVhKg9k8g1PN0V4+KfE1SAmbU83rKp2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KtEVdrLeib/86iNpKQ/WjfPU3mZhjUu45ZfYbpaDztvskTVXHxhamwNvea/bK4A0I8Hr++quZspm8PKlHP4V9o9F7gbgbth9n70KsyjGTRrQwhRcvN9xAqpjbVKjO6LJ857Be1C/HsP4wdV190Xv0N1FRPPRS+ZXYlBANg1ZGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l70Y7W9G; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718673537; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cMWj1ehLsQMHQ6xsbkW8qF8f364GlB50X+t54HacL1o=;
	b=l70Y7W9GCh11wbS1mG8bHrczwupNamaAEdofdOb0tOldyemx6q2+oxwHjWFOzs8Ik/CY34EAVitzXKysx+kqtol1PLyJQ7cpDFSf9kcMKuXzjl1vh62LF6JstbUC7kJKt903cGhEMb4gq76FVprZzNbAlwAnDkhE0+d/GyYJjWY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W8hw48V_1718673536;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W8hw48V_1718673536)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 09:18:57 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mfd: tps6594-core: Remove unneeded semicolon
Date: Tue, 18 Jun 2024 09:18:54 +0800
Message-Id: <20240618011854.109426-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/mfd/tps6594-core.c:516:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9346
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mfd/tps6594-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
index c59f3d7e32b0..a7223e873cd1 100644
--- a/drivers/mfd/tps6594-core.c
+++ b/drivers/mfd/tps6594-core.c
@@ -513,7 +513,7 @@ static int tps6594_check_crc_mode(struct tps6594 *tps, bool primary_pmic)
 	} else {
 		regmap_reg = TPS6594_REG_SERIAL_IF_CONFIG;
 		mask_val = TPS6594_BIT_I2C1_SPI_CRC_EN;
-	};
+	}
 
 	/*
 	 * Check if CRC is enabled.
-- 
2.20.1.7.g153144c


