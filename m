Return-Path: <linux-kernel+bounces-362614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746E99B6F0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99F81C20E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552DA18453C;
	Sat, 12 Oct 2024 20:35:10 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83B12CD88
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765310; cv=none; b=oqBaMR0iaiUQxFmHo1CkJmeKMyR+JuL5uW0kjr+4PCQr06JBH+CjmykFdQG5NhzmUPIXceZAQjnlFV+LyANeqdLbjanKhJmZEOzQ/a3aDQzun7EzsGZKUwNmZwEF45JdqlLUqeLSrtzrbDZp5Hu3OeM1Ax7pke6vb9ylAoJNJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765310; c=relaxed/simple;
	bh=xnT15ehoKpQ2fh6wgbED8f2JaPplSPqVcgR+3FBsvQU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7woQgQfJIi4u6wzugxDJSlyvxsGMrMhZwZHO6QaufR902e/LZdxMRxlFfXIMsssZyLHo819GK/5zxThfhqtcCBkqxuDMvU2WABVGLtw2QT94ZxuaemNio/lTKwZdkyBzlBnfCMZdMzwsJkdWsI29StpLv0Ls7DvwVhvhBwY9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-56.elisa-laajakaista.fi [88.113.26.56])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 6866500e-88d9-11ef-8861-005056bdd08f;
	Sat, 12 Oct 2024 23:34:41 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Oct 2024 23:34:40 +0300
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/13] iio: chemical: bme680: avoid using camel case
Message-ID: <ZwrdYOZVVeDsi0gZ@surfacebook.localdomain>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-3-vassilisamir@gmail.com>
 <Zwj3QZE30juE53Vy@smile.fi.intel.com>
 <ZwlzczfUPtqA5SA1@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwlzczfUPtqA5SA1@vamoirid-laptop>

Fri, Oct 11, 2024 at 08:50:27PM +0200, Vasileios Aoiridis kirjoitti:
> On Fri, Oct 11, 2024 at 01:00:33PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 10, 2024 at 11:00:19PM +0200, vamoirid wrote:

...

> > >  	var1 = ((1340 + (5 * (s64)calib->range_sw_err)) *
> > > -			((s64)lookupTable[gas_range])) >> 16;
> > > +			((s64)lookup_table[gas_range])) >> 16;
> > 
> > Also an opportunity to make this neater like
> > 
> > 	var1 = (1340 + (5 * (s64)calib->range_sw_err)) * (s64)lookup_table[gas_range]);
> > 	var1 >>= 16;
> > 
> > So, at bare minumym there are redundant parentheses. And looking at the table
> > and the first argument of multiplication I'm puzzled why casting is needed for
> > the second? Shouldn't s64 already be implied by the first one?
> 
> I think the 2nd cast indeed is not needed since the 1st one forces the
> s64 so I can remove it.

Thinking about this more, you don't need the first either,
if using 5LL instead of 5.

-- 
With Best Regards,
Andy Shevchenko



