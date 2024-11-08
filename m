Return-Path: <linux-kernel+bounces-402048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEC09C22B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC071C23023
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6E8199953;
	Fri,  8 Nov 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PxLPn6qw"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEE1EE000
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085898; cv=none; b=g6qXEMVENons31489Owm2+t/J2lRt6XtZO93bVExT2JV3I3jLVmO2O6mHzFptTh2yW2dNm9i71SKy5kxCwItZ5rSQVd9bglGYidjAWH8uE/Q27mB8xeOclNj1t1g5Gx3dx5eNQ9Kvbit6RtgILAO0wBq9LoxOmS2KNhrMmUR82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085898; c=relaxed/simple;
	bh=75Eg7EgzGb3t2skGxXRtHLRyHgVkEk6GPLFLwnWUtYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mx34yotfKXic8MWR/ONSR2dK+3d2pqZ4EskIdsnyGC36+hZ4CKuxMzPIa15BUyudyDUUzU+mJqSZXhWxoXASmyTtu4UfXTBO4AMDslB+fzaZC/Wy9tcE9R0E1m5JeupuCMO1GfgNCmWNaYEYAzTIVHzwpk+55edmkwZPRVpd4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PxLPn6qw; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731085892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5DHk+sDKjM8ibnVVCT79MDemuf2uF3Kitw2xqyF/tU=;
	b=PxLPn6qwXZ50sll3FIFN4jFLQJdkQzNSiHc7KJkt8lHdBXEs328SBfr3oSp+bGz0Q2/gFn
	H6Ilf6JijbFe0aIygNaDnwvF28MgzFlrD39H7q+BWNu27T1OBfiRc5ILVSB/IGEOH7RhGV
	kOHTdLlBT7A/zHfnp9r9urokJ5ELs7s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Remove unneeded semicolons
Date: Fri,  8 Nov 2024 18:10:16 +0100
Message-ID: <20241108171015.1973-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove duplicate semicolons.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/btree_cache.c | 2 +-
 fs/bcachefs/btree_iter.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index a0a406b0c7bc..c313a5bce886 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -519,7 +519,7 @@ static unsigned long bch2_btree_cache_scan(struct shrinker *shrink,
 		if (btree_node_accessed(b)) {
 			clear_btree_node_accessed(b);
 			bc->not_freed[BCH_BTREE_CACHE_NOT_FREED_access_bit]++;
-			--touched;;
+			--touched;
 		} else if (!btree_node_reclaim(c, b, true)) {
 			__bch2_btree_node_hash_remove(bc, b);
 			__btree_node_data_free(bc, b);
diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index b47bfcc438f3..cc13fe1d2be6 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -2699,7 +2699,7 @@ struct bkey_s_c bch2_btree_iter_peek_prev_min(struct btree_iter *iter, struct bp
 	}
 
 	/* Extents can straddle iter->pos: */
-	iter->pos = bpos_min(iter->pos, k.k->p);;
+	iter->pos = bpos_min(iter->pos, k.k->p);
 
 	if (iter->flags & BTREE_ITER_filter_snapshots)
 		iter->pos.snapshot = iter->snapshot;
-- 
2.47.0


