Return-Path: <linux-kernel+bounces-217172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9F90AC8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1273AB26EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE861946CC;
	Mon, 17 Jun 2024 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="CpqG31sy"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAA194092
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621962; cv=pass; b=ETAJ8v1Imog4Mdx/DF1MrRoBkGRDZ4NRsmwt5C26ON0zFiRp74DVnr/NXyV7xqDWESS0pY2ryO0bA1JBQ6Ae0p6JYrKFE7QUqDmujXkpRXZm/W1sgQ1CdyGOyhDnpWf4K19VHWWgouPzi4b/XdsImEMGQ6mLKVMM/3OyBPNPrIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621962; c=relaxed/simple;
	bh=XairXL6336cO2ADQJcpKT06x0AoJbC+Ijt3sC/Ms+QI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSyC4lkZE3tOcbNxZyp858fRacp7LEHzJqLM32ibz4Uo37MSIs/JhjIS/YWNhyZKB8Lx+AwZ6x3RTOB7T/Az2FpZbgsVw+qzfEAikLesHd+KdMjVoKOadd7GQbwSc9QakoR6+QZhxkA8M7po92jiFBPFMkutQd7+2iAwt9shEGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=CpqG31sy; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1718621943; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oHaER6uPIKsyeIAcWHi1RHRYgbHQRsphk+c4CK1G6GBPK8kfPHC8QUyeNQXw7DsYV2EmmeGj8vmEsPCei9i1IR3L8vmtWeb+CHC7bvOHspHI/T/lB6ao9LefvAvE5D94QRefC1qSXrp3d5B3WV4z6ItnVJGGWmN9CETSIXcz358=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718621943; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u+O1n/OB/Q+PPfTIjJ9hQgiheZf7bi7XElMSkoNsqp8=; 
	b=HOK9MPLV0sv9c78gp5wUOoZSzelXcFeIxJtko4T7bTdmpUBs4/JWgIPshMMFGO8khOtLC3jiyYvfnOvV92DyA7luRanjfO6FA2mlon2xNaF7A3pO3UZsQOy3MZm16bEl/WkUN+S6YTSzwwwy973Hyc0su6Y8CtX80p7aYYsNLv8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718621943;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u+O1n/OB/Q+PPfTIjJ9hQgiheZf7bi7XElMSkoNsqp8=;
	b=CpqG31sy0BhHhRCSPviAS5RKgs35pjOqDiVH7RXl29eMLj6O9QRcKbjoWm1e/c0w
	uxyw12IhvFPu0qBetTrtQOuZ1H7MoKQ2Q/k/socq2dI4QgpRwSYVHKBH+jdIjrkqWvq
	lEpExaHI78AWlJrFMpMLwtnNfu19jdc5F/9zd1+YrpEJV2fKWGPSFZFRCq/Nql87njY
	Lu4z4oFiq9hRdsIJ6LEwg1Vaue7ryjar21/eOp5vC4l88JGFLqPAhLfNwY0ag3SOonc
	wuA2nxuLWN9crJsHVD6s19ZSFVgnFhEDea7CUdyBiWKhKqS1thQWHyV7lGt3lxl+svl
	LrfheKPjNw==
Received: by mx.zohomail.com with SMTPS id 1718621940916892.2587924932478;
	Mon, 17 Jun 2024 03:59:00 -0700 (PDT)
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
Subject: [PATCH 0/2] Fixes of AMD GFX7/8 hang on Loongson platforms
Date: Mon, 17 Jun 2024 18:58:44 +0800
Message-ID: <20240617105846.1516006-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset tries to fix some workaround code in amdgpu/radeon driver,
that makes Loongson 3A+7A platform suffering from GPU crashes.

Icenowy Zheng (2):
  drm/amdgpu: make duplicated EOP packet for GFX7/8 have real content
  drm/radeon: repeat the same EOP packet for EOP workaround on CIK

 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 12 ++++--------
 drivers/gpu/drm/radeon/cik.c          |  7 ++-----
 3 files changed, 11 insertions(+), 20 deletions(-)

-- 
2.45.1


