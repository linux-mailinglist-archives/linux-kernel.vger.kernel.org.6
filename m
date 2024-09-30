Return-Path: <linux-kernel+bounces-343857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FA698A063
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D7C286756
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C431925B3;
	Mon, 30 Sep 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="m+BZf78l"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064B51917CE;
	Mon, 30 Sep 2024 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695310; cv=none; b=rszASwdtbEsAbInpBXZLHfeo7cRRU4rC3NTQMMjj9P0D6pvKau0rCb04XxY4g5y65uf3pio/7cknPlFjkUtj2m9zkYCcru8eCsNJtVcIia8PSvfT86kc/OMGit8dVcxda9VS4sUFJkMUEh8n6YHHJkhf6YZOP9ALZew+M2CLMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695310; c=relaxed/simple;
	bh=xNCCKhkH5T4nEuciH0Wx5E5MCm4jd9UEmtVF0z4WlU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjXiM6ujR2D1Iew/x7aZMB4HwITNYURe/6S3uC2tiQl8eZQz7aeDyCAnjdR75P8gECA9gfSNnVlIW9ZLunWwJw30rMVmQAM5QL1ZlkgXlYVGtHViFDlMr4JjIuigdDLZPnTk8ovGw4lMmJwY1HQ6iouYepxWlaYgPZxWXWX9Fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=m+BZf78l; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CTfrBTHtE2N5e4XS3bQTDf0+jRY2b4e2Jn7IEE+c/y0=;
  b=m+BZf78lNsIY/Duy6QRs5HJ6/KjWLAtPrWPKL6uqjvGBz78G8TpwNVyS
   4Sgz9Ts5DcGXdIDfsVHopy+IhrzTZTEKwxoUFEzQvj4QjIifNluaeDZVV
   gul8UUTnlTW+feA7lWLMIBbViHxvDVjZnDnK7GmOnChT/hJEaOdMXqyWY
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956885"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: kernel-janitors@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/35] maple_tree: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:00 +0200
Message-Id: <20240930112121.95324-15-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 lib/maple_tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 37abf0fe380b..b7f59c40530e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4327,9 +4327,9 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
  * mas_alloc_cyclic() - Internal call to find somewhere to store an entry
  * @mas: The maple state.
  * @startp: Pointer to ID.
+ * @entry: The entry to store.
  * @range_lo: Lower bound of range to search.
  * @range_hi: Upper bound of range to search.
- * @entry: The entry to store.
  * @next: Pointer to next ID to allocate.
  * @gfp: The GFP_FLAGS to use for allocations.
  *


