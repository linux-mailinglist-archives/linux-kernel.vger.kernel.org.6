Return-Path: <linux-kernel+bounces-332665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29497BCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8569B284CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327D189F43;
	Wed, 18 Sep 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Z/nlijjs"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C9718A6D8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664877; cv=none; b=POvED0wmnkCWlAB0e7qW/Z0JNFFovgY7i9e6Z9DoRIedYCui2owaoMvWvHcLMHreqZJbedOI39JJyUjzd1Va/00znZGFZrTyCPboUMjWJMvVUqm5gLso2QFFH/efLIYIB78daxZPSNCfGC0PIzdlSJ5wruoKKbXclWlVJRuugMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664877; c=relaxed/simple;
	bh=FheUAec7IZrrKH4+pc1ScbmLFr0EFfoZVGSVTBU6VbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RB6lmtY818fHWJEmXpOjF0SYfJo/cA6HkkN4+j7oaZYxrwaxgHLbSS8u/psssqz+lrQsJWnNtEHKOYajrEy86aaDUhEhKJ81eTtO+YPKHsIuzqdT9ouGwcKvFoJAHn+S8cbfX6ZnrWoX174GmNOagqwnlpDhkEhWxvjey4Wg5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Z/nlijjs; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726664864;
	bh=+/DdLbFCN3x83oxAHHqnPnAEM1hgWNumW7T/6E5yt74=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Z/nlijjsIPVYfoQ6a59DNrs8PKxLojV+05bztVAkKuFI0yQdKA+BdSHxRWoxkM02y
	 r8PYArD1aocmjWuCG4KjpPoeLCy7KW9vWckPBX5avVwYKBPIxt6LGY5FN/CYveuVgK
	 9CYckwFXkqyHIKiOHkCcwK8b7pwbvcAr8i52VGSE=
X-QQ-mid: bizesmtp89t1726664860t19rzamf
X-QQ-Originating-IP: 2zu9pDuYwD3Ysa5lHmxqXSm3b9oArIDcCu9nUlMvo/o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 21:07:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14238727235013610136
From: WangYuli <wangyuli@uniontech.com>
To: helen.koike@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	wangyuli@uniontech.com,
	david.heidelberg@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [PATCH 2/4] drm/ci: Upgrade requests requirement to 2.32.0
Date: Wed, 18 Sep 2024 21:06:41 +0800
Message-ID: <DDD9CA844EBE782F+20240918130725.448656-3-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240918130725.448656-1-wangyuli@uniontech.com>
References: <20240918130725.448656-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

GitHub Dependabot has issued the following alert:

"build(deps): bump requests from 2.31.0 to 2.32.2 in
 /drivers/gpu/drm/ci/xfails.

 When making requests through a Requests Session, if the first
 request is made with verify=False to disable cert verification,
 all subsequent requests to the same origin will continue to ignore
 cert verification regardless of changes to the value of verify.
 This behavior will continue for the lifecycle of the connection in
 the connection pool.

 Severity: 5.6 / 10 (Moderate)
 Attack vector:          Local
 Attack complexity:       High
 Privileges required:     High
 User interaction:    Required
 Scope:              Unchanged
 Confidentiality:         High
 Integrity:               High
 Availability:            None
 CVE ID:        CVE-2024-35195"

To avoid disturbing everyone with the kernel repo hosted on GitHub,
I suggest we upgrade our python dependencies once again to appease
GitHub Dependabot.

Link: https://github.com/dependabot
Link: https://github.com/psf/requests/pull/6655
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/ci/xfails/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/xfails/requirements.txt b/drivers/gpu/drm/ci/xfails/requirements.txt
index 2fae1299e07b..f69b58356a37 100644
--- a/drivers/gpu/drm/ci/xfails/requirements.txt
+++ b/drivers/gpu/drm/ci/xfails/requirements.txt
@@ -7,7 +7,7 @@ charset-normalizer==3.2.0
 idna==3.4
 pip==23.3
 python-gitlab==3.15.0
-requests==2.31.0
+requests==2.32.0
 requests-toolbelt==1.0.0
 ruamel.yaml==0.17.32
 ruamel.yaml.clib==0.2.7
-- 
2.45.2


