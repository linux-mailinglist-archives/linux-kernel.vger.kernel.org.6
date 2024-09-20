Return-Path: <linux-kernel+bounces-333922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6097CFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 04:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799D62862FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0ABA20;
	Fri, 20 Sep 2024 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PWrhNpS3"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4FAD5B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726799334; cv=none; b=jHOOEpQI22dTGB/W2ZxJ+kGlURdjN+gj1TMM1+f4YHhJxbCuuWtGC2UHeraRCpAwW7vhfSPUvGS1E8107j8r7Z/gtOjHfJtoU9nrSwu5XHgjgq1X/KoRTvJyup36lmrJ4RPnk4zzZ2U6VxCOTmck5E2hbsJv6CbwnrQvyArVp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726799334; c=relaxed/simple;
	bh=BKlr3+EU7o2g+k9JolJofSyzaISCtBlFA1mmGxTc0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUBHF3SU+N01dSnKRFlFfBLeWyfCfO1M1V4UApWa/BnJAp2FQ5PD6dv5JSI4skQJe048j+MiY7+cH79nw/fVgOuHYDiQOaxKhnMpX8W3yIy9XAT18lEAsr/7SQ3rmYMnJTuOvy/aWbhQLtlrzgVXZdcKDODReOyUF6YVBbpRLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PWrhNpS3; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726799288;
	bh=ifx+ZckwuWVd+o/wPo5C7cSBCHIaUHDcqg3L8g5bsoI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PWrhNpS3vSd/z9yMNq2OlE2jUCWdmNOzyN1G42t3L1qIbTMFIqRJF2Jrlr4BQJIrz
	 l5UITmDDeXdoVwzsoCuFuqT/aCvRFWi/Qb2eeHOfAyHL4ym6Sl+X/fKcxZbvunAr5L
	 /zsE6Bfb13i1F3PlEIGD+CXcvj5bC9yEwiuillBw=
X-QQ-mid: bizesmtpsz8t1726799283t76ai2n
X-QQ-Originating-IP: c/JGzc5vUu00GxVqvgOYvgyNKNsXDRcwh2V9//dekwU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Sep 2024 10:27:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13208387810574560565
From: WangYuli <wangyuli@uniontech.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	yifan1.zhang@amd.com,
	vitaly.prosyak@amd.com,
	Tim.Huang@amd.com,
	Prike.Liang@amd.com,
	jesse.zhang@amd.com,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	kevinyang.wang@amd.com,
	srinivasan.shanmugam@amd.com,
	victorchengchi.lu@amd.com,
	Jiadong.Zhu@amd.com,
	tao.zhou1@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	le.ma@amd.com,
	Wenhui.Sheng@amd.com,
	alexdeucher@gmail.com,
	WangYuli <wangyuli@uniontech.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/amdgpu: Fix typo "acccess" and improve the comment style here
Date: Fri, 20 Sep 2024 10:27:55 +0800
Message-ID: <F25A139789E87C3E+20240920022755.1162495-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

There are some spelling mistakes of 'acccess' in comments which
should be instead of 'access'.

And the comment style should be like this:
 /*
  * Text
  * Text
  */

Suggested-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/all/f75fbe30-528e-404f-97e4-854d27d7a401@amd.com/
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/all/0c768bf6-bc19-43de-a30b-ff5e3ddfd0b3@suse.de/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d3e8be82a172..33fd2da49a2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1893,8 +1893,10 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
 
-	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   acccess. These should be enabled by FW for target VMIDs. */
+	/*
+	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
+	 * access. These should be enabled by FW for target VMIDs.
+	 */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 408e5600bb61..57b55b6d797d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1247,8 +1247,10 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(struct amdgpu_device *adev,
 	soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 	mutex_unlock(&adev->srbm_mutex);
 
-	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
-	   acccess. These should be enabled by FW for target VMIDs. */
+	/*
+	 * Initialize all compute VMIDs to have no GDS, GWS, or OA
+	 * access. These should be enabled by FW for target VMIDs.
+	 */
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID0_SIZE, 2 * i, 0);
-- 
2.45.2


