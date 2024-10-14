Return-Path: <linux-kernel+bounces-363803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C1399C748
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C381F235DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D017B51A;
	Mon, 14 Oct 2024 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqWPE431"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D3170A15;
	Mon, 14 Oct 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902298; cv=none; b=CuSMINB3deYI3/oPNHDfFqLKJW1y2/0LiU6AkWbOnCT2eCu7cOoNonkjcXIoXE195KwEvF4CxC5qZb/wgbPfDrGZpEsjqXKVziU9aMnNdFey8TZda/LS03h0b3Ik5M9/4zb6pn84yze1dfxHxg9kY+JTPWq8HRMRs/JvBnxKNKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902298; c=relaxed/simple;
	bh=Z4tHIoKQq8t0bvhXTL19D9qGxsgh/EFKiNcGeEuil+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=id2UBlPA6+fWfE9UDLYKG6BBDG23MiFWEXWuuyQjWiXjM5x/7CQMEaejThOP6TtQP/6dCTkVTe0aXN4M3RtmOMArkfHhoiCKcA+M9E63z725K1VRlhDNHLECCRGcMKqhUqFXA/7eZOHB6jlZDldcoY3VjZs74DSR7qdISVvV7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqWPE431; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728902297; x=1760438297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z4tHIoKQq8t0bvhXTL19D9qGxsgh/EFKiNcGeEuil+s=;
  b=hqWPE431n3pynHXIEyUT2JCFf8iYC/4fgXqKiuAPvgKQJQcbCo47yrgE
   Gs6F0gEQ6PvJPTBhVRUgQkuhLYlKcOdEzLBzTCGOcVoQNUThQsl2rYysP
   if79yY0Fi7vMnc4gFqfJZOuDl34D6CPS+pKJnR070kiPlHnXRYKR5xXpx
   cAATh2sKCiWj2W6r7W2tICbTYiT98BDefBLNZdUnd9v8q/dW2iS+XEO2m
   hRJdTrZ5dMpZ0klqGOkzBJl16ifjPh3dt7yQsJdSJZP8LclasiK9Sl0Td
   y3pNEtK6hVF7Dra6Lo7BPEne80KjHHojj05XjqlW3qupzgqhIQbs+DJcD
   g==;
X-CSE-ConnectionGUID: DoGjn85IRyi4cqvEbK/e0g==
X-CSE-MsgGUID: luqAZQCpRhq97p3hzteRrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="32160053"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="32160053"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 03:38:16 -0700
X-CSE-ConnectionGUID: j713thrmR2Krl7su8y0JUg==
X-CSE-MsgGUID: PHp5ocJAQPqfnGoPVZeA4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77985597"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 14 Oct 2024 03:38:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7874E2E6; Mon, 14 Oct 2024 13:38:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] tg3: Increase buffer size for IRQ label
Date: Mon, 14 Oct 2024 13:38:10 +0300
Message-ID: <20241014103810.4015718-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC is not happy with the current code, e.g.:

.../tg3.c:11313:37: error: ‘-txrx-’ directive output may be truncated writing 6 bytes into a region of size between 1 and 16 [-Werror=format-truncation=]
11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);
      |                                     ^~~~~~
.../tg3.c:11313:34: note: using the range [-2147483648, 2147483647] for directive argument
11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);

When `make W=1` is supplied, this prevents kernel building. Fix it by
increasing the buffer size for IRQ label and use sizeoF() instead of
hard coded constants.

While at it, move the respective buffer out from the structure as
it's used only in one caller. This also improves memory footprint
of struct tg3_napi.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 12 ++++++------
 drivers/net/ethernet/broadcom/tg3.h |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..b5a2f0e2855e 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -11299,6 +11299,7 @@ static void tg3_reset_task(struct work_struct *work)
 
 static int tg3_request_irq(struct tg3 *tp, int irq_num)
 {
+	char irq_lbl[IFNAMSIZ + 6 + 10]; /* name + "-txrx-" + %d */
 	irq_handler_t fn;
 	unsigned long flags;
 	char *name;
@@ -11307,20 +11308,19 @@ static int tg3_request_irq(struct tg3 *tp, int irq_num)
 	if (tp->irq_cnt == 1)
 		name = tp->dev->name;
 	else {
-		name = &tnapi->irq_lbl[0];
+		name = &irq_lbl[0];
 		if (tnapi->tx_buffers && tnapi->rx_rcb)
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(irq_lbl),
 				 "%s-txrx-%d", tp->dev->name, irq_num);
 		else if (tnapi->tx_buffers)
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(irq_lbl),
 				 "%s-tx-%d", tp->dev->name, irq_num);
 		else if (tnapi->rx_rcb)
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(irq_lbl),
 				 "%s-rx-%d", tp->dev->name, irq_num);
 		else
-			snprintf(name, IFNAMSIZ,
+			snprintf(name, sizeof(irq_lbl),
 				 "%s-%d", tp->dev->name, irq_num);
-		name[IFNAMSIZ-1] = 0;
 	}
 
 	if (tg3_flag(tp, USING_MSI) || tg3_flag(tp, USING_MSIX)) {
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index cf1b2b123c7e..2c5d1eee8068 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3033,7 +3033,6 @@ struct tg3_napi {
 	dma_addr_t			rx_rcb_mapping;
 	dma_addr_t			tx_desc_mapping;
 
-	char				irq_lbl[IFNAMSIZ];
 	unsigned int			irq_vec;
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


