Return-Path: <linux-kernel+bounces-546320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D094A4F921
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC9CC7A7712
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F01FCCE0;
	Wed,  5 Mar 2025 08:49:29 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB5155342
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164569; cv=none; b=AYrDcNor9LfQo30nl92X4PZEQE/kF6/+vFR4myY+1OOCsG8QVKNpQhKCqLJSEaHlTSVT9nGUEXasxu310dUudu0yxAI+E4xvOAmY23KHiE0x/TzCpFKGVSJHmxmzyk9S//rRLzNZ6w1Rh2np3HSxm6gCJtA6U6invL+m9foDphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164569; c=relaxed/simple;
	bh=yfFBnLn+fuD3/41VczLm6o4ptlqda7y5AWJitbLBqDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JMht9QBz6I37ASVNPa2u2OH5gtRW8fdveSqIWYz5RBKCXTBMiy5xtuyKcNlEPe3wbFXJTmG0Q2rc/O8NHB+9zFDVeEraf7u39QUexKfhwGRSwGtcDerSJigDC/95/SKj1idHzizA/rrH/AT/HUb+5BrsM1vydG6J3bUZhA7RRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201603.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202503051649121107;
        Wed, 05 Mar 2025 16:49:12 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 16:49:14 +0800
Received: from locahost.localdomain (10.94.3.63) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 16:49:13 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <patrik.r.jakobsson@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm/gma500: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 16:49:11 +0800
Message-ID: <20250305084911.6394-1-hanchunchao@inspur.com>
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
tUid: 2025305164912164124181fdacdef9f62b883ff43a2aa
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/gpu/drm/gma500/cdv_device.c:218 cdv_errata() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/gma500/cdv_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index 3e83299113e3..718d45891fc7 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -215,7 +215,7 @@ static void cdv_errata(struct drm_device *dev)
 	 *	Bonus Launch to work around the issue, by degrading
 	 *	performance.
 	 */
-	 CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
+	CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
 }
 
 /**
-- 
2.43.0


