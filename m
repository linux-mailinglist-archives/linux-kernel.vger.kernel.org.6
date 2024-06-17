Return-Path: <linux-kernel+bounces-217173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A3690AC75
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A7B28B9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB9194A52;
	Mon, 17 Jun 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="A1lFzybB"
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6F19408B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621963; cv=pass; b=Ygg4O8HFujqFsJuFBpaEuDRpC7Nwe2QEvOlIEa+yDLtBPw5nfI8Is8vyUkkX2WdRt+f5a63YMYcnB4e/XWqrmbbNKHVUh2lQ3iOx89/J31Sx+67l+t9YyFi2GbnGvo19jIUFj5wHyJEZJYbh+kv4aJ8k4NGKlapb1dguCDQ3uJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621963; c=relaxed/simple;
	bh=2FF8en3kxW7XGjWfgnmPl2BT58CWqJAVe6+zuuRngN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U81v1Xo9n4UcwD6O3crf+xVkExaj/Dk1j6+7jOBFO/wctx6XIm9fXg2LUxuTkol1Rh7LbMicmnNRi+n6BYek4ElwIA4qJ1PrtVMbKZAMLoZt1cWb3Nlrrm6+egBRnUdggoVZWo/ftw2N1D9600n0hoJbP7LAHI20GEm8v8y18jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=A1lFzybB; arc=pass smtp.client-ip=136.143.184.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1718621947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DKO0aj3EPYUTcOPxFrsAL9cMTc5yUNWwZee8gyN4ILvsCWnjg3xEtqYefnRS7FQHvtUKOuB68UC0BkZWvGB/UAEKXRQFqAOemoY1HQZ0s1AuI4glKqVKpZbjd9+GRBukkCwS7IZwn4xm5/5MGUAVNcLG+QpmXZf9aYC0V8i2ZmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718621947; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qk5Pm/6kG6W39CDEfIuvU92qq7NTedFoL4HtX5NeHPc=; 
	b=UodZPC8bNTyHyo0+3Ia0oVPQ2Sx39bh59SS46ra7ej7/pimIasVASkf/6EeL3FeHRdE4DLWI9lxaJkyspKGF0xl5cc7N3eza8v0pfC0gTrr0/ixP7R9oiFmJ0IeM9xAn4T589kkalj9rcink0ti3QC/25fFfDCE1Ljzle05uujc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718621947;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Qk5Pm/6kG6W39CDEfIuvU92qq7NTedFoL4HtX5NeHPc=;
	b=A1lFzybBX7ueDnYbXAjbrSum520AJGOjKAPUeJsvS3zOP4/r+Ym3gdvwOhbhQx77
	xEyrunklvl1xN7xSsRn6H8DbR3jiujnAZOsK62yXajF8LFENldYx7StfdmGNfYB9xr0
	mvYBGtTC6bfCT4uHFduKVxiFXgEJsLFDT2BERPN/234iEze9HFp1xEXEZaCa3QFCcMJ
	O6aNcO7TMbK4S0t3GTN8AsRfDDj63wav3TGvadsJ4RuMNF+WD4TeCATUv1AB1UkgihC
	/YYQQFxEve5g66VaQomxsjJaV2CBM5tBJkOrMg8+cZiHo8BSKEZJw7YeJ8TGSTbOp0W
	7RuMT1xevQ==
Received: by mx.zohomail.com with SMTPS id 1718621945962884.5678500265545;
	Mon, 17 Jun 2024 03:59:05 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pan Xinhui <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] drm/amdgpu: make duplicated EOP packet for GFX7/8 have real content
Date: Mon, 17 Jun 2024 18:58:45 +0800
Message-ID: <20240617105846.1516006-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240617105846.1516006-1-uwu@icenowy.me>
References: <20240617105846.1516006-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The duplication of EOP packets for GFX7/8, with the former one have
seq-1 written and the latter one have seq written, seems to confuse some
hardware platform (e.g. Loongson 7A series PCIe controllers).

Make the content of the duplicated EOP packet the same with the real
one, only masking any possible interrupts.

Fixes: bf26da927a1c ("drm/amdgpu: add cache flush workaround to gfx8 emit_fence")
Fixes: a2e73f56fa62 ("drm/amdgpu: Add support for CIK parts")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 ++++--------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 541dbd70d8c75..778f27f1a34fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2117,9 +2117,8 @@ static void gfx_v7_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
-	/* Workaround for cache flush problems. First send a dummy EOP
-	 * event down the pipe with seq one below.
-	 */
+
+	/* Workaround for cache flush problems, send EOP twice. */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	amdgpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
@@ -2127,11 +2126,10 @@ static void gfx_v7_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 				 EVENT_INDEX(5)));
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
-				DATA_SEL(1) | INT_SEL(0));
-	amdgpu_ring_write(ring, lower_32_bits(seq - 1));
-	amdgpu_ring_write(ring, upper_32_bits(seq - 1));
+				DATA_SEL(write64bit ? 2 : 1) | INT_SEL(0));
+	amdgpu_ring_write(ring, lower_32_bits(seq));
+	amdgpu_ring_write(ring, upper_32_bits(seq));
 
-	/* Then send the real EOP event down the pipe. */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	amdgpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 2f0e72caee1af..39a7d60f1fd69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6153,9 +6153,7 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
 
-	/* Workaround for cache flush problems. First send a dummy EOP
-	 * event down the pipe with seq one below.
-	 */
+	/* Workaround for cache flush problems, send EOP twice. */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	amdgpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
@@ -6164,12 +6162,10 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct amdgpu_ring *ring, u64 addr,
 				 EVENT_INDEX(5)));
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
-				DATA_SEL(1) | INT_SEL(0));
-	amdgpu_ring_write(ring, lower_32_bits(seq - 1));
-	amdgpu_ring_write(ring, upper_32_bits(seq - 1));
+			  DATA_SEL(write64bit ? 2 : 1) | INT_SEL(0));
+	amdgpu_ring_write(ring, lower_32_bits(seq));
+	amdgpu_ring_write(ring, upper_32_bits(seq));
 
-	/* Then send the real EOP event down the pipe:
-	 * EVENT_WRITE_EOP - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	amdgpu_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
-- 
2.45.1


