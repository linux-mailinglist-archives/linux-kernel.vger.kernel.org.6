Return-Path: <linux-kernel+bounces-217174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414E90AC76
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E3F1F261CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284CE194AFD;
	Mon, 17 Jun 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="mK4K9mZQ"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B5194A57
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621965; cv=pass; b=qUeqNxJ3jWtLe/AHdhc1CB9Mv2ma/DySCxmhNPwipHb+9sGKrBGNHvb6grhbGrDguTd62ZTPN7gdgoCMINp4rDfS3dPEUt1JZKWt/tEblNqqk7HMMj8Ap/+OgEdgHmcVe4yvreF2zAnvxQpsAbhCzao9kHAoJDhrnkwtEHDo9R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621965; c=relaxed/simple;
	bh=ldsAQorbP3AstudYkEejC33QaQ+CJr0FQcuREvLrtbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI8pbb/7JEzq5mgjnfgxtmjJyyOBmjTNXsJ+WgbEbw5HyQLZapYVeMj4dh2AL8UOUejhN1RLUI7uIcqaoBlr3wtuEFgViZ+/Ewqi6CTX1SBD77KsTTFaeTvryz+p2TlKKqoGW6GeOFDk3EVJbr4z//O3pnNt5s2iYUJ/1Ot1cxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=mK4K9mZQ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1718621951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fG2P7fwYFpQOevPGrIWIoeshtJla9Lcbn8a2jlfGty91UM1k1HSrTK81AQGx9bAFN+sBFe7RTuo4hwrBV2FBS+yMslhSgNRP4TT+AqROY006xeqxdP3koZX1ylmpoOGiRQSgjMQ8gCmro7ac0nuzbeuiQyR6PnLy5GjAWMBBbsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718621951; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PqebUlTi0iTLhNoy5+l4cYqvssMhPIoYeMJsxXTSYO0=; 
	b=a5HFpa5yywFMOrPbAX2DxynDZt366JGeZihUKmkCnRd+uwQJO63UHKxZunBoKmyzSpcuEAIMFCOHqKleMabxRGx/Bny+vE7j69Lx1T8XeMWM/njYtoO9WkiuQA8fdvP+ttrFVJ4KGx9QoFCrtbeyTctlSW0W46E6Th6BY3bgr+Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718621951;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PqebUlTi0iTLhNoy5+l4cYqvssMhPIoYeMJsxXTSYO0=;
	b=mK4K9mZQzFqR7/rXCzgNoZTY3g8EetbvAU7kPgMmg7cJYDYXw8ec3H0fr1oxIiU5
	vzKcRyzIMvv80AZgmALB6ar1NscLqaGgW8FBQPiW7dhl+ytTgwRDA18RTd4un5p4Zgm
	NUwfn+cQNIdlq7Ymo3Lgvxc7zmhQxoep7JMjtxyrnEe7DH3pZBfRpgzR7W8bgYXiHfo
	itg4eeMbguO7Z/Wsid5yg+5Vm69ppHZV/pnpktYZ1cvJSQGZW2vqd3NjWz9uQUYlySa
	Qo0t6/xWbXC/h4g715TLS02W5t8uqdedJdTQ387MGAf20vm3jS0p5LWILweV8mZkmkn
	9qPVk0cliw==
Received: by mx.zohomail.com with SMTPS id 1718621950320316.9838256232267;
	Mon, 17 Jun 2024 03:59:10 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/radeon: repeat the same EOP packet for EOP workaround on CIK
Date: Mon, 17 Jun 2024 18:58:46 +0800
Message-ID: <20240617105846.1516006-3-uwu@icenowy.me>
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

Ths first EOP packet with a sequence number as seq-1 seems to confuse
some PCIe hardware (e.g. Loongson 7A PCHs).

Use the real sequence number instead.

Fixes: a9c73a0e022c ("drm/radeon: workaround for CP HW bug on CIK")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 drivers/gpu/drm/radeon/cik.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 8275eeba0b349..9d203054f922a 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3543,9 +3543,7 @@ void cik_fence_gfx_ring_emit(struct radeon_device *rdev,
 	struct radeon_ring *ring = &rdev->ring[fence->ring];
 	u64 addr = rdev->fence_drv[fence->ring].gpu_addr;
 
-	/* Workaround for cache flush problems. First send a dummy EOP
-	 * event down the pipe with seq one below.
-	 */
+	/* Workaround for cache flush problems by sending the EOP event twice */
 	radeon_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	radeon_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
@@ -3554,10 +3552,9 @@ void cik_fence_gfx_ring_emit(struct radeon_device *rdev,
 	radeon_ring_write(ring, addr & 0xfffffffc);
 	radeon_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
 				DATA_SEL(1) | INT_SEL(0));
-	radeon_ring_write(ring, fence->seq - 1);
+	radeon_ring_write(ring, fence->seq);
 	radeon_ring_write(ring, 0);
 
-	/* Then send the real EOP event down the pipe. */
 	radeon_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	radeon_ring_write(ring, (EOP_TCL1_ACTION_EN |
 				 EOP_TC_ACTION_EN |
-- 
2.45.1


