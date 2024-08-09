Return-Path: <linux-kernel+bounces-280742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D0794CE6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB69C1C21A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C2191F8D;
	Fri,  9 Aug 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kifipsTC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B941C6E;
	Fri,  9 Aug 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198624; cv=none; b=mpkdk3fMmMvP22g0AspMKGH8/kU6awP/h8M8re6mSjh9WR8sZOFLFdF5oS9jcS9nV55C+j6a3lMAjopJFLbya6ByQ6TvTI7t7wEVRc13oUHzNglgtDFlistIIEnkMVQMxVwRWmKqT8Isbz2H58KGZTpw0bT3Z03OMZK/Y5/M9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198624; c=relaxed/simple;
	bh=1FzYbWOLuoa+uz4DMEu0pz7Ud2kqpfV6TTOIjpY4fT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDAji1CwbEn3ysqpMMz7fdVgCM0YPsYc7FkaLbrmNRlODHJDS2xK+zLvIJxI5cpC0q2INxnwYeBAgsKdbKcDpeShSaEUbhGLOcVnNVvxQqXUdSyXJZvQyicGL4r6TcjbsupaT6lSTNUjd8ZTPXF/6N2J5ic/HDbP7Rg2cb6te7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kifipsTC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723198622; x=1754734622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1FzYbWOLuoa+uz4DMEu0pz7Ud2kqpfV6TTOIjpY4fT8=;
  b=kifipsTCgoGvs2rjqb2nKpJHfDOQaBRDGb+AT1GC77Pf6mbJF6pSjY86
   xd84+xdT3ie0+Jh2oxoxqTHQVy6i8vVDDeFjYt0HjOzcdpbgaL7ZFaPbi
   Vtsa6R8l1dUDJGnlHk2JaARKt+rLrPTgiOkMoy06xvINh1kAD2gmmDKIx
   22phw8+hJzaRooifiB3FtO21WOz5kcAsIq/nyo0v+sEOljtQ5SHRFJaWL
   ApfYj5gzR5R1FC9D31BotUAxRenBp+xB3gXUkMD9IgmxPZSjJitKL3IJW
   awqPRw1VgMxWPP6X1CQBGcoHGzWTR5eRZ20f58rA7hy5SQTF2SgxeORwT
   w==;
X-CSE-ConnectionGUID: EqlIbhLNRmu5EuO+nPTlQg==
X-CSE-MsgGUID: wFJqkKxpTIe/6cZ4dJvfaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12932045"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="12932045"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 03:17:01 -0700
X-CSE-ConnectionGUID: 8eIczuMFRT2RD3Nu+zn0vw==
X-CSE-MsgGUID: WFdNnVXyQ6auNoYRo1kCPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57495772"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO intel.com) ([10.245.245.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 03:16:56 -0700
Date: Fri, 9 Aug 2024 11:16:52 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: "Nilawar, Badal" <badal.nilawar@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
	tursulin@ursulin.net, airlied@gmail.com, daniel@ffwll.ch,
	linux@roeck-us.net, andi.shyti@linux.intel.com,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	anshuman.gupta@intel.com, riana.tauro@intel.com,
	ashutosh.dixit@intel.com, karthik.poosa@intel.com,
	andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v4] drm/i915/hwmon: expose fan speed
Message-ID: <ZrXslA1c-BhO6zYr@ashyti-mobl2.lan>
References: <20240809061525.1368153-1-raag.jadav@intel.com>
 <23dc7824-50cd-4ba3-be5a-df141e8fe69a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23dc7824-50cd-4ba3-be5a-df141e8fe69a@intel.com>

Hi Badal,

> > +static int
> > +hwm_fan_read(struct hwm_drvdata *ddat, u32 attr, long *val)
> > +{
> > +	struct i915_hwmon *hwmon = ddat->hwmon;
> > +	struct hwm_fan_info *fi = &ddat->fi;
> > +	u32 reg_val, pulses, time, time_now;
> > +	intel_wakeref_t wakeref;
> > +	long rotations;
> > +	int ret = 0;
> > +
> > +	if (attr != hwmon_fan_input)
> > +		return -EOPNOTSUPP;
> Using a switch case in rev3 is more logical here. It will also simplify
> adding more fan attributes in the future. This is why switch cases are used
> in other parts of the file.

it was my suggestion and to be honest I would rather prefer it
this way. I can understand it if we were expecting more cases in
the immediate, like it was in your case.

But I wouldn't have an ugly and unreadable one-case-switch in the
eventuality that something comes in the future. In that case, we
can always convert it.

Thanks,
Andi

