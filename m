Return-Path: <linux-kernel+bounces-211130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82CD904D85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB4AB259C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594F16D4FD;
	Wed, 12 Jun 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PexS0sML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237816D4F2;
	Wed, 12 Jun 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179405; cv=none; b=r47KBlW34J6JjS8sx9X4WnkIMIqmxMDTHW0SUKpXurRhNfdcNbJ5WqjTTQz4HDwIZPZNn77VBv7JlMTE0EkFXME+0+KfqQnyDnt2mUeUESnRKeSX+In46+6mDE8XMNpN93bb6EdRxCpMyUhf5oUJ4G4mNAWsA67bUN4jXx5z6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179405; c=relaxed/simple;
	bh=6enCHXveZgAYbXgHaRRpmhGhyCreyLPzbGhbgLZ2hDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAKCbqhNwKPfYYa+leMAwhbsK2XxRXu1QIAEq/GGTIhLO+Sc06wLwXYBbLC/oKmc3Yf9pA90URdS2SvHWKZDsIXCKdnpyZGIQ0iWxS7ChP+OUPhi12zFMrPqn8UnILOJYAbMieohRTjej7tde/dhgSvQa6aZ9NsZG2lhv1hr5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PexS0sML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0108FC3277B;
	Wed, 12 Jun 2024 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718179405;
	bh=6enCHXveZgAYbXgHaRRpmhGhyCreyLPzbGhbgLZ2hDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PexS0sMLd/W7IVnk6pm9zOlPdZ2d1ATfswIV2WMX6kJykYjXi4XTFo9+nC8zKGb7v
	 LNPCDoCOTVh3QdwZq3W0JkIOVMxSUFyDHxhD9cnnVVFSqkeEdsKBTykvHY3LFX6aVt
	 8vJM+fk6Q/Aj9ApalxqUN4BokJwCRtNwIblf7RUw=
Date: Wed, 12 Jun 2024 10:03:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v10 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Message-ID: <2024061215-deflected-dimness-a317@gregkh>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <20240612035359.7307-3-lakshmi.sowjanya.d@intel.com>
 <2024061230-thimble-oxymoron-3beb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061230-thimble-oxymoron-3beb@gregkh>

On Wed, Jun 12, 2024 at 10:02:46AM +0200, Greg KH wrote:
> On Wed, Jun 12, 2024 at 09:23:58AM +0530, lakshmi.sowjanya.d@intel.com wrote:
> > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > 
> > Add Intel Timed I/O PPS usage instructions.
> > 
> > Co-developed-by: Pandith N <pandith.n@intel.com>
> > Signed-off-by: Pandith N <pandith.n@intel.com>
> > Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> > ---
> >  Documentation/driver-api/pps.rst | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> > index 78dded03e5d8..75f7b094f963 100644
> > --- a/Documentation/driver-api/pps.rst
> > +++ b/Documentation/driver-api/pps.rst
> > @@ -246,3 +246,27 @@ delay between assert and clear edge as small as possible to reduce system
> >  latencies. But if it is too small slave won't be able to capture clear edge
> >  transition. The default of 30us should be good enough in most situations.
> >  The delay can be selected using 'delay' pps_gen_parport module parameter.
> > +
> > +
> > +Intel Timed I/O PPS signal generator
> > +------------------------------------
> > +
> > +Intel Timed I/O is a high precision device, present on 2019 and newer Intel
> > +CPUs, that can generate PPS signals.
> > +
> > +Timed I/O and system time are both driven by same hardware clock. The signal
> > +is generated with a precision of ~20 nanoseconds. The generated PPS signal
> > +is used to synchronize an external device with system clock. For example,
> > +it can be used to share your clock with a device that receives PPS signal,
> > +generated by Timed I/O device. There are dedicated Timed I/O pins to deliver
> > +the PPS signal to an external device.
> > +
> > +Usage of Intel Timed I/O as PPS generator:
> > +
> > +Start generating PPS signal::
> > +
> > +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
> > +
> > +Stop generating PPS signal::
> > +
> > +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
> 
> Why is this not described in Documenation/ABI/ ?

Oops, that was patch 3/3, sorry.

