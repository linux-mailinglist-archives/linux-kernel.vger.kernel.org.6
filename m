Return-Path: <linux-kernel+bounces-559127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC6A5EFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D7F1889404
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361B82641DF;
	Thu, 13 Mar 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cw2Iv3zf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E260382
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858887; cv=none; b=TFseTfHcYmYCwH+IU5hvN1jrS5meD8TWMDka5wcjgCWsEoQcrjpCQQdwH6KUCOYiM4FVwvBBuKrZtRRt9oRGoVa96wofMyJ4526RLiIBq7ExdOPqyFQu10uRn8tTaq071anVbUSGDZViQGKxSrsOzNXJtrivpj/juo1j1Mup0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858887; c=relaxed/simple;
	bh=Jdr+MwfN0sSug4SaeHAkQwkcWWz7z+eJSV1vYnl+DLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiUW5aB2aEjuOfcTfdQQocAj0H7Zy3pycHqx3ekmaaL8faDPw4cf0LxgItDZX8mY5LtBB3LQ9EO1o/TqyLr5UlAHphRFXVBjWH+HxIhEAcD4EZMTswEDiyLwv2jsgkmWj9BI4cA8Qtvv9K1A0DUqqVyz8FuPuJV9jVovQUI11LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cw2Iv3zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3CCC4CEE3;
	Thu, 13 Mar 2025 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741858886;
	bh=Jdr+MwfN0sSug4SaeHAkQwkcWWz7z+eJSV1vYnl+DLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cw2Iv3zfzrI//Im3pQZUsikCdBIFSpiIas+NJed1wJ9cKgQm/cDdfu00ZQgdBSm1g
	 nmZhBcljZQJhOq9n9RWBFSYkm9ky1/IBBP7poSM/z6+/dXkAR1RrJgvJxuUEQUmKpv
	 OkdEEv9tr/wtVCGrFmcg6vdL86H4h7xyaoqTKyTs=
Date: Thu, 13 Mar 2025 10:41:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gupta, Nipun" <nipun.gupta@amd.com>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, derek.kiernan@amd.com, dragan.cvetic@amd.com,
	arnd@arndb.de, praveen.jain@amd.com, harpreet.anand@amd.com,
	nikhil.agarwal@amd.com, srivatsa@csail.mit.edu, code@tyhicks.com,
	ptsm@linux.microsoft.com
Subject: Re: [RFC PATCH 1/2] drivers/misc: add silex multipk driver
Message-ID: <2025031328-unmanned-scale-faf4@gregkh>
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
 <2025031256-accurate-tactics-1ff7@gregkh>
 <b43b6051-238b-207f-f0c5-3071950c1a0f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43b6051-238b-207f-f0c5-3071950c1a0f@amd.com>

On Thu, Mar 13, 2025 at 02:46:11PM +0530, Gupta, Nipun wrote:
> On 12-03-2025 15:48, Greg KH wrote:
> > On Wed, Mar 12, 2025 at 03:24:20PM +0530, Nipun Gupta wrote:
> > > +	return sprintf(buf,
> > > +		"Hardware interface version: %d.%d.%d\n"
> > > +		"Hardware implementation version: %d.%d.%d\n"
> > > +		"Count request queues: %d\n"
> > > +		"Total max pending requests: %d\n"
> > > +		"Max pending requests per request queue: %d\n"
> > > +		"Pkcores 64 multipliers: %d\n"
> > > +		"Pkcores 256 multipliers: %d\n",
> > > +		MPK_SEMVER_MAJOR(v), MPK_SEMVER_MINOR(v), MPK_SEMVER_PATCH(v),
> > > +		MPK_HWVER_MAJOR(hwv), MPK_HWVER_MINOR(hwv), MPK_HWVER_SVN(hwv),
> > > +		cnt, maxtotalreqs, rqmaxpending,
> > > +		mults >> 16, mults & 0xFFFF);
> > 
> > No!
> > 
> > sysfs is "one value per file", which this is not at all.
> 
> Will create separate entries for each.

Why is any of this needed in sysfs?  Why not just use debugfs as it
looks like debugging information, right?

> > > +	if (IS_ERR(multipk_class)) {
> > > +		ret = PTR_ERR(multipk_class);
> > > +		pr_err("can't register class\n");
> > > +		goto err;
> > > +	}
> > > +	ret = alloc_chrdev_region(&devt, 0, MULTIPK_MAX_DEVICES, "multipk");
> > 
> > Again, why not a dynamic misc device per device in the system?
> > 
> > No need to make this harder than it is.
> > 
> > But again, this really should use the in-kernel apis we already have for
> > this type of hardware, don't make a custom user/kernel api at all.
> > That's not going to scale or be easy to maintain for any amount of time.
> 
> Agree to some extent, but as Crypto AF_ALG does not support offloading
> asymmetric operations, we added this driver as misc driver. This device is
> supported in AMD Versal series devices: https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal/premium-series.html.
> We would maintain the driver with minimal possible user interface changes.

Please work with the crypto developers to add support for async
operations.  And if that's not going to work out, we need an ack from
them explaining why this driver does not fit into the current framework
and that they are ok with this unique, custom, one-off, totally
out-of-the ordinary, custom userspace-software-requring, api that you
have created here.

thanks,

greg k-h

