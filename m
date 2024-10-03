Return-Path: <linux-kernel+bounces-348472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0698E819
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4BB1C256EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96080027;
	Thu,  3 Oct 2024 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Plu6LJo0"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9C54FAD;
	Thu,  3 Oct 2024 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727918184; cv=none; b=V4cJlZPR5Pq4iZ0doHNknA+YUGZ2TQrFJm3Q2VtTxq/gpxezMdRCCBgwB02utOFG0I0A2DSE8948GSV8mbrlF7T91Z7TM3F7hLIPPCPQMCMkgXMjI4BVQ+FMssC7EtUjcMBe3YJyao/BUQI306s+DCPeG6+i37fQQUW8z/WqzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727918184; c=relaxed/simple;
	bh=yRyRu09rjWWRWVV1/aff06NT17wDw3k6NqMkdlOVvWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+y1KoGfP78MtyQFiDp2srkRZD0U77mRW1JYQW5F/B2UQ2sAtraO64nXlK/0UMqQFZdS80YUy0tDKW8wCRGd1Ev9IdD+1rJ4HxdqPRgRcpw7HpEBYm/BnKz9k4PD7f9qjWqo9BLGQqNVn9Rp4znIEfJ6qtob/7H0v9UilyrnkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Plu6LJo0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=PdU9COH57s3vSHoEOCAqWIpM+hbAu2HfjusrmOZfRXM=; b=Plu6LJo0UcIThH5g
	oi4hWfeLULlgjGuzO4UNU+KhEQoudNFc725ZkUskq3ZO9PmGJhmz+Fp0NdBBV++o7jPT03cZw06kb
	B/mL20z9F94+rvmDgtYlCta5dRLlIq33ZhFNXEaVJezOTPFdEHUTSong/DMW76nAKm31OPtB3r+iQ
	dHn8EczfYIcDdqAEpjym/HeYG0jMWwliKZItW0OJWS91neZtB2tIgn0Yy6fsAADpyYXWI+WcMCEyl
	/VPmfKZGMyFOgyCW0ugeMH2gzsPcL0UET5YHlgnn4KXEkcK/QTYypIn2ugyXBfPEbRMdkvJGQ950t
	t/YE6BFzwc1EPUuqjw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1swARu-008Zju-07;
	Thu, 03 Oct 2024 01:16:10 +0000
From: linux@treblig.org
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/9] dm cache: Remove unused dm_cache_size
Date: Thu,  3 Oct 2024 02:15:48 +0100
Message-ID: <20241003011554.266654-4-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003011554.266654-1-linux@treblig.org>
References: <20241003011554.266654-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

dm_cache_size() has been unused since the original commit
c6b4fcbad044 ("dm: add cache target")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/md/dm-cache-metadata.c | 9 ---------
 drivers/md/dm-cache-metadata.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index 5c757603ab36..a9a1ab284076 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1218,15 +1218,6 @@ int dm_cache_load_discards(struct dm_cache_metadata *cmd,
 	return r;
 }
 
-int dm_cache_size(struct dm_cache_metadata *cmd, dm_cblock_t *result)
-{
-	READ_LOCK(cmd);
-	*result = cmd->cache_blocks;
-	READ_UNLOCK(cmd);
-
-	return 0;
-}
-
 static int __remove(struct dm_cache_metadata *cmd, dm_cblock_t cblock)
 {
 	int r;
diff --git a/drivers/md/dm-cache-metadata.h b/drivers/md/dm-cache-metadata.h
index 3e5472173baa..5f77890207fe 100644
--- a/drivers/md/dm-cache-metadata.h
+++ b/drivers/md/dm-cache-metadata.h
@@ -71,7 +71,6 @@ void dm_cache_metadata_close(struct dm_cache_metadata *cmd);
  * origin blocks to map to.
  */
 int dm_cache_resize(struct dm_cache_metadata *cmd, dm_cblock_t new_cache_size);
-int dm_cache_size(struct dm_cache_metadata *cmd, dm_cblock_t *result);
 
 int dm_cache_discard_bitset_resize(struct dm_cache_metadata *cmd,
 				   sector_t discard_block_size,
-- 
2.46.2


