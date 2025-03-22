Return-Path: <linux-kernel+bounces-572423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192BA6CA33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81D91B63267
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBDD1FC7C1;
	Sat, 22 Mar 2025 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="oQ1Hn2jm"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA01E522
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742648531; cv=none; b=ti2BEwCDTenBjCHJz6x4AlvM2xRDk+zA08elGxnfj0RAyrFt3XqKq/jRhvpOdcgdVrPerHZPNqW02ye8Mx6Sev3Oj6pz1qdyRWDDPBmgzRzQXuxXpMB4DNShQjBKY8C/pas4GZ2232jYB8rS7rgkOZPDvUjqrx01lYc6uxHKyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742648531; c=relaxed/simple;
	bh=rQAw/ISQ6BOYJwE4XWCJsIhRc7VzBe7pmK6CDlOObGc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=LiYKxKtiticERtiJKobGAdmwIPzGwpaxNBY+Oa14xafHaISMG5Nzt8v47JsTFRF1lAQbFztsXveGYgoRmgane7x2p9y/ooV1m+w1fkkd1fmkcAUTBKWcWqgujwQDARLYgPB7mE6tgMWqfv7ZeiKhFK770mFr2pSuuN8HhkSkEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=oQ1Hn2jm; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rrkAapiM4Z4Q3OEqykchoHDL9D+L/TPmZQaJ/pDnNE4=;
  b=oQ1Hn2jml6NUEPxnosT4RnWIFbnHOIQ7wykQCdnxt8Re0yhNWbysBNlH
   nd9USWN2zHY7hLmgK9jYBX2Hzd5qs9aqWZWAxo5gFbk9JiD6GfLFxhb1D
   ajg8XnKOWjcgqSsbcug62+WzCAZxp+Rfo6yAgbDK3weU25yAoQcbXFHNn
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.14,267,1736809200"; 
   d="scan'208";a="112315997"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2025 14:02:01 +0100
Date: Sat, 22 Mar 2025 14:02:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Lang Yu <Lang.Yu@amd.com>
cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
    Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c:311:49-70: opportunity for
 str_true_false(vpe -> collaborate_mode) (fwd)
Message-ID: <alpine.DEB.2.22.394.2503221401320.12345@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Sat, 22 Mar 2025 20:31:17 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c:311:49-70: opportunity for
    str_true_false(vpe -> collaborate_mode)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Lang Yu <Lang.Yu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   88d324e69ea9f3ae1c1905ea75d717c08bdb8e15
commit: f9070b0f2f9edb503b20b12782d4d601cafc6d5e drm/amdgpu/vpe: add VPE 6.1.1 support
date:   1 year ago
:::::: branch date: 15 hours ago
:::::: commit date: 1 year ago
config: loongarch-randconfig-r064-20250322 (https://download.01.org/0day-ci/archive/20250322/202503222049.sUXL3q6w-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202503222049.sUXL3q6w-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c:311:49-70: opportunity for str_true_false(vpe -> collaborate_mode)

vim +311 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c

9d4346bdbc6484 Lang Yu    2022-05-23  290
9d4346bdbc6484 Lang Yu    2022-05-23  291  static int vpe_early_init(void *handle)
9d4346bdbc6484 Lang Yu    2022-05-23  292  {
9d4346bdbc6484 Lang Yu    2022-05-23  293  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
9d4346bdbc6484 Lang Yu    2022-05-23  294  	struct amdgpu_vpe *vpe = &adev->vpe;
9d4346bdbc6484 Lang Yu    2022-05-23  295
4e8303cf2c4dd2 Lijo Lazar 2023-09-11  296  	switch (amdgpu_ip_version(adev, VPE_HWIP, 0)) {
9d4346bdbc6484 Lang Yu    2022-05-23  297  	case IP_VERSION(6, 1, 0):
9d4346bdbc6484 Lang Yu    2022-05-23  298  		vpe_v6_1_set_funcs(vpe);
9d4346bdbc6484 Lang Yu    2022-05-23  299  		break;
f9070b0f2f9edb Lang Yu    2023-11-15  300  	case IP_VERSION(6, 1, 1):
f9070b0f2f9edb Lang Yu    2023-11-15  301  		vpe_v6_1_set_funcs(vpe);
f9070b0f2f9edb Lang Yu    2023-11-15  302  		vpe->collaborate_mode = true;
f9070b0f2f9edb Lang Yu    2023-11-15  303  		break;
9d4346bdbc6484 Lang Yu    2022-05-23  304  	default:
9d4346bdbc6484 Lang Yu    2022-05-23  305  		return -EINVAL;
9d4346bdbc6484 Lang Yu    2022-05-23  306  	}
9d4346bdbc6484 Lang Yu    2022-05-23  307
9d4346bdbc6484 Lang Yu    2022-05-23  308  	vpe_set_ring_funcs(adev);
9d4346bdbc6484 Lang Yu    2022-05-23  309  	vpe_set_regs(vpe);
9d4346bdbc6484 Lang Yu    2022-05-23  310
f9070b0f2f9edb Lang Yu    2023-11-15 @311  	dev_info(adev->dev, "VPE: collaborate mode %s", vpe->collaborate_mode ? "true" : "false");
f9070b0f2f9edb Lang Yu    2023-11-15  312
9d4346bdbc6484 Lang Yu    2022-05-23  313  	return 0;
9d4346bdbc6484 Lang Yu    2022-05-23  314  }
9d4346bdbc6484 Lang Yu    2022-05-23  315

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

