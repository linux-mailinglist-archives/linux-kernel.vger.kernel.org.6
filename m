Return-Path: <linux-kernel+bounces-268983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A360942BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3421C2163F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAB71AC437;
	Wed, 31 Jul 2024 10:26:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BA8801;
	Wed, 31 Jul 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421588; cv=none; b=KLh7PQ//VF/obXw4LUE3HFVkXqYXXGMcb+U5W3/vmlsK6Eyd4q1OZI1kXezZFqspiB1ZUfbGL89T4nw3MWpZVLTM+J6xnFY92Q/lBgFRBKsj/WgYJOrfrY+n21YPF1n+sP6ydrhwUPu9CQcHUApSufb8GmzezBfDroeLjCdZkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421588; c=relaxed/simple;
	bh=UkfPCXSY0TJpmYvGROn1A/n8nq/8Glii+x0OVkLjdZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HEAkKdwBQMGhiBf+7sDURFjeylCndeQBCLj7Ad+/RF/A7iLH6iiDaM+1BC2Cz3sdSZbTZ152b0ipYr5Gm5cvfIOlFn24KiC0G51OvWLWpKfOTM9iTVxdTYbAKkzLhEViiv2Biq1xX0fO8/nPn/r5apKmalOIwZILLOVdCP6/y9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYpCk42wBzxVxp;
	Wed, 31 Jul 2024 18:26:10 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2833C1400DD;
	Wed, 31 Jul 2024 18:26:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Jul
 2024 18:26:21 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
	<Frank.Li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] xhci: Remove unused function declarations
Date: Wed, 31 Jul 2024 18:24:29 +0800
Message-ID: <20240731102429.1714302-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 674f8438c121 ("xhci: split handling halted endpoints into two steps")
remove xhci_cleanup_stalled_ring() but leave declaration.
And commit 25355e046d29 ("xhci: use generic command timer for stop endpoint commands.")
left behind xhci_stop_endpoint_command_watchdog().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/usb/host/xhci.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index ebd0afd59a60..7d0a09939fa4 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1904,10 +1904,6 @@ int xhci_queue_reset_ep(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		enum xhci_ep_reset_type reset_type);
 int xhci_queue_reset_device(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		u32 slot_id);
-void xhci_cleanup_stalled_ring(struct xhci_hcd *xhci, unsigned int slot_id,
-			       unsigned int ep_index, unsigned int stream_id,
-			       struct xhci_td *td);
-void xhci_stop_endpoint_command_watchdog(struct timer_list *t);
 void xhci_handle_command_timeout(struct work_struct *work);
 
 void xhci_ring_ep_doorbell(struct xhci_hcd *xhci, unsigned int slot_id,
-- 
2.34.1


