Return-Path: <linux-kernel+bounces-221481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553890F445
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C051F23576
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D5158A33;
	Wed, 19 Jun 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow3s5M2H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAD15442F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815125; cv=none; b=AS5o+5c7NeX632eM2vlOKI8EXikPImB84NV0mS7B2L/1iLK2nqBC3xV8/hf7U1LYmf/23pGnMq8patKNhzlvIiF3hQFtWXYMj2uCA7xOW82ooc28t88uXpaKiV5UhbWitQHCiLKvilruYwkkJhUiSGfqEt6iwY4BF5oOr+2NiBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815125; c=relaxed/simple;
	bh=1A8nYQ+AU/gcSYykTj7+s4r366tLXBHAdRsHXP53d9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbKtISICpvEy9bysZMtDY09h1YZMVcfjiTq42R2ouMjlFclf25edx5Y1QYhg6iBVAa3dfrphkijHmQ273Gdicyr2UoHdKolJmWGFeIlOzHvAolVs8SDywmLg/u9YZw4ysFUWydXwKxFom73Nc5iWRmgPqIibWKSJQxNuRQN1sAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow3s5M2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33688C4AF12;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815125;
	bh=1A8nYQ+AU/gcSYykTj7+s4r366tLXBHAdRsHXP53d9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ow3s5M2HFKFOKxYI+ZW7CYPC5YHtBAjegQ7sLko1XvfVKkSRgwNs5mcWenZ2xqqOl
	 wYs0DsrU5KkOlgQBsGatW0MLUYJcidYikTXmtdlWAH0qXJR81GShl87oOqN1OApSN6
	 SNuhnc4MRpTHKg+dpgY5bphjHbJtO85puHSbVYbzY20KFU5SLdV99xgOIQCvO+YwRU
	 1yISELaI2iR7uG4FNH9JG24vPx5hrijNQUSsFw9t1C029AjyuVHh+cdf2r62Qq2rO5
	 bNOyyLVVl5AiBdsRUH5E3RbdjwQ/g83JU+9/GlWmNboBj3uPtp13gR5Smc4gExvafQ
	 k109suoQMUFpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A8BC27C53;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 00:38:47 +0800
Subject: [PATCH v3 07/14] drm/mediatek: Add OVL compatible name for MT8195
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-igt-v3-7-a9d62d2e2c7e@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
In-Reply-To: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, Mao Huang <littlecvr@chromium.org>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: YT Shen <yt.shen@mediatek.com>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718815123; l=1129;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=mOuE7odjWvJz++xtcQ1qyetBOiaSUZbqiZM9+aN0j54=;
 b=RnVS8lxJ2hbgfxMuJ8FfxIhXzI/RE5/P4ANTqoO+t9BzCLSfR+RUVSyrJvEiMeDYDURJSeBSs
 6IjpIle5w6nAl52cP8MESwBMPqE2AKldyXQh93P80Ya8A+xi0vvRB+i
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Add OVL compatible name for MT8195.
Without this commit, DRM won't work after modifying the device tree.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index b5f605751b0a..8e047043202b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -743,6 +743,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8192-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8195-disp-ovl",
+	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
 	  .data = (void *)MTK_DISP_OVL_2L },
 	{ .compatible = "mediatek,mt8192-disp-ovl-2l",

-- 
Git-146)



