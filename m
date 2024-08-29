Return-Path: <linux-kernel+bounces-306212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04609963B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30351F2436D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A13158219;
	Thu, 29 Aug 2024 06:19:17 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F614B949
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912357; cv=none; b=VksrFjwzuQsJgnanke9Nkl1kiZGqvmw42o5t4flzKerZjUv/dO7LxTkmvMEQFFBSjBMXiCg7EVjyFQRPCKkk+FssDg5CT4C8NBlQNyRCub2JXiLQ5Q+RfDpkA3SqCUb7jaJF9Jt4yrb80XXiS4gc7KFPX5DffH16mcxOqP7Jkz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912357; c=relaxed/simple;
	bh=PsWT63ZgRECvcsjRAmBIJ+5RAgq7uqtwqNcvlY1z9Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GVsRVAAYa8xgng63lYl42G0pZGfsPsmEU2MASGdnj4KuPWI/L/mQ5U77180BsIxMpwXZKnGkhd/QTyI4C/z2SaWb7yk8RFH+a+78qh/25hnB0HGkzgfwypQtghPv4nvrYSJcAKGUe3rHRzwm9psJfC8zvzeRDAbeVpwGxWV0bQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866d01223008-ee03c;
	Thu, 29 Aug 2024 14:16:04 +0800 (CST)
X-RM-TRANSID:2ee866d01223008-ee03c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d0122313c-91b43;
	Thu, 29 Aug 2024 14:16:04 +0800 (CST)
X-RM-TRANSID:2ee366d0122313c-91b43
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhangjiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools/mm: rm thp_swap_allocator_test when make clean
Date: Thu, 29 Aug 2024 12:20:08 +0800
Message-Id: <20240829042008.6937-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhangjiao <zhangjiao2@cmss.chinamobile.com>

rm thp_swap_allocator_test when make clean

Signed-off-by: zhangjiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mm/Makefile b/tools/mm/Makefile
index 15791c1c5b28..f5725b5c23aa 100644
--- a/tools/mm/Makefile
+++ b/tools/mm/Makefile
@@ -23,7 +23,7 @@ $(LIBS):
 	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
 
 clean:
-	$(RM) page-types slabinfo page_owner_sort
+	$(RM) page-types slabinfo page_owner_sort thp_swap_allocator_test
 	make -C $(LIB_DIR) clean
 
 sbindir ?= /usr/sbin
-- 
2.33.0




