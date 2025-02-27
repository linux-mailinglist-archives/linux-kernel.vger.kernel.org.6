Return-Path: <linux-kernel+bounces-535723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D1A4766A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB9A1888C27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC45621C9F4;
	Thu, 27 Feb 2025 07:20:37 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3813777E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640837; cv=none; b=jSqgdrFglxJhFqvFORc/5fjknU0pgEHxBdzGDp3UaduN94kGUBAmFNkzu23YR+fHZyaJBNBugw0dol855zJwwhwVWJu/9KawAftcjgM7EMJU2t+K3j1gbovMlHU0z2ac75dmn89vKE/m2+x/PGtTSQhXGZfEn5FRFMHEV1w+f1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640837; c=relaxed/simple;
	bh=vY0joXwMwqKykt8m9Q39Pzzp++KV0tAE97Fkf7a8FAE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOgoH5yM6SxvWdvvwuWfa7ujeiPayYJwx8MfuUaGobDftRjUvsZXm+kpxwzxKnYgV//gCYivgqYwanHpDr+qxNKmr7Do4xRGsvtZE10Tjgf83LW4kHiCZ7P8OxwtJpWMxhM08AuK3J/WjDaAVzzmh8BypcIoM3mCINQtv+3VrpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 50c1f2b8-f4db-11ef-a2a4-005056bdfda7;
	Thu, 27 Feb 2025 09:20:26 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Feb 2025 09:20:26 +0200
To: Raag Jadav <raag.jadav@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lee@kernel.org,
	giometti@enneenne.com, gregkh@linuxfoundation.org,
	raymond.tan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mfd: intel-ehl: Introduce Intel Elkhart Lake PSE
 GPIO and TIO
Message-ID: <Z8ASOo-TcQrZtgbj@surfacebook.localdomain>
References: <20250226061527.3031250-1-raag.jadav@intel.com>
 <20250226061527.3031250-5-raag.jadav@intel.com>
 <Z78VIjgkzf_GlauU@smile.fi.intel.com>
 <Z78VkEnJh8l9MWF7@smile.fi.intel.com>
 <Z7_0gJJL_h6lq4cz@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7_0gJJL_h6lq4cz@black.fi.intel.com>

Thu, Feb 27, 2025 at 07:13:36AM +0200, Raag Jadav kirjoitti:
> On Wed, Feb 26, 2025 at 03:22:24PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 26, 2025 at 03:20:35PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 26, 2025 at 11:45:27AM +0530, Raag Jadav wrote:

...

> > > > +++ b/drivers/mfd/intel-ehl-gpio.c
> > > 
> > > We are usually align the file name and Kconfig option, and I like Kconfig
> > > choice, so intel_ehl_pse_gpio.c (also note the style with other intel_$SOC_*
> > > files in the folder.
> 
> More than 3 words is a bit of an overstretch, no?

No, it's short enough.

....

> > And also Subject, you have currently 3 different names for the same:
> > Kconfig, Subject, filename.
> 
> Yeah just trying to dial down the acronym syndrome, you know how it has
> plagued our minds.

Right, but in MFD we are trying to follow some common schema(s) for file names.
Currently the most clear one is for PMIC drivers. Let's keep going with the
rest as well.

-- 
With Best Regards,
Andy Shevchenko



