Return-Path: <linux-kernel+bounces-205334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA568FFAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A67284D9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55515B102;
	Fri,  7 Jun 2024 04:27:32 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A415A87D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734450; cv=none; b=jkdLtrdxpJhNR3F1iocp4kWvch8vEux4aPDa69NlBtoeARFJdlRCfehD44ozRIViWNfyCdYVym/rktrevm+UrD3ZGVOPCHbQO8H61buBq37uxzTwkQOnUQXjYqn9PentdpxkEFtldnl7Q8lcSvWh8r3G6t5R2iXPr9X8p9VxxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734450; c=relaxed/simple;
	bh=7gl1AN5VoGYDAloRBlrC9gntFL0DEWYQ21UCfP9EHRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJyEbCPq9OaAMCbIe9fz/DwSo3l6A6TcClfzlr5549R1+KWSmXHUJ2Q4mrQKAUVcSi66qqMwOii9YrbcgWhb2rZl5OxozfCstpH6whwEmwnDnuJkBTpTgmp1jYLXq42bmUsQPgBKcROU5TqtBCWE+YC3x5kMHasNZs26ZyyFAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkt13WFzPpnL;
	Fri,  7 Jun 2024 12:24:06 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E979180085;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:06 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 054/110] ubifs-utils: Add descriptions for new lib files in libubifs/README
Date: Fri, 7 Jun 2024 12:25:19 +0800
Message-ID: <20240607042615.2069840-55-chengzhihao1@huawei.com>
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

There are many linux kernel source files have been adapted into
ubifs-utils, add descriptions for these source files in README.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/Makemodule.am   |  2 +-
 ubifs-utils/libubifs/README | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 ubifs-utils/libubifs/README

diff --git a/ubifs-utils/Makemodule.am b/ubifs-utils/Makemodule.am
index d297f7a2..c02ec313 100644
--- a/ubifs-utils/Makemodule.am
+++ b/ubifs-utils/Makemodule.am
@@ -49,7 +49,7 @@ mkfs_ubifs_LDADD = libmtd.a libubi.a $(ZLIB_LIBS) $(LZO_LIBS) $(ZSTD_LIBS) $(UUI
 mkfs_ubifs_CPPFLAGS = $(AM_CPPFLAGS) $(ZLIB_CFLAGS) $(LZO_CFLAGS) $(ZSTD_CFLAGS) $(UUID_CFLAGS) $(LIBSELINUX_CFLAGS) \
 	-I$(top_srcdir)/ubi-utils/include -I$(top_srcdir)/ubifs-utils/common -I $(top_srcdir)/ubifs-utils/libubifs -rdynamic
 
-EXTRA_DIST += ubifs-utils/common/README
+EXTRA_DIST += ubifs-utils/common/README ubifs-utils/libubifs/README
 
 dist_sbin_SCRIPTS = ubifs-utils/mount.ubifs
 
diff --git a/ubifs-utils/libubifs/README b/ubifs-utils/libubifs/README
new file mode 100644
index 00000000..551ed8e6
--- /dev/null
+++ b/ubifs-utils/libubifs/README
@@ -0,0 +1,30 @@
+UBIFS Library (Imported from linux kernel 6.8-rc2 41bccc98fb7931d63)
+
+* ubifs.h is a selection of definitions from fs/ubifs/ubifs.h from the linux kernel.
+* key.h is copied from fs/ubifs/key.h from the linux kernel.
+* ubifs-media.h is copied from fs/ubifs/ubifs-media.h from the linux kernel.
+* find.c is copied from fs/ubifs/find.c from the linux kernel.
+* scan.c is copied from fs/ubifs/scan.c from the linux kernel.
+* gc.c is copied from fs/ubifs/gc.c from the linux kernel.
+* log.c is copied from fs/ubifs/log.c from the linux kernel, and amended.
+* tnc_commit.c is copied from fs/ubifs/tnc_commit.c from the linux kernel, and amended.
+* master.c is copied from fs/ubifs/master.c from the linux kernel, and amended.
+* recovery.c is copied from fs/ubifs/recovery.c from the linux kernel, and amended.
+* lpt.c is a selection of functions copied from fs/ubifs/lpt.c from the linux kernel, and amended.
+* auth.c is a selection of functions copied from fs/ubifs/auth.c from the linux kernel, and amended.
+* budget.c is a selection of functions copied from fs/ubifs/budget.c from the linux kernel, and amended.
+* commit.c is a selection of functions copied from fs/ubifs/commit.c from the linux kernel, and amended.
+* debug.c is a selection of functions copied from fs/ubifs/debug.c from the linux kernel, and amended.
+* debug.h is a selection of functions copied from fs/ubifs/debug.h from the linux kernel, and amended.
+* io.c is a selection of functions copied from fs/ubifs/io.c from the linux kernel, and amended.
+* lprops.c is a selection of functions copied from fs/ubifs/lprops.c from the linux kernel, and amended.
+* lpt_commit.c is a selection of functions copied from fs/ubifs/lpt_commit.c from the linux kernel, and amended.
+* misc.h is a selection of functions copied from fs/ubifs/misc.h from the linux kernel, and amended.
+* orphan.c is a selection of functions copied from fs/ubifs/orphan.c from the linux kernel, and amended.
+* replay.c is a selection of functions copied from fs/ubifs/replay.c from the linux kernel, and amended.
+* sb.c is a selection of functions copied from fs/ubifs/sb.c from the linux kernel, and amended.
+* super.c is a selection of functions copied from fs/ubifs/super.c from the linux kernel, and amended.
+* tnc.c is a selection of functions copied from fs/ubifs/tnc.c from the linux kernel, and amended.
+* tnc_misc.c is a selection of functions copied from fs/ubifs/tnc_misc.c from the linux kernel, and amended.
+* journal.c is a selection of functions copied from fs/ubifs/journal.c from the linux kernel, and amended.
+* dir.c is a selection of functions copied from fs/ubifs/dir.c from the linux kernel, and amended.
-- 
2.13.6


