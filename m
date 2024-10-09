Return-Path: <linux-kernel+bounces-357910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736319977B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8771C220D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19291E285C;
	Wed,  9 Oct 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IP7Vn03r"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486D71A0AFA;
	Wed,  9 Oct 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510255; cv=pass; b=lVSdw2vFNnPmU+HvIl8dGPBX8UnhvPqgQJWFScX12BFaIwOLPMfL5SjbhYJlXF9tyTUdZKH+Q+4UAsl4IZ80AzG/rn9l8UEWEXPQX4E13lvDj3IOGnQ474BI+tW2He4veh6IcDRJxWMkawy3XQMEcL6zABEGUgYFvIgefVYCZnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510255; c=relaxed/simple;
	bh=EumyMqRP3ZRih9USB9tVghZIhnj4oL3qMhwfHWb7Sbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VrLBsIz3+Yn4hNkQ4yt4cyhtfKNbrqjYb628FxyfPin8wAt2CAuyidG/lLwxOnefFJMNOVhEgHrZ2reei2QnP8p1+rgDOTl8EkwGclR8Liu4ciwpcbyMZX7tbnlV3eE1tFcqpGcJdG3lyWjR0wPm9ufCvgcDSuXtgxNgynNyi38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=IP7Vn03r; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728510238; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RNpVt7PgbXAoEY9ef9PTTEqmkLcTC28ULUs6HOqzh1GF6iHuffhAAYYVswsNmevzhE/qmFBw95n8Kd8bDoM08xhJGbjREdSVyd91kgcz1luFbeKzBJtrETG3t+nu0+KZNTEdLQYanPZm/+nJHpp6JuhKSc4mJq5HYtrUF3teGaE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728510238; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YIlrE0fcMEPzbyHoxB6Wnq7KQhP7bhlB1XNHnfKuC+g=; 
	b=WB+vWQfxbmW9Igb53vhVA8xgInqaObyCraR2r/lXoQSKq5ADwjyWws+G8VSfcNf+F4amsOGtPrGq6K7px+sfH/bAsVaSodQG07++oG/+XnXeLJF14VPMZyd2t3rLjfpJtkyFEdw6Bd+VNC07W3wRUE029oGcoemhofYosm5CSvE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728510238;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=YIlrE0fcMEPzbyHoxB6Wnq7KQhP7bhlB1XNHnfKuC+g=;
	b=IP7Vn03rIc5lYG9cF81FXkBwzSB0pfvi1QCXO5SuW+Bec++6cDN6J7kM+GhzDYI7
	Iz/hPJ9QR0GjxUFpsdYYLdSKJVwB3BYedpLcz/m68p4doOlg9rOTgu9H1DtdMoL2Kum
	/eJd9kWY11iO/T8lVuAp2vPv5acBz/4L6/nLlqQY=
Received: by mx.zohomail.com with SMTPS id 1728510237013233.51078949345924;
	Wed, 9 Oct 2024 14:43:57 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: kernel@collabora.com,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/gpu: Fix Panthor documentation build warnings
Date: Wed,  9 Oct 2024 22:43:30 +0100
Message-ID: <20241009214346.2308917-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix Panthor documentation build errors uncovered by the makedocs target
when building with extra warnings enabled.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: f25044688b04 ("drm/panthor: add sysfs knob for enabling job profiling")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/gpu/drivers.rst         | 1 +
 Documentation/gpu/drm-usage-stats.rst | 1 +
 Documentation/gpu/panthor.rst         | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index b899cbc5c2b4..7b1282e2d807 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -22,6 +22,7 @@ GPU Driver Documentation
    afbc
    komeda-kms
    panfrost
+   panthor
 
 .. only::  subproject and html
 
diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index a80f95ca1b2f..12ca3193bf15 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -186,4 +186,5 @@ Driver specific implementations
 
 * :ref:`i915-usage-stats`
 * :ref:`panfrost-usage-stats`
+* :ref:`panthor-usage-stats`
 * :ref:`xe-usage-stats`
diff --git a/Documentation/gpu/panthor.rst b/Documentation/gpu/panthor.rst
index cbf5c4429a2d..3f8979fa2b86 100644
--- a/Documentation/gpu/panthor.rst
+++ b/Documentation/gpu/panthor.rst
@@ -4,7 +4,7 @@
  drm/Panthor CSF driver
 =========================
 
-.. _panfrost-usage-stats:
+.. _panthor-usage-stats:
 
 Panthor DRM client usage stats implementation
 ==============================================
-- 
2.46.2


