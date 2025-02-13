Return-Path: <linux-kernel+bounces-512465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A5A339A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DB1165C55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6320B805;
	Thu, 13 Feb 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gx27qmYB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7B20B1ED;
	Thu, 13 Feb 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434052; cv=none; b=tdlRlytyy+YAmAtI9V5+hO5eTf5Jod3Umg3TnywbkAHhSzZqOR5HP8REKbHwaFVigKebna68iXCtLAQXAAgGZL9A17wxtk4Nbu3E5TYSdg7fc79wSnLrDNVnBPBRb+G1P/5/Pc0gxXfKoSMKPDhH/rFLfdS5MRb4e3GSOB/f6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434052; c=relaxed/simple;
	bh=usa/ZD9eo6oR2HXcMxracFfe5+vucFm+dr5h2mXZtcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgYnw3KSSk10YtkSr0F+DdjsBfeyawlUBxju7OLMoKbdLRjqzRvZ5j0lXGHEuCzHbrDboxCl6k+lYCJwGubo/LsxMn2vINniHUC8OUarQ6LGPzZUYh6MdcfwZQUJ82XnkMoky3VHKTSLfkSSciZPRAeNQidMnvvpZRbcxkkawC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gx27qmYB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739434051; x=1770970051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usa/ZD9eo6oR2HXcMxracFfe5+vucFm+dr5h2mXZtcE=;
  b=Gx27qmYBe1G1vovqJyNXMPK9DcTKIqbcw08ty2mxWEp94cb5pTD2gIEj
   bguGLwVzM5e/D74KcbeE2xP9JlXhIDHmPaIZQFsdJPZeGP+6ImkhkLFYW
   bHOvJ81ZQ0MTNZedZSsayUHfd3eAacFiqXqfH/jnUsq391W3XSfnaD5nh
   3eRrgcUqBUQ+YvBHW0z2b7bsJ3nXv8cFxz28nGHTjns84rx6rIeVLQRgn
   kDseOa+XQNW3B/SrsLqDMhx+p5guvwzyqaRD8ntJeM3w0TmdzbIW7vJCw
   k9Y40YA/7APWi+Bv7y+ePXh1qhtRN8I47usiQ9O2/GFLVcrnI3tsu2hMw
   w==;
X-CSE-ConnectionGUID: 9p+e3iB1Swen+4vBMC1j1Q==
X-CSE-MsgGUID: ev/5A+/2TAS8HCExeqRU7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51517529"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51517529"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:07:12 -0800
X-CSE-ConnectionGUID: DE0Db2kJTBuQiCzTf1puqg==
X-CSE-MsgGUID: ZzeN7gI5RB+dIqKDLQxnLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118258626"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 00:07:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiUFX-0000000B6EX-1V9w;
	Thu, 13 Feb 2025 10:07:07 +0200
Date: Thu, 13 Feb 2025 10:07:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <balbi@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: gadget: Add support for
 snps,reserved-endpoints property
Message-ID: <Z62oKwwhBC9ufH5c@smile.fi.intel.com>
References: <20250203191524.3730346-1-andriy.shevchenko@linux.intel.com>
 <20250203191524.3730346-3-andriy.shevchenko@linux.intel.com>
 <20250212011013.xumqgguhluxdslpz@synopsys.com>
 <Z6x5lB4hGpz-9IzS@smile.fi.intel.com>
 <Z6zvcF1oe4TklTlK@smile.fi.intel.com>
 <20250213011736.orc23wbgvjoybrbq@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213011736.orc23wbgvjoybrbq@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 01:17:41AM +0000, Thinh Nguyen wrote:
> On Wed, Feb 12, 2025, Andy Shevchenko wrote:
> > On Wed, Feb 12, 2025 at 12:36:04PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 12, 2025 at 01:10:17AM +0000, Thinh Nguyen wrote:
> > > > On Mon, Feb 03, 2025, Andy Shevchenko wrote:

...

> > > > > static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
> > > 
> > > > >  		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
> > > > >  			dep = dwc->eps[i];
> > > > > +			if (!dep)
> > > > > +				continue;
> > > > 
> > > > It should be fine to ignore this check here. Something must be really
> > > > wrong if there's an interrupt pointing to an endpoint that we shouldn't
> > > > be touching. If we do add a check, we should print a warn or something
> > > > here. But that should be a patch separate from this.
> > > 
> > > Theoretically everything is possible as it may be HW integration bug,
> > > for example. But are you asking about separate patch even from the rest
> > > of the checks? Please, elaborate what do you want to see.
> > 
> > Re-reading the code again, I don't understand. If we get to this loop
> > ever (theoretically it might be an old IP with the reserved endpoints),
> > we crash the kernel on the first gap in the array. And since the function
> > is called on an endpoint, it doesn't mean that all endpoints are allocated,
> > so I do not see the justification to issue a warning here.
> > Or do you imply that DWC3_VER_IS_PRIOR(DWC3, 183A) may not have an HW
> > integration similar to what we have on Intel Merrifield?
> > 
> > For now I'm going to leave this check as is.
> 
> Oops, you are correct. I read this as the same logic as below.

NP. Thank you for the review, and thanks for acking the next version!

-- 
With Best Regards,
Andy Shevchenko



