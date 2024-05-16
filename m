Return-Path: <linux-kernel+bounces-181128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68AC8C77CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F66282FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5A51474C6;
	Thu, 16 May 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Lx/VUXV+"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AA138C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866653; cv=none; b=VvQuXvThuYCMy9FOsCvBsw0/SYATDylZi1PNtT6TENMsBBAdkW0ikfAOZXjf3V0iHI8H8+/yRsLhwwW7V+g6fM2pwRt6HTMbs+JPqzfftkjN1me9xC58w2ja5n0tOEUVaTA42sm5F2iyL4CMtNv92fay9DJv4gTQqLYUrd0gFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866653; c=relaxed/simple;
	bh=G1lDGnjhyJ7Ve4PIHh0atn8KGFSqLwZuTuc0oadXrro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifcYQHb1awnHtrsCSAjvA2i3GOOOpaK9nob3lHA4xU9yO1sEFYytKe2B00FiUq79eea/QRxAQKccFLMdMRCHQL2q8LxG6TmBVy7689CPMikIWfJJxQJKfRbl9mV6EngwkKfUSxz/vl40kToxlSGmhFEveu0wTdOd3ee90SbAvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Lx/VUXV+; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zqiddJDPtoHIu0oZ8yctrj4tnb0n+qoaibljudxr+uE=; b=Lx/VUXV+8oIP1NeN
	fvLk7t+T8WwUqKHypprgU1b/JapMZp7DNA2CQaTCEGdNq/qPQNtH+Fa7o/rQWOoP3rxI/ereBkKZK
	wOHVmVMLVsyFpQt1I+e1qb1/ZjKDCUsW9bQwMkgfQKOUH1WAun4PMNGqwU6SuNQslfQuLvOGvz3Lr
	UjuRqzt9kStW7NeEIxko78Rtv/sHPq2EiRVIOwSMOmvYzIvNF8Ma064eFA/WY8+ZKS+jEdlJe64X1
	xbne+6VdXOogMSA2jbJXfSpmaNm78E7sYL6M3nqHQB8quXs6StDOvjoy0C7C0oMsNDc43+o1tXcpn
	aTDJZvJ7qUnSUmFfJA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s7bIS-001Eq6-34;
	Thu, 16 May 2024 13:37:25 +0000
From: linux@treblig.org
To: liviu.dudau@arm.com,
	mripard@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/komeda: remove unused struct 'gamma_curve_segment'
Date: Thu, 16 May 2024 14:37:24 +0100
Message-ID: <20240516133724.251750-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'gamma_curve_segment' looks like it has never been used.
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index d8e449e6ebda..50cb8f7ee6b2 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -72,11 +72,6 @@ struct gamma_curve_sector {
 	u32 segment_width;
 };
 
-struct gamma_curve_segment {
-	u32 start;
-	u32 end;
-};
-
 static struct gamma_curve_sector sector_tbl[] = {
 	{ 0,    4,  4   },
 	{ 16,   4,  4   },
-- 
2.45.0


