Return-Path: <linux-kernel+bounces-546237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1AA4F838
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6257A6495
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642831DE2C1;
	Wed,  5 Mar 2025 07:48:14 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D32E338C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160894; cv=none; b=fFz0rxg4GxVdu7hMHjqrxLT7ysmtxzcn3670+9I5Bvl/jvx4ogQ8QXATUk3APiuNtJghozTHsfgksZbbcqJrmzExYXOlfIBqIQR5vKwuBFxhkJSWskfM+6DN0TMubwCg05ALa8/Lo8wF23Ex/wUKBSSe9UW+H0rGpXWvQbSStdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160894; c=relaxed/simple;
	bh=9bco8vryGMjh/mWNs97gBG+DV3eTJlVDcgjyIBN4kwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdEo1gZH76yNnwDyd4sq/Vsdud71JpXFJ1KCmCXzTAIIUUAfGYiCXjccbEl8hM9BiC557vqJtVFV58n+LlYQEEvk6zRNV9LDYvIdboYN2mIr6P1mJHWzMAsoeyqCGfkMiVwpGN83nojDjulbpvpZuabS3v64ZxvJeeduabS0J14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503051548036510;
        Wed, 05 Mar 2025 15:48:03 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 15:48:04 +0800
Received: from locahost.localdomain (10.94.3.63) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 15:48:03 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <willy@infradead.org>, <viro@zeniv.linux.org.uk>, <josef@toxicpanda.com>,
	<brauner@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] ufs: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 15:48:01 +0800
Message-ID: <20250305074801.5026-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025305154803e390c1d5ff094a653e4c2037508d1666
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
fs/ufs/inode.c:1063 ufs_alloc_lastblock() warn: inconsistent indenting
fs/ufs/inode.c:1077 ufs_alloc_lastblock() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 fs/ufs/inode.c | 64 +++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 7dc38fdef2ea..e67475f6e0db 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1060,41 +1060,41 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 	for (i = 0; i < end; ++i)
 		bh = bh->b_this_page;
 
-       err = ufs_getfrag_block(inode, lastfrag, bh, 1);
-
-       if (unlikely(err))
-	       goto out_unlock;
-
-       if (buffer_new(bh)) {
-	       clear_buffer_new(bh);
-	       clean_bdev_bh_alias(bh);
-	       /*
-		* we do not zeroize fragment, because of
-		* if it maped to hole, it already contains zeroes
-		*/
-	       set_buffer_uptodate(bh);
-	       mark_buffer_dirty(bh);
+	err = ufs_getfrag_block(inode, lastfrag, bh, 1);
+
+	if (unlikely(err))
+		goto out_unlock;
+
+	if (buffer_new(bh)) {
+		clear_buffer_new(bh);
+		clean_bdev_bh_alias(bh);
+		/*
+		 * we do not zeroize fragment, because of
+		 * if it maped to hole, it already contains zeroes
+		 */
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
 		folio_mark_dirty(folio);
-       }
-
-       if (lastfrag >= UFS_IND_FRAGMENT) {
-	       end = uspi->s_fpb - ufs_fragnum(lastfrag) - 1;
-	       phys64 = bh->b_blocknr + 1;
-	       for (i = 0; i < end; ++i) {
-		       bh = sb_getblk(sb, i + phys64);
-		       lock_buffer(bh);
-		       memset(bh->b_data, 0, sb->s_blocksize);
-		       set_buffer_uptodate(bh);
-		       mark_buffer_dirty(bh);
-		       unlock_buffer(bh);
-		       sync_dirty_buffer(bh);
-		       brelse(bh);
-	       }
-       }
+	}
+
+	if (lastfrag >= UFS_IND_FRAGMENT) {
+		end = uspi->s_fpb - ufs_fragnum(lastfrag) - 1;
+		phys64 = bh->b_blocknr + 1;
+		for (i = 0; i < end; ++i) {
+			bh = sb_getblk(sb, i + phys64);
+			lock_buffer(bh);
+			memset(bh->b_data, 0, sb->s_blocksize);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+			unlock_buffer(bh);
+			sync_dirty_buffer(bh);
+			brelse(bh);
+		}
+	}
 out_unlock:
-       ufs_put_locked_folio(folio);
+	ufs_put_locked_folio(folio);
 out:
-       return err;
+	return err;
 }
 
 static void ufs_truncate_blocks(struct inode *inode)
-- 
2.43.0


