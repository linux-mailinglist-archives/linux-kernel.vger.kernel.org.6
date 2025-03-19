Return-Path: <linux-kernel+bounces-568598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D961A69821
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42687B028A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E320C01C;
	Wed, 19 Mar 2025 18:36:35 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760A20B808
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409395; cv=none; b=R3CYgExOBBkvKpC89MmwGbJR2xOEsXJ8rRUuKc6dKJCxdH3DX3utEU8wHsNKDwO7+21r6bejUnyuQs6PZEUnHIeaLdiDCMrATr9bKz7d50xuBSqFTnqF/oNoe8CRECcm2L5uFKNpWLm2dPpiH4s9hzMnuZZHl5njyGx2v1PBOuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409395; c=relaxed/simple;
	bh=5ymoAD0W77hJjvYqA3owbEmEAUulXBHS2ozPUfQ05zw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG5VCz6AIyzp7DtZW+hzGdzRAv8jWGcOGhy5672rJNzBDK5ICLJbab0iLLFjwl2DfgNMkovpO1tnj3smwblDdxOUDQEWj0ZRggZWjENONhLCl5qFsuxOutZnwxohDqcpKyVbHTrxOgKmjk149n6m7LUfr0gV0yMK4KlCjUFr+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 0770a905-04f1-11f0-ab8e-005056bd6ce9;
	Wed, 19 Mar 2025 20:36:12 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Mar 2025 20:36:10 +0200
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v2 2/2] net: usb: asix: ax88772: Increase phy_name
 size
Message-ID: <Z9sOmllizdg79UvL@surfacebook.localdomain>
References: <20250319105813.3102076-1-andriy.shevchenko@linux.intel.com>
 <20250319105813.3102076-3-andriy.shevchenko@linux.intel.com>
 <Z9rYHDL3dNbaK9jZ@shell.armlinux.org.uk>
 <Z9rvXilnPCblbfIv@smile.fi.intel.com>
 <Z9r7UPJUJ_Ds6n-6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9r7UPJUJ_Ds6n-6@shell.armlinux.org.uk>

Wed, Mar 19, 2025 at 05:13:52PM +0000, Russell King (Oracle) kirjoitti:
> On Wed, Mar 19, 2025 at 06:22:54PM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 19, 2025 at 02:43:40PM +0000, Russell King (Oracle) wrote:
> > > On Wed, Mar 19, 2025 at 12:54:34PM +0200, Andy Shevchenko wrote:
> > > > -	char phy_name[20];
> > > > +	char phy_name[MII_BUS_ID_SIZE + 3];
> > > 
> > > MII_BUS_ID_SIZE is sized to 61, and is what is used in struct
> > > mii_bus::id. Why there a +3 here, which seems like a random constant to
> > > make it 64-bit aligned in size. If we have need to increase
> > > MII_BUS_ID_SIZE in the future, this kind of alignment then goes
> > > wrong...
> > > 
> > > If the intention is to align it to 64-bit then there's surely a better
> > > and future-proof ways to do that.
> > 
> > Nope, intention is to cover the rest after %s.
> 
> Oops, I had missed that MII_BUS_ID_SIZE is the size of the "%s" part.
> I think linux/phy.h should declare:
> 
> #define PHY_ID_SIZE (MII_BUS_ID_SIZE + 3)
> 
> to cater for the ":XX" that PHY_ID_FMT adds.
> 
> So the above would become:
> 
> 	char phy_name[PHY_ID_SIZE];
> 
> I wonder whether keeping PHY_ID_FMT as-is, but casting the argument
> to a u8 would solve the issue?
> 
> Maybe something like:
> 
> static inline void
> phy_format_id(char *dst, size_t n, const char *mii_bus_id, u8 phy_dev_id)
> {
> 	BUILD_BUG_ON_MSG(n < PHY_ID_SIZE, "PHY ID destination too small");
> 	snprintf(dat, n, PHY_ID_FMT, mii_bus_id, phy_dev_id);
> }
> 
> would solve it?

Would you like to send a formal patch? I will base my fix on top of it and test
that in my case.

-- 
With Best Regards,
Andy Shevchenko



