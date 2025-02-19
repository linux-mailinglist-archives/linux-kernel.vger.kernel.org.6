Return-Path: <linux-kernel+bounces-520774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D347A3AF12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3391887E50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856113FD86;
	Wed, 19 Feb 2025 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="mh560O6V"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B421805A;
	Wed, 19 Feb 2025 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929562; cv=none; b=Iyyrgs1njz1uR1n9Jxh9iUX4f5Y1WOp+rica8C0OfCmikP0l1TCyzz5lxXeVGTfkh4UwwIGf9215INfbYgaYYer+zjyQirURBmWJUD0XZeExpzGaRVL6MSQh4lvaXUsvQjk5TJgvyGLxvivpIW1VQnOfX7Ca9EbncB7Zrwu1JpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929562; c=relaxed/simple;
	bh=X2xNTqB/Cqa4cbVnrIEsF4+3Pw6nAfHkwNBHVpwCN0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNZKZ3VANFSLDGt+bLyAjSNssBoUma4Zroc2DIZrh/U7OftZC3Y+VkCJ/JbsVm/4t3QytJw1T1MYfvvAhP02B7GWmT/9Ew2HutD4eXCsaLKmtM4bYEfhjHaf/TK+1Xod5EZFCY2ID7Jm9UkSq4nMekjKdgenqG6lGOxfEu/og88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=mh560O6V; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=wgJVz3rQRUpYbvizKytamBakn0wuddTOgzOQZp1vbQQ=; b=mh560O6VDYkV0bFz
	Ffv+Jt5xPynWLQmU7rNdRXSN7txHnIZWU3sMDfIiPIyMZSTLCel/MVz5xHe0gvZMMbRKVt0AjumTd
	pI/vmYbmlSVh0NpDnT9HaJvP3hfjTzSX4mrsm5Iu17SSOODN/rGQ/vrALH5nIqMeSBf0pQFYMliuI
	9yqgfOiUrxLNz+xdlqclx1DquV3sVa8iQQgtbLj+hoH6LWMTe7anZpFMPjnPJDWZbWWw5AL+zBrLq
	RUEzxC2Dof2b5ue9/l5dJoDAMrRBZbBpM9Iq0plsmMBJYIQQYlQ5zWjE1BKzKVZG46izhYoYIFTRg
	wjs0/KGKYK7KJEuhpw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tkZ9x-00GmJC-1w;
	Wed, 19 Feb 2025 01:45:57 +0000
From: linux@treblig.org
To: almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] fs/ntfs3: Remove unused ni_load_attr
Date: Wed, 19 Feb 2025 01:45:54 +0000
Message-ID: <20250219014556.293497-2-linux@treblig.org>
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

ni_load_attr() was added in 2021 by
commit 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 fs/ntfs3/frecord.c | 57 ----------------------------------------------
 fs/ntfs3/ntfs_fs.h |  3 ---
 2 files changed, 60 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 5df6a0b5add9..d227f9923290 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -280,63 +280,6 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return rec_find_attr_le(ni, mi2, le2);
 }
 
-/*
- * ni_load_attr - Load attribute that contains given VCN.
- */
-struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
-			    const __le16 *name, u8 name_len, CLST vcn,
-			    struct mft_inode **pmi)
-{
-	struct ATTR_LIST_ENTRY *le;
-	struct ATTRIB *attr;
-	struct mft_inode *mi;
-	struct ATTR_LIST_ENTRY *next;
-
-	if (!ni->attr_list.size) {
-		if (pmi)
-			*pmi = &ni->mi;
-		return mi_find_attr(ni, &ni->mi, NULL, type, name, name_len,
-				    NULL);
-	}
-
-	le = al_find_ex(ni, NULL, type, name, name_len, NULL);
-	if (!le)
-		return NULL;
-
-	/*
-	 * Unfortunately ATTR_LIST_ENTRY contains only start VCN.
-	 * So to find the ATTRIB segment that contains 'vcn' we should
-	 * enumerate some entries.
-	 */
-	if (vcn) {
-		for (;; le = next) {
-			next = al_find_ex(ni, le, type, name, name_len, NULL);
-			if (!next || le64_to_cpu(next->vcn) > vcn)
-				break;
-		}
-	}
-
-	if (ni_load_mi(ni, le, &mi))
-		return NULL;
-
-	if (pmi)
-		*pmi = mi;
-
-	attr = mi_find_attr(ni, mi, NULL, type, name, name_len, &le->id);
-	if (!attr)
-		return NULL;
-
-	if (!attr->non_res)
-		return attr;
-
-	if (le64_to_cpu(attr->nres.svcn) <= vcn &&
-	    vcn <= le64_to_cpu(attr->nres.evcn))
-		return attr;
-
-	_ntfs_bad_inode(&ni->vfs_inode);
-	return NULL;
-}
-
 /*
  * ni_load_all_mi - Load all subrecords.
  */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 382820464dee..2034dca90a5e 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -530,9 +530,6 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 			       struct ATTR_LIST_ENTRY **le,
 			       struct mft_inode **mi);
-struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
-			    const __le16 *name, u8 name_len, CLST vcn,
-			    struct mft_inode **pmi);
 int ni_load_all_mi(struct ntfs_inode *ni);
 bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi);
 int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
-- 
2.48.1


