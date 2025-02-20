Return-Path: <linux-kernel+bounces-523715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB66A3DA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949C519C0472
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1D21F5616;
	Thu, 20 Feb 2025 12:44:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAD1F4276
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055471; cv=none; b=PuQ7rkbil5U0blX5AvUVJ7yrrZzpFl2HKf8GPh9CvkAWlAlLKGqurE1UcNDfe2Cbex3zilNMinqA8Fc9KOFW/JeSXPXT2k3OVOSM4n8LTqP8qzyJUinwmPWG94jlFDDG9PwNJAATbrmhZqP3s7p1spA8tisKH/DevbdOBV4Fy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055471; c=relaxed/simple;
	bh=lvx92rKN2PxFjFrJ0WL6Nh9gpWcH5VUIvGWArYkDFL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMYTCOBJ4kUZTfFivk355opVEIg3C3Z0aM6o7VVWRCWSiXzWKg4czh8p2KSoxiiIZ9qhUNPZWcoVnRrIaUDrHVQWWD0gwIV4q5CI5/lMjneXnWQYbGE4QnBsMIzDsmWlwTl3b7LTGA9sONk9oazCvVhNmdTqJ2z8AEYU0sVLEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: K+7V4WxqSLCDiqwPlGtgjg==
X-CSE-MsgGUID: DConT0wlSKCiF2KgfD/fEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40951871"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40951871"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:44:29 -0800
X-CSE-ConnectionGUID: zDUthwpFSGacll6Cmhu3lQ==
X-CSE-MsgGUID: psRC0RrURMmVKVj4WTzidw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="120136922"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:44:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1tl5uj-0000000DKgG-1bRa;
	Thu, 20 Feb 2025 14:44:25 +0200
Date: Thu, 20 Feb 2025 14:44:25 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] auxdisplay: MAX6959 should select BITREVERSE
Message-ID: <Z7cjqd4T5vsELuoK@smile.fi.intel.com>
References: <11603b392e2899b44fce61bbc8626a1aaa32b8f0.1740037706.git.geert@linux-m68k.org>
 <CAHp75VcMweeEa=oAsVOLefuUKx96YJVg4ifdqT-uySPLXWeAeg@mail.gmail.com>
 <CAMuHMdXxu_H52JJPwwU-GSNA=J0qQ8oJtU53+gEidukTaFhseg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXxu_H52JJPwwU-GSNA=J0qQ8oJtU53+gEidukTaFhseg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 20, 2025 at 10:07:52AM +0100, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Thu, 20 Feb 2025 at 09:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Feb 20, 2025 at 9:48 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > If CONFIG_BITREVERSE is not enabled:
> > >
> > >     max6959.c:(.text+0x92): undefined reference to `byte_rev_table'
> >
> > LGTM now, thanks.
> > Do you think we are in an emergency to send it for v6.14?
> 
> No.
> 
> > If possible, I would prefer to send this in PR for v6.15 as the
> > problem was from day 1 and only bitbot found the configuration so far
> > that fails to build.
> 
> I had to go through lots of loops to disable BITREVERSE and reproduce
> the build issue (e.g. CRC32 selects BITREVERSE), so I doubt anyone
> will ever encounter it with a real config.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



