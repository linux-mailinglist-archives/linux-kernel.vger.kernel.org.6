Return-Path: <linux-kernel+bounces-361921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DAA99AEFB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F66BB223A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7FD1E0B8D;
	Fri, 11 Oct 2024 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="NxfrxLdI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51DE1D049D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687574; cv=pass; b=YhRjNOTdS030NbohTYBPRqj6yG0OOlSbg7aoe3O2SRXPnVCHdFI4mLRXB8arFzzX+yGF2zsuamfZE/uAiPkd6u3VHtK08rhlujNDBrgQZWnJ6zIdVG31M+bZs133L+Uh0U2Mk4aK6qdWAPcP2/Jqg0Fkn1P6RUg05s+LMJDvlUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687574; c=relaxed/simple;
	bh=Qv8CXLdZAiiNIfQVdO0ViFmqcC9M3xQEKZ7MafA4zWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WM5u2hVV+0NuJ3roP4XClNVy3MAg7TC5E11DjMzQj14Pbn9W0PcwH6qgx4jfqrfhO1wcVxkLBz1AZdElPvppXhE29iGuEcP+ZipXRZmCdrVHtmO5PH1BLgBxM0cfJMtRwf44rsc9Wekdcr3ZYzva/cCUzV70da4w6Ui9Zw3OkJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=NxfrxLdI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728687559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WjW1abGkQwA8Dk2uzIEWnYG5zIpa0GwBrr2rYJVVNUTtOanm6iKZVZpV2947o9yqGEwxvA7Ukvzz5uw97e18m5k4BjV2JxdmvmGlh22ILPFYEAKfGr6H2M63dw6pbuI7x83kp5hACFpl0/F69xJg3gHdDxKIcR8fo/CXXdC314k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728687559; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jFfN6A7FKfkWOXVC2socfrJvDAKg5lUtpPic1FuxX5U=; 
	b=TrQj6XseIwomwOlebXPGiD8nU2XnRc053EnIXqaqyz6G8uLRloJBcyplaZjpdd6d4gt7YagwsWt1XyMwm1p2GTQf1m6Bi0o0SZ8NSqs3HxzY5O/5OgE+HkqxbBByiQIlmkvYj9KXPBYaSOArGKH/jFQWbLQMKWLGyjEPVfKaqrI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728687559;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jFfN6A7FKfkWOXVC2socfrJvDAKg5lUtpPic1FuxX5U=;
	b=NxfrxLdIRQ5g1iShqyqs8xqJIAYs3ge7+YFbiXJK2vDzmN3OLFcuEabizvlD6E93
	eT8g7Bb9UBCVhlKPanzpzLZAG+YUFVGQTshF7VCUg67TMa79191cZgvKR7UM07UZFcc
	o1DQhYH9TuLyNfqBav5WhbSZfkR2Ht3WWwqN5jTM=
Received: by mx.zohomail.com with SMTPS id 1728687557745482.7109764290499;
	Fri, 11 Oct 2024 15:59:17 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/panthor: Fix runtime suspend sequence after OPP transition error
Date: Fri, 11 Oct 2024 23:56:59 +0100
Message-ID: <20241011225906.3789965-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In case an OPP transition to a suspension state fails during the runtime
PM suspend call, if the driver's subsystems were successfully resumed,
we should return -EAGAIN so that the device's runtime PM status remains
'active'.

If FW reload failed, then we should fall through, so that the PM core
can flag the device as having suffered a runtime error.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 4082c8f2951d..cedd3cbcb47d 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -528,8 +528,13 @@ int panthor_device_suspend(struct device *dev)
 		    drm_dev_enter(&ptdev->base, &cookie)) {
 			panthor_gpu_resume(ptdev);
 			panthor_mmu_resume(ptdev);
-			drm_WARN_ON(&ptdev->base, panthor_fw_resume(ptdev));
-			panthor_sched_resume(ptdev);
+			ret = panthor_fw_resume(ptdev);
+			if (!ret) {
+				panthor_sched_resume(ptdev);
+				ret = -EAGAIN;
+			} else {
+				drm_err(&ptdev->base, "FW resume failed at runtime suspend: %d\n", ret);
+			}
 			drm_dev_exit(cookie);
 		}
 
-- 
2.46.2


