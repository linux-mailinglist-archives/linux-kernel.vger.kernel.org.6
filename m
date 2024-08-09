Return-Path: <linux-kernel+bounces-280873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5294D04E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820F1B22DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07B19413C;
	Fri,  9 Aug 2024 12:33:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3721DFF5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206819; cv=none; b=jTnRTwUlwFvyFqTq0AJEvWnizin/liVaONZzj+TP+jHKeAu00y5ginjNJGyKNXNOJph+V919CWmau4v1TSJxNVFfueQi250LcdVWIEOaG3A4MEhJpNSr5LUc4I7Ld3E2QEuaXhnxxgsNbqOo9qXhr1ieCop9IIThAcbkB6SfQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206819; c=relaxed/simple;
	bh=BJKJmrIyCP3SUD+BWk9lsHhu3+psPUuG8xSNrtkvrro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcY7gZHfk4IKOAUu2hh+CVf2cOO4pE/EhaCi1CG6qjOKzwnHerfFLoTQoNawLw7lZ7VdbEZp+wy0vxhkVgvGGGuseRchsvfbG10xET3N0w7B0oe73t89wH5ZGnPa7eFkebCRFS/AXKXNWk69j7uGmMPY1uI1/MQREUINZ30+G0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 4LGf8BuzT6Kw//YsCVcTTA==
X-CSE-MsgGUID: pLZeuPJVRYeyPzcOJiKzlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21519638"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21519638"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:33:37 -0700
X-CSE-ConnectionGUID: Lf1gs+PFTeexB22+9418CA==
X-CSE-MsgGUID: +zJVLFiAQPSjurjBYmlqeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="88193632"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:33:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1scOoH-0000000DPpJ-1WUm;
	Fri, 09 Aug 2024 15:33:33 +0300
Date: Fri, 9 Aug 2024 15:33:33 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Zhang Ning <zhangn1985@outlook.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID: <ZrYMne34hVa33qKf@smile.fi.intel.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> Hi, Greg & Rafael
> 
> recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> for debian kernel[0]. I find tmu and typec failed to probe.
> 
> after check source code, I find irq for these two devices are 0, when
> use platform_get_irq, it will alway fail.
> 
> 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> 		return -EINVAL;
> 	return ret;
> 
> My workaround for debian is to hardcode irq to 0, instead to use api.
> 
> I don't know how to write a good solution, thus send an email to you.

Hold on, how the heck you got 0 in the first place?

> [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs

-- 
With Best Regards,
Andy Shevchenko



