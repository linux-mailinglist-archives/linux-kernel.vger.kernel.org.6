Return-Path: <linux-kernel+bounces-211125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D90904D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C512D1C2494E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117816C843;
	Wed, 12 Jun 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DqQ1KXw0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA14696;
	Wed, 12 Jun 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179370; cv=none; b=bqN1WQTLSX1vJlVNvrjX2JXahT8P1j1gDSZqJe7PlXDyYulLG3i3JkuWX4RiuCrjgtD7l9NiUUoetA/yfgI9+40YPlRf5IFqsI0z2NBjmBS9q8Zqbl9ZoOiuTshu7oTzAQp0x4dNoRhg1bZEm0QYnq8yRrTSNunsnkV20Ht9iDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179370; c=relaxed/simple;
	bh=N1bClvRvObB6ZljtKs6JY5eoGxIdtJA0IytQtreuk6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl7h0cw1DsJ5R+bFW4sR734k27USvAyyzDHZe8wM/oBXcDyr6ZUjdnl/Dq54jbI1tBYQUmi2vTI33wFVb6TwrHmYmlgQdFeSd2dTqNGqcayYagDcSboNFAgVdTL3BIsLhG5MlPUNhyH8d1XrXSimuSntkUZjFwiQfckmUvOiz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DqQ1KXw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE9C3277B;
	Wed, 12 Jun 2024 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718179369;
	bh=N1bClvRvObB6ZljtKs6JY5eoGxIdtJA0IytQtreuk6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqQ1KXw0HNnwmUKJCtNZVDfhBe9ukGFZ7dzd+n4fYJrunK6hfe4FJomwSnPaOvx/c
	 apRLmhXvSe/GBslRA3UUyOgTQXT8sHPifvpEe2LQnUCYs2COloIkNmouGty1vdQJ3c
	 268Vs+5S6WLlB1kEmMZyzzJWlFToymZjeSuZodDo=
Date: Wed, 12 Jun 2024 10:02:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v10 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Message-ID: <2024061230-thimble-oxymoron-3beb@gregkh>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <20240612035359.7307-3-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612035359.7307-3-lakshmi.sowjanya.d@intel.com>

On Wed, Jun 12, 2024 at 09:23:58AM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Add Intel Timed I/O PPS usage instructions.
> 
> Co-developed-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  Documentation/driver-api/pps.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 78dded03e5d8..75f7b094f963 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -246,3 +246,27 @@ delay between assert and clear edge as small as possible to reduce system
>  latencies. But if it is too small slave won't be able to capture clear edge
>  transition. The default of 30us should be good enough in most situations.
>  The delay can be selected using 'delay' pps_gen_parport module parameter.
> +
> +
> +Intel Timed I/O PPS signal generator
> +------------------------------------
> +
> +Intel Timed I/O is a high precision device, present on 2019 and newer Intel
> +CPUs, that can generate PPS signals.
> +
> +Timed I/O and system time are both driven by same hardware clock. The signal
> +is generated with a precision of ~20 nanoseconds. The generated PPS signal
> +is used to synchronize an external device with system clock. For example,
> +it can be used to share your clock with a device that receives PPS signal,
> +generated by Timed I/O device. There are dedicated Timed I/O pins to deliver
> +the PPS signal to an external device.
> +
> +Usage of Intel Timed I/O as PPS generator:
> +
> +Start generating PPS signal::
> +
> +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
> +
> +Stop generating PPS signal::
> +
> +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable

Why is this not described in Documenation/ABI/ ?

thanks,

greg k-h

