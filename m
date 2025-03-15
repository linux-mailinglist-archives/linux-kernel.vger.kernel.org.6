Return-Path: <linux-kernel+bounces-562405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06BA6261E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 05:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4C242029D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB4318B484;
	Sat, 15 Mar 2025 04:48:10 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4A376
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742014090; cv=none; b=byT5llYROmRNZazlil5bm+9XjxI6doykV8b1g5w40TJ3vf5c0b6eLxiJxqKibI5xBB1NRbJo7zj+gk5sp6dd0oU2WDFQJAp4itIefT9w/v+vAsCkAxWP1de2tVbF4nFRNMAZqKWSfKcYAfMepyGWE74tNyPcalFasbRMi+PrdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742014090; c=relaxed/simple;
	bh=slZqHKRCXbTLW55e2hzu9MhyzSWZgXax1voMKAKaSQE=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=iG70TPJtODTHyAN4417QT+XS67F9ZLRGLm5Biur2qcHyVtqGRFISW20HCNDAXdJjBz0IMBAWLrZ5suUjJPZn/j6R0xbcFeS5CxhFaAUyi0NUROwpgIoUx4KdPlRI1DmYH/YBc32lpmQ43SyLluAj99v8qr1dmhlCqrxrnPtV2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZF7yn5sVnz8R03d;
	Sat, 15 Mar 2025 12:48:01 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52F4lul3079032;
	Sat, 15 Mar 2025 12:47:56 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 12:47:56 +0800 (CST)
Date: Sat, 15 Mar 2025 12:47:56 +0800 (CST)
X-Zmail-TransId: 2afc67d5067c64c-14494
X-Mailer: Zmail v1.0
Message-ID: <20250315124756851v6UQVu4NRD-RV62eoG0va@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <mripard@kernel.org>
Cc: <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <simona@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm06IFJlcGxhY2UgbmVzdGVkIG1heCgpIHdpdGggc2luZ2xlIG1heDMoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52F4lul3079032
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D50681.000/4ZF7yn5sVnz8R03d

From: FengWei <feng.wei8@zte.com.cn>

Use max3() macro instead of nesting max() to simplify the return
statement.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 drivers/gpu/drm/drm_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index f593dc569d31..115a8eb0d8a5 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -856,7 +856,7 @@ long drm_ioctl(struct file *filp,
 		in_size = 0;
 	if ((cmd & ioctl->cmd & IOC_OUT) == 0)
 		out_size = 0;
-	ksize = max(max(in_size, out_size), drv_size);
+	ksize = max3(in_size, out_size, drv_size);

 	drm_dbg_core(dev, "comm=\"%s\" pid=%d, dev=0x%lx, auth=%d, %s\n",
 		     current->comm, task_pid_nr(current),
-- 
2.25.1

