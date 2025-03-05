Return-Path: <linux-kernel+bounces-546523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F87A4FBB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D603918873D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D97205E2B;
	Wed,  5 Mar 2025 10:21:18 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882C13AC1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170077; cv=none; b=sR5h7U+cGVE8zbluES4uxKewVc2tq7tmIOQrjSorglR49hwKVNd4BcwLKfn6SdKU28qEft9bIefHn5FL8DK2rGV8WU7s7UtUQivZg34w+AE/snFKqNoCgarBhOl8nK9vfzWAHyASdObMjbL3d/nnwP6nfPFWiqDcBk9kf+MrG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170077; c=relaxed/simple;
	bh=5PEk+JDQsfLzMycFsSiNa9hy6CLK/qnFNELdqsC06r0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnpAqgpjONP+HtHgL21Ep1/omSA5dfoT9p49/QUZA+8Y3l/LaXRcsY0KV/+PmKpjHZj/1/K8MK27s+KVaR9nMaJO//q5hRSt0YG9FWDGOLMiHxkoOoU5Q/Sn+uZxJSOGpVCkIbdQOXymFvBDfE0y6lwRi3m59D7Ii+CvmbJeGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202503051821078543;
        Wed, 05 Mar 2025 18:21:07 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:21:09 +0800
Received: from locahost.localdomain (10.94.12.149) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:21:08 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mripard@kernel.org>, <dave.stevenson@raspberrypi.com>,
	<mcanal@igalia.com>, <kernel-list@raspberrypi.com>,
	<maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
	<airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm/vc4: plane: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 18:21:07 +0800
Message-ID: <20250305102107.2595-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201615.home.langchao.com (10.100.2.15) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025305182107940427e00671b9a07b4e530dba967011
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/gpu/drm/vc4/vc4_plane.c:2083 vc6_plane_mode_set() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index c5e84d3494d2..056d344c5411 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -2080,7 +2080,7 @@ static int vc6_plane_mode_set(struct drm_plane *plane,
 			/* HPPF plane 1 */
 			vc4_dlist_write(vc4_state, kernel);
 			/* VPPF plane 1 */
-				vc4_dlist_write(vc4_state, kernel);
+			vc4_dlist_write(vc4_state, kernel);
 		}
 	}
 
-- 
2.43.0


