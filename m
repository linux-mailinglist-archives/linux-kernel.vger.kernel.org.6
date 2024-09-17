Return-Path: <linux-kernel+bounces-331762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7371497B0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5992895B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C82C1779AB;
	Tue, 17 Sep 2024 13:43:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE271803E;
	Tue, 17 Sep 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580627; cv=none; b=gbl56SMsjqkWwqlLKa2j3it9P6B7xW/TUbaw1f38ozo8ALCBYlew2iFgNG03dxARGlmcDx7HThdcPq95PfoBhGSkaSyYcpaxZpM0Jzz5M9IfR/inowrI11N+69yh11997/c4oOsLPm3t2G1qagRqRzNUgV7EQ/z97Hqkk0CE7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580627; c=relaxed/simple;
	bh=SoBcQwDaJ8+uNIdEyM8N9AClY8QjK48xnJ6xh4wKxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUkaxKIyWIPkw0+sETJ5urwzsRoRm0jYq11bRr7YEZXQ6dMwtM52HtBzzvkn9HSltTehDGWE7qwznV6TC4kEl7mUwZX/5DBgySjVHgGcqDgbJrLzi8gTd8SQXM6DeDVMOG+j4yQP9p+CjEyK0NeLq8oRXZpYsBYGAyRCAdcWj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Ev8gR9PBRICW+hm+IoZ1AQ==
X-CSE-MsgGUID: MHAxnoUVSi++GlQCV+jLIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25375589"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25375589"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 06:43:46 -0700
X-CSE-ConnectionGUID: 6+PbPi8IQgeclJgFKbhjMw==
X-CSE-MsgGUID: BJTXdvH2TB+gxLoX/YyuMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69411125"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 06:43:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sqYUJ-00000009pq4-335P;
	Tue, 17 Sep 2024 16:43:27 +0300
Date: Tue, 17 Sep 2024 16:43:27 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in INTEL MID PLATFORM
Message-ID: <ZumHf28MVOWhH-Q7@smile.fi.intel.com>
References: <20240917103955.102921-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917103955.102921-1-lukas.bulwahn@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 17, 2024 at 12:39:55PM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 5f1cda51107f ("platform/x86: intel_scu_wdt: Move intel_scu_wdt.h to
> x86 subfolder") moves intel-mid_wdt.h in ./include/linux/platform_data into
> the x86 subdirectory, but misses to adjust the INTEL MID PLATFORM section,
> which is referring to this file.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust the file entry to this header file movement.

Ah, thanks!
It was due to renase issue (initially the Intel MID MAINTAINERS patch was the last).

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



