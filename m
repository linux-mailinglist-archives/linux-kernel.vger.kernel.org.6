Return-Path: <linux-kernel+bounces-512381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA206A33887
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198F2188BF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4D207E08;
	Thu, 13 Feb 2025 07:08:57 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA120205ACF;
	Thu, 13 Feb 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430537; cv=none; b=un6stlUE+11TA+LyfS5NRvvsAu5litZZu+x0agWJvPLiXCa2vIuaPXV9bEYVlDG7e3f1M+0wQhOQeGBInRCzol1nByIsMnZSyvbf2WEwfLOymj9rnnudOTfTvIzE14RSUyhIeBgmyUTCJf6kUTbc7HgfKZ0ZcLH9lnq1zRwoZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430537; c=relaxed/simple;
	bh=G7cFBjk0Nhtkq9jhkSQ0grLq6Hk5BwwhAOZXb5lb1d0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVsGs/T4H8lvA91Sjv7pb7DKZx5Vh2UJXoi8DisxbNfCFcRMzLkdIsIQ1teezdjN0TXDCvT1Pjkk1OBgzBu4QjTsupXeqUYK9WrdjRouUvXY3ZfoSCSDc/UxwdHfOlFCXiBOrx+TdmHlPfEtEF1xIAnvnZHho3m++WPALCcEClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id KZV00139;
        Thu, 13 Feb 2025 15:08:39 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Feb 2025 15:08:40 +0800
Received: from locahost.localdomain (10.94.13.56) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Feb 2025 15:08:39 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
	<Xinhui.Pan@amd.com>, <airlied@gmail.co>, <simona@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <corbet@lwn.net>, <Rodrigo.Siqueira@amd.com>,
	<mario.limonciello@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] Documentation: Remove repeated word in docs
Date: Thu, 13 Feb 2025 15:08:37 +0800
Message-ID: <20250213070837.2976-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201614.home.langchao.com (10.100.2.14) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 202521315083964d9b138c6aa985701335c0a1431e4b0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "the" in docs.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 Documentation/gpu/amdgpu/display/dc-debug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/display/dc-debug.rst b/Documentation/gpu/amdgpu/display/dc-debug.rst
index 013f63b271f3..605dca21f4ae 100644
--- a/Documentation/gpu/amdgpu/display/dc-debug.rst
+++ b/Documentation/gpu/amdgpu/display/dc-debug.rst
@@ -154,7 +154,7 @@ of the display parameters, but the userspace might also cause this issue. One
 way to identify the source of the problem is to take a screenshot or make a
 desktop video capture when the problem happens; after checking the
 screenshot/video recording, if you don't see any of the artifacts, it means
-that the issue is likely on the the driver side. If you can still see the
+that the issue is likely on the driver side. If you can still see the
 problem in the data collected, it is an issue that probably happened during
 rendering, and the display code just got the framebuffer already corrupted.
 
-- 
2.43.0


