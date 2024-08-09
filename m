Return-Path: <linux-kernel+bounces-281062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D32B94D28E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31ED281ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3047197512;
	Fri,  9 Aug 2024 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fig52glp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BBB17555
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215138; cv=none; b=oaAvx0de7dh/Geop8W9FXSTe5A+scmBNuBlzxELzp6wyBPg287Ju1vEmn8QDcfmaHoA5nxgvqIg3d3OOSmIv6HwpsfMYE4TgK52+cl5suVjFLXeUfTPVVzCLNtKAd+kDMQ3JPdmzFga6Oh97Q4MnWJ50nXxQbGc4JUtSQXSKMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215138; c=relaxed/simple;
	bh=7WplMSug71/EOusgaQrPAOpsFo4e08Jx7F5wiEeran4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WqQmZrzsXt6iEC4GQi28hMGEEJNgpwWrX/8SlhnWOCzYj8W3v4Y6QrBl1aJiBTgAj5RIcXss29kl2sy/Gr7fFauQvHKSG/N0iHK+3T+AkNBbeZd4gheGhX8UawLyWqKICaSvP+GJEvJaQJA+JNeMVMpzV+G5sZGeiOMUTrQExYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fig52glp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723215136; x=1754751136;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7WplMSug71/EOusgaQrPAOpsFo4e08Jx7F5wiEeran4=;
  b=fig52glpQ6ISl8rTs1/elHxsUlPkRbDvj1e1YQVhW4bRGpj6NvVyBSBZ
   Pgh8H7a5DXP9OnzHKQa/vh2aMjo3i2RLmWNFglDN7u6eFHtpY/fJwNmWQ
   mk2DCiuTpXskxgbO3gkvEjFuuU/6gAFhCB7NVqtNRIoc05I25slYwtChE
   g6h8lETfkiSAelMsDO9bI8FJXYP5qligj84PflRoyJFK75oqsUP6DB1Jc
   okdyCn4tBeY11wxBtRKWQuxkh/hGY7RRP1c4Ex0LgH1eNZXsRi2uwZFmN
   jcPvyR5Vb8dOnXtQQcnPNOHiic8zihD6T3KZt+FrZexWIkYulr59+zngm
   g==;
X-CSE-ConnectionGUID: h1nk4OLeSKySTO90zYITiA==
X-CSE-MsgGUID: gKMy3nRlTSOatT3HILa1Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21249389"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21249389"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:52:15 -0700
X-CSE-ConnectionGUID: 0udurY+eQ7qN3rFsyrjGZA==
X-CSE-MsgGUID: hMiX7EJ+RMOdGFQ7ncAeLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57252255"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 09 Aug 2024 07:52:13 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scQyM-0008In-36;
	Fri, 09 Aug 2024 14:52:08 +0000
Date: Fri, 9 Aug 2024 22:51:27 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Niethe <jniethe5@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Gautam Menghani <gautam@linux.ibm.com>
Subject: arch/powerpc/kvm/powerpc.c:1061:9: error: implicit declaration of
 function 'kvmppc_get_vsx_vr'; did you mean 'kvmppc_get_sr'?
Message-ID: <202408092224.k3BjS6oT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jordan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
commit: 52425a3b3c11cec58cf66e4c897fc1504f3911a9 KVM: PPC: Introduce FPR/VR accessor functions
date:   11 months ago
config: powerpc64-randconfig-r051-20240809 (https://download.01.org/0day-ci/archive/20240809/202408092224.k3BjS6oT-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408092224.k3BjS6oT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408092224.k3BjS6oT-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kvm/powerpc.c: In function 'kvmppc_set_vmx_dword':
>> arch/powerpc/kvm/powerpc.c:1061:9: error: implicit declaration of function 'kvmppc_get_vsx_vr'; did you mean 'kvmppc_get_sr'? [-Wimplicit-function-declaration]
    1061 |         kvmppc_get_vsx_vr(vcpu, index, &val.vval);
         |         ^~~~~~~~~~~~~~~~~
         |         kvmppc_get_sr
>> arch/powerpc/kvm/powerpc.c:1063:9: error: implicit declaration of function 'kvmppc_set_vsx_vr'; did you mean 'kvmppc_set_sr'? [-Wimplicit-function-declaration]
    1063 |         kvmppc_set_vsx_vr(vcpu, index, &val.vval);
         |         ^~~~~~~~~~~~~~~~~
         |         kvmppc_set_sr
   In file included from arch/powerpc/kvm/powerpc.c:25:
   arch/powerpc/kvm/powerpc.c: In function 'kvm_vcpu_ioctl_get_one_reg':
>> arch/powerpc/kvm/powerpc.c:1729:52: error: implicit declaration of function 'kvmppc_get_vscr'; did you mean 'kvmppc_get_sr'? [-Wimplicit-function-declaration]
    1729 |                         val = get_reg_val(reg->id, kvmppc_get_vscr(vcpu));
         |                                                    ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/kvm_ppc.h:412:29: note: in definition of macro 'get_reg_val'
     412 |         case 4: __u.wval = (reg); break;        \
         |                             ^~~
   arch/powerpc/kvm/powerpc.c: In function 'kvm_vcpu_ioctl_set_one_reg':
>> arch/powerpc/kvm/powerpc.c:1780:25: error: implicit declaration of function 'kvmppc_set_vscr'; did you mean 'kvmppc_set_sr'? [-Wimplicit-function-declaration]
    1780 |                         kvmppc_set_vscr(vcpu, set_reg_val(reg->id, val));
         |                         ^~~~~~~~~~~~~~~
         |                         kvmppc_set_sr


vim +1061 arch/powerpc/kvm/powerpc.c

  1048	
  1049	
  1050	static inline void kvmppc_set_vmx_dword(struct kvm_vcpu *vcpu,
  1051		u64 gpr)
  1052	{
  1053		union kvmppc_one_reg val;
  1054		int offset = kvmppc_get_vmx_dword_offset(vcpu,
  1055				vcpu->arch.mmio_vmx_offset);
  1056		int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
  1057	
  1058		if (offset == -1)
  1059			return;
  1060	
> 1061		kvmppc_get_vsx_vr(vcpu, index, &val.vval);
  1062		val.vsxval[offset] = gpr;
> 1063		kvmppc_set_vsx_vr(vcpu, index, &val.vval);
  1064	}
  1065	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

