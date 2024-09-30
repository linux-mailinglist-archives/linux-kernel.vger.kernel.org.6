Return-Path: <linux-kernel+bounces-343864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C089E98A074
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59565B262A0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD61974FA;
	Mon, 30 Sep 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="oaCkkQEp"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94967192D60;
	Mon, 30 Sep 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695313; cv=none; b=UcXLUZ0xtdOUz55mjv0BszRNtDZZhtLwpXZd9vH1+huQOVDkX7gqlvs63KO1WJoxQFjSo00336PFig0wrpoPOUIZydKHW1PoDmSnWcPDZF1+CX6yACcQVehXyCRe65E1kYSAAyVJltouUAH2lst8RSCUSCg2B00hW0UErEcLuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695313; c=relaxed/simple;
	bh=pGqXg4P1o4zVinzAECzGnRRhDpcsu4G2IzB/n5Z103o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWymZqgtc3GHR5xvqtDIGZcVRHt4VgFxpc7+iwWrfvG1+ehfpdePsXMPXCPiGJRih6C0R9RxviHU/z2MxAHjEth8ySKDFZOQKbZ9h6DIRWEqfVDpgqI9EvxtKYdPj6OxLQqMqXQ9GG4m3uCfrEvYNZ0sV+1GGZ5JFctov24Tlj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=oaCkkQEp; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BfS+oY30RPok/ll7+qBitmbLy1BCCA1+SqXnGd5VNCA=;
  b=oaCkkQEp6qEJRTI8xwFOEEkn7VKdtUR/6X9m0eiEBI3a76dILDWCRgDR
   z+GnCbQoaa8kYwaivCvIBGufXqfGsSevZUGq2bm7/QMPx8tN8294lOeNe
   6RiOpv32I3mnUsp7KYpD5gBLH6RatxeF20MZpBpOZegumeAyv1r/VR99R
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956892"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: kernel-janitors@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/35] drivers/gpu/drm: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:06 +0200
Message-Id: <20240930112121.95324-21-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/drm_gem_framebuffer_helper.c |    3 +--
 drivers/gpu/drm/drm_gpuvm.c                  |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 3bdb6ba37ff4..43a2440a0b05 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -581,9 +581,8 @@ static int drm_gem_afbc_min_size(struct drm_device *dev,
  *			    struct drm_afbc_framebuffer members
  *
  * @dev: DRM device
- * @afbc_fb: afbc-specific framebuffer
  * @mode_cmd: Metadata from the userspace framebuffer creation request
- * @afbc_fb: afbc framebuffer
+ * @afbc_fb: afbc-specific framebuffer
  *
  * This function can be used by drivers which support afbc to complete
  * the preparation of struct drm_afbc_framebuffer. It must be called after
diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index f9eb56f24bef..1e4eb6f44c92 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2301,11 +2301,11 @@ __drm_gpuvm_sm_unmap(struct drm_gpuvm *gpuvm,
 /**
  * drm_gpuvm_sm_map() - creates the &drm_gpuva_op split/merge steps
  * @gpuvm: the &drm_gpuvm representing the GPU VA space
+ * @priv: pointer to a driver private data structure
  * @req_addr: the start address of the new mapping
  * @req_range: the range of the new mapping
  * @req_obj: the &drm_gem_object to map
  * @req_offset: the offset within the &drm_gem_object
- * @priv: pointer to a driver private data structure
  *
  * This function iterates the given range of the GPU VA space. It utilizes the
  * &drm_gpuvm_ops to call back into the driver providing the split and merge


