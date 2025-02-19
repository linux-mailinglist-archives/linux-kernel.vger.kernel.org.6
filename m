Return-Path: <linux-kernel+bounces-520775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE01A3AF13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556231887FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37021474CC;
	Wed, 19 Feb 2025 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="fq44WCQu"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E511DA4E;
	Wed, 19 Feb 2025 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929562; cv=none; b=s7VlnMUsi9Pog4URNY79U6lMjB7tHvu3BFj5UdJRpTF+5xFVZJTgPArH0tgbEx00zjZevq+ClY+8a/BYWvQG1NxOaBSOxxbmcrrKNCJfYE67vktgTb7uOOhGB4t+KMIVcvIgEg6qMIZn2bkByA94IkvNl14LQXQpAFmDiDsXqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929562; c=relaxed/simple;
	bh=7ecqkVVdj/whIMKW2rpEMqEnB/OL2Wi9CrKSSscVsFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zpv36Kq/ej01DPWhkpTtOSs0LMyNyinU3GacAO+KDspUpPfepEsrRwBkGGUhetsLp6Ea8owNse/dPdvxToKluYkjFWCNI74tZD2NrvfFWNl+lV/TfT4qeHnJdnNwzRjLvetptfJE4hIv5XrAailgJElbUhN/LUz2Rp8avcZIGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=fq44WCQu; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=EAp/ff+jU6zqDJFGhB7GlURbx/lq4hD8LZ7g7IXmRLo=; b=fq44WCQuHxmYNkmd
	PLh/x9w1Vp/NUgx5IOkGaD/vEPdn+Rn1Kf6NUr3lzCKgSGsykaDlVgP0nS8SFwBMvUqavptPscTiw
	eHUKag00ErDt1I+Ej8M4jfzSs5QfivLdPaQF3wygoFyBxN6RJkpdvwHOqQq58ndcZScqK4S45qCuH
	7+4a0rekcE4A54MHlAhD7Ds1/b3+TG0kWVpzP9+1XcEPfqGxGAbHclwOwK7Ji8zrzDGhmqGRKMBrE
	B47hixks1zxD2nJXa7BTBTtCSXDr/egsE+9mYO3X5xVLqt+7qp0iTGaYImDttFyEHgUIZylos9qC/
	UHBIqcgQAtqVE5OPmA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tkZ9y-00GmJC-0l;
	Wed, 19 Feb 2025 01:45:58 +0000
From: linux@treblig.org
To: almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] fs/ntfs3: Remove unused ntfs_sb_read
Date: Wed, 19 Feb 2025 01:45:55 +0000
Message-ID: <20250219014556.293497-3-linux@treblig.org>
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

ntfs_sb_read() was added in 2021 by
commit 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/ntfs3/fsntfs.c  | 28 ----------------------------
 fs/ntfs3/ntfs_fs.h |  1 -
 2 files changed, 29 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 938d351ebac7..df81f1f7330c 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1035,34 +1035,6 @@ struct buffer_head *ntfs_bread(struct super_block *sb, sector_t block)
 	return NULL;
 }
 
-int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer)
-{
-	struct block_device *bdev = sb->s_bdev;
-	u32 blocksize = sb->s_blocksize;
-	u64 block = lbo >> sb->s_blocksize_bits;
-	u32 off = lbo & (blocksize - 1);
-	u32 op = blocksize - off;
-
-	for (; bytes; block += 1, off = 0, op = blocksize) {
-		struct buffer_head *bh = __bread(bdev, block, blocksize);
-
-		if (!bh)
-			return -EIO;
-
-		if (op > bytes)
-			op = bytes;
-
-		memcpy(buffer, bh->b_data + off, op);
-
-		put_bh(bh);
-
-		bytes -= op;
-		buffer = Add2Ptr(buffer, op);
-	}
-
-	return 0;
-}
-
 int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 		  const void *buf, int wait)
 {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 2034dca90a5e..0e34c944b622 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -616,7 +616,6 @@ enum NTFS_DIRTY_FLAGS {
 	NTFS_DIRTY_ERROR = 2,
 };
 int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty);
-int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer);
 int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
 		  const void *buffer, int wait);
 int ntfs_sb_write_run(struct ntfs_sb_info *sbi, const struct runs_tree *run,
-- 
2.48.1


