Return-Path: <linux-kernel+bounces-343872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA498A092
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90D528905C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C719ABCD;
	Mon, 30 Sep 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="P5wlDW5v"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF241991B1;
	Mon, 30 Sep 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695318; cv=none; b=Kf+dHq65Wjidys5W+KMk0B1y8Hgrog0gL7+Dh2L9EOCWbtm8caHaRi1CbWfc4A4/Tzi1F0KC8BWCeYoEAHGtchR8uKhY+10hXf0FVZFesTETtrgry4GaVyRqSZwwUJUOgcc/dHOwear3artYWr4hn35Av9LZbp4h6+jQKiWh44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695318; c=relaxed/simple;
	bh=TB4U6VouMk23UP8h1yZrrlqjVbjR7lKpBYDP//HWIAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kr9yabfrW/TA4kfFgWdC1m8gT+/GmEL0J94IAwvHhlr6Z9wFoMOsAFSoohy0DFdEaEK3M298NaumzrhyuJq22eMB9SFSGjAcS/Chqod1Q0c5v2grRPcNeOVnDStAmasfstrIJC/1MLkq16DRvxZhV/g/ziKb/SeLka8UP0IN1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=P5wlDW5v; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u3pl9BpxHhH1BKJ7NLax2viqoTtgY3yczEwlj2/GIFI=;
  b=P5wlDW5vOrd0xdik/YegYucRtAqG+zqLtWfu0YlUeXGptVCDZ9pJJgKx
   IoB+9Nkrs7MUkWmRMNt7krJu3boRmrLFF4agfyctT/hjApw/sT0zuqN5M
   21CfIZyj2FtT25R2IZyDaIl79Qxpp3IptTYAY5SKNgeZBT3gfuzL9AvYP
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956908"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:28 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Richard Weinberger <richard@nod.at>
Cc: kernel-janitors@vger.kernel.org,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 28/35] UBI: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:14 +0200
Message-Id: <20240930112121.95324-29-Julia.Lawall@inria.fr>
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
 drivers/mtd/ubi/eba.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index c7ba7a15c9f7..efce5bf41ef6 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -731,8 +731,8 @@ int ubi_eba_read_leb(struct ubi_device *ubi, struct ubi_volume *vol, int lnum,
  * ubi_eba_read_leb_sg - read data into a scatter gather list.
  * @ubi: UBI device description object
  * @vol: volume description object
- * @lnum: logical eraseblock number
  * @sgl: UBI scatter gather list to store the read data
+ * @lnum: logical eraseblock number
  * @offset: offset from where to read
  * @len: how many bytes to read
  * @check: data CRC check flag


