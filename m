Return-Path: <linux-kernel+bounces-553793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B91A58EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931643A839F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD020DD5B;
	Mon, 10 Mar 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ts9UIdCa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED5224257
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597394; cv=none; b=NViD9b2bhcPDeRs0u7gOlV7ZfzBBLjRCxwQ53tLdEZSSgbAXWNMRGcJ4TAGI2kFR/Jlx3z+GWfPkVB1XW4qqvs8T/QxcmZq7IkrdXwoIIYhLCTFBf+T1R9BJWHr5NIE7Hyyp8ZImpngzIG10Nod56KcbD8kG2g1lz9RoD2jXM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597394; c=relaxed/simple;
	bh=E/3AoimEHPfSiJVr+H62gGSF15LvCj70rP8AZpyOeV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9JoBChPYcsi2GZlafLqfreDjN9ljG+ZWoYxZIjiX0F0ClbEUwa+gGAn/ZDP51MWQNp6rp+xM+aUjFhU4QBlPn7RHK4KCrezm4XXhMZJqthUpwokbg3OgX/uJQ0UskI84bBmfy7XDsdtvceozUoIso9HfzPf8QjEabz/ZBcf5PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ts9UIdCa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741597394; x=1773133394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E/3AoimEHPfSiJVr+H62gGSF15LvCj70rP8AZpyOeV0=;
  b=Ts9UIdCaJeJV1FRkSL6Z1l5DJbZHoszmXseRCD1QYv46z5tebHivrnWd
   OuVHMpS+ilg6AVHu5yStU+w29RemayeqZkaO7jlbRckN8SRarIjmdY6fW
   3WMnx1j/q/kCjXjRYpY6arptgQYhiJaCPb6NXkQGHtlT61rIJOu3nmP/r
   WAo4UiwDsZozW9TSK7tIhopDEVRjp1i3p1djc6hEnHT/Wl7sU5UsWVZuu
   dXBqahGnkmdNl4XsipuoV2t1FidANywzpj4yJawY+o/QS4X1Br5cjCZo8
   xZG5MS5ruo3BuhIr2REG2HAV9wqBsyrvzgFvjhh3rMfp4YBKj5zpLNbSI
   w==;
X-CSE-ConnectionGUID: jqEUreXuQwO2mmm9T591YA==
X-CSE-MsgGUID: FiHdv8wlSHCToqvj9erGrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46366757"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="46366757"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:03:13 -0700
X-CSE-ConnectionGUID: vOGfLQTETPCPjBAXnt9i4Q==
X-CSE-MsgGUID: i3XyW8wHRgSBsg5SNUH6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119769949"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:03:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trZ2R-00000001CLH-2H8k;
	Mon, 10 Mar 2025 11:03:07 +0200
Date: Mon, 10 Mar 2025 11:03:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, nnac123@linux.ibm.com,
	horms@kernel.org
Subject: Re: [PATCH next 5/8] test_hexdump: Fix sample output if zero bytes
 requested
Message-ID: <Z86qy5LOAJUlmkC9@smile.fi.intel.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
 <20250308093452.3742-6-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308093452.3742-6-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 09:34:49AM +0000, David Laight wrote:
> If 'len' is zero the expected output is an empty string even if
> 'ascii' is requested.

It's related to the previous one...
So, seems to me the series need a bit more (re-)thinking...

-- 
With Best Regards,
Andy Shevchenko



