Return-Path: <linux-kernel+bounces-546516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A5A4FB9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842C718832F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FADE2066C8;
	Wed,  5 Mar 2025 10:16:54 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB971EDA04
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169813; cv=none; b=cgvgwUQ1SFss6kkM6XjEfAuYZPiiumONL4/ksC/lM/TrqZLUoDanyXSr+hsn6PSc8ZCF5tto7Fz8/nTeOJTmodPjLwIIaUpiC0JhKqLkJBDjR9xGxQZIlyDne/XHOUSrmrXQrgAxHOs7TW3PVRMMixgs/d8e5865LcoTHybOxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169813; c=relaxed/simple;
	bh=9eJkz6xBHFlfxmfmWGtJEtqu6v7jI/bFb0XlenDIwFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbVUa9D1vORCquJPVfMpZ19HH7EzMxhPBAhohjjBRDkJPLGCMKIrv9wmvzWoKEjfMwlVittrfDh1TpZfkR5SqOD6Q6IvGDWXnuBLkSRKjiqbKHLGz0sd2SRDzVTZA9c0v1xCZ3DD3phAef5I+Pu89Kk4KTVd4PYs0o9jZ+EFnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202503051816425810;
        Wed, 05 Mar 2025 18:16:42 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:16:44 +0800
Received: from locahost.localdomain (10.94.12.149) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:16:43 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <alain.volmat@foss.st.com>, <rgallaispou@gmail.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm/sti: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 18:16:41 +0800
Message-ID: <20250305101641.2399-1-hanchunchao@inspur.com>
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
tUid: 2025305181642e8e3dbad78845846aec19cb8a166a0e9
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/gpu/drm/sti/sti_hda.c:696 sti_hda_bind() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/sti/sti_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 14fdc00d2ba0..6c9a49146f44 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -693,7 +693,7 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
 
 	connector->hda = hda;
 
-		bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
+	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
 	if (!bridge)
 		return -ENOMEM;
 
-- 
2.43.0


