Return-Path: <linux-kernel+bounces-539190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802EA4A1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670FF1891A22
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562CB27CCD9;
	Fri, 28 Feb 2025 18:41:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736B27CCD1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768061; cv=none; b=vGIiBqODF6QSBV/K1VSvrXN/p0yxt25gMYhxldGCCv5m8ex6hGbWc/CQrQcGg02M6UDQ6B94Nu41V/GbFnle7quFJsjDyGBTA+DALfk2JnA4QFySs/mOMvrxXtx0MlklGb/WALNrGwGgMQK1lYqPg+0feNPJ7pP2mqvUSJcQU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768061; c=relaxed/simple;
	bh=vQ5KyLQlTv6sGL5ntni4zYc+uYj9BcqjYLxVJDXmrw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL4h7A+n6uiQ0WKaKww3iplZSFXGnyZKn5+9Ij7raRF3bU5R8hi/+IlvZeB85MFls9BgM4Bc4dIRTUn6dN4bWOVaAjAM1L1U/5odg9qIWP9ABVX5529Gw9UsZI4Y5PpzeAr6BwbCHaZwKCxPBfHdwls8jNKwY11SS7X5ahPy/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: tWxa5eecSk+fu/n84kIW1Q==
X-CSE-MsgGUID: bDK/5FIESBiIdq8ElwqS8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41410251"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41410251"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:40:58 -0800
X-CSE-ConnectionGUID: oVmv6m1gQVufc07QWgcQDA==
X-CSE-MsgGUID: cmG7VsB/S0OvhfKTFXhBuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122645991"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:40:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1to5I4-0000000G3b6-00Rq;
	Fri, 28 Feb 2025 20:40:52 +0200
Date: Fri, 28 Feb 2025 20:40:51 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Ferry Toth <fntoth@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 08/10] x86: document X86_INTEL_MID as 64-bit-only
Message-ID: <Z8IDM8jb-3i5jxYU@smile.fi.intel.com>
References: <20250226213714.4040853-1-arnd@kernel.org>
 <20250226213714.4040853-9-arnd@kernel.org>
 <8c8a5aa5-f434-4006-b36c-02311b94041f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8a5aa5-f434-4006-b36c-02311b94041f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 05:20:54PM +0100, Ferry Toth wrote:
> Hi,
> 
> On 26-02-2025 22:37, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The X86_INTEL_MID code was originally introduced for the 32-bit
> > Moorestown/Medfield/Clovertrail platform, later the 64-bit
> > Merrifield/Moorefield variants were added, but the final Morganfield
> > 14nm platform was canceled before it hit the market.
> > 
> > To help users understand what the option actually refers to, update the
> > help text, and add a dependency on 64-bit kernels.
> > 
> > Ferry confirmed that all the hardware can run 64-bit kernels these days,
> > but is still testing 32-bit kernels on the Intel Edison board, so this
> > remains possible, but is guarded by a CONFIG_EXPERT dependency now,
> > to gently push remaining users towards using CONFIG_64BIT.
> 
> That is a bit more than I said :-) I only know of Merrifield, as Andy
> removed the SFI bits and got ACPI working. For the other platforms I don't
> know the status. Additionally there are pieces of code where 32b runs
> substantially faster than 64b (I know of at least crc32c).
> 
> Maybe Andy can confirm the other platforms?

Listed SoCs are all capable of running 64-bit code.

Telling that they 64-bit only is a bit of a lie but it seems for good. :-)

OTOH I dunno if there is still a plan by community to resurrect Intel Medifield
and Clovertrail (there are phones in a working shape still around), but either
way they will need to switch to ACPI and U-boot to begin with and that's in my
knowledge not trivial and not easy task. That said, I don't think it will ever
happen.

-- 
With Best Regards,
Andy Shevchenko



