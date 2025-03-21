Return-Path: <linux-kernel+bounces-570609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67D7A6B283
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F77448829E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74522AE69;
	Fri, 21 Mar 2025 01:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iEZbggtj"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749911F949
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742519240; cv=none; b=OdxCgCBjwQa3NG1BMdpkTmInUB/EdwLeQYpxLu/jpt963lhLYMZVh0IvuXrSsCa+CKY/kwbLgIsXMUzbDEVNOvLUw5OqO5BRkwuvUNlA6ishmEalubZUz++SO4wQDNMQBoPyIs/a5zr8+plybsFJhzSxSe/3sjpcKvVNgwnAu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742519240; c=relaxed/simple;
	bh=LzjLWtNm8vIx5m/jeMY8e5F6Ay/oAnGOKZbPpKEEA3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCfA56PRNNLewGi9OW4dsq0ueSGu5hUs9emcV6sNhLh3V/ci23EKFJ67oQeesDwzyDoa+FO+TOZYln3iDOf8QbyFjw0/NtvbosTdYCDlCUvBxkkIYPRN78M6AhXqlE3qhv3BjGA8CCzDd0OOZSdidwGdLQ7rDImBEpVeSuWTEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iEZbggtj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742519223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WVZwF7aFIAedNImI3f0zkPZlr8EcTIXGZ6tIWmPnltQ=;
	b=iEZbggtjtl+3K2e42DqCYGW/GyIiFB1eviHiXmcOHdNnHVTGsDtK+ncpP/pFdql+jbPV8j
	ZsulXdX62DHD/FDquYJyo9HMLNiyTvNmOREV+V9BjTAVFcabrKPveVmxgEo28V9zCZUn2f
	UCoE9Gfir6xkq2NfyCMnhBJeN4WSEOQ=
From: sunliming@linux.dev
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	everestkc@everestkc.com.np,
	niharchaithanya@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sunliming <sunliming@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] staging: gpib: warning: variable 'nec_priv' set but not used warning
Date: Fri, 21 Mar 2025 09:06:49 +0800
Message-Id: <20250321010649.10918-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below kernel warning:
drivers/staging/gpib/eastwood/fluke_gpib.c:196:23: warning: variable 'nec_priv' set but not
used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/staging/gpib/eastwood/fluke_gpib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 0304c5de4ccd..6854a745ccff 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -194,10 +194,8 @@ static int fluke_line_status(const gpib_board_t *board)
 	int status = ValidALL;
 	int bsr_bits;
 	struct fluke_priv *e_priv;
-	struct nec7210_priv *nec_priv;
 
 	e_priv = board->private_data;
-	nec_priv = &e_priv->nec7210_priv;
 
 	bsr_bits = fluke_paged_read_byte(e_priv, BUS_STATUS, BUS_STATUS_PAGE);
 
-- 
2.25.1


