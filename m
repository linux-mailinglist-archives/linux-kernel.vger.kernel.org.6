Return-Path: <linux-kernel+bounces-216188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29628909C89
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E071C215F7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3C18732D;
	Sun, 16 Jun 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swlsQLbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9E1850BC
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718526555; cv=none; b=OtNLU1FHw2mOh1TVyrR+FUI/IGrxLiWXxmGXrViGoT6LCPxwXVPW0oaeTj0qaOdQ5UGaYiG68Ci9YlshiM9jf63knpWr4WeYVr4iIo5pUaYuQ157pHmvF+JBNQZZhENk81H184pp65if78v6y66JZxjRnMtcxEkPT6Ib/aNpQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718526555; c=relaxed/simple;
	bh=w4HhvErl0+9KBEyLNkAXO343a8rNSOMKg9ZlSA5XdCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVCYfFrx7E8mAVDyWEWaGndzn9KBr69bdJLm/32NvqCdrdw8WEgqp3p173zHEWVWH5e6eMp0DLxlWS7YAbiGBChmAOADiUrNOl6c8oNchE9u1/+k6ALaCRdVdxP1njChqJEOmI0+Kfi4lMHFwkfUE7soA7AoTDHz6nJv/CZZjCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swlsQLbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E73B2C4AF1C;
	Sun, 16 Jun 2024 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718526554;
	bh=w4HhvErl0+9KBEyLNkAXO343a8rNSOMKg9ZlSA5XdCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=swlsQLbXrGn4m+8Wm0zCjzNViBZ2DUpjkfzvI1SSMoPp7nnaMRI0KplUAtIAXBbac
	 pxXsnyBi7n2Im3KiZr+A0v5XvQiYqrTMBjHsy/rYP1vkQE3P5bFh8c4ngepOx/VskT
	 Zg/4bjpiAxjNufkklMgFpQT4tkRMhMvL67dSC0ELq9mvsAxvLMjrjLLB2jE29U25c1
	 XlPT1xtHnymRxtnaGVzy4es3UuzfLL/EOtuc95qwVFq1+x2N8ZivHpMrH3SZvLC9m1
	 +FLZtCSXHrAfNxAZPxgNDN2w230KnIsgk1vwP3Jg2D2iVZTWTQGeuYYibKxhDv/R2m
	 EwurrCpaIfDMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5973C2BA16;
	Sun, 16 Jun 2024 08:29:14 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Sun, 16 Jun 2024 16:29:12 +0800
Subject: [PATCH 02/13] drm/mediatek: Add OVL compatible name for MT8195
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240616-mediatek-drm-next-v1-2-7e8f9cf785d8@mediatek.com>
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
In-Reply-To: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>, 
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718526553; l=1050;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=BgdlkkD28fU8kVaiXpAjJEsbIm8CSiJsfkQTGRrkbL8=;
 b=EwafnihtQo1NceoMulPvwo+G3mrLHtE3FpAhX/nodSUl+rH3kr3UHBTnd2O4spc5zZHP4HpVh
 nZpiY49XaxJAwmU+24gkfIOA0MU9S0VkvSNAzw0hB3HrI+9gv37T3SC
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



