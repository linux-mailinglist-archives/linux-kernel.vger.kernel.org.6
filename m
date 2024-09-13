Return-Path: <linux-kernel+bounces-328875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8D978A34
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B341C21C72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79C146A71;
	Fri, 13 Sep 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pVdVjUQQ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBB34CD8;
	Fri, 13 Sep 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260612; cv=none; b=G/UMX6zMcXwpi1SPa9AQcioQbBRWVEp00hAqf0p6jE0JE40rNZInQoIQTxypG+NVN/7Zoxj4VpRDdhcrUzS0HRjyRKAD7wDlDOkivrWG9mJcgiASMm0lKtmOwS/Bj8SkZuWcmGWr8ZDgJC4Ju+ZhvTTriXzn2hvwWGi7S3Tamdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260612; c=relaxed/simple;
	bh=2zrYHpA3kX7JC9/5SSEGb4MN5LXNBxgDBMyfH9tRaJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8mUslEN/gNo2G659ltj8bnccWyr08SI7rtbteCMwY3nfKF4RVFeIDKZo8n32K9XYN+w+uZBmAF8f6uHUnHm9rp4zo6DcCEfaGO4/VD5PrckjY3PQe6zkrksQgSgfvB7PutExIzUDrjL9Yz8oZNbMvKZI+xpbkTPxpw6Y/hp3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pVdVjUQQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=jEbycQkoY9Azc+AVUuDXEFyr7MoYnCHK99x5c0TENqw=; b=pVdVjUQQa79uxa4+
	EMWhBqRmKqBrs9XI5qCf3F7pLmX67mVeyim0A6u5rtEeafpUAangpGyFhfeOXv0AbL/VfZI+eaWBn
	xE4BZkSHxGabrN7BSOfLron793/1vw8WGHdZRILhPKSn5SassfFr0qFQjApFMVxL3HJ7dJJmSXHgx
	cyMJs/a2HGe2jMCWI0upsYdSs9wapGnP/xHuDfX42QG/8kQxoHnDxAuWpXAS9kh7sMuwU+em7t846
	isFB10fntPtXjbkSm6KS6drgtiD3ut2szXAa5c0Jzy2Cg81+5KG+EHpcbgJfSOVTLOV9Kbdap+bPW
	k7lFB/6luppr0PkOlA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1spDF1-005foX-2B;
	Fri, 13 Sep 2024 20:50:07 +0000
From: linux@treblig.org
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] fs/ntfs3: Remove unused al_delete_le
Date: Fri, 13 Sep 2024 21:50:06 +0100
Message-ID: <20240913205006.279177-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'al_delete_le' was added by:
Commit be71b5cba2e6 ("fs/ntfs3: Add attrib operations")

but has remained unused; there is an al_remove_le which seems
to be being used instead.

Remove 'al_delete_le'.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/ntfs3/attrlist.c | 53 ---------------------------------------------
 fs/ntfs3/ntfs_fs.h  |  2 --
 2 files changed, 55 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 9f4bd8d26090..a4d74bed74fa 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -382,59 +382,6 @@ bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le)
 	return true;
 }
 
-/*
- * al_delete_le - Delete first le from the list which matches its parameters.
- */
-bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
-		  const __le16 *name, u8 name_len, const struct MFT_REF *ref)
-{
-	u16 size;
-	struct ATTR_LIST_ENTRY *le;
-	size_t off;
-	typeof(ni->attr_list) *al = &ni->attr_list;
-
-	/* Scan forward to the first le that matches the input. */
-	le = al_find_ex(ni, NULL, type, name, name_len, &vcn);
-	if (!le)
-		return false;
-
-	off = PtrOffset(al->le, le);
-
-next:
-	if (off >= al->size)
-		return false;
-	if (le->type != type)
-		return false;
-	if (le->name_len != name_len)
-		return false;
-	if (name_len && ntfs_cmp_names(le_name(le), name_len, name, name_len,
-				       ni->mi.sbi->upcase, true))
-		return false;
-	if (le64_to_cpu(le->vcn) != vcn)
-		return false;
-
-	/*
-	 * The caller specified a segment reference, so we have to
-	 * scan through the matching entries until we find that segment
-	 * reference or we run of matching entries.
-	 */
-	if (ref && memcmp(ref, &le->ref, sizeof(*ref))) {
-		off += le16_to_cpu(le->size);
-		le = Add2Ptr(al->le, off);
-		goto next;
-	}
-
-	/* Save on stack the size of 'le'. */
-	size = le16_to_cpu(le->size);
-	/* Delete the le. */
-	memmove(le, Add2Ptr(le, size), al->size - (off + size));
-
-	al->size -= size;
-	al->dirty = true;
-
-	return true;
-}
-
 int al_update(struct ntfs_inode *ni, int sync)
 {
 	int err;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index e5255a251929..f0cf4c8aa1ec 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -471,8 +471,6 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
 	      u8 name_len, CLST svcn, __le16 id, const struct MFT_REF *ref,
 	      struct ATTR_LIST_ENTRY **new_le);
 bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le);
-bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
-		  const __le16 *name, u8 name_len, const struct MFT_REF *ref);
 int al_update(struct ntfs_inode *ni, int sync);
 static inline size_t al_aligned(size_t size)
 {
-- 
2.46.0


