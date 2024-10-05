Return-Path: <linux-kernel+bounces-352182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E29991B57
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 01:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7E51C21045
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FC165EFB;
	Sat,  5 Oct 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hIqsSE+A"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF013635B
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 23:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728170767; cv=none; b=S+iUgxVetXMoyRN/boxsXGBqUalboKnrP0oqwpQpRnzFgBbJzeanEvtdSB7jj0hoFr7WtxcLvQhUZ3YUXJmHtlzkvj+h7iEpbO8BBr+CIspwj93TJx5H4KZLLQ3mmoojeuOZFKGzj1pTDMMeSisWx9Du1RIZKZ3slpCidlmecsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728170767; c=relaxed/simple;
	bh=U2nCiiMgFI8/IuIo1nA7qhFhCW2NcDPzmoQuNlIQKb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPpou3+HHR8EiWp8/tl4JOYiN1iGOxnh8GBWeeJKH4Qq+2Nmr6NnZIt1gIMMbL6m1dS8ckCa2SsJJmRLBI53E8BGm4auNkHKVU7uhts6EGfpEJQ2RYyUzuA7S/g8H6BvBsweaBEHPYotur8OTYRYL3O7aV3rnQPUZ4GKgYeS5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hIqsSE+A; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=bH75UUiSgOjpB/GMh3ZaKU2cpH9596DeOfRb2X80uds=; b=hIqsSE+AIGrZQCB0
	fHhMqECqnOgaS9R9x8Q+OQ5OSy3feIsGQnjpZH+LFJekn29H0aU5yY7rKAqzZEpg7QFm111bC+PwA
	Iyz5pmSO4cvNw5JwEjINdAE/QnzgMDforcNhWNDdU/aLwSOaEFtgwnQXjLq81o8eS2iFClkpOyvaW
	dE5YDwZJO1VHU23rfXngMp7c9aNTxoysbQGgont3mcOWYEBYZnfujYOA/egfGmagprcfqQ0PTwCZF
	Ekn5aUfyvw8HMM87fi8pubWcBxA82VWOCYtkoHxTj2Y/7C1cQNJlfjwYdMONbZOKsl1mUjGGHoRCZ
	fUDOSqtWe3VCEGe5DQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxE9o-009Da5-2C;
	Sat, 05 Oct 2024 23:25:52 +0000
From: linux@treblig.org
To: hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/rockchip: cdn-dp: Remove unused functions
Date: Sun,  6 Oct 2024 00:25:51 +0100
Message-ID: <20241005232551.307399-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

cdn_dp_get_event and cdn_dp_dpcd_write were added in 2017 by commit
1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")

but unused.
Remove them.
(Build tested only on x86-64)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 39 ---------------------------
 drivers/gpu/drm/rockchip/cdn-dp-reg.h |  2 --
 2 files changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 33fb4d05c506..a57cda971f20 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -244,40 +244,6 @@ int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
 	return ret;
 }
 
-int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
-{
-	u8 msg[6], reg[5];
-	int ret;
-
-	msg[0] = 0;
-	msg[1] = 1;
-	msg[2] = (addr >> 16) & 0xff;
-	msg[3] = (addr >> 8) & 0xff;
-	msg[4] = addr & 0xff;
-	msg[5] = value;
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_DPCD,
-				  sizeof(msg), msg);
-	if (ret)
-		goto err_dpcd_write;
-
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_WRITE_DPCD, sizeof(reg));
-	if (ret)
-		goto err_dpcd_write;
-
-	ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
-	if (ret)
-		goto err_dpcd_write;
-
-	if (addr != (reg[2] << 16 | reg[3] << 8 | reg[4]))
-		ret = -EINVAL;
-
-err_dpcd_write:
-	if (ret)
-		DRM_DEV_ERROR(dp->dev, "dpcd write failed: %d\n", ret);
-	return ret;
-}
-
 int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
 			 u32 i_size, const u32 *d_mem, u32 d_size)
 {
@@ -400,11 +366,6 @@ int cdn_dp_event_config(struct cdn_dp_device *dp)
 	return ret;
 }
 
-u32 cdn_dp_get_event(struct cdn_dp_device *dp)
-{
-	return readl(dp->regs + SW_EVENTS0);
-}
-
 int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
 {
 	u8 status;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index 441248b7a79e..68c3dbff1123 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -459,9 +459,7 @@ int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
 int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable);
 int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip);
 int cdn_dp_event_config(struct cdn_dp_device *dp);
-u32 cdn_dp_get_event(struct cdn_dp_device *dp);
 int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
-int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value);
 int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len);
 int cdn_dp_get_edid_block(void *dp, u8 *edid,
 			  unsigned int block, size_t length);
-- 
2.46.2


