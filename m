Return-Path: <linux-kernel+bounces-279134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367994B969
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12FAB20E9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF85189BA3;
	Thu,  8 Aug 2024 08:57:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115A188CC8;
	Thu,  8 Aug 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107434; cv=none; b=KBDTWXgENLA6kfm+HaUHV5JNGpre4+50fUKIPxuETd+6XUY1nlSIA5afnS0/vj61bqcZ8zCOZS/qF98JHVccbJoFt+G2QiTuKD39j/4EbxdOraW5dulStj4zkBldmphrKsbV53izcdxKfvq/pu5Q+yeIC9shE/LZjuBxBWW6GYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107434; c=relaxed/simple;
	bh=VYBBPZ7lM3ShgYEXJ3xnjAE/HlqU0FLWWd8odj3TVRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=joj4F2xLLD/8BeF/lqMqjRFJw8rpWvrsaPuMR2KY2dcQFEsAGzJRM4iYPYuwO4gmDK1giatN1Qab+eO2falpu6ruD+dbHgIXYJwMUxbQ4N8p0AfDD89Xf1DMCVmQuxrWTAHu0WomdKEa3MfZDl7PjVmT0JTModz1+6ES1AmNmH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wfgqx265LzpTCZ;
	Thu,  8 Aug 2024 16:55:57 +0800 (CST)
Received: from kwepemf500010.china.huawei.com (unknown [7.202.181.248])
	by mail.maildlp.com (Postfix) with ESMTPS id C7879140604;
	Thu,  8 Aug 2024 16:57:08 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemf500010.china.huawei.com
 (7.202.181.248) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 8 Aug
 2024 16:57:08 +0800
From: Guo Xuenan <guoxuenan@huawei.com>
To: <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <guoxuenan@huawei.com>,
	<guoxuenan@huaweicloud.com>, <jack.qiu@huawei.com>, <ganjie5@huawei.com>
Subject: [PATCH] Documentation: dontdiff: remove 'utf8data.h'
Date: Thu, 8 Aug 2024 16:57:07 +0800
Message-ID: <20240808085707.3235019-1-guoxuenan@huawei.com>
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
 kwepemf500010.china.huawei.com (7.202.181.248)

From: ganjie <ganjie5@huawei.com>

Commit 2b3d04787012 ("unicode: Add utf8-data module") changed the
database file from 'utf8data.h' to 'utf8data.c' to build separate
module, but it seems forgot to update Documentation/dontdiff. Remove
'utf8data.h' and add 'utf8data.c'.

Signed-off-by: ganjie <ganjie5@huawei.com>
---
 Documentation/dontdiff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 3c399f132e2d..94b3492dc301 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -262,7 +262,7 @@ vsyscall_32.lds
 wanxlfw.inc
 uImage
 unifdef
-utf8data.h
+utf8data.c
 wakeup.bin
 wakeup.elf
 wakeup.lds
-- 
2.34.3


