Return-Path: <linux-kernel+bounces-205313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A58FFA90
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EB8B24A05
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1B315574C;
	Fri,  7 Jun 2024 04:27:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5E13E3EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734433; cv=none; b=kRuBO76tXMJjqvrfZxKX6VcrghfJ73xYNCkH2tyijqHWnLptL+Ffhk3IFYAY0Xq4B/XHNxR2h3XXitiDI1qxawFTDP18X75fG3aE+3SGxOV7Ew1ocQK8Ym0w0zWJ8KtmELXobyOAy6yeSfsRudZHcGF07EYM0YGH6HYVV+ywLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734433; c=relaxed/simple;
	bh=mfsoppF1Qw60Y53W+7G69oz+2Y1v7+YgU4N9F0B40GA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNV270Zv0udUraX+WTkw1miZJL10dfY9kHvhvQG5jDt+lDMXMv40gE6vJ9SMkiL9Djyp1sAhgQcdxKf9oTomi0dAkDfSUfSDoRwo+kDQ2K2FWCpA9pzyFXX7M5h3VhEakFsa8EzUpMPNUqfMwPx2d/amW41nByExLgHbT4aROjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSj649CMzmYRT;
	Fri,  7 Jun 2024 12:22:34 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 618D4180085;
	Fri,  7 Jun 2024 12:27:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:50 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 032/110] ubifs-utils: Add common definitions in linux kernel
Date: Fri, 7 Jun 2024 12:24:57 +0800
Message-ID: <20240607042615.2069840-33-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Add common definitions in linux kernel, which are used in UBIFS linux
kernel libs.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/defs.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/ubifs-utils/common/defs.h b/ubifs-utils/common/defs.h
index 548d9dfb..506f752c 100644
--- a/ubifs-utils/common/defs.h
+++ b/ubifs-utils/common/defs.h
@@ -11,8 +11,11 @@
 #include <unistd.h>
 #include <limits.h>
 #include <errno.h>
+#include <time.h>
+#include <assert.h>
 #include <execinfo.h>
 
+#include "linux_types.h"
 #include "ubifs.h"
 
 /* common.h requires the PROGRAM_NAME macro */
@@ -76,8 +79,41 @@ static inline void dump_stack(void)
 	free(strings);
 }
 
+static inline u32 get_random_u32(void)
+{
+	srand(time(NULL));
+	return rand();
+}
+
+static inline time_t ktime_get_seconds()
+{
+	return time(NULL);
+}
+
+#define likely(x) (x)
 #define unlikely(x) (x)
 
+#define cond_resched() do {} while(0)
+
+#define BUG() do {				\
+	assert(0);				\
+} while(0)
+#define BUG_ON(cond) do {			\
+	assert(!cond);				\
+} while(0)
+
+#define smp_wmb()		do {} while(0)
+#define smp_rmb()		do {} while(0)
+#define smp_mb__before_atomic()	do {} while(0)
+#define smp_mb__after_atomic()	do {} while(0)
+
+#define min3(x, y, z) min((typeof(x))min(x, y), z)
+
+static inline u64 div_u64(u64 dividend, u32 divisor)
+{
+	return dividend / divisor;
+}
+
 #define do_div(n,base) ({ \
 int __res; \
 __res = ((unsigned long) n) % (unsigned) base; \
-- 
2.13.6


