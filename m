Return-Path: <linux-kernel+bounces-218511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4D90C122
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34C1282B73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69436168DA;
	Tue, 18 Jun 2024 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b1BuqTBw"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA457DF6C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673214; cv=none; b=du5s+sWCZ/8uXkV2O8+BfzaCT6IXFGYRWNC2HLsuQZ5dpFHY2P0bJTtbQfBwuR9c8UTH2BkprGLLbkCsW1Ey2my+2ECvDzR9615iAt9m8orJR4Wf7rb+ZJKgKiHycvnBSjgHqfSftEYY26G5r3y6IP6x2fBJP8cYMLm824EKM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673214; c=relaxed/simple;
	bh=90vIj6K9YZdXsuNer0E/YjYMdzSlaGzufo6sg9kC4zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FFBdd/k1kEq5mQajHewJnTGpp1am5Ea17vJgw34onHWC11A9xEBrFoztNjMfqUB2NfIILns1w534cSLLnHsE355ni4fEh5xuIomVbEiAx5VjGeWhauutHpxMU+Bd68JawscB2L4+m2NxLtK+EbuZcnF9JsQnYcKltHBYjoywVSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b1BuqTBw; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718673202; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=F2EvtlmpzUqPwQjzdIlNTcw1IGFTPpGxTHB82p1P88g=;
	b=b1BuqTBwr30tjLdECxPL8NewFyWEWczZ/hvb6AOdtzH76mOfFjYF2xFzw8nLqe6p/osL3sfSyptycFyv8yv23YJxkO1cTFPjPJo1e3CPxVU9KjquIpWpFYOIy/2eXqS3SmqeR5Nz6X3tThUmsr+LyhFqhmIdlcx1imEhaHbFPaE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8i3Xbu_1718673201;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W8i3Xbu_1718673201)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 09:13:22 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com
Cc: mike.leach@linaro.org,
	james.clark@arm.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] coresight: stm: Remove unneeded semicolon
Date: Tue, 18 Jun 2024 09:13:19 +0800
Message-Id: <20240618011319.97542-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/hwtracing/coresight/coresight-priv.h:231:2-3: Unneeded
semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9345
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index fc3617642b01..15fee93d7696 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -228,7 +228,7 @@ static inline void *coresight_get_uci_data_from_amba(const struct amba_id *table
 		if ((pid & table->mask) == table->id)
 			return coresight_get_uci_data(table);
 		table++;
-	};
+	}
 	return NULL;
 }
 
-- 
2.20.1.7.g153144c


