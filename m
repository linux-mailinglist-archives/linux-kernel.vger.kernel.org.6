Return-Path: <linux-kernel+bounces-391882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553AB9B8CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853461C21006
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B5155CA5;
	Fri,  1 Nov 2024 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzQq78Qs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2076839F4;
	Fri,  1 Nov 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449074; cv=none; b=NA/jeO3gzfAm8AuwnONUtgvjE7JHET89I/lFYl8xFw7h00RB6RCF+NOTeMah1MW5CluQa+23KjDSqeBsYCnjj/+LiODuQ+yD5Yl/6uONK9MJGV6ki+/mZvDCHDbVLs1Gqw+1O01WC+FYbuHlSaEDLSVPpLwz95R0BJ53bIWaXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449074; c=relaxed/simple;
	bh=bRIUBXwyuUR5UZBUszgbH8lg8rGnMux7wOltYqXItLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU2zvEyuLbuWahiE6NhjHPvglDzMqPbCuASCwKwlzBRUpmVi7IwbFM67oQ3MtfP+XOR3/RB/8+q0SWUF3YM6A/nmzRgxB8EJEXqGBaMDFcT0/pc5WBVqk7KOa4ZzPuQwB3KTX6UF1SdOsPthsEU20SlXTRuzw7ta3lpyYTZAB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzQq78Qs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730449073; x=1761985073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRIUBXwyuUR5UZBUszgbH8lg8rGnMux7wOltYqXItLs=;
  b=JzQq78QsdlrVeRmDy93DeGosFMpZgKCKQ1Hd9zC4wQgT3p33J8urC00S
   9oCGZqfe4snliWSEKegFid4arcuNEn8/SZEvxKBJqI9yEDkNsGBI6yZt+
   ZBkPF5X4C8frrgV0hucbrSBAJYgp/TuJIp0oxRM5IlxReTT0gIVVlc3lU
   gQfx2/h+PLArpWtNFhGHNDBnCj0hAxtlwE6VBcbdSQeg7t8vy8sKk9Raz
   aG31y+b5O2mqeXSitwxx8vQDt2gGiGnu7Po1oupEf+jr0mz0hnAhXlGDO
   K8/S8PbeabB0oTQqsm3/lKlvbObwvLEvDVjtJinWl7a7hYx4wc7LWQDs4
   w==;
X-CSE-ConnectionGUID: 7u15njSNTCydLSFk34IKJw==
X-CSE-MsgGUID: QbxfAPI5TNGwLCeu0JDefQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41579347"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="41579347"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:17:52 -0700
X-CSE-ConnectionGUID: zK+JKYeGQ/mNbJIvyhA3OA==
X-CSE-MsgGUID: rxGZFeNORqqCwLTOdcXExg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="88024299"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:17:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6mqn-00000009xZS-1yQQ;
	Fri, 01 Nov 2024 10:17:45 +0200
Date: Fri, 1 Nov 2024 10:17:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
	corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
	Dong Eddie <eddie.dong@intel.com>, N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [V2 4/4] Documentation ABI: add PPS generators documentation
Message-ID: <ZySOqYbGAmrmVZek@smile.fi.intel.com>
References: <20241031163508.259522-1-giometti@enneenne.com>
 <20241031163508.259522-5-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031163508.259522-5-giometti@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 31, 2024 at 05:35:08PM +0100, Rodolfo Giometti wrote:
> This patch adds the documentation for the ABI between the Linux kernel
> and userspace regarding the PPS generators.

...

> +What:		/sys/class/pps-gen/
> +Date:		February 2025

Don't you want to add KernelVersion? The date is hard to map to the actual
version where it may appear first.

> +Contact:	Rodolfo Giometti <giometti@enneenne.com>

Ditto for all of them.


-- 
With Best Regards,
Andy Shevchenko



