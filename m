Return-Path: <linux-kernel+bounces-335467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CBA97E628
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B4AB20AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EFF1D52B;
	Mon, 23 Sep 2024 06:49:48 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1979E1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074188; cv=none; b=fyHJVSkxXKAJ6N2+ajRWTRQG1cjo95FiphjPiaxC8my5dW9dqgg/EHTzyLiqKCiwbSYw9UxgEWJ/GknL7+5BHInRO1S1yzVU8UR8CqUoWRGPVzc2iPQToImEJ5nHznS1sfawHn28jNQC6rxMi6AchW5HdAZjH4u0PQRbR3wNXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074188; c=relaxed/simple;
	bh=zBZJxughIAFvgeZ3zt0Sy5TmrcQjEYNK4/SoSdgeMoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/swJuBOp0FFh2+z3n6kgUm9jVmgYUfvafjjrc2vbDwBlxNJFqWZJ7p87cgDIbyavZYxXqAr7EoPZqHBvPhX6OV93wDQiVZaDXiSjO4ptd0MZdnDbnLFCvomUE848LqtVziKzy4ORycl8mTQcDEIePipz3VNx0pKRyfdklomKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee866f10ec7ca1-b2cd6;
	Mon, 23 Sep 2024 14:46:32 +0800 (CST)
X-RM-TRANSID:2ee866f10ec7ca1-b2cd6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466f10eb4cad-53dd8;
	Mon, 23 Sep 2024 14:46:31 +0800 (CST)
X-RM-TRANSID:2ee466f10eb4cad-53dd8
From: Ba Jing <bajing@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	zhangpeng.00@bytedance.com,
	sidhartha.kumar@oracle.com,
	bajing@cmss.chinamobile.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] shared: linux: remove unused variables
Date: Tue,  3 Sep 2024 11:29:52 +0800
Message-Id: <20240903032952.10120-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These variables are never referenced in the code, just remove them.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 tools/testing/shared/linux.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
index 17263696b5d8..eb1b1878cf64 100644
--- a/tools/testing/shared/linux.c
+++ b/tools/testing/shared/linux.c
@@ -13,8 +13,6 @@
 #include <urcu/uatomic.h>
 
 int nr_allocated;
-int preempt_count;
-int test_verbose;
 
 struct kmem_cache {
 	pthread_mutex_t lock;
-- 
2.33.0




