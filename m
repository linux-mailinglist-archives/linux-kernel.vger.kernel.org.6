Return-Path: <linux-kernel+bounces-362623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87999B70E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09721C20CA0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CDB1487CE;
	Sat, 12 Oct 2024 20:48:00 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B2146599
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728766080; cv=none; b=Htd4gKX9jvJMF8hCxUWMCfGu7mHT5hrTXjc1VQz/rXTbIePg3eNFM2b95U5xJS6espHUAzwXmTN7kAXmMwx1SuQlS9CWSPJpSSW8OlYLHJP8GBSzfU0ztCKC6xb3Gr97EQBB5YUxWKEOmvK5V48Lqy+xjGtTSa28az9Bd/TNSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728766080; c=relaxed/simple;
	bh=AisCTrykfdwchnw9oOUCd822oZfY0675duc3AmxHqY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDd+jDApqumXoXeURxZY7hYjPnOSGHB24UIGReBGnQ4MJW+i8atHSA1j7wVVuVwIuTx98V/PBlL8qhNfFVDdLpgUCLJO/qdYrIpTY9jX5Yb6aS9FtTSBQ0tNd+v3PNBJCwyNJX6GzcVZbH2puTHqsde2qrJA4HTqgwuGK5HvkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-56.elisa-laajakaista.fi [88.113.26.56])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 3d7686c2-88db-11ef-8861-005056bdd08f;
	Sat, 12 Oct 2024 23:47:48 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Oct 2024 23:47:48 +0300
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/13] iio: chemical: bme680: Add support for preheat
 current
Message-ID: <ZwrgdOvfdo8VAR-T@surfacebook.localdomain>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-14-vassilisamir@gmail.com>
 <ZwkAYSvmYyu1F5dU@smile.fi.intel.com>
 <Zwl3w_lwdfqNRYK_@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwl3w_lwdfqNRYK_@vamoirid-laptop>

Fri, Oct 11, 2024 at 09:08:51PM +0200, Vasileios Aoiridis kirjoitti:
> On Fri, Oct 11, 2024 at 01:39:29PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 10, 2024 at 11:00:30PM +0200, vamoirid wrote:

...

> > > +	data->preheat_curr = 0; /* milliamps */
> > 
> > Instead of the comment, make it better to any appearance of the variable in the
> > code by adding unit suffix.
> > 
> > 	data->preheat_curr_mA = 0;
> > 
> > (yes, capital 'A').
> 
> I used the comment here because it is exactly like this above and I
> though it is more consistent if I do the same. But I guess repeating a
> not so good design choice for consistency might not be the best
> decision.

Right. I would rather see an additional patch that adds unit suffixes here
and there...

-- 
With Best Regards,
Andy Shevchenko



