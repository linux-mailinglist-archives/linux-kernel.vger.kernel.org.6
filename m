Return-Path: <linux-kernel+bounces-516797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89816A37781
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4525916EF6F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B182C1A255C;
	Sun, 16 Feb 2025 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEt5Y11o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA2199BC;
	Sun, 16 Feb 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739738146; cv=none; b=N3OFN3RNdZbxO0CXm7laT5azy34LXFBY4LSjFQxLXrMpWWDGA156oCNadp5A8PQFUpcx/FzWIW3CAYjIuPHvgMOHbAU9+aMAE6ELz7/ucjSXF6iw+U4fDe6o3io8Qym72Nnp3VcEBZMGt1DzJDL5CxHqrmugFuGQvnd0x/DhE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739738146; c=relaxed/simple;
	bh=LeyiCwbkjaOysFvQ4mOuGKJuih2sDYAwwRMijTkW+UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erA3qTQqiI3/SDg2e/epH8ur56/Ove6mUBCM2TZfKVe0tqwj2gR8N8J1cdBv8ckfpKoJ2/vOgld/7f20ax6xbc2CcdcqU+K64Y12CCHjgqRsidLvc8Lo5i4Spj+AJmxIequvfQesFv8WIWKb6hFCpa//Ees5fXbxO4VM8s6BuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEt5Y11o; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739738144; x=1771274144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LeyiCwbkjaOysFvQ4mOuGKJuih2sDYAwwRMijTkW+UI=;
  b=kEt5Y11o36VPTN9iqAFfY2apRvIzv8kmuOkwLJewq633Jy8Yr7KaRVeG
   7ZRnaNlK5GMokh9aXuOd/AwMhZl4DcKQUzp0EzQLuJnBfFlrbZybENRP+
   qmne5QZTxGTMbP5W0A2n3pjHxYmKo+a3K6/WFhzPslJByL/Jv4hPjVo5X
   GIFoxXAkJxY0GdKviJUZsQeWEL0E7q/INMIZODJAQ0FlCy6O0qo39B3ie
   SRIMVOgxjUMPUaanLmgjOdW4MRVnU1s6tF9+N7y7Nm5RWRY2Ez9LI9LYD
   sJ0T+jjO2yapRW+x4tQmg7gYazPtX6JlCH2JjbovQQXA3Am0FYCb5jHjC
   Q==;
X-CSE-ConnectionGUID: /RAd1RaeRZW4eni9aNheBw==
X-CSE-MsgGUID: kHudeDF3RLaGUk+fUGOnng==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="44074574"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="44074574"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:35:44 -0800
X-CSE-ConnectionGUID: ZMQX+35ZQbSQ/d9tzrkZiQ==
X-CSE-MsgGUID: IhxRcb3/ScOjFBSjnZ/+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="118959537"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:35:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tjlMY-0000000CD37-2oJx;
	Sun, 16 Feb 2025 22:35:38 +0200
Date: Sun, 16 Feb 2025 22:35:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>, Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 11/14] platform/x86: Split the alienware-wmi driver
Message-ID: <Z7JMGq8iEaY7Fziw@smile.fi.intel.com>
References: <20250207154610.13675-1-kuurtb@gmail.com>
 <20250207154610.13675-12-kuurtb@gmail.com>
 <Z6uBJ9AC5XgZTlJG@black.fi.intel.com>
 <D7PT98IDXMUV.G2F1LRF8BX7@gmail.com>
 <Z6ufIQADzILVMusc@smile.fi.intel.com>
 <D7SIOS9FABGO.1ZOTYZJ4PWMTA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7SIOS9FABGO.1ZOTYZJ4PWMTA@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 05:21:00PM -0500, Kurt Borja wrote:
> On Tue Feb 11, 2025 at 2:04 PM -05, Andy Shevchenko wrote:
> > On Tue, Feb 11, 2025 at 12:59:53PM -0500, Kurt Borja wrote:
> >> On Tue Feb 11, 2025 at 11:56 AM -05, Andy Shevchenko wrote:
> >> > On Fri, Feb 07, 2025 at 10:46:07AM -0500, Kurt Borja wrote:

...

> >> >> +		set_bit(profile, choices);
> >> >
> >> > Do you need it to be atomic?
> >> 
> >> I don't think so. `choices` belongs to this thread only.
> >
> > So, __set_bit() will suffice then.
> 
> For some reason I thought `set_bit` was the non-atomic one. This is good
> to know.

JFYI it is an old agreement that foo() is the locked (atomic) version of
__foo(), but this agreement is broken in many cases nowadays (in many drivers
:( unfortunately).

...

> >> >> +void __exit alienware_wmax_wmi_exit(void)
> >> >> +{
> >> >> +	wmi_driver_unregister(&alienware_wmax_wmi_driver);
> >> >> +}
> >> >
> >> > Why not moving these boilerplate to ->probe() and use module_wmi_driver()?
> >> 
> >> This 3 files are a single module and it has two WMI drivers so this
> >> can't be used.
> >
> > Can it be split to two separate modules then?
> 
> These two WMI drivers share a lot of features on old alienware models.
> Hence why I decided to link them together. IMO this bit of boilerplate
> is a fair tradeoff.

It can be split to three files, common parts, mod1, mod2.

-- 
With Best Regards,
Andy Shevchenko



