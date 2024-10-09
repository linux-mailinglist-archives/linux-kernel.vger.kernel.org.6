Return-Path: <linux-kernel+bounces-356606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900E996415
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AFD1F267E4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA35192B62;
	Wed,  9 Oct 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Uvc7Qzp3"
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6C190054
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463888; cv=none; b=BoLHz0EZzVRqU23PHAqiu7Xw5AtFPWpEwt+GLc4Z1cdMu4jQDr+e7VS2VpBlD+Sh8Qun3UQAsArJsfeYPZ9LvO0gdDFPWAOSvqPf7JtzMG6v0xU/I9ydTeGaQP5Ps0/I4T/CPhrms7ZpR8KUOBQSDCbu1shOPnef8cRVpOchiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463888; c=relaxed/simple;
	bh=FV7e7mTgWHw2Z3NtjjRX2MBIrZt/rRVowc+kGDl6BTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpDmb365uHVwMcw/DiC3V43uUrpcgi9Pz3b1HUYdjaNu4PzK+JEHe/W6XOL8lq7610kws/+HtaiGN2CL48argjdJ+1jJhA5tIMBdf4bMR207zVVkul+DgpZNIi4REIHwLVv+sl3ILnEi8MdQ+q7VqTBiENsOFErIsrmL3ZT32OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Uvc7Qzp3; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id ySMgsnKqdwy3rySMpsrqeB; Wed, 09 Oct 2024 10:48:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728463704; bh=FV7e7mTgWHw2Z3NtjjRX2MBIrZt/rRVowc+kGDl6BTw=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Uvc7Qzp3FEYqEqD/rvjmJO5Xey0Exv95Xx0hpAoe1d8Xc1nrOyYNy3B0Qka4A9xWF
	 VTk/MIl9zPj5Ft2zQMZtL65RVZ8xU2T9RNpLtTP79TtFM+/WvR03LFjwbMEUEn5P6r
	 HKrELBR7gCH6/mieShNQciQOgiUh+s6tI1nGuH6uQaBIrD/G0ktLl1FEWYGoZPa+0V
	 ItmCRAv4idtsjq48Ks8M6gs75NptG97JlB7i2XVvxsBZKsAZhzT5PY1H2zSkDJTowQ
	 pyaro9wn0seAUuwhSvHUIeZ6+v5cEhiigCfFCKR3CCZpHRUV5gYhugdSsmP1IghcI5
	 VwuygQfR4l9ug==
Message-ID: <fcb70129-f6f0-459f-b099-a2ca3a569095@enneenne.com>
Date: Wed, 9 Oct 2024 10:48:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] Documentation ABI: add PPS generators documentaion
To: Greg KH <greg@kroah.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
 Hall Christopher S <christopher.s.hall@intel.com>,
 Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com, Dong Eddie <eddie.dong@intel.com>,
 N Pandith <pandith.n@intel.com>,
 T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
 Zage David <david.zage@intel.com>,
 Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-4-giometti@enneenne.com>
 <2024100819-wildlife-counting-6c63@gregkh>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <2024100819-wildlife-counting-6c63@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMlxE6mUpguHLy4ZvIxzQPIAvV3oB91YJn+BHky68AOsVpS7bwixEkOVJrpjeOGo9ZFdHSSbs2c9eBLq1tNThaef4RirLZgvb5mqiW8S59WeVTqYM3GX
 V5VJ8obslYmIOAePh1NzhNfg8CpEmF8Plub2jPSti0jjP5816AnTohPZkhR2HugQ9PcPJ71cK0hAcqKtILQytYh+w06cv8HfrxYr82PEstZR4j9q13mXPakW
 uEel2a+sCfIVKVH+Hb6VobAA06voeej0RiAaOX1XFWRsMLmgmB/PyIpkSj1sEoyQbOMsWWOCvtDm/UspPeUQoUFYVsQm3W3zfQrGXKQyZJ9h7t4S7w1E8POS
 l9+7L/vCX4K6wa4qBJJpSVS/3dCSXHs821nsGtsKplB0Lci1C78cAICSQFkfOwZRdl5wCUYLhRyZI9kFg8XC/tN1LGczEuZXeFr2qqm3CiinSFDH5y6qqhCj
 Tijj+jk29qEyvYj5bxxLe0aNzWdLz0XEt1iOQ89CiZZroj+/hQKuB0NbpggfGas4O365COlCNdddUNaQmuaM/vuL9IML4mEd72UVxxVJwc2gEGcxpON6Fb57
 OEobIMtrjztEFfSbR3gov9ZAptzs31WcBAiSpUmmWGuleRc7TlHu8QcZceVSOo0sZQ6BBAxkiGaammCtLXNNIX0k

On 08/10/24 17:43, Greg KH wrote:
> On Tue, Oct 08, 2024 at 03:50:33PM +0200, Rodolfo Giometti wrote:
>> This patch adds the documentation for the ABI between the Linux kernel
>> and userspace regarding the PPS generators.
>>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>> ---
>>   Documentation/ABI/testing/sysfs-pps-gen | 44 +++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
>>
>> diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
>> new file mode 100644
>> index 000000000000..9ad066cb3ce5
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-pps-gen
>> @@ -0,0 +1,44 @@
>> +What:		/sys/class/pps-gen/
>> +Date:		October 2024
>> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
>> +Description:
>> +		The /sys/class/pps-gen/ directory will contain files and
>> +		directories that will provide a unified interface to
>> +		the PPS generators.
>> +
>> +What:		/sys/class/pps-gen/pps-genX/
>> +Date:		October 2024
>> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
>> +Description:
>> +		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
>> +		PPS generator into the system. Each directory will
>> +		contain files to manage and control its PPS generator.
>> +
>> +What:		/sys/class/pps-gen/pps-genX/enable
>> +Date:		October 2024
>> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
>> +Description:
>> +		This write-only file enables or disables generation of the
>> +		PPS signal.
>> +
>> +What:		/sys/class/pps-gen/pps-genX/name
>> +Date:		October 2024
>> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
>> +Description:
>> +		This read-only file reports the name of the X-th generator.
> 
> Again, why a name?  What is that for?

This can be useful in order to distinguish between different PPS generators in 
the system.

For example, the PARPORT generator is not very precise, and userspace 
applications should be able to know which generator corresponds to the device 
/dev/pps-gen0 or /dev/pps-gen1, etc.

> 
>> +
>> +What:		/sys/class/pps-gen/pps-genX/system
>> +Date:		October 2024
>> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
>> +Description:
>> +		This read-only file returns "1" if the generator takes the
>> +		timing from the system clock, while it returns "0" if not
>> +		(i.e. from a peripheral device clock).
>> +
>> +What:		/sys/class/pps-gen/pps-genX/time
>> +Date:		October 2024
>> +Contact:	Rodolfo Giometti <giometti@enneenne.com>
>> +Description:
>> +		This read-only file contains the current time stored into the
>> +		generator clock as two integers representing the current time
>> +		seconds and nanoseconds.
> 
> Trailing whitespace, please always run checkpatch.pl.

Fixed.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


