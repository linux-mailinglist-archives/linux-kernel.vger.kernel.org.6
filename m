Return-Path: <linux-kernel+bounces-548084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D0A53FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FC21892875
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04013C9A4;
	Thu,  6 Mar 2025 01:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Z3o4sBW/"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DA13957E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223437; cv=none; b=Dg6LPMVKjAkCS32NAw6RDkWtxfN6KdUb/Kfmj8mOT/ofJsA5jYl/dv2sGQFYovNKP9oc88V8m4M7SMfU2YbhzH2DcF9dy0vWZtN/+QbwBk2jqCzbuvvSbPdUIz9mrEW2nPCSZMKB3rrtTzuP5sLX259TeKK3HxdntCY1ugRpxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223437; c=relaxed/simple;
	bh=+Hc8vsUYhQ8odL+uATaoG000r3kc9nDdJqvlcs+g3Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGZoQ0PU0xDYVnxKVHYRDunYSJiVSFv+hjI7t8DHAIX4aRuA9q+pthWjU3o6clBUBtCPtiXZGNmoMKUMaWuCz0hMp56rG0/+JcTb8RpKC6+9v+XQ5voD7yWEqpUu0wjYuP8VqmwOXaxose4RBFCXS4EgA94brVYTWTIEhhtsPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Z3o4sBW/; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=7Y9rS+AETT1NXmp2dmIw1lH8pnQXRJxHrN42KuRZCJA=; b=Z3o4sBW/zaYjxCyN
	3GpmUjqFB+0Iw+8/YEAeyV8W26r/iMHiECPGcHSLSRpHtgJLWKUE6nVl7/Ecm+Nq525ItBZVIslS8
	hV4AFoZfo2nbof/znySjzhfcoB7o5t/MsKZZD/N8wrtEd8p4nOjXK71gh7zIeZod/u7xsfOM2i2R/
	Q4NFMd0IaIcjYTCVBWkccgm3zN58hFduB4TF/gTVws93OY0SL1If3ncQaz+M2sFkYQLNbMMcOkHqH
	rTfNullz92HFjOQX9uPhsVpdvVX/rk817RuuAMo1MPBU4zAN5Hc9mDrZxUM1KtIoSFl8MlgNK9cL+
	iVZ2ZpvKet7OO2Ulcw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpzkp-002zw6-2Y;
	Thu, 06 Mar 2025 01:10:27 +0000
From: linux@treblig.org
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] mfd: ezx-pcap: Remove unused pcap_adc_sync
Date: Thu,  6 Mar 2025 01:10:27 +0000
Message-ID: <20250306011027.257021-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pcap_adc_sync() was added in 2009 by
commit 13a09f93d2bf ("mfd: add PCAP driver")
but has remained unused; the async version is still used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/mfd/ezx-pcap.c       | 33 ---------------------------------
 include/linux/mfd/ezx-pcap.h |  1 -
 2 files changed, 34 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 8d006f6be48c..1be4557b7bdd 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -25,11 +25,6 @@ struct pcap_adc_request {
 	void *data;
 };
 
-struct pcap_adc_sync_request {
-	u16 res[2];
-	struct completion completion;
-};
-
 struct pcap_chip {
 	struct spi_device *spi;
 
@@ -335,34 +330,6 @@ int pcap_adc_async(struct pcap_chip *pcap, u8 bank, u32 flags, u8 ch[],
 }
 EXPORT_SYMBOL_GPL(pcap_adc_async);
 
-static void pcap_adc_sync_cb(void *param, u16 res[])
-{
-	struct pcap_adc_sync_request *req = param;
-
-	req->res[0] = res[0];
-	req->res[1] = res[1];
-	complete(&req->completion);
-}
-
-int pcap_adc_sync(struct pcap_chip *pcap, u8 bank, u32 flags, u8 ch[],
-								u16 res[])
-{
-	struct pcap_adc_sync_request sync_data;
-	int ret;
-
-	init_completion(&sync_data.completion);
-	ret = pcap_adc_async(pcap, bank, flags, ch, pcap_adc_sync_cb,
-								&sync_data);
-	if (ret)
-		return ret;
-	wait_for_completion(&sync_data.completion);
-	res[0] = sync_data.res[0];
-	res[1] = sync_data.res[1];
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pcap_adc_sync);
-
 /* subdevs */
 static int pcap_remove_subdev(struct device *dev, void *unused)
 {
diff --git a/include/linux/mfd/ezx-pcap.h b/include/linux/mfd/ezx-pcap.h
index ffde195e12b7..ea51b1cdca5a 100644
--- a/include/linux/mfd/ezx-pcap.h
+++ b/include/linux/mfd/ezx-pcap.h
@@ -31,7 +31,6 @@ int ezx_pcap_set_bits(struct pcap_chip *, u8, u32, u32);
 int pcap_to_irq(struct pcap_chip *, int);
 int irq_to_pcap(struct pcap_chip *, int);
 int pcap_adc_async(struct pcap_chip *, u8, u32, u8[], void *, void *);
-int pcap_adc_sync(struct pcap_chip *, u8, u32, u8[], u16[]);
 void pcap_set_ts_bits(struct pcap_chip *, u32);
 
 #define PCAP_SECOND_PORT	1
-- 
2.48.1


