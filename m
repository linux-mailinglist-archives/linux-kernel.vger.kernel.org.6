Return-Path: <linux-kernel+bounces-299880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ECC95DBD3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF021C218F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C514C5AF;
	Sat, 24 Aug 2024 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="htoa2wxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F238149DF0;
	Sat, 24 Aug 2024 05:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476684; cv=none; b=rfxK4G9/VfDvsGS9h8x8aUTl303jITyqXnDtzaE+i7q3o4zw87QLJeGr7q5ibQ9W4QOzrQOezG2v3veKYdASB26DsnE/AocYi+GWDEUtQLXl2H6vGkHCJ9KtmC5Oz7gGCqJU6Zx5kqq1T6wUcwvHCQ83JSIYp/gg6gOLYxyJRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476684; c=relaxed/simple;
	bh=+mtznrRw+WkO4Q3pJ4tEm1SSyICPnSau4ifvkkKFX4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbmlaVIpZ4ovBwJwuG+nlKiKrNSKBIKnu1ZZnourpj7zxq7HTWuniSTLi3Go5fpnyC7HOObb5rkw29lctaIKxktF9x4SLwPOGv5b4JYfc46bbuNkcIiCbEbmEKZ/UJH9mByIksw2/pShHcXdb9PH47VyJSO439rHlRED7l6IDBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=htoa2wxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF62C32781;
	Sat, 24 Aug 2024 05:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476683;
	bh=+mtznrRw+WkO4Q3pJ4tEm1SSyICPnSau4ifvkkKFX4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htoa2wxkL0Tupsp33cHJTs4PcxDzOKMa2Wt1R7G5g+pX1+E5Rp6xtOc0qDwDF7DgB
	 zC8aNIp1W5GuqSRGihC+Y0Bp5gBVsyiI/EyiXDzTCOcHXga0qHnGdepiFKs/OZJZm4
	 q7I36gyYcwH0yMAdf5Pv+vjtWsuLzOuhUXMRcgmA=
Date: Sat, 24 Aug 2024 10:20:45 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: subramanian.mohan@intel.com
Cc: tglx@linutronix.de, giometti@enneenne.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
	christopher.s.hall@intel.com, pandith.n@intel.com,
	thejesh.reddy.t.r@intel.com, david.zage@intel.com,
	srinivasan.chinnadurai@intel.com
Subject: Re: [PATCH v12 3/3] ABI: pps: Add ABI documentation for Intel TIO
Message-ID: <2024082447-sizably-unsmooth-40ed@gregkh>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-4-subramanian.mohan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823070109.27815-4-subramanian.mohan@intel.com>

On Fri, Aug 23, 2024 at 12:31:08PM +0530, subramanian.mohan@intel.com wrote:
> From: Subramanian Mohan <subramanian.mohan@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver.
> 
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Acked-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-pps-tio | 8 ++++++++
>  MAINTAINERS                                      | 1 +
>  2 files changed, 9 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
> new file mode 100644
> index 000000000000..8face1dc8010
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
> @@ -0,0 +1,8 @@
> +What:		/sys/devices/platform/INTCxxxx/enable
> +Date:		September 2024
> +KernelVersion:	6.12
> +Contact:	Christopher Hall <christopher.s.hall@intel.com>

Why are you adding a random person here who did not sign off on this
commit as being responsible for it?

> +		Subramanian Mohan<subramanian.mohan@intel.com>

Do you really need 2 people for a sysfs attribute?

> +Description:
> +		(RW) Enable or disable PPS TIO generator output, read to
> +		see the status of hardware (Enabled/Disabled).
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f328373463b0..242d9784ee5d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18263,6 +18263,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
>  L:	linuxpps@ml.enneenne.com (subscribers-only)
>  S:	Maintained
>  W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
> +F:	Documentation/ABI/testing/sysfs-platform-pps-tio

Why are you saying that Rodolfo is now responsible for this file?

>  F:	Documentation/ABI/testing/sysfs-pps

Wait, there already is default pps sysfs attributes?  Why aren't you
adding your attribute to them instead?  Doing a "driver-specific"
attribute for a generic class device is not a good idea as userspace
tools will never know to look for it.

thanks,

greg k-h

