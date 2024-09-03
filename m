Return-Path: <linux-kernel+bounces-312733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D3969A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A089B23C00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2041C7688;
	Tue,  3 Sep 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJ4bSY2o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD591C62D5;
	Tue,  3 Sep 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360168; cv=none; b=GKBRVN/Ko81a+jwzbnUGZ4FyTpveA7gh+Bk70tZqOOYISR5MBRTBg4gGDMWL8NW280Pbh7hFZut1otWXBd3IsGxGKlya2Ex7MUdP+BX9i3ltWYoMWmjJ5TRr8XGUcoro/UaLgtLN7fqtOZI29AFKKN2Zn+MUKsglxr2bOu2J2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360168; c=relaxed/simple;
	bh=gMwgQZEFb1DkTLA8W3FavtJEyjv5GVsdG3M06avj9po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU24gSyPlTmNmti5zIUMJPooqLThJEwiO7lCtdMxiohqxCIQjiX4HMtyjsdc+Igs1reHKYG9rcYCP83nXNyraQ4mLGue4r4VMAQWqxt1iT257C0qOBPr7+bR9o0+AgjHzXuHvfA2m3b/XVNVpbObcl0O4/ZpjztTfxZMoG4SOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJ4bSY2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431BDC4CEC8;
	Tue,  3 Sep 2024 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360167;
	bh=gMwgQZEFb1DkTLA8W3FavtJEyjv5GVsdG3M06avj9po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJ4bSY2opquQVALh+jaVTK1oVEqYeRD8wpcgfkdcFS3mhkddcxfC0jy8ny3MfIVcR
	 eNvxOQmeDRa8gVH8g/rT8hXGYWaojVIFC/3QjaYsOX8312mywJ5UGGAB502ODN3irM
	 kWYbW2WlJvo4Mcfq3Bjv2bspipkx6DiANq+hJ5BE=
Date: Tue, 3 Sep 2024 12:25:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: subramanian.mohan@intel.com, tglx@linutronix.de, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com, david.zage@intel.com,
	srinivasan.chinnadurai@intel.com
Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Message-ID: <2024090304-viewing-lavish-c05e@gregkh>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-3-subramanian.mohan@intel.com>
 <2024082456-kitchen-astride-7892@gregkh>
 <801c7a93-667b-4c23-9493-4cbe979847a2@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801c7a93-667b-4c23-9493-4cbe979847a2@enneenne.com>

On Tue, Aug 27, 2024 at 03:09:15PM +0200, Rodolfo Giometti wrote:
> On 24/08/24 04:21, Greg KH wrote:
> > On Fri, Aug 23, 2024 at 12:31:07PM +0530, subramanian.mohan@intel.com wrote:
> > > From: Subramanian Mohan <subramanian.mohan@intel.com>
> > > 
> > > Add Intel Timed I/O PPS usage instructions.
> > > 
> > > Co-developed-by: Pandith N <pandith.n@intel.com>
> > > Signed-off-by: Pandith N <pandith.n@intel.com>
> > > Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> > > Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> > > ---
> > >   Documentation/driver-api/pps.rst | 24 ++++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> > > index 78dded03e5d8..75f7b094f963 100644
> > > --- a/Documentation/driver-api/pps.rst
> > > +++ b/Documentation/driver-api/pps.rst
> > > @@ -246,3 +246,27 @@ delay between assert and clear edge as small as possible to reduce system
> > >   latencies. But if it is too small slave won't be able to capture clear edge
> > >   transition. The default of 30us should be good enough in most situations.
> > >   The delay can be selected using 'delay' pps_gen_parport module parameter.
> > > +
> > > +
> > > +Intel Timed I/O PPS signal generator
> > > +------------------------------------
> > > +
> > > +Intel Timed I/O is a high precision device, present on 2019 and newer Intel
> > > +CPUs, that can generate PPS signals.
> > > +
> > > +Timed I/O and system time are both driven by same hardware clock. The signal
> > > +is generated with a precision of ~20 nanoseconds. The generated PPS signal
> > > +is used to synchronize an external device with system clock. For example,
> > > +it can be used to share your clock with a device that receives PPS signal,
> > > +generated by Timed I/O device. There are dedicated Timed I/O pins to deliver
> > > +the PPS signal to an external device.
> > > +
> > > +Usage of Intel Timed I/O as PPS generator:
> > > +
> > > +Start generating PPS signal::
> > > +
> > > +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
> > > +
> > > +Stop generating PPS signal::
> > > +
> > > +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
> > 
> > As I mentioned on the sysfs documentation, why isn't this just a generic
> > pps class attribute instead?  Why did you make it
> > only-this-one-special-driver type of thing?
> 
> This is an Original Sin when PPS generators were introduced. :-(
> 
> In 2011 a patch from Alexander Gordeev <lasaine@lvk.cs.msu.su> (which
> introduced the "parallel port PPS signal generator") was committed in the
> main kernel.
> 
> At the time it was something exotic and doing a PPS generator interface for
> it was not considered (since it actually has no controlling inputs), but now
> several Ethernet cards have such PPS generator functionalities, and they are
> enabled in a per-driver way or via the PTP API.
> 
> This code is a pure PPS generator and it cannot use any other way to enable
> such functionality than the one above since the PPS layer misses a proper
> implementation for PPS generator.
> 
> If you are willing to stop the inclusion due this fact maybe its time to add
> such PPS generators interface... on the other hand, if you agree for
> inclusion we can do this job as soon as the code has been included, in order
> to fix this anomalous status.

Please make a generic pps subsystem for this, it would make it simpler
for everyone.

thanks,

greg k-h

