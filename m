Return-Path: <linux-kernel+bounces-234832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFB91CB42
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BE71C21D54
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059E2574F;
	Sat, 29 Jun 2024 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="R+/lIPx6"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731C1C17
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719638601; cv=pass; b=RPxznr2hQu+k3D+d2sN6+c1pCzlAtkO9Bym8ZElSfRDZygRxANKSGlkLWlfOPDu2q9YOSzzx2MfRKQvtXLpi8zs1xFUpv6uLcxZ1k56CPyVSBOssHPeL13soJZ964FGXJ5ZLAqejBEzU8rYvO6pJSA+chH+wyj7EiCIJR4CCAQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719638601; c=relaxed/simple;
	bh=/JEfSCm+ZU7Xs7JIUpdyL8HRj8QSLKVCdar7QU502Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrONuPhP6kxEcgZyeRR9vOMW51BFWIM5oLbEHweD+JR7sQUToDsG2pHCukRynPUT1LWx+NvMCs0IcZsRCFtoywjME/DBIvEIQBa8CwQd7VdlYLuW4SjdS+/mn1zZUwYNUXUlUlGjceB3Zkxaznb182BFkkwFLNcD0lB9oNdW238=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=R+/lIPx6; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1719638586; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fhS08vbqW3H4/k2q3naZ+EGyPNDga3CC7UZ/McCvXn3UVpxK15JJBInCQlscPJzjLdX9l6wVh5bl6P8DNFMuDvTqvlKCo6Qr92feFJieIEpvuuKXvdjDBNcUgH8oQhIclJlr8wwYKxhUllfi9adZYv6QQOVB3HDqZzGU2w+B2QU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1719638586; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8ELiCFvmKeq7yctdOzbA7uFe3ZHMTxmd1PiqaEMmYic=; 
	b=nWZ8Xeu9gRDAs6lD1zvhKUwbIr12onDLLbK3D6wpJxEz467ABly4HDI8iqMjVFsr50QrqJhuL6xyB6HMga6WW8owY1N8yojO+Vb6vav+e60cCDGeweeumMdZyLP7GUqb553owOAeepfbInShnlEaRmJoZJr5fpIWQ93WXRyYv4s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1719638586;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8ELiCFvmKeq7yctdOzbA7uFe3ZHMTxmd1PiqaEMmYic=;
	b=R+/lIPx60Tf7TUj4EV69MAqn2XUvDEeGTve+HPuBo4Q9qViZsmygytBIs9+C28A7
	3ScH0kyIY7JyEKE8tcmu++dYs9Ch7/PZ0hxZUgGwTUv80fUtES3yHhInecmRj3magyE
	xhy6q9yCt9dqRieJyDJcK+AYgL7BA2yAuiku9QqLfiTI89lQSUiagAraV8sARJN4MWL
	4y7TH+sAhXuJ+Yo4NaXwxiUmlD87rcIGWyY9CDPQISqcrfO5ZcFK6sZbV+8iOeGpvXT
	YbnDrzjxs9kTnMm3p6UKboChtI2PnoisSpy5svBxUlRNqgEo7hy/KLPwsCtzCS2soAk
	nHoXOGrhjA==
Received: by mx.zohomail.com with SMTPS id 1719638584701382.1484552031518;
	Fri, 28 Jun 2024 22:23:04 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 0/2] drm/ttm: support device w/o coherency
Date: Sat, 29 Jun 2024 13:22:45 +0800
Message-ID: <20240629052247.2653363-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patchset tries to make TTM support devices w/o full DMA coherency
capability (usually due to part of the link between the device and the
CPU, esp. PCIe controller, do not have full coherency).

The patchset itself looks quite straightforward, however I don't know
why this isn't included in the kernel in years, so make it a RFC.

Tested on Rockchip RK3566, which has a PCIe controller w/o full
coherency with an AMD OLAND GPU (R7 240). Mainly radeon driver is
tested, but amdgpu driver is tried and at least OpenGL (glmark2) works.
(The board used for testing is a Quartz64, which has a PCIe slot that
can directly be seated with a PCIe graphics card)

Icenowy Zheng (2):
  drm/ttm: save the device's DMA coherency status in ttm_device
  drm/ttm: downgrade cached to write_combined when snooping not
    available

 drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++++
 drivers/gpu/drm/ttm/ttm_device.c  | 2 ++
 drivers/gpu/drm/ttm/ttm_tt.c      | 4 ++++
 include/drm/ttm/ttm_caching.h     | 3 ++-
 include/drm/ttm/ttm_device.h      | 5 +++++
 5 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.45.2


