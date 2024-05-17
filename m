Return-Path: <linux-kernel+bounces-182687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2618C8E7D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E8B21310
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDAC140E4D;
	Fri, 17 May 2024 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="IAFN0GXD"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4E1E891
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988557; cv=none; b=jTt7G+KIVZpcejJVUsTkHXwUxPc4ee1dszTH6vIX7oSEIvD/tSWACCL42n/ygcMROXbTEsVjw6qHEE6sU+PLMKSD+auVb2LSZdpSwITuZAgx9GASJSw1Y8c350HeVFTN07JiT/ASHc5XRumQTyyPV7rOIxTanwYmj5OvDUgSM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988557; c=relaxed/simple;
	bh=g5hkFF2YatT1J555QjHP98S2fwrGFhKOuoy/tBv+6sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDUPro3Ak6W2b92gUtznxGLbx74M7WFW1KBll+kwhLXgxJjKG7fxiWWBhvbd0Zv6xdxsmnx3O7Vyig6UntaI8xxmo0yKREFN/1xWZycEW6Ap3ag23OzBpAaTTKSjHRhJTIu1e2GfCYF1woWSHThfX0NoiCbd3qksnYls4d85oEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=IAFN0GXD; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ILMEqfh6mvs3M8j1PQ8qkskmAIghR6blibOu6WSgkI8=; b=IAFN0GXDM37GpEc8
	QPOxKd6lWlXkBNOtBnJ7FyvQBhOcrNP7svoLSWggCSXmfjwvEml53oLsbc8tJbUBjrVvRT6rNgWhW
	Z1iBzrTxITvbKsTeKQglKAnWkx132s8noF87SkyjJIuA6EDvSrvsymQUg0JRLdxVxEJqtazTn4Mgl
	7GFwsX0SInTFlEA2T/wqtJM8V5Jdx27uCoRIErcbveSh+9P5J1sj7p5CUmmkxNS0jIU34ggGdSQC8
	b+hSZCT3R8+6FfYKf7mduxsr9EONaVeGa39dq4nNYN5FiXG1/cdDGZ3d33ND/pjoBDVQx3whT4Hoo
	hOaMfqKaYCmgcSEMyg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s870g-001TlX-1J;
	Fri, 17 May 2024 23:29:10 +0000
From: linux@treblig.org
To: zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	maarten.lankhorst@linux.intel.com
Cc: daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/6] drm/vmwgfx: remove unused struct 'vmw_stdu_dma'
Date: Sat, 18 May 2024 00:28:58 +0100
Message-ID: <20240517232858.230860-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'vmw_stdu_dma' is unused since
commit 39985eea5a6d ("drm/vmwgfx: Abstract placement selection")
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 2041c4d48daa..50022e9e3519 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -85,11 +85,6 @@ struct vmw_stdu_update {
 	SVGA3dCmdUpdateGBScreenTarget body;
 };
 
-struct vmw_stdu_dma {
-	SVGA3dCmdHeader     header;
-	SVGA3dCmdSurfaceDMA body;
-};
-
 struct vmw_stdu_surface_copy {
 	SVGA3dCmdHeader      header;
 	SVGA3dCmdSurfaceCopy body;
-- 
2.45.1


