Return-Path: <linux-kernel+bounces-259856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236AB939E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86012B2258A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF314B96F;
	Tue, 23 Jul 2024 09:54:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C7822615
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728455; cv=none; b=D1SyUW7r4rzgpv9Vhmw93x5/x02PlFFwo1EdHqosrd5In6SbMzOriLLP3YmPGVin0Gvb4tTDAvf5QX47Yazi2B/oHkyUYYkzD6axpROD3Y2XEMqjJsydqp0tN78lVq5seMn1JsLFsY80XYE3F9d6Eq/ZKJUdGj7rRmSTKvl7lII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728455; c=relaxed/simple;
	bh=NtfIwWeXvlsZEG/2wTXt7RzqUXcT2D9B1ujIXtUiaTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZP+kvWPEXqa6HMpUbbSHnBd2bPfpFfYFywC2jq5aoubQ6C4Mvkcw/CRVXUuDwBJ9/iNnvtCdp5JnKhBrNy2wa7t2qJc1NxIK0G+0McaclEMQ3fY6NOKsSIBo9Ihs+uIiPdDInic/rZwM+3SFTGj+eT7qq5eIjSybdjoPshXI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ebe9620248d711ef93f4611109254879-20240723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:9a903de0-ccdc-49ef-9344-e19dc9abf223,IP:5,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-15
X-CID-INFO: VERSION:1.1.38,REQID:9a903de0-ccdc-49ef-9344-e19dc9abf223,IP:5,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-15
X-CID-META: VersionHash:82c5f88,CLOUDID:b4718e6bfbe46ce6a77ef1fe607cb3a7,BulkI
	D:240723173705O876ZW6R,BulkQuantity:1,Recheck:0,SF:66|23|72|19|43|74|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: ebe9620248d711ef93f4611109254879-20240723
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(111.48.58.10)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2021975999; Tue, 23 Jul 2024 17:42:48 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	kenneth.feng@amd.com
Cc: mario.limonciello@amd.com,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	candice.li@amd.com,
	victorchengchi.lu@amd.com,
	sunil.khatri@amd.com,
	Jun.Ma2@amd.com,
	kevinyang.wang@amd.com,
	Tim.Huang@amd.com,
	jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/amdgpu: fix OLAND card ip_init failed during kdump caputrue kernel boot
Date: Tue, 23 Jul 2024 17:42:32 +0800
Message-Id: <20240723094232.162319-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Why]
When running kdump test on a machine with R7340 card, a hang is caused due
to the failure of 'amdgpu_device_ip_init()', error message as follows:

  '[drm:amdgpu_device_ip_init [amdgpu]] *ERROR* hw_init of IP block <si_dpm> failed -22'
  '[drm:uvd_v3_1_hw_init [amdgpu]] *ERROR* amdgpu: UVD Firmware validate fail (-22).'
  '[drm:amdgpu_device_ip_init [amdgpu]] *ERROR* hw_init of IP block <uvd_v3_1> failed -22'
  'amdgpu 0000:01:00.0: amdgpu: amdgpu_device_ip_init failed'
  'amdgpu 0000:01:00.0: amdgpu: Fatal error during GPU init'

This is because the caputrue kernel does not power off when it starts,
cause hardware status does not reset.

[How]
Add 'is_kdump_kernel()' judgment.
For 'si_dpm' block, use disable and then enable.
For 'uvd_v3_1' block, skip loading during the initialization phase.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
During test, I first modified the 'amdgpu_device_ip_hw_init_phase*', make
it does not end directly when a block hw_init failed.

After analysis, 'si_dpm' block failed at 'si_dpm_enable()->
amdgpu_si_is_smc_running()', calling 'si_dpm_disable()' before can resolve.
'uvd_v3_1' block failed at 'uvd_v3_1_hw_init()->uvd_v3_1_fw_validate()',
read mmUVD_FW_STATUS value is 0x27220102, I didn't find out why. But for
caputrue kernel, UVD is not required. Therefore, don't added this block.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/si.c            | 6 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 137a88b8de45..52ebc24561c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -50,6 +50,7 @@
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
 #include <linux/pci.h>
+#include <linux/crash_dump.h>
 
 #include <drm/ttm/ttm_bo.h>
 #include <drm/ttm/ttm_placement.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 85235470e872..fc0daed1b829 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2739,7 +2739,8 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 #endif
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
+		if (!is_kdump_kernel())
+			amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
 		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
 		break;
 	case CHIP_OLAND:
@@ -2757,7 +2758,8 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 #endif
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
-		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
+		if (!is_kdump_kernel())
+			amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
 		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
 		break;
 	case CHIP_HAINAN:
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a1baa13ab2c2..8700a22ba809 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -1848,6 +1848,7 @@ static int si_calculate_sclk_params(struct amdgpu_device *adev,
 static void si_thermal_start_smc_fan_control(struct amdgpu_device *adev);
 static void si_fan_ctrl_set_default_mode(struct amdgpu_device *adev);
 static void si_dpm_set_irq_funcs(struct amdgpu_device *adev);
+static void si_dpm_disable(struct amdgpu_device *adev);
 
 static struct si_power_info *si_get_pi(struct amdgpu_device *adev)
 {
@@ -6811,6 +6812,11 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	struct amdgpu_ps *boot_ps = adev->pm.dpm.boot_ps;
 	int ret;
 
+	if (is_kdump_kernel()) {
+		si_dpm_disable(adev);
+		udelay(50);
+	}
+
 	if (amdgpu_si_is_smc_running(adev))
 		return -EINVAL;
 	if (pi->voltage_control || si_pi->voltage_control_svi2)
-- 
2.25.1


