Return-Path: <linux-kernel+bounces-538671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFAA49BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248FC17465F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4370926B97F;
	Fri, 28 Feb 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0ReA9YM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5426E63B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752244; cv=none; b=hlpvzzBUn5N1RGPNbHtVdF9yJlnrg35kw2UOJjBB4JDw8flRTXtc61yJTlvmCSyUjweE1DOSONNLjIViFJfWggoaqc5lvZykQ/ufXe0U45tggvjFEL4LjdkDblMnQ4a/lXZkI+sh9XejooCoZS8ZcmYYCll+/HlH3WBECjLcBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752244; c=relaxed/simple;
	bh=16brUvkqRfrzkx6Yi38s5UMJmUx0qgk+Q51rGTFtZbs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ulzcN8DL4JqG3nt/ip5CkEKb5j1khYS/UB/e5ugAdUqXb+WB3PRrBWHL2DCrPH3yOVReunIv1fmXJqHV4XrRFao7cJ3kYX8PLiDNzeHzoPdT/UvA28fA0rktEDiNIzmpCZT60f+CycR4LtWCs2b3K+bM2o9v+OijLwFrSbqXWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0ReA9YM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740752243; x=1772288243;
  h=date:from:to:cc:subject:message-id;
  bh=16brUvkqRfrzkx6Yi38s5UMJmUx0qgk+Q51rGTFtZbs=;
  b=e0ReA9YMWF807MwvY19mYFKDMBv12Y4H1dMrMGtpMyCniES3oGIPmkhc
   FLXphd902EqUoFT5oneAuK9haNgIM6i2dxHywBE+NNvSFAQL0yqBYK4zY
   Kfu7sW/YT/jlUn3qhB0pK1wrpD+9LgIJBrTkz/1hrUVstsFkEIEpq8dfl
   bSLh5wh7SIaydgGolZ1fETMYLTGFb/Y+qQin42uS23OD/NI4e6eXyiLqC
   T6XOJKeM3hGULvcCAgOnhxnhkrtc+1vEip2EqutCXnqyYZQIVBWhQrd3U
   JaPgctRze0mseYJ6MLylXpDbDowVtpJgknC6DL+ktozXsUzBooY/aXiEP
   g==;
X-CSE-ConnectionGUID: gZuSg63RTqKd3SnpMk/tLg==
X-CSE-MsgGUID: s7oLkZC9RXO9R9TS1CMU9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="53069452"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="53069452"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 06:17:22 -0800
X-CSE-ConnectionGUID: YyALxu6yRiirmT2Axp0bWw==
X-CSE-MsgGUID: glJhJJIoQvOwbG3ZTVQMtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="140570524"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 28 Feb 2025 06:17:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to1B1-000F0N-28;
	Fri, 28 Feb 2025 14:17:19 +0000
Date: Fri, 28 Feb 2025 22:15:48 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 9c94c14ca39577b6324c667d8450ffa19fc1e5c4
Message-ID: <202502282231.Ky7O8sDo-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 9c94c14ca39577b6324c667d8450ffa19fc1e5c4  x86/bootflag: Replace open-coded parity calculation with parity8()

elapsed time: 1462m

configs tested: 12
configs skipped: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386    buildonly-randconfig-001-20250227    gcc-12
i386    buildonly-randconfig-002-20250227    gcc-11
i386    buildonly-randconfig-003-20250227    clang-19
i386    buildonly-randconfig-004-20250227    gcc-12
i386    buildonly-randconfig-005-20250227    gcc-11
i386    buildonly-randconfig-006-20250227    clang-19
x86_64  buildonly-randconfig-001-20250228    clang-19
x86_64  buildonly-randconfig-002-20250228    clang-19
x86_64  buildonly-randconfig-003-20250228    gcc-12
x86_64  buildonly-randconfig-004-20250228    clang-19
x86_64  buildonly-randconfig-005-20250228    gcc-12
x86_64  buildonly-randconfig-006-20250228    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

