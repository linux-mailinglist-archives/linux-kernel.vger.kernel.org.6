Return-Path: <linux-kernel+bounces-558750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6B9A5EA87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF451174699
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B313A26D;
	Thu, 13 Mar 2025 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dGE+CHhX"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9BAF4FA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839907; cv=none; b=J/8w8MNXMiUV1gkqikuo5Cm4/6H0nAdmUTXIqBnqcS30G2zoJuVBt81tpNIDipBiZhvfjWxakqexJHo98AC07yaYFF3tBGwg9WTxmvDx2mrc2g3PyH2wR0hkqBnkPXHUHR4bn5tu4g96W5Cjov0PX5ltUgjPtovJHVzHLqb3ESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839907; c=relaxed/simple;
	bh=uOmNbrGMfropRywYdxYE8WWIPfslWOr4+goJLmUglPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjGa1RTWNhSeWaJmRlUotIsS3hon+8U04BbeWC99uXcu71XTZFOWpkiWj0p1f2llPKbpzLL8WFmmkXaD/99ZteIqx59i4xXhkUR96qX0JDiks31O3v7gvMLiSvB/o1HYdJqFJ+SQnTKIEHwe/g6cineCYMapG1aQfSQpDT8z5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dGE+CHhX; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.200.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 35E6B3F942;
	Thu, 13 Mar 2025 04:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741839463;
	bh=c+lwiNEeZKR7bI4cisdbs6du9vDi2xjExAwAe2kT2pU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=dGE+CHhX76Bjsezh7k3+mUoKnaOtigHVK8ZgjC3t+JdL598zHcLvL+cEbBWMBVhrC
	 I9hqbl5AxOeN6xgdOr5eERdLUfCZwNgbx+tKBQs/DS49ye20oc9jK421R2BxxxjfEN
	 /t/GDbo4f2Ev77VWm4OhNH432h+XFEYMYF4JEyNVLqXSrx7+f6Usgeg2RX98otPtU5
	 FxnRl4iGXKzD7NGj1logg0lXeZ9D/9SvxDS9dAD+B2HiPOZG+2ynkgPvwV4OpuOMYy
	 FMjkRcw5KwG2KXErJxXLJcz/mEeVm83d+XR3pEQeaSN5pWOFwcIRGedFYXP09hPrVv
	 VWMPFSEveZHsQ==
From: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
To: 
Cc: leo.lin@canonical.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: add .hdrtest to .gitignore under drm directories
Date: Thu, 13 Mar 2025 12:16:56 +0800
Message-ID: <20250313041711.872378-1-leo.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header self-contained tests in drm may leave .hdrtest files in
include/drm/ and drivers/gpu/drm/. Omit them by adding .gitignore

Signed-off-by: Yo-Jung (Leo) Lin <leo.lin@canonical.com>
---
 drivers/gpu/drm/.gitignore | 1 +
 include/drm/.gitignore     | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 drivers/gpu/drm/.gitignore
 create mode 100644 include/drm/.gitignore

diff --git a/drivers/gpu/drm/.gitignore b/drivers/gpu/drm/.gitignore
new file mode 100644
index 000000000000..d9a77f3b59b2
--- /dev/null
+++ b/drivers/gpu/drm/.gitignore
@@ -0,0 +1 @@
+*.hdrtest
diff --git a/include/drm/.gitignore b/include/drm/.gitignore
new file mode 100644
index 000000000000..d9a77f3b59b2
--- /dev/null
+++ b/include/drm/.gitignore
@@ -0,0 +1 @@
+*.hdrtest
-- 
2.43.0


