Return-Path: <linux-kernel+bounces-574870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D4A6EAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0052A16CB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43C1A5B9B;
	Tue, 25 Mar 2025 08:00:20 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994717E4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889620; cv=none; b=RrWOCRnQGAZEchCP0lYV6g3eEy7gJkud1DvUpuCvGbzII6GXb4YFocRrhmbH8KJmcv2kjFZAWvsImpt6fg2ihk+2Qr/fJSVnCnaaCnr7Z4W/OxwPFutDHv1e8zUhKp4xDQ42t5NUXAWgkfMgX3ns2jBO4gIfcIDbhFNP/XmoRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889620; c=relaxed/simple;
	bh=9eJkz6xBHFlfxmfmWGtJEtqu6v7jI/bFb0XlenDIwFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NNi8jdVjRJItxXTJizfRKyOIgc5RlZSOsosi2yP9IdaxrZRbL7m8XiOo8TewL1MO2DV92fJ9DsCievT44AFT0Mf27dHKJxDTZX19O0cX51oSLun6lmq0RqAG4CtAsYhA1KxKipe8NPRQLJwQq3uvfyUHuTSM+rPBtRdBHQX/jBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201609.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503251600120513;
        Tue, 25 Mar 2025 16:00:12 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 16:00:12 +0800
Received: from locahost.localdomain.com (10.94.16.22) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Mar 2025 16:00:11 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <alain.volmat@foss.st.com>, <rgallaispou@gmail.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	"Charles Han" <hanchunchao@inspur.com>
Subject: [PATCH] drm/sti: hda: fix inconsistent indenting warning
Date: Tue, 25 Mar 2025 16:00:09 +0800
Message-ID: <20250325080009.4016-1-hanchunchao@inspur.com>
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
tUid: 2025325160013cedcb9694d183af368d965475e555e5a
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


