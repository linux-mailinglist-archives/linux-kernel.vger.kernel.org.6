Return-Path: <linux-kernel+bounces-183041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B948C93B9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF811F21421
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DFF18638;
	Sun, 19 May 2024 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="vOygvmCD"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791C18EB1
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716104496; cv=none; b=ezWj3pi+sQ053Ff7RBOgC1pp0NL8lqWBwn2oKSY+6YlLqnBO+We24mkoQA8b+BuGEuOLsMTn4ZqH8JBabWZu+UDZ8E6+Qi1IqsKEMRsudCBSym5F9tOPjXVHPAvDvkcc+Pu/A9YTwSUhPr3IfXxBOdHozxRjUJa0nie5nx2YdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716104496; c=relaxed/simple;
	bh=Scg55UA1RklCqNoWsYUK6xDYQtS3H7dxz/frrtpb58o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpPOi4nm/Kq8f2GAsZ4vFraOOmDYXoNysE/VYAu1PiOswSs6o2Lw0hatpitiK7osaCSOUYNOm7rx4SuxZoIABmZK9Sv/M3bgU8ShQQx34Rn2yCwQ9gx3R6snGPKKKjKxa0vIoojtT2M2q0gNLuga6Ov8yQ5/FCNV8aNQmxVnzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=vOygvmCD; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1716104492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MnNP0xmGDxanAFfueiOaEkQQkHaHD1N0yNfpZxYHu7g=;
	b=vOygvmCDYinXST/hlK0BHdTlaBBRBua3v5DJoizXW0DvbnBy+6JMwYe825c+hN/C6EIrAU
	lkjsD5+VqDB/koqTW6oERNexd+smn06YnvgtrM5wvxYggFd7+xL6Ak0o4sp581Y0A+qLFC
	YC+cT7kry3X8lXNhqpcJIMQU7TPmmli3kg7+COe9BrF4izNbNK5e3DkMJ4to3GDm9dxAvC
	MRKyDzxMaLzmIQyQTc/2BrxrlbdFK4mtByEPvUI7aWyl3E+LyJbnjVDHk7nPH9P3UU7mOD
	0jFX8VnkCjcaBqEns5klYd7p348AoA/D2O6NYnNylrPRyhDUmcnKd0PRjRnpEg==
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: hjc@rock-chips.com
X-Envelope-To: heiko@sntech.de
X-Envelope-To: andy.yan@rock-chips.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	stable@vger.kernel.org,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066
Date: Sun, 19 May 2024 04:31:32 -0300
Message-ID: <20240519074019.10424-2-val@packett.cool>
In-Reply-To: <20240519074019.10424-1-val@packett.cool>
References: <20240519074019.10424-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 9bcb40a64..e2c6ba26f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -515,6 +515,7 @@ static const struct vop_data rk3066_vop = {
 	.output = &rk3066_output,
 	.win = rk3066_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3066_vop_win_data),
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.max_output = { 1920, 1080 },
 };
 
-- 
2.45.0


