Return-Path: <linux-kernel+bounces-210908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 183A7904A02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA8D1F245B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF223769;
	Wed, 12 Jun 2024 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FdmUU+DV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969764A;
	Wed, 12 Jun 2024 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166569; cv=none; b=d0OwgEeSbrhi+15xcag1+PokLToO4NXO7uoDQPopYiiYniQ55oPwcaVKCz99RHFroUDX83XoAO3izWCNtumzxBhHK9cNjKoIv+2sxzFyVEDh+Gr291CVUxiPZtnYw21KBjYW/4l0qt6jiC3qnxAMkNRg4xxtJVmqI03nx0+EPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166569; c=relaxed/simple;
	bh=qbMh0+pf2SPeD3Kjln8qLzxtLjXV8v02l3LAkjQVDyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBx8ZGW/+P/xuPqdlIzbfZj76mVFLiKgEsrtoxdPBU4Ws+k5Z3Qo+AbHiEUDjj0RhulyOarWs0o5Mz1EypDgMmexA6EpS8jzOsVHmeWc1Yph3ikXYn6AecjBM+ARphB2j1bfCrgUaEibReE0kVR1eonQ1uyeN3J2nI1TALCtsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FdmUU+DV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DUVnrezAAabhLkyXkeIE6MKzW6donbVmDcF5Y3z7MHI=; b=FdmUU+DVgDEttgjLj+4RxQ0bZA
	tviaev38EhPBLr63OK5PQUupTvTyfCOSlPW9tJ5mhQa8idu9/Bqmfo7lJgVB6bysG/SJIUO7vhCzR
	w8A7ujfqMgQJldJqgO/bOqYhKiElMPdFeTRoHyRCCHat/KGTOpLND7Zz665kXgoa03MG5Kv65eUAR
	k28R5R4B6U1OfRrVOnGh44BWCQg1PX3YbYu6nlPy34dWXx4wYVrhYyGRb5Y5k7IAI+eII0bARTwrD
	2jJSXNMIuQrnlWmZ1Lrx9yAFDATXWR724DXw09FW6RgMKStwrtWIdJUik1ppQ5T4stI/mn+5OfgSX
	ATldFxOg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHFbu-0000000B1YS-0tjz;
	Wed, 12 Jun 2024 04:29:22 +0000
Message-ID: <8b66c491-ec6a-430f-8566-114372151c3a@infradead.org>
Date: Tue, 11 Jun 2024 21:29:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] ABI: pps: Add ABI documentation for Intel TIO
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com, pandith.n@intel.com,
 subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <20240612035359.7307-4-lakshmi.sowjanya.d@intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240612035359.7307-4-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 6/11/24 8:53 PM, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver.
> 
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
>  MAINTAINERS                                      | 1 +
>  2 files changed, 8 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
> new file mode 100644
> index 000000000000..e461cea12d60
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
> @@ -0,0 +1,7 @@
> +What:		/sys/devices/platform/INTCxxxx/enable
> +Date:		September 2024
> +KernelVersion:	6.11
> +Contact:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> +Description:
> +		(RW) Enable or disable PPS TIO generator output, read to
> +		see the status of hardware (Enabled/Disabled).
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aacccb376c28..9c623f167aa9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17946,6 +17946,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
>  L:	linuxpps@ml.enneenne.com (subscribers-only)
>  S:	Maintained
>  W:	http://wiki.enneenne.com/index.php/LinuxPPS_support

I can't connect to (load) that web page above (wiki...).
Is it correct? Does it work for other people?


> +F:	Documentation/ABI/testing/sysfs-platform-pps-tio
>  F:	Documentation/ABI/testing/sysfs-pps
>  F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
>  F:	Documentation/driver-api/pps.rst

-- 
~Randy

