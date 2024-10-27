Return-Path: <linux-kernel+bounces-383464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2A9B1C29
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075081C211F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03C2EAE5;
	Sun, 27 Oct 2024 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ru49DLQW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1924B29;
	Sun, 27 Oct 2024 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730003894; cv=none; b=fBDzwE8t+3Ghpc+17rILQwWn1ij8ICkDBwTPPYVIxwFHc4psI/JzKBbFwYq4B4pG/1Su/i5JNTtBQHto6x/sdXQ8Wi43cvBV7Xj0Dj8fT87ju56Mu+518jIa2u8HNT5K6tF7xO5VSo64sJryipN/6M6PBmu4lvVsYwlcs0YSxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730003894; c=relaxed/simple;
	bh=ECxxFyhpO8qHRImcih3jeV1ktiIwqvcCsxWmhdKNxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/JWgRUweW36T21dAr/TYe0ZVl89DwfiiYWXJaGgwGEjpLZilP6Hc1fo8E5l5zfAi2ublSQnE3MxOViD4t/HJzbRRE3k+4o3B7u37Dq4d6vyi1WUwRQDcfiLg6osWtytPY2yFk9u8G+4zVkIMib2c32zo8bdSphrCMUUm/ohftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ru49DLQW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730003892; x=1761539892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ECxxFyhpO8qHRImcih3jeV1ktiIwqvcCsxWmhdKNxh4=;
  b=Ru49DLQWBXeFYhCAHUsRzVZzMHhz4TYz2m9U4pKRHl8DbiKRH9R9tuCO
   BpFQ8x2OPnHWAIq6oiZxO13SXXrG6b4Q8kX8LiKXbRAChiyQzeY+vdt7U
   tjmLsqpAyHiaEuKVcvNaFhsI6IonZXP8fJ15bgRLnZM1qDfoBzP8DElR/
   V5pO8GbQJhbPj4pIRlieFuLQ+bfEwaFQiy0OZxzcfP25HbrkegEQ2FV9m
   UmAaPhWOsg0xkC3tindgRCm7hAqtkK06aK8OBiACMb/chxz+DF4eW0rQ0
   AMg4vPiWPdUfDHvaAoT5SwBvqmb+6gvVA+zKer3ZRG/ebQvTcNlkmEVrV
   A==;
X-CSE-ConnectionGUID: 8Ei0AJGySkqPUxOYFDOFag==
X-CSE-MsgGUID: dmHpKKnNRsa13MId6jkuTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="32491949"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="32491949"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 21:38:11 -0700
X-CSE-ConnectionGUID: TUJ2qrRORae0DfeeuQklgQ==
X-CSE-MsgGUID: 8d3gP7ykRz+5Hpbrgjsbbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="112140445"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Oct 2024 21:38:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4v2U-000aMc-0Z;
	Sun, 27 Oct 2024 04:38:06 +0000
Date: Sun, 27 Oct 2024 12:38:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Karl.Li" <karl.li@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Chungying Lu <chungying.lu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 3/3] mailbox: mediatek: Add mtk-apu-mailbox driver
Message-ID: <202410271207.42FIkHwC-lkp@intel.com>
References: <20241024092608.431581-4-karl.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024092608.431581-4-karl.li@mediatek.com>

Hi Karl.Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Karl-Li/dt-bindings-mailbox-mediatek-Add-apu-mailbox-document/20241024-173032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241024092608.431581-4-karl.li%40mediatek.com
patch subject: [PATCH 3/3] mailbox: mediatek: Add mtk-apu-mailbox driver
config: nios2-randconfig-r111-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271207.42FIkHwC-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241027/202410271207.42FIkHwC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271207.42FIkHwC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/mtk-apu-mailbox.c:29:24: sparse: sparse: symbol 'g_mbox' was not declared. Should it be static?

vim +/g_mbox +29 drivers/mailbox/mtk-apu-mailbox.c

    28	
  > 29	struct mtk_apu_mailbox *g_mbox;
    30	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

