Return-Path: <linux-kernel+bounces-263790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EECD93DA81
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152AF1F242EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7AA14A0A5;
	Fri, 26 Jul 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeuksaIJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9122E651;
	Fri, 26 Jul 2024 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031273; cv=none; b=rlnRu0K8gCVIwlE0LQSqnmdf/a8jA7/ukA2ZgJZUjUFY4Ye6lu7ICnPf/W21LnfqgJ/hpOM9W2XiNjWgqevn4pFbvL9Cle2szxWEYBLmuwt8DCePT+GZKb2VHVMe9Gi7wdcZ6dxFBUtTh/J/ZYkPt5Soxg5/hrnVa35D3GWhLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031273; c=relaxed/simple;
	bh=KXzyMiqWhQX4ndGNanRkoOPSluRFzpIB0ORYVmvSy3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8f5UkglGXu11T/1fvleGT2ZC3G3uOBxiNwdQoxphtlKNVpwcVhFSgmMPUeWjmrSbiXqx2cjnbfnVJc/kRIKW4XUg9mBKHmw23UoQicbxWXT4Z7zxRWzl4tHKLVW87IXg9yBvXNU8wEVEZVmO3gOqppx3Nk+Y8huxYIQNktkVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeuksaIJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722031271; x=1753567271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KXzyMiqWhQX4ndGNanRkoOPSluRFzpIB0ORYVmvSy3o=;
  b=eeuksaIJ0knl+UB65gIxRbDHSdCUkUikP6jqGgsOGpWJASNWzXnmaIEG
   hInNPJjteg3L6iNvWkHA6kwEd7zqz1D+2AxkPFbjcM+5S206LutI9qlJe
   xVCAnbW7hEp7Hx890i/5092Mw7jNLjgMxv0hLf5uwy0DCL/6kb2fZuPG9
   vsAd/U2RDr9TrQGgK9Eh7a+LFwWqRmv6+gsN8V4vyc/qX510X96BvUjjZ
   lcL87I55sYMp7lV5L/44IR8lkTrfJMYrDQHNsIMCk0wkhtopqS+5tePjt
   6e1tkMbLmREIu4SkZ7XzoLCh1ZMG+5zsWW564EFH/LtJl0Av9UfsOiP/4
   A==;
X-CSE-ConnectionGUID: DVDCkWW9RLmKCTypgPdUOg==
X-CSE-MsgGUID: t14r7Sc8QuaZJKHJZOWs/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="30452541"
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="30452541"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 15:01:11 -0700
X-CSE-ConnectionGUID: ZS/U4jQnQGenNkVQlQ7Tsw==
X-CSE-MsgGUID: RbzKLVvKQey2JPycz39+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,239,1716274800"; 
   d="scan'208";a="58171431"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Jul 2024 15:01:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXSzp-000pQi-0w;
	Fri, 26 Jul 2024 22:01:05 +0000
Date: Sat, 27 Jul 2024 06:00:36 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, mehdi.djait@bootlin.com,
	christophe.jaillet@wanadoo.fr,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <202407270505.ADlarsms-lkp@intel.com>
References: <20240726194456.1336484-3-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726194456.1336484-3-lanzano.alex@gmail.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on drm-misc/drm-misc-next linus/master v6.10 next-20240726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Lanzano/dt-bindings-display-Add-Sharp-Memory-LCD-bindings/20240727-035313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240726194456.1336484-3-lanzano.alex%40gmail.com
patch subject: [PATCH v2 2/2] drm/tiny: Add driver for Sharp Memory LCD
reproduce: (https://download.01.org/0day-ci/archive/20240727/202407270505.ADlarsms-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407270505.ADlarsms-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

