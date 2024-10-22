Return-Path: <linux-kernel+bounces-375360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7289A94FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D441F239D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70B2E628;
	Tue, 22 Oct 2024 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="XFV6Cei2"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E82233B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729557072; cv=none; b=msz3N/gWeS91GCW9bIzknWOZ5fRgesNDm7umr1ETWqICgb0dJPB5bmo3sTqHWzlpC45VJIK7u8wX/xHN3QLq9RPI32a8g7Cpeh50DxRHft2aLaQ6e1FdffMxsgch9DC1FF9roh7MJiKiZsE6U2LWZ2RB636Qvguy4xOPeSq8xiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729557072; c=relaxed/simple;
	bh=w6Eik1qpcQNe7jNkjEq3wVI4awe5EDSTIs3j3SHy8SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQ7jWAMA+pmAIQkHKFVf1VlOoQbTGGcvHXnmv6bmfWY8x8r9qnSmG9g77JAs0TPU3YeY8a5ugTpbZOHoNOk1r7YK8X+D4y8Tz6BD86thYYtHW6WnlOvJi5Y117UFzWSBHKJjf/z5T4Zfc5gmmb6+uHkYrMDsadVuF/BYJNhQgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=XFV6Cei2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=DkGlfYG+fP6ir/iK23MmiC803FFVOnvYmoVQk97+8sA=; b=XFV6Cei2D/8nzYmz
	mJwdS3+275F+JES+fOljq/1Rxh2X5w9bKsFkesVXlCdcSYnf9SDzoilMR3AJ3DFIfIhnl+mH6BaG9
	aqKDqX4E3897/kTQKA6SOX96xz6CdSikVz9lTfcikH5CfY4WJBberVghoCxxCQAgpgp7vyvqucqPN
	XyS1td6UuMLXCGJWmE7BaL89Febo5SUTCKu5zkMP1QyQzaJ7QoLdsx3yrP8dtdVaHDKi/fjIkR9D0
	yEDsoj+pOufvDnuX5gHMahhowiWJrVmgUFcqnWcdqkjz2rPJFPsTdn8clZ0C+/TUNAtda899olU0l
	Lyi7Jp6QCmN1t3txEQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t32nf-00CeRN-0k;
	Tue, 22 Oct 2024 00:31:03 +0000
From: linux@treblig.org
To: kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] nouveau: Remove unused functions
Date: Tue, 22 Oct 2024 01:31:02 +0100
Message-ID: <20241022003102.303052-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

dcb_outp_match() last use was removed in 2017 in
commit 99a845a30f62 ("drm/nouveau/disp/nv50-gt21x: remove workaround for
dp->tmds hotplug issues")

dcb_xpio_parse was added in 2012 in
commit 112a12aab8a5 ("drm/nouveau/bios: add support for parsing xpio table
data")
but never used.

Remove them.

dcb_xpio_parse was the last user of struct nvbios_xpio, so remove it
as well and the FLAG #defines.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../gpu/drm/nouveau/include/nvkm/subdev/bios/dcb.h |  2 --
 .../drm/nouveau/include/nvkm/subdev/bios/xpio.h    | 12 ------------
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/dcb.c     | 14 --------------
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/xpio.c    | 13 -------------
 4 files changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/dcb.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/dcb.h
index 73f9d9947e7e..12e6b2f21564 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/dcb.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/dcb.h
@@ -61,8 +61,6 @@ u16 dcb_table(struct nvkm_bios *, u8 *ver, u8 *hdr, u8 *ent, u8 *len);
 u16 dcb_outp(struct nvkm_bios *, u8 idx, u8 *ver, u8 *len);
 u16 dcb_outp_parse(struct nvkm_bios *, u8 idx, u8 *, u8 *,
 		   struct dcb_output *);
-u16 dcb_outp_match(struct nvkm_bios *, u16 type, u16 mask, u8 *, u8 *,
-		   struct dcb_output *);
 int dcb_outp_foreach(struct nvkm_bios *, void *data, int (*exec)
 		     (struct nvkm_bios *, void *, int index, u16 entry));
 #endif
diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/xpio.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/xpio.h
index 11b4c4d27e5f..cd0ffebcb73a 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/xpio.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/bios/xpio.h
@@ -2,18 +2,6 @@
 #ifndef __NVBIOS_XPIO_H__
 #define __NVBIOS_XPIO_H__
 
-#define NVBIOS_XPIO_FLAG_AUX  0x10
-#define NVBIOS_XPIO_FLAG_AUX0 0x00
-#define NVBIOS_XPIO_FLAG_AUX1 0x10
-
-struct nvbios_xpio {
-	u8 type;
-	u8 addr;
-	u8 flags;
-};
-
 u16 dcb_xpio_table(struct nvkm_bios *, u8 idx,
 		   u8 *ver, u8 *hdr, u8 *cnt, u8 *len);
-u16 dcb_xpio_parse(struct nvkm_bios *, u8 idx,
-		   u8 *ver, u8 *hdr, u8 *cnt, u8 *len, struct nvbios_xpio *);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dcb.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dcb.c
index 8698f260b988..ae1faa63d68f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dcb.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dcb.c
@@ -193,20 +193,6 @@ dcb_outp_parse(struct nvkm_bios *bios, u8 idx, u8 *ver, u8 *len,
 	return dcb;
 }
 
-u16
-dcb_outp_match(struct nvkm_bios *bios, u16 type, u16 mask,
-	       u8 *ver, u8 *len, struct dcb_output *outp)
-{
-	u16 dcb, idx = 0;
-	while ((dcb = dcb_outp_parse(bios, idx++, ver, len, outp))) {
-		if ((dcb_outp_hasht(outp) & 0x00ff) == (type & 0x00ff)) {
-			if ((dcb_outp_hashm(outp) & mask) == mask)
-				break;
-		}
-	}
-	return dcb;
-}
-
 int
 dcb_outp_foreach(struct nvkm_bios *bios, void *data,
 		 int (*exec)(struct nvkm_bios *, void *, int, u16))
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/xpio.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/xpio.c
index 250fc42d8608..a47393e90de9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/xpio.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/xpio.c
@@ -59,16 +59,3 @@ dcb_xpio_table(struct nvkm_bios *bios, u8 idx,
 	}
 	return 0x0000;
 }
-
-u16
-dcb_xpio_parse(struct nvkm_bios *bios, u8 idx,
-	       u8 *ver, u8 *hdr, u8 *cnt, u8 *len, struct nvbios_xpio *info)
-{
-	u16 data = dcb_xpio_table(bios, idx, ver, hdr, cnt, len);
-	if (data && *len >= 6) {
-		info->type = nvbios_rd08(bios, data + 0x04);
-		info->addr = nvbios_rd08(bios, data + 0x05);
-		info->flags = nvbios_rd08(bios, data + 0x06);
-	}
-	return 0x0000;
-}
-- 
2.47.0


