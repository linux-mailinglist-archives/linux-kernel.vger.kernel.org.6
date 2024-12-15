Return-Path: <linux-kernel+bounces-446577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2CC9F266B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F567163AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320961D696;
	Sun, 15 Dec 2024 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="n0zL26eG"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE338DC8
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300025; cv=none; b=E/lUaTU7a08AaXXmNrslC2O95vi7FUdGKP+rw+eOUWR0l0iyFPwGc/imM5anyyoeqxtjErGdYgeQJM+jOqGqOvs1txJaq7UO9PFA2QPCEwfYlldBXOEhdZjsDInvcQjcVhf1wSGi/Nn8IQfzxUB42HuZV6/kXfKmAxKxTEv6J80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300025; c=relaxed/simple;
	bh=208BiTv2DepqDoiOAGVV/y0GTGq2EYW+abeF7itm9I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7IwaERGPdenfOHexVlSKIb62bxo3eOnHM2eDFBTfF10qV0hcsh6GBstDLY84qROzhFs+6nw6Kfb9+KQxhU7I5zKdd++7ov9MJZVuswcOfp4CtyHpP1YFluzZjQ1CrLh5sIoJIugrKu0qPHKtGOVul/VygIjDg/u5lNrdCkTVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=n0zL26eG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=j25qHSApzncyRr3fV7n8eHJV1JPDpKKPKVP7ZGcHdZE=; b=n0zL26eGyIFWHeWs
	Nzie2G75r64ALTSe/EIglaUawMZ9iQfVzz6G0tbnvkoKJWosuvPgNx8X4oL0HTbNC2ouRQ9HYwCq7
	5+GQbtIPXjKkPP6eJcXYokAvuOcJZ/6uMqG3u4RByOkjb8FHqQ+8ON9/ncZrBxmJ9YY9nfLjRFVx9
	xXlhaPlu48KDpdPJi3QBZMCziAtgkXyc45gyXq/KygNP0TM7KgV+/hkYvg/dThu1t0YvZwoaxnpT0
	Q8Kx33FSH2fKUGhVMC46p9nvaCBcA4HJdKTLD0Dt1QjfhG/mNLyzg2qEgLPpJDVza2knj4fihWd3a
	5ef6yaeYT8LcOTWn5g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tMwes-005V34-2K;
	Sun, 15 Dec 2024 22:00:14 +0000
From: linux@treblig.org
To: hdegoede@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/vboxvideo: Remove unused hgsmi_cursor_position
Date: Sun, 15 Dec 2024 22:00:14 +0000
Message-ID: <20241215220014.452537-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hgsmi_cursor_position() has been unused since 2018's
commit 35f3288c453e ("staging: vboxvideo: Atomic phase 1: convert cursor to
universal plane")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/vboxvideo/hgsmi_base.c      | 37 ---------------------
 drivers/gpu/drm/vboxvideo/vboxvideo_guest.h |  2 --
 2 files changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_base.c b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
index 87dccaecc3e5..db994aeaa0f9 100644
--- a/drivers/gpu/drm/vboxvideo/hgsmi_base.c
+++ b/drivers/gpu/drm/vboxvideo/hgsmi_base.c
@@ -181,40 +181,3 @@ int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
 
 	return rc;
 }
-
-/**
- * hgsmi_cursor_position - Report the guest cursor position.  The host may
- *                         wish to use this information to re-position its
- *                         own cursor (though this is currently unlikely).
- *                         The current host cursor position is returned.
- * Return: 0 or negative errno value.
- * @ctx:              The context containing the heap used.
- * @report_position:  Are we reporting a position?
- * @x:                Guest cursor X position.
- * @y:                Guest cursor Y position.
- * @x_host:           Host cursor X position is stored here.  Optional.
- * @y_host:           Host cursor Y position is stored here.  Optional.
- */
-int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
-			  u32 x, u32 y, u32 *x_host, u32 *y_host)
-{
-	struct vbva_cursor_position *p;
-
-	p = hgsmi_buffer_alloc(ctx, sizeof(*p), HGSMI_CH_VBVA,
-			       VBVA_CURSOR_POSITION);
-	if (!p)
-		return -ENOMEM;
-
-	p->report_position = report_position;
-	p->x = x;
-	p->y = y;
-
-	hgsmi_buffer_submit(ctx, p);
-
-	*x_host = p->x;
-	*y_host = p->y;
-
-	hgsmi_buffer_free(ctx, p);
-
-	return 0;
-}
diff --git a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
index 55fcee3a6470..643c4448bdcb 100644
--- a/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
+++ b/drivers/gpu/drm/vboxvideo/vboxvideo_guest.h
@@ -34,8 +34,6 @@ int hgsmi_query_conf(struct gen_pool *ctx, u32 index, u32 *value_ret);
 int hgsmi_update_pointer_shape(struct gen_pool *ctx, u32 flags,
 			       u32 hot_x, u32 hot_y, u32 width, u32 height,
 			       u8 *pixels, u32 len);
-int hgsmi_cursor_position(struct gen_pool *ctx, bool report_position,
-			  u32 x, u32 y, u32 *x_host, u32 *y_host);
 
 bool vbva_enable(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
 		 struct vbva_buffer *vbva, s32 screen);
-- 
2.47.1


