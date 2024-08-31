Return-Path: <linux-kernel+bounces-309785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7525967064
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAAD1F2351C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12116A94F;
	Sat, 31 Aug 2024 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPtNQsZ0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D013B797;
	Sat, 31 Aug 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725094197; cv=none; b=qfQcTLZkaNb2vE6ueTwX7CnDAVu6jdqt3upAjj1rg2qagBZKteskmepjCXNhLqDUwyfSce37sQKp+1P13EmxkA3vbCwjzQio9w88dIK2mXTY1KiLbHhdzvVh+b7/eB1KeSLVRp3S/e7uxtGa26Orv7hwKM9jvrfKeWnWz2z5htg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725094197; c=relaxed/simple;
	bh=Qtwn4MMSQwPVIkrDa8LfPR7jXofCn96dS1Y0GPTstBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfCavYyJFUfE4mU2Ag1jT33U6GzvdVpdWhNYHqBwbm3CBNKxoXlAqSUbLZEBBIJpVhX1xB25FZb99qMrHxFu1Ti3iGcO/+BMKuaGHkLrp6r4+dE45MJg5xppWbLSvOr2W/tV/ci3yA1DziFQG7FwgUEP/2ubpZhBbXtLCyLAypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPtNQsZ0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725094195; x=1756630195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qtwn4MMSQwPVIkrDa8LfPR7jXofCn96dS1Y0GPTstBo=;
  b=VPtNQsZ05RIi0QAx1qaYQqNsVdEjdmDXYIKhXtjPtjyfP9m13XQc3048
   x1vhvJ4hkByZVlvbnU5lVwFa19EKJmFHpvLHxib6W5cp1zOw8M7zGEEfP
   /6hPxYj0Tv3qzwEZLidJCEvusvnQos8zVh5UWl2JQ4A/7qEcc+wkQFs9E
   P4fEnB6HRguil1xZCvUsbyLHcMIEJQLX92fSn94N0pf24zphdHnZg67ej
   ysuGQUJ2hIrOT/+lKaaD+1cQoLQxH/HDJ0EDY/4JjrgGVIgHKlscDxBql
   EnrHPrYGDekJG0ahzf/JC9epkSdI0QTQwYgaGBffLK7yYLzY9X7Q1XLIx
   A==;
X-CSE-ConnectionGUID: Buas4pi6TeaopqP1mxAmOg==
X-CSE-MsgGUID: 0Ilf8048TQKGoW4uAo/MGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23863000"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23863000"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 01:49:55 -0700
X-CSE-ConnectionGUID: NA9CVosaQ76HRFxiqyDTEQ==
X-CSE-MsgGUID: D9nNyHbbSlGFAa3u55Njtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="64865875"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Aug 2024 01:49:53 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skJnq-0002Tq-0d;
	Sat, 31 Aug 2024 08:49:50 +0000
Date: Sat, 31 Aug 2024 16:49:48 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] of: move empty_root and unittest data DTBs to
 .init.rodata section
Message-ID: <202408311656.JgYqHrnC-lkp@intel.com>
References: <20240826124802.1552738-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826124802.1552738-1-masahiroy@kernel.org>

Hi Masahiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on masahiroy-kbuild/fixes linus/master v6.11-rc5]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/of-move-empty_root-and-unittest-data-DTBs-to-init-rodata-section/20240826-205316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20240826124802.1552738-1-masahiroy%40kernel.org
patch subject: [PATCH] of: move empty_root and unittest data DTBs to .init.rodata section
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240831/202408311656.JgYqHrnC-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311656.JgYqHrnC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311656.JgYqHrnC-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: testdrv_probe+0x30 (section: .text) -> overlays (section: .init.data)
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

