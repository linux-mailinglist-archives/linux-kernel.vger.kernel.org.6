Return-Path: <linux-kernel+bounces-197079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80F8D65DA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0439F2900F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1E178C6E;
	Fri, 31 May 2024 15:35:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D4768F0
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169725; cv=none; b=Q5YU5qzXhNihB+olUvBSwj3Katixl5sqFaZr5DoxjPkj5amCqMBOdj7Z5OU2T1qSm+OwwnYhGMVkZhXuNg0s0CSiwueYlW9lbsMEQb6jEsE8657M5py9esPUtQVa3YGNTZcfTEaBq+uoPYF/aiz5nEolR7xn3q5TZjX8YiXOJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169725; c=relaxed/simple;
	bh=WzRVZRXW/49J+Ybd+DpDG+SXTI2pTex3NfX9W9B+acs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8VJ6Y2Kei0AuItvd/yiz1JSc0Gpe8cwSNOkrsZGH8IcmAX5bQDzTn+hGwrS4RIeDLc2bxYWh8seN/daVuz/+Zh1MGKXC7E01BE1DC5NsBoHqTrE1Gd81TX4Ytd2ZOexwm46DDGpgNUrhQlsROIlGSnfxpxLBds09h9SuVCIe4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: pVaiqx4URMS6CoSTD1k8gw==
X-CSE-MsgGUID: EaoSMrSRTSq1BwSFrckJdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25121307"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25121307"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:35:24 -0700
X-CSE-ConnectionGUID: /kCK+uXHTrWJCLe/IyZkDw==
X-CSE-MsgGUID: +RcDkpZiTQ2nJcc7cy7qdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36188237"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 08:35:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1sD4Hn-0000000CVY6-4C7E;
	Fri, 31 May 2024 18:35:20 +0300
Date: Fri, 31 May 2024 18:35:19 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: geert@linux-m68k.org, tzimmermann@suse.de, ojeda@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot
 message
Message-ID: <ZlnuNx6gKJV6w9YS@smile.fi.intel.com>
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 31, 2024 at 11:20:54AM +1200, Chris Packham wrote:
> Like we do for charlcd, allow the configuration of the initial message
> on line-display devices.

Pushed to my review and testing queue, thanks!

I tweaked the define to be LINEDISP as Geert suggested.

-- 
With Best Regards,
Andy Shevchenko



