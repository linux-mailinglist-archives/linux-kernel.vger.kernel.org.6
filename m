Return-Path: <linux-kernel+bounces-574891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21087A6EB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9ED51891045
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9D91A5BA6;
	Tue, 25 Mar 2025 08:12:41 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF9481C4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890361; cv=none; b=rs44CTKzMkXlWcdLDG9jVuqaXvNkHl3hKzJ6UwNKQ3rHV8IzrS1D+xPNAOoA0TBbrShCmVduEezGWhNAofOO2/Tz/HJKWHUrZXIWdGApsrE3bYWZ+4H5/MOu/dQtjAooplc0/g2gjkpRitrv3ajKQTiFFif8i5y6FERfFmxFrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890361; c=relaxed/simple;
	bh=5PEk+JDQsfLzMycFsSiNa9hy6CLK/qnFNELdqsC06r0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WloanrvhiROMEkhzf4ptlDI4PLdPnDr3lbZBu/d8m67dIVJUSOzBnlhp7w/NzTWP2aU7l3bc9Ot9fF2YFxvsYSJkNJZOejSbnKL5aOGu4KeK4NYowPPEyrvz966je9Dj8Vf9lxQdqg+zqUkG8qeBxEIyzAKxJ5dykvaa5nrX8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503251612350664;
        Tue, 25 Mar 2025 16:12:35 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 16:12:34 +0800
Received: from locahost.localdomain.com (10.94.16.22) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 16:12:33 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mripard@kernel.org>, <dave.stevenson@raspberrypi.com>,
	<mcanal@igalia.com>, <kernel-list@raspberrypi.com>,
	<maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
	<airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm/vc4: plane: fix inconsistent indenting warning
Date: Tue, 25 Mar 2025 16:12:32 +0800
Message-ID: <20250325081232.4217-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025325161235ef9fda8f684a16f0e8a09cc18c2a19e4
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


