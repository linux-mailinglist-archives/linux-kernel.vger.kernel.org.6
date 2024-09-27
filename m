Return-Path: <linux-kernel+bounces-341361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7398F987F03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61571F21918
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B895171089;
	Fri, 27 Sep 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FsuOPIlr"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C315854D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727420277; cv=none; b=dxh6G5HQvvMf5GkLaX3oG3I9/LYEUloUNxStsCRWVhNgdIoNJyDP4NQkeGqiVJph5nla6BOybBXtYYLf0gR9J+rWcJaUOeE9RDdNDKHU8yLGBNWXExaGv7Jej954juGbNxXiUVqLesjl5WGOyobZG5Bxp7M4qQkPg89fozeqk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727420277; c=relaxed/simple;
	bh=55fsKfoFW3cFpdX4eEwVdmlZSN/1KITXssyXDukoR9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D3yAM5MwvxZwU1WEqSuWVqUxI//FlDwt+6EyEdSNrFzqG+bWhnvzIdTjPnvaGJmZWlAJ1ak1BKMyE13KFFekahj6EuEF0KhOSt7CRLuqXpo/Q5krpbBbIfYCM+i9YG/OnJIkHGb7a5/G6uv0c2wEN2veJrcY1bHkWP3/eGdZaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FsuOPIlr; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727420273; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lm4phqS7A6HguwH5oHc4wZl+h617qLTjcXj+ufu38W8=;
	b=FsuOPIlrfughAV1cbzFrIxc4Q90x6N+4qzGEoX3XtNDvGNfL8Qj+3ESXp47fTJRysxvw6uJGrC5exZmdi5iHMPIZGPpx9EZAkGQaMPpiWSkdRUeJ3wz8qZ+2t2tG6PRO7pmtPUPdGv7YZ2ZXq0p4jv13LdrbIn8/tLKXO/x69kQ=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WFpiDnj_1727420263)
          by smtp.aliyun-inc.com;
          Fri, 27 Sep 2024 14:57:52 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: Felix.Kuehling@amd.com
Cc: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amdkfd: Remove the redundant parameter comments in function get_wave_count
Date: Fri, 27 Sep 2024 14:57:42 +0800
Message-Id: <20240927065742.126124-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit updates described non-existent parameters 'wave_cnt' and
'vmid', and failed to describe the existing 'queue_cnt' parameter.

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:954: warning: Excess function parameter 'vmid' description in 'get_wave_count'.
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:954: warning: Excess function parameter 'wave_cnt' description in 'get_wave_count'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11144
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 3bc0cbf45bc5..247d927438e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -944,9 +944,7 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
  *
  * @adev: Handle of device whose registers are to be read
  * @queue_idx: Index of queue in the queue-map bit-field
- * @wave_cnt: Output parameter updated with number of waves in flight
- * @vmid: Output parameter updated with VMID of queue whose wave count
- *        is being collected
+ * @queue_cnt: Output parameter updated with number of waves in flight
  * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-- 
2.32.0.3.g01195cf9f


