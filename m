Return-Path: <linux-kernel+bounces-510819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5BA3227C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FA63A9032
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449AF206F21;
	Wed, 12 Feb 2025 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PY6H+C1w"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEB1205E0D;
	Wed, 12 Feb 2025 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352999; cv=none; b=H8WV7vKH3bK+OvzwzakiZGoDNyqbIKNX/+Bf2CAa8OpJXsO9F/DBrt6OOOs9ntu8HS+LEK+tQr28pt7x1MLUi6b6Ss5qI/JbMuN9hX7o/b2hQvps6Fhqv9F18POFgZ5QK3qutC750E2lJ94rjlZW4tCGoZhiCvY+hPOLpiGnVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352999; c=relaxed/simple;
	bh=kBff/CeZOD7kxT3LNbE6M8lpQFzkn1RzKnS2nA15g+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQYz4PTO02cmJ2nRNkxTcSqviNl/il7BO2HsCTu6LXrZJ+kGu6B+rnGv4H3TRxj+NTppChUZiGjDXR6uAWdUmXCGHEd7hkoGAT6mgpwaMcvkiOXOvbr0t3YjSIHkX7jBojzO/DDJyjTUTZNbWC5OqM3XZowJuKfHAOKrAYdXuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PY6H+C1w; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=E49mb
	M8Y56MagZCzjfVLDOWNTUIqbd/u7olBPvb7dv0=; b=PY6H+C1wTH948HCsVaQ2D
	Ud2InDLN9wC8gpamSiJfdOX/JrlVKnvkMQxwtn5ozj9rGTURWtnZk0T7FTBnpbId
	LE5uAZVmDnuNlW9KVeZOkwUmnHDZZzUj+MaPCd6LDiHDFLW8VzuEnr3tNRwvJwra
	gguPS2eaFOEx7/YezWvvZo=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnG9Fja6xn14FuLQ--.33700S4;
	Wed, 12 Feb 2025 17:35:37 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v14 02/13] drm/rockchip: vop2: Rename TRANSFORM_OFFSET to TRANSFORM_OFFS
Date: Wed, 12 Feb 2025 17:34:57 +0800
Message-ID: <20250212093530.52961-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093530.52961-1-andyshrk@163.com>
References: <20250212093530.52961-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnG9Fja6xn14FuLQ--.33700S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWxKw4rJFWDCryxAr43KFg_yoWrCr18pr
	W3JayDWF4UKFs2qFWkAr15AF48Jan2k3yfGa9xJrnIqFyaga4DWw12ka4UJr47ta4I9FZ2
	q3saqrW7urW3tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1jgxUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gzxXmesX27xyQAAsz

From: Andy Yan <andy.yan@rock-chips.com>

This help avoid "exceeds 100 columns" warning from checkpatch

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 8 ++++----
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index ebc9cb93073c..8e1b742a7550 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1524,7 +1524,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en);
 		vop2_win_write(win, VOP2_WIN_AFBC_HDR_PTR, yrgb_mst);
 		vop2_win_write(win, VOP2_WIN_AFBC_PIC_SIZE, act_info);
-		vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFSET, transform_offset);
+		vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFS, transform_offset);
 		vop2_win_write(win, VOP2_WIN_AFBC_PIC_OFFSET, ((src->x1 >> 16) | src->y1));
 		vop2_win_write(win, VOP2_WIN_AFBC_DSP_OFFSET, (dest->x1 | (dest->y1 << 16)));
 		vop2_win_write(win, VOP2_WIN_AFBC_PIC_VIR_WIDTH, stride);
@@ -1535,7 +1535,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 	} else {
 		if (vop2_cluster_window(win)) {
 			vop2_win_write(win, VOP2_WIN_AFBC_ENABLE, 0);
-			vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFSET, 0);
+			vop2_win_write(win, VOP2_WIN_AFBC_TRANSFORM_OFFS, 0);
 		}
 
 		vop2_win_write(win, VOP2_WIN_YRGB_VIR, DIV_ROUND_UP(fb->pitches[0], 4));
@@ -3448,7 +3448,7 @@ static const struct reg_field vop2_cluster_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_AFBC_TILE_NUM] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_VIR_WIDTH, 16, 31),
 	[VOP2_WIN_AFBC_PIC_OFFSET] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_PIC_OFFSET, 0, 31),
 	[VOP2_WIN_AFBC_DSP_OFFSET] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_DSP_OFFSET, 0, 31),
-	[VOP2_WIN_AFBC_TRANSFORM_OFFSET] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFSET, 0, 31),
+	[VOP2_WIN_AFBC_TRANSFORM_OFFS] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFS, 0, 31),
 	[VOP2_WIN_AFBC_ROTATE_90] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE, 0, 0),
 	[VOP2_WIN_AFBC_ROTATE_270] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE, 1, 1),
 	[VOP2_WIN_XMIRROR] = REG_FIELD(RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE, 2, 2),
@@ -3547,7 +3547,7 @@ static const struct reg_field vop2_esmart_regs[VOP2_WIN_MAX_REG] = {
 	[VOP2_WIN_AFBC_PIC_OFFSET] = { .reg = 0xffffffff },
 	[VOP2_WIN_AFBC_PIC_SIZE] = { .reg = 0xffffffff },
 	[VOP2_WIN_AFBC_DSP_OFFSET] = { .reg = 0xffffffff },
-	[VOP2_WIN_AFBC_TRANSFORM_OFFSET] = { .reg = 0xffffffff },
+	[VOP2_WIN_AFBC_TRANSFORM_OFFS] = { .reg = 0xffffffff },
 	[VOP2_WIN_AFBC_HDR_PTR] = { .reg = 0xffffffff },
 	[VOP2_WIN_AFBC_HALF_BLOCK_EN] = { .reg = 0xffffffff },
 	[VOP2_WIN_AFBC_ROTATE_270] = { .reg = 0xffffffff },
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 29cc7fb8f6d8..8510140b0869 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -118,7 +118,7 @@ enum vop2_win_regs {
 	VOP2_WIN_AFBC_PIC_OFFSET,
 	VOP2_WIN_AFBC_PIC_SIZE,
 	VOP2_WIN_AFBC_DSP_OFFSET,
-	VOP2_WIN_AFBC_TRANSFORM_OFFSET,
+	VOP2_WIN_AFBC_TRANSFORM_OFFS,
 	VOP2_WIN_AFBC_HDR_PTR,
 	VOP2_WIN_AFBC_HALF_BLOCK_EN,
 	VOP2_WIN_AFBC_ROTATE_270,
@@ -335,7 +335,7 @@ enum dst_factor_mode {
 #define RK3568_CLUSTER_WIN_DSP_INFO		0x24
 #define RK3568_CLUSTER_WIN_DSP_ST		0x28
 #define RK3568_CLUSTER_WIN_SCL_FACTOR_YRGB	0x30
-#define RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFSET	0x3C
+#define RK3568_CLUSTER_WIN_AFBCD_TRANSFORM_OFFS	0x3C
 #define RK3568_CLUSTER_WIN_AFBCD_OUTPUT_CTRL	0x50
 #define RK3568_CLUSTER_WIN_AFBCD_ROTATE_MODE	0x54
 #define RK3568_CLUSTER_WIN_AFBCD_HDR_PTR	0x58
-- 
2.34.1


