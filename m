Return-Path: <linux-kernel+bounces-303396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F3A960B85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04258B25A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57271C3F24;
	Tue, 27 Aug 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="kePo+yvf"
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8881BFE01
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764350; cv=none; b=tD2IgBRoHXFI6ktsrunOFTKhg2bntpdKhMJjsk1dtTyr8PKPx7v9wkrJQ+Shejl7ESduESd3Ay+//z9srYV6m46fjjMWiT6cY/WAB4UxWeelOiingf5gAcybhyTMcGr52VNX4jwy/pGWRwH2Ko30Uf4/ZinzbXUI/9HDzgRgX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764350; c=relaxed/simple;
	bh=FZ9EdpASgQDQw2I7w/OIDjomodkMadaDVqA//AQdHFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHTos940h4EUCPk2vDvHNWl011QZZ3h3yttZ7U7gMt7Yt8cBXwWFZtUIl53FdO5C8tXDXCg7qxKGYesQ6Zeqq54RVY4My7IeKl5eTBenidHcEWdlKYjjxPK/jFfGzHDUqyDR25mVPZHUfhkEPyRbdB7234s/QpO33hBt3EoAuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=kePo+yvf; arc=none smtp.client-ip=62.149.156.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id ivwhsEWU7cvwVivwisevbv; Tue, 27 Aug 2024 15:09:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1724764157; bh=FZ9EdpASgQDQw2I7w/OIDjomodkMadaDVqA//AQdHFA=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=kePo+yvfR7O0OeidKzu+YE0VwBqglOYHxYZKz2+46VCsnQFlkeuWw/h+cuddvvHsK
	 dqNFkY+sFcwUWhehKHPE9qVTQmDBXnvrD/ECEDSCDdr6IVr7SkCWXDTDi2nwJlT31f
	 6yPUEmMkMbeOiP3acSdzi60OojvADiYFeK5N3EOG+XnZgG+aXAsrPsASip+PL3e/Cg
	 xBq+txbCkKg7O8t81NyUedmSOINMV6aG+ViD9wifxz0afURneGneu7DHt4uwRgTO3t
	 OAvkcLsrMNm8vCiq+2bsK34oeLc0osXVZnGq3Qujijgj+CyyJmq6wD7aBxlfM/fVSe
	 newzoBzCuKhfA==
Message-ID: <801c7a93-667b-4c23-9493-4cbe979847a2@enneenne.com>
Date: Tue, 27 Aug 2024 15:09:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
To: Greg KH <gregkh@linuxfoundation.org>, subramanian.mohan@intel.com
Cc: tglx@linutronix.de, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com, pandith.n@intel.com,
 thejesh.reddy.t.r@intel.com, david.zage@intel.com,
 srinivasan.chinnadurai@intel.com
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-3-subramanian.mohan@intel.com>
 <2024082456-kitchen-astride-7892@gregkh>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <2024082456-kitchen-astride-7892@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCxSOsKTWK/QqMUreYQRbcEbpjB4JvIEZ8LKm8HLFEP8QYO+CiHRklqJ6DR+Bi/+50wcfKJjl1w/LffkdK8iVJcfO9jneACUgOkjsZNPW9Y/1lmCMnak
 lUiaT6cmtLnHIztcHDkBib+bb9+blU5PknSq6n+Of/8X3Asw+OtqzMuY/K6xo05CbZ1GgJyuLDyFxt0HAFKMkGMrk0HngzoAFyWlK1XD/RucXSuRFAhiwnW1
 YZrDx6bal/FTcOVsKhMhPhU0mAdrWdy2VrjTq7Dq51IzzFvjMy/rqKL/9qvh47UTFl+RNi3lUi5EU8xzdQAysUsV0ir2LLgdcAzCVQ7GvNDmmwbgGaMSbBJg
 nK99s7tZ+0tnGGC6qrH4kbhv0Vf9ZsOawCKlFrczlnhhJwQtUoiFprXFAPTcifWbt63rr+BwozkgMKgvAgNB13kcpcD/AQqiNHgLPdlYu9p7c8Yc0MXEojA/
 mzQFydziZYO8F/lfZcDAhiJanqp/Q3WX2RRQAzQKrBuJZ0ULEmzywkYG/ETCqXwmWjAVcyp/rGgRKNF2g6A6l8mNpTUMsw5s6X3NUA9Ze8pdg8VFQnHXLa7b
 QGPeunlkJaejwV8YFwceRv16PMqvHKUZ3DjWqBfjJ+EhqHSjIE/Z8+BRsXyzRMhkjDo=

On 24/08/24 04:21, Greg KH wrote:
> On Fri, Aug 23, 2024 at 12:31:07PM +0530, subramanian.mohan@intel.com wrote:
>> From: Subramanian Mohan <subramanian.mohan@intel.com>
>>
>> Add Intel Timed I/O PPS usage instructions.
>>
>> Co-developed-by: Pandith N <pandith.n@intel.com>
>> Signed-off-by: Pandith N <pandith.n@intel.com>
>> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Subramanian Mohan <subramanian.mohan@intel.com>
>> ---
>>   Documentation/driver-api/pps.rst | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
>> index 78dded03e5d8..75f7b094f963 100644
>> --- a/Documentation/driver-api/pps.rst
>> +++ b/Documentation/driver-api/pps.rst
>> @@ -246,3 +246,27 @@ delay between assert and clear edge as small as possible to reduce system
>>   latencies. But if it is too small slave won't be able to capture clear edge
>>   transition. The default of 30us should be good enough in most situations.
>>   The delay can be selected using 'delay' pps_gen_parport module parameter.
>> +
>> +
>> +Intel Timed I/O PPS signal generator
>> +------------------------------------
>> +
>> +Intel Timed I/O is a high precision device, present on 2019 and newer Intel
>> +CPUs, that can generate PPS signals.
>> +
>> +Timed I/O and system time are both driven by same hardware clock. The signal
>> +is generated with a precision of ~20 nanoseconds. The generated PPS signal
>> +is used to synchronize an external device with system clock. For example,
>> +it can be used to share your clock with a device that receives PPS signal,
>> +generated by Timed I/O device. There are dedicated Timed I/O pins to deliver
>> +the PPS signal to an external device.
>> +
>> +Usage of Intel Timed I/O as PPS generator:
>> +
>> +Start generating PPS signal::
>> +
>> +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
>> +
>> +Stop generating PPS signal::
>> +
>> +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable
> 
> As I mentioned on the sysfs documentation, why isn't this just a generic
> pps class attribute instead?  Why did you make it
> only-this-one-special-driver type of thing?

This is an Original Sin when PPS generators were introduced. :-(

In 2011 a patch from Alexander Gordeev <lasaine@lvk.cs.msu.su> (which introduced 
the "parallel port PPS signal generator") was committed in the main kernel.

At the time it was something exotic and doing a PPS generator interface for it 
was not considered (since it actually has no controlling inputs), but now 
several Ethernet cards have such PPS generator functionalities, and they are 
enabled in a per-driver way or via the PTP API.

This code is a pure PPS generator and it cannot use any other way to enable such 
functionality than the one above since the PPS layer misses a proper 
implementation for PPS generator.

If you are willing to stop the inclusion due this fact maybe its time to add 
such PPS generators interface... on the other hand, if you agree for inclusion 
we can do this job as soon as the code has been included, in order to fix this 
anomalous status.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


