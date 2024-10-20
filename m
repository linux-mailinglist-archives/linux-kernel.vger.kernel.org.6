Return-Path: <linux-kernel+bounces-373347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D29A5598
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0412829B0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FF194C9D;
	Sun, 20 Oct 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="krgZy8/C"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7625320E;
	Sun, 20 Oct 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446874; cv=none; b=BIWuJIOWTMD9qu/8y7D6MFOHiGOYx4SNkKPgSTuLmYMKQbPcAbW/Z63HARHmkDSkKEVj31ROaGEVaV4hlI4Qa5K8yQbCou5q5jjVH9O/2SDVO+F4H0oHopx0j7NijhDRCDNE017PgVmxtTZlYRJxI9iKgLgXTQibHETC+/rO5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446874; c=relaxed/simple;
	bh=63xd4Dz1Q927vKekmZcmFdSpmfjsh1TFH6ByVh0FH2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4y6I8vdO6gEyxp6IbgKPbEJTU/q3Kt5T9Xb4ecGmLBbG+DjmpHQFVCF9w3IFFSApWtMnJ2+YSDFN2wMeBEAM+yIlNTem+2bFuk1vxLep6HDNM3PDZCmBF8Ih1Cr7F982VUCJlmTqzApQ3Z+1ntVBXfDvf9S+mF1YAjVjT/CgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=krgZy8/C; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=o0FaGiYaRFDr0GjbTZnQROVCEAcJkRWf9ElG48sEBSA=; b=krgZy8/CvwBQW5XDzgm3Cvt7I7
	ruXcl/VeyBPBX2rpPD+B5yLDZHzsMVd4VYT0GqE3xHdNRMsUU0QpA4VZxwH0fzP1IF307M1ZlN66N
	FOCd9l0rPk/bswL8JMHk3EPC8LmKDrVTGYpWX62r1Xh2bz5neCC2uJN8wNPjdXwNdarpS3mHwngaK
	VA3XsaeR4y24kYi/6cX708Q/iQeKAMxiAZTRS1PFjzGvpgkfPiACRbUi7jzgzihrpb5onmqQ1ao3P
	cGLGe3pgZeW9wljQh90lhthB8ltK570sAGjKVe1Wz89Azd0hNF0uyBm62rBNrmk7YGczDOcbErOS6
	8C/gG/4w==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2a8L-0000000FSlm-0EaO;
	Sun, 20 Oct 2024 17:54:30 +0000
Message-ID: <fcc96a91-6ce4-4878-8674-9ee5da062d6d@infradead.org>
Date: Sun, 20 Oct 2024 10:54:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V1 4/4] Documentation ABI: add PPS generators documentation
To: Rodolfo Giometti <giometti@enneenne.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
 Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com, Dong Eddie <eddie.dong@intel.com>,
 N Pandith <pandith.n@intel.com>,
 T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
 Zage David <david.zage@intel.com>,
 Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
References: <20241018143915.3877425-1-giometti@enneenne.com>
 <20241018143915.3877425-5-giometti@enneenne.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241018143915.3877425-5-giometti@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 7:39 AM, Rodolfo Giometti wrote:
> This patch adds the documentation for the ABI between the Linux kernel
> and userspace regarding the PPS generators.
> 
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> ---
>  Documentation/ABI/testing/sysfs-pps-gen | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
> 

The files "enable", "name", "system", and "time" descriptions are written in
present tense. Preferably change the descriptions for "pps-gen" and "pps-genX"
to present tense also.


> diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
> new file mode 100644
> index 000000000000..427ba985f413
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-pps-gen
> @@ -0,0 +1,44 @@
> +What:		/sys/class/pps-gen/
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		The /sys/class/pps-gen/ directory will contain files and

		                                  contains file and

> +		directories that will provide a unified interface to

		            that provide a

> +		the PPS generators.
> +
> +What:		/sys/class/pps-gen/pps-genX/
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
> +		PPS generator into the system. Each directory will

		              in the system.
		                               Each directory

> +		contain files to manage and control its PPS generator.

		contains files

> +
> +What:		/sys/class/pps-gen/pps-genX/enable
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This write-only file enables or disables generation of the
> +		PPS signal.
> +
> +What:		/sys/class/pps-gen/pps-genX/name
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This read-only file reports the name of the X-th generator.
> +
> +What:		/sys/class/pps-gen/pps-genX/system
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This read-only file returns "1" if the generator takes the
> +		timing from the system clock, while it returns "0" if not
> +		(i.e. from a peripheral device clock).
> +
> +What:		/sys/class/pps-gen/pps-genX/time
> +Date:		October 2024
> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
> +Description:
> +		This read-only file contains the current time stored into the
> +		generator clock as two integers representing the current time
> +		seconds and nanoseconds.

-- 
~Randy


