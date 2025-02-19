Return-Path: <linux-kernel+bounces-520776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2DA3AF14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979DA3AD83D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E367188721;
	Wed, 19 Feb 2025 01:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RBsBy/Ka"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862DE2AE6C;
	Wed, 19 Feb 2025 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929564; cv=none; b=nEIvJ554UcXHWYwkx7SN1NPVAeOMJPyOvisYIsy1YFWBnBzyKLve4FV7DK9oGb0Bi5YtPrOtRmxs2ZIMkjDPpQENOKLFgdQvr7WFFAibdPpvH2fTGFIVTSs9gA232kJDX42PXHlYZiiYTiQUG0qALBdXZhWC9ynWkyixw+97MWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929564; c=relaxed/simple;
	bh=ga2tNZICwomRcjV0C+bl1ZxZSDN6a6K85tSrSdGKXck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAgJ3GatHEmc/JYoEFImxOmUpNoT/VW1UAh5/VS/X0DwX5XJJHgRZGRT2I5L5YXINQyo2pALvpDhRQdoR46oiIzYL4IGD8HsBGUwRJ5oA4q4W02Tbe5LQF/DyLO8tlI8+Dqc0l2RV+Y4GRr4k0cvQzfOmmXv6QQRBS6fzd+csus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RBsBy/Ka; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=opKDNiGodqvA36hpdCHaOfs9vH6wfaWz90o6fifyo6s=; b=RBsBy/KaxB4iq+rm
	H4wGD1OEpFL9HMMr07D13R/Bjy+56wDPGdvq5lfKdiUJ1OyK8Kn5LjL3Tov02OWF8/XGSYPxGS7Wv
	TYjygCc3MZ/e+WDko71N+T5kEIah8I0ZXuWspa9h4AHDfIq1uMgLIfLCfju+B0A2256RvoF/zjlui
	4BQB8TW83EuMG6HqSdP1aD13U6wH6p4xvx69mAAjUuXggME3HGMCpnUVRyQzUvAEd+vrAtyBV4w7J
	PrNYNdI0HPetQF2KfEcbXLd2pRdOtyGyAqaeejkqMdJ+T5CNZv6mXeU+JEsUDIGwUM5lcmO18qKuI
	kD1fK/1H0DllLUnE4Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tkZ9z-00GmJC-0j;
	Wed, 19 Feb 2025 01:45:59 +0000
From: linux@treblig.org
To: almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] fs/ntfs3: Remove unused ntfs_flush_inodes
Date: Wed, 19 Feb 2025 01:45:56 +0000
Message-ID: <20250219014556.293497-4-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219014556.293497-1-linux@treblig.org>
References: <20250219014556.293497-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ntfs_flush_inodes() was added in 2021 by
commit 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
but has remained unused.

Remove it, and it's helper function.

Note: There is a commented out call to ntfs_flush_inodes in
ntfs_truncate() - I've left that in place.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/ntfs3/inode.c   | 40 ----------------------------------------
 fs/ntfs3/ntfs_fs.h |  2 --
 2 files changed, 42 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index a1e11228dafd..3e2957a1e360 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1024,46 +1024,6 @@ int ntfs_sync_inode(struct inode *inode)
 	return _ni_write_inode(inode, 1);
 }
 
-/*
- * writeback_inode - Helper function for ntfs_flush_inodes().
- *
- * This writes both the inode and the file data blocks, waiting
- * for in flight data blocks before the start of the call.  It
- * does not wait for any io started during the call.
- */
-static int writeback_inode(struct inode *inode)
-{
-	int ret = sync_inode_metadata(inode, 0);
-
-	if (!ret)
-		ret = filemap_fdatawrite(inode->i_mapping);
-	return ret;
-}
-
-/*
- * ntfs_flush_inodes
- *
- * Write data and metadata corresponding to i1 and i2.  The io is
- * started but we do not wait for any of it to finish.
- *
- * filemap_flush() is used for the block device, so if there is a dirty
- * page for a block already in flight, we will not wait and start the
- * io over again.
- */
-int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
-		      struct inode *i2)
-{
-	int ret = 0;
-
-	if (i1)
-		ret = writeback_inode(i1);
-	if (!ret && i2)
-		ret = writeback_inode(i2);
-	if (!ret)
-		ret = filemap_flush(sb->s_bdev_file->f_mapping);
-	return ret;
-}
-
 /*
  * Helper function to read file.
  */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 0e34c944b622..d628977e2556 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -713,8 +713,6 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		   u32 len, u32 copied, struct folio *folio, void *fsdata);
 int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
 int ntfs_sync_inode(struct inode *inode);
-int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
-		      struct inode *i2);
 int inode_read_data(struct inode *inode, void *data, size_t bytes);
 int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, const struct cpu_str *uni,
-- 
2.48.1


