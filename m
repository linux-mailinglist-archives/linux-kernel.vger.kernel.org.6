Return-Path: <linux-kernel+bounces-299881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CD95DBD5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476561C21D99
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E16149DF0;
	Sat, 24 Aug 2024 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wA0avRKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0214EC6E;
	Sat, 24 Aug 2024 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476687; cv=none; b=BW38f+ZmX66iG7kvd76CTlVqKBqw81eA7wQ0Js1l1EaOUQ5YsI25LeTEFpWhdjirdq5nvg+7e+AdB8xTg/TQ8PHKWCs0SmuKapHQR7PRiu8hJW//tY0JWDwbWoG4FO3omrHPMNhZUjqhD5pbrYQUm0QhgrgwgQmFDGBSC2grbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476687; c=relaxed/simple;
	bh=5kEeYIlxBzGGo8mfY9SEsvwz2GSp8RGaG7/jOtH+ufU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDcBQly8gwhPRDw7eCRm8AdWfofx8UcSLcxkwHgUv16C9PAkwOYDpBBpKyf0c1BdW0U7q7+sB2Me8Rb76uR6+MUc/s4SLZyY6jbTbJ8PkN1wVTNdE7Nz/PdJACzhLjzIccEosKtUyE2lNrkSdrzho2yMsTFoHq2JxuG7qCW1Kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wA0avRKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D42C4AF12;
	Sat, 24 Aug 2024 05:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476686;
	bh=5kEeYIlxBzGGo8mfY9SEsvwz2GSp8RGaG7/jOtH+ufU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wA0avRKvi9xO/gvOJWhMR4RqOhZ5tULe2KkjC8HIbtA18ytoF/fLlM6u9+vPneZ7W
	 zjBFL4qo5TAOFGhJb7ykUlbzd6zWbxolp1Ut+ukBht3i6vRQfQB48MzQf3qZW7/xTX
	 pLKPdEM2g0RJN89Ev6ACKgGXthroOcIN7WSvjGTc=
Date: Sat, 24 Aug 2024 10:21:40 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: subramanian.mohan@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com, david.zage@intel.com,
	srinivasan.chinnadurai@intel.com
Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Message-ID: <2024082456-kitchen-astride-7892@gregkh>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-3-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070109.27815-3-subramanian.mohan@intel.com>

On Fri, Aug 23, 2024 at 12:31:07PM +0530, subramanian.mohan@intel.com wrote:
> From: Subramanian Mohan <subramanian.mohan@intel.com>
> 
> Add Intel Timed I/O PPS usage instructions.
> 
> Co-developed-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
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

As I mentioned on the sysfs documentation, why isn't this just a generic
pps class attribute instead?  Why did you make it
only-this-one-special-driver type of thing?

thanks,

greg k-h

