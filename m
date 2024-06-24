Return-Path: <linux-kernel+bounces-227926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C597915829
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC51F26E73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787A1A08B8;
	Mon, 24 Jun 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="aI5OECwn"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E39D2233B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261698; cv=none; b=GE2b2J+iVKqKUzESeP0Lcn0I12nBS98dVvS0mqISOcIwlxrEyo0zVspyXx8UpYWHieVVvtNePRDAAeOw985cB9OASVUA74PeMr+YV9CAln0PDKAEK1r4QN60WZVZjyJVFdRZ7mYBvv5WaEDuPvZunbzA9krvuNYlKPDz41LBCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261698; c=relaxed/simple;
	bh=tWCL1FtPBEHUqHV/mVV4NpiHDzF1a0ibqAaSMs6EgoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWa+8YGnOdffs9b51ZGm/+P0XBsP9wzTxFO5q3avxg7E58nHMKZFIUB2cd6qW8p41Q9PBgfHt4+Mjqu+D0YNY5NuY8gLjZTl93gWQ9zgALHWUvFjdDIxXmRs4uWmFC/zQQF7I5zDcYtnofy8Abzkl7JYoeIhYTCum2zc2gQI1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=aI5OECwn; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Envelope-To: val@packett.cool
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1719261693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xzQDjhOrGwD3tQUSZRV5dR0f05Nxv9TwNmLi45IeEPA=;
	b=aI5OECwnIhB55yaokMZbw0g8l+RbdY9aKqpV/dm5rtqadRfSmnAZuRJlL/hcj+5BN6ut41
	j2xAK7D94C/IFQNcKQVX9EtcK3vROwaZztlmY70JVtGdpUutud89T4/0D4VTanYMKN1CBu
	W7ruKZKF1YupCoi459CzRS2MnFGhAI1VLTx1tGlR8wlgUTR2ZuUKrTQ1XBHYCN1ExTIUbO
	/84OzWPgajgw7f9rc6Lea6uPhAZi1FPos4j0nLXMeykW/YwrA1JmX9A5gR6fq+zTpcQ/FY
	lsXDriUsd009uYuIA/h1LCN8yPTlJ9fq8pK9bsop1RZSm0Z+OEtwTP/k77IXuQ==
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
Subject: [PATCH v4 0/2] drm/rockchip: vop: Support internal display on RK3066
Date: Mon, 24 Jun 2024 17:40:47 -0300
Message-ID: <20240624204054.5524-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This tiny patch series makes the changes required to enable the RGB
display output on the Rockchip RK3066 SoC. Final version as discussed.

Val Packett (2):
  drm/rockchip: vop: clear DMA stop bit on RK3066
  drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 ++
 3 files changed, 7 insertions(+)

-- 
2.45.2


