Return-Path: <linux-kernel+bounces-205577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 667C38FFDB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023891F23680
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6E15AAC1;
	Fri,  7 Jun 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tHm8i6C9"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB8155324
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747053; cv=none; b=kG0s6orZQhheyubROMcBRUdn9kHgnfVRCPKgznt5JkCFoY1KKX+9oCELuwhei7d+HDt7JkPcVIAofvAjlfo0PuzJZEJMcvOP+odOoX7VuEKVzXmmK+5d0575rUl9zQuosm650TixAkfW6bvPIjvfKiz6sXw80HzqzuaDrZxvS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747053; c=relaxed/simple;
	bh=FpuvL4593qRHlpmjQ1YfxZrUGHYKS16ufcV/X677aEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sq/AII7BFxPntBCAwM8b17CpmJIpnUeGLvfp4HRQ0ECPwSQARdrozuzcSogFHMj1Xtl5p8zbwGtTVLixgSTKoWUPVODFVTDgvBvmmpF5hrs755/5/wjeHdVb0YBox7HEiuHMDaWFDuLYz6yFNQ+lBUD2G8YYjwN5Z0QL4zehGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tHm8i6C9; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717747042; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LGPDSuEWYQNsSeMeTMESqBCmFs0R73CKvSwzI1HJPxw=;
	b=tHm8i6C9rYGeoA8m7W7ZoA8ll4YNwS2xxfBmya/R819cuKF7sluM3EdNnd5JJdFdE/IHHqZNkv5FXFClVu81omwso4FDdn59dHffJAv9xzgxlEMByL9o4Drst91unMK7z+1GUUAvuwSxea6Dtq/lJu21uTlm1BvioEfkohjHCR4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8-TjpP_1717747041;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W8-TjpP_1717747041)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 15:57:22 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: dave.jiang@intel.com,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] ntb: Fix kernel-doc param for ntb_transport_create_queue
Date: Fri,  7 Jun 2024 15:57:20 +0800
Message-Id: <20240607075720.77136-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch updates ntb_transport_create_queue() kdoc header to specify the
correct input parameters used by the function.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ntb/ntb_transport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9e7847a378e..5d466a3f117b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1966,9 +1966,10 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
 
 /**
  * ntb_transport_create_queue - Create a new NTB transport layer queue
- * @rx_handler: receive callback function
- * @tx_handler: transmit callback function
- * @event_handler: event callback function
+ * @data: user-defined data to associate with the queue
+ * @client_dev: the device structure of the NTB client
+ * @handlers: structure containing receive, transmit, and event callback
+ *	      functions
  *
  * Create a new NTB transport layer queue and provide the queue with a callback
  * routine for both transmit and receive.  The receive callback routine will be
-- 
2.20.1.7.g153144c


