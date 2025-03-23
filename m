Return-Path: <linux-kernel+bounces-572924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3AEA6D075
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20223188B54F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90518FDDB;
	Sun, 23 Mar 2025 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1N4RLvC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB13190052
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752385; cv=none; b=lVUfM3UHBc5jcrj1h/MJiUzQIj3JSoj9iZJ3lx0cKt/dQkssTsmKGMMz9VCJ02UWjUR80XEjuoZPQOL8jiOabzBSk1RBQkr4D8jzl5pOatMJ7ikIFMmn+XBD6O2M/u3DbmgYjdZDB9C4HL9mcvTKCqEL7LR1gREbdFKD6Kinj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752385; c=relaxed/simple;
	bh=MXnQHSr+AHPw86rzIi6v6hyJ1x6zW5Z8ZkydO4MLDWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HJH7VbYHV0ugibd0MHs53thnCfM9HchcfW3+h9ePJgsuvSC35xAKoAkCxm9EjSX1bKBUFGkelqDch+2Iy/GXzTanMzetJReLkpObXpHdi8oioy7TXJuDAgDluMcP6favUhHcySlddTRbAxPn50QdYUZwQP51H7I4BCZ1FlJUAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1N4RLvC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742752384; x=1774288384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MXnQHSr+AHPw86rzIi6v6hyJ1x6zW5Z8ZkydO4MLDWE=;
  b=Q1N4RLvCKknZ5+lV4vJvSQziEZ3cnifZTFTNH2OKVrPJV28inLZDbvHO
   Uue4VgA9sbkNFXSX6B+jf3zNB1EUmQIn6kQTDm9uyb0JLPyb0AYouFEe6
   3lrXJVwi7XwK8CCN2fh6GyaqRKShWAT+3ty8UFguZtLY4pQxLacgz9vgl
   zZJPLCv1bMFY3dbWi+LUdEB44N5Hu6nIZs/ISMoxq4AGiCqZJ4Z5NS4jJ
   ieAh/Rp240J7H9OdaAuvM8crUGU+SA/IponrutX5WZ/QGbSPqbLq59ZZw
   EKTZQXHGTr2+bVUbO0Uj9/WPuLgxO7GshJry235AxWBQ+RJoKDrBKWcou
   w==;
X-CSE-ConnectionGUID: FBxcxSGQQhW+tnJK1baEcw==
X-CSE-MsgGUID: HSGetSGxQ76KXC8+0Hoslg==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="44075977"
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="44075977"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 10:53:03 -0700
X-CSE-ConnectionGUID: hapjj2mNTSa3px8geK8Fvg==
X-CSE-MsgGUID: Vv89XpeVTKyojyWX9Ng4zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,270,1736841600"; 
   d="scan'208";a="124303459"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 23 Mar 2025 10:53:02 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twPVM-0002t7-0F;
	Sun, 23 Mar 2025 17:53:00 +0000
Date: Mon, 24 Mar 2025 01:52:42 +0800
From: kernel test robot <lkp@intel.com>
To: Rong Xu <xur@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Kees Cook <kees@kernel.org>
Subject: ld.lld: error: vmlinux.a(arch/riscv/kernel/process.o):(function
 __show_regs: .text.unlikely.+0xc): relocation R_RISCV_HI20 out of range:
 527419 is not in [-524288, 524287]; references '.L.str'
Message-ID: <202503240105.hUVR2ALl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   586de92313fcab8ed84ac5f78f4d2aae2db92c59
commit: 0043ecea2399ffc8bfd99ed9dbbe766e7c79293c vmlinux.lds.h: Adjust symbol ordering in text output section
date:   4 months ago
config: riscv-randconfig-r064-20250323 (https://download.01.org/0day-ci/archive/20250324/202503240105.hUVR2ALl-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project c2692afc0a92cd5da140dfcdfff7818a5b8ce997)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250324/202503240105.hUVR2ALl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503240105.hUVR2ALl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: vmlinux.a(arch/riscv/kernel/process.o):(function __show_regs: .text.unlikely.+0xc): relocation R_RISCV_HI20 out of range: 527419 is not in [-524288, 524287]; references '.L.str'
   >>> referenced by process.c:64 (arch/riscv/kernel/process.c:64)
   >>> defined in vmlinux.a(arch/riscv/kernel/process.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

