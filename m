Return-Path: <linux-kernel+bounces-546580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCAA4FC65
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946CE16B2D7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD192207E05;
	Wed,  5 Mar 2025 10:41:05 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604F207A2E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171265; cv=none; b=iOB8ZiuLr50D9kXmdfCqB++i/phrxNQHQffvkF47sVG5SoSFw59RkE/bFNjxPRLalC32/fhT0OCokuGGOMIUZRCPAAeklikOzOQU81oEwARX52D+zAOm/TgKqvLrjo+uDQTdxKlXaD+wCgJdE7CdlBF80RR5GyMyRVGK6/bmoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171265; c=relaxed/simple;
	bh=3JPySr5dw3NPFVc4Lyn2JzIWtNxdbjeavFZy+IqtDX8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FbW/C5Xa6xJbH7Xi+HljMmaNVFld2yA57GfRp4OXxY3Yv5qwuAnu21oUyIKrWbfUDu+Kur1frfEnHDugPJlsxCcHONEuZN1yCUBZheULiJcmto405sJ69CRuqc/4S88T5DRAhY167nE1DBOlFPvlwlq85RbP00VGmL+tLcrJhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201620.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503051840595898;
        Wed, 05 Mar 2025 18:40:59 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201620.home.langchao.com (10.100.2.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:40:59 +0800
Received: from locahost.localdomain (10.94.12.149) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 18:40:58 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <Jesse.zhang@amd.com>,
	<Hawking.Zhang@amd.com>, <mario.limonciello@amd.com>, <tim.huang@amd.com>,
	<Likun.Gao@amd.com>, <kevinyang.wang@amd.com>, <dan.carpenter@linaro.org>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] drm/amdgpu: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 18:40:57 +0800
Message-ID: <20250305104057.3416-1-hanchunchao@inspur.com>
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
tUid: 2025305184059bb5983e679e3534c0473304859018e69
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c:582 amdgpu_sdma_reset_engine() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 42a7b86e41c3..1037a2f9e3b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -579,5 +579,5 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 	if (suspend_user_queues)
 		amdgpu_amdkfd_resume(adev, false);
 
-       return ret;
+	return ret;
 }
-- 
2.43.0


