Return-Path: <linux-kernel+bounces-546535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F5A4FBD8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA94616D12E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B4B206F0C;
	Wed,  5 Mar 2025 10:25:53 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228F205AB0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170353; cv=none; b=q6ThKImSFZNgPaNHVXR6ZhRnnW/jymJtv4Re+XSY/v7OeZFJVvYJsYmfiO75OzwgOVXT3XiX/zJXEnMzQ5bMUpm61Zp5fwuLfSEaWio/4oBZNWCQLvWTX+JfndIIFlLjsS0glXhrOCd/M907Eww4EQaeljN3KiId9vxuqQInpLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170353; c=relaxed/simple;
	bh=ItiS4E8laBKeZou5HFbYZgNwx/zR5N819TIit3uCjpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l32ji5fEvEOf4kScj6FFZq6mE/BcqzTAt4qaWX3HxXBnZb3Bnkb8cY8YewHcOg1R/HaxL0qYqvSo7JUX9LWfLhsMFth3q/YXO5Obd4scOC0RCFyc1clawpVFF7Nsw0Va65cVjHXZ4L07/LHM1FULgT1hA0WXmr57KlBeMKbft+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201604.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503051825435377;
        Wed, 05 Mar 2025 18:25:43 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201604.home.langchao.com (10.100.2.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:25:42 +0800
Received: from locahost.localdomain (10.94.12.149) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:25:42 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <linus.walleij@linaro.org>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm: pl111: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 18:25:40 +0800
Message-ID: <20250305102540.2815-1-hanchunchao@inspur.com>
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
tUid: 20253051825430b65dd2f2dece0f4ceb240cc0849b790
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/gpu/drm/pl111/pl111_versatile.c:504 pl111_versatile_init() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/pl111/pl111_versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 1e4b28d03f4d..5f460b296c0c 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -501,7 +501,7 @@ int pl111_versatile_init(struct device *dev, struct pl111_drm_dev_private *priv)
 	 * if we find it, it will take precedence. This is on the Integrator/AP
 	 * which only has this option for PL110 graphics.
 	 */
-	 if (versatile_clcd_type == INTEGRATOR_CLCD_CM) {
+	if (versatile_clcd_type == INTEGRATOR_CLCD_CM) {
 		np = of_find_matching_node_and_match(NULL, impd1_clcd_of_match,
 						     &clcd_id);
 		if (np)
-- 
2.43.0


