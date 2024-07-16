Return-Path: <linux-kernel+bounces-253483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637099321F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59470B229B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26C17BB15;
	Tue, 16 Jul 2024 08:38:01 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D533335D3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119081; cv=none; b=SjxgCZL5FVhDPLjHNsH4qf+FsicQd6StVyABW5RqNupL4PyK4b5y+6GSnandTTqxa6cpx6yR+5HTJKklqWQWH4I2i0dz0wAmYW+Q2CQuKA+c9PP+nb2/OE5zRNKSoil+8OES7caSzDoM++5RzyOajxBuXr0zFDC1lbU11WPm0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119081; c=relaxed/simple;
	bh=BOF7NLOwq5fm/Pj/PWEnCpF9uLqIZrzl+aupNCzPNh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUeSvTCzNwLNY0rWyrrO3rke+fOfJMwQCH5ob8A139gUKLnoGkXDCicyiGOU+8qd3EQnfvgYhtcwKrQ8uz7RDQ0YFQFN2zmoZ55Nl7bRIUYesaIZClvExoMjBQ/+byi2Fl0+GNM8UMGfYpqiYAztx5a7KweXt0uqmz6OlELWUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz6t1721119067t1j4fc5
X-QQ-Originating-IP: BT+kcmN9uYv2QkdoMKC/3l/74MbZXXmtA9kVUJ2qgqI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Jul 2024 16:37:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1197825335289385382
From: WangYuli <wangyuli@uniontech.com>
To: helen.koike@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	david.heidelberg@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	vignesh.raman@collabora.com,
	torvalds@linux-foundation.org,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH] drm/ci: Upgrade setuptools requirement to 70.0.0
Date: Tue, 16 Jul 2024 16:37:43 +0800
Message-ID: <0237854884D6DB3C+20240716083743.33415-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

GitHub Dependabot has issued the following alert:

"Upgrade setuptools to version 70.0.0 or later.

 A vulnerability in the package_index module of pypa/setuptools
 versions up to 69.1.1 allows for remote code execution via its
 download functions. These functions, which are used to download
 packages from URLs provided by users or retrieved from package
 index servers, are susceptible to code injection. If these
 functions are exposed to user-controlled inputs, such as package
 URLs, they can execute arbitrary commands on the system. The
 issue is fixed in version 70.0.

 Severity: 8.8 / 10 (High)
 Attack vector:        Network
 Attack complexity:        Low
 Privileges required:     None
 User interaction:    Required
 Scope:              Unchanged
 Confidentiality:         High
 Integrity:               High
 Availability:            High
 CVE ID:         CVE-2024-6345"

To avoid disturbing everyone with the kernel repo hosted on GitHub,
I suggest we upgrade our python dependencies once again to appease
GitHub Dependabot.

Link: https://github.com/dependabot
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/ci/xfails/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/xfails/requirements.txt b/drivers/gpu/drm/ci/xfails/requirements.txt
index e9994c9db799..5e6d48d98e4e 100644
--- a/drivers/gpu/drm/ci/xfails/requirements.txt
+++ b/drivers/gpu/drm/ci/xfails/requirements.txt
@@ -11,7 +11,7 @@ requests==2.31.0
 requests-toolbelt==1.0.0
 ruamel.yaml==0.17.32
 ruamel.yaml.clib==0.2.7
-setuptools==68.0.0
+setuptools==70.0.0
 tenacity==8.2.3
 urllib3==2.0.7
 wheel==0.41.1
-- 
2.43.4



