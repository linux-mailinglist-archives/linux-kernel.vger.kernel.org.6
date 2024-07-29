Return-Path: <linux-kernel+bounces-265187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B793EDB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4072821B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1013184FAC;
	Mon, 29 Jul 2024 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y2lGS09b"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088522119
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236349; cv=none; b=Sw098IOABK/zLhZzdi3/Mo5PE+Cogz7XqiackpfB0QOgJeF8f+yar5kqghV0pOq+ydFJr1Joywyh8dlExqy9aG+7UzIOXDOP4c+Kl56A1t2deKlPNsTqBihDIae34HwFFZxMBbbrxhaS5Iad9rrxojoZXc/Z4yHUhu9kkXz4Vdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236349; c=relaxed/simple;
	bh=1cv/1ReaA2D0soxwMq6cYRYxpIcLJH+dDH6Ctd7iF5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B7Xwm53KUgAu+UNpxvGSpPfRXAoSKx6lPt/S72VEfRKH1OfnTnv8ALMs9VmNCXv0NfOv2vAGPIVtrY08xmH/MK6BmY1W4oYLxFp4JBncLSQy6Ledq3ku6mG9e+LNJ4Lbd9h+jdEOipZyH7knlis/o3dWpEu+i98iBJoqeThnWJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y2lGS09b; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qMnAg
	qz5utWZu6iGhNxZV1JaRMw2eNLw6IaRXRPszgk=; b=Y2lGS09bGUNCXBd5EvKXD
	PnLX9Vz2A0zg4U6lEfrMGLubHwD17OK+6Z5UlZuHIzyGIw6ZggYIVk9M68kVEMS4
	pIUZOX/BI8GDGo6ewgQL7b785CP+mq6Hyt106ONlHDK3zWYbvjoQ6IoTbOlbJ42F
	VqsrIJLFuQai9H1VK1qrJw=
Received: from localhost.localdomain (unknown [111.48.69.247])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3X051Padm2W56Ew--.54492S2;
	Mon, 29 Jul 2024 14:57:58 +0800 (CST)
From: oushixiong1025@163.com
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm: Add the missing symbol '.'
Date: Mon, 29 Jul 2024 14:57:56 +0800
Message-Id: <20240729065756.123788-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X051Padm2W56Ew--.54492S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3uw4UJr1kAry8Gw13CFg_yoWfXrX_u3
	W7WwsrJrZrA3sFvFnIvanFqF9Fka4Y9F48Gw4vga4ftw12yw13JF4qgrsavr1DGw48AF98
	tanrXr17ZFnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8dOz7UUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXRorD2XAmeWNiwAAs8

From: Shixiong Ou <oushixiong@kylinos.cn>

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/drm_probe_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index bb49d552e671..285290067056 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -888,7 +888,7 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
  * disabled. Polling is re-enabled by calling drm_kms_helper_poll_enable().
  *
  * If however, the polling was never initialized, this call will trigger a
- * warning and return
+ * warning and return.
  *
  * Note that calls to enable and disable polling must be strictly ordered, which
  * is automatically the case when they're only call from suspend/resume
-- 
2.25.1


