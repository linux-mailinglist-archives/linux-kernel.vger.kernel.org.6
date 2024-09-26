Return-Path: <linux-kernel+bounces-340165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B2986F47
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF49280F63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999D1A704F;
	Thu, 26 Sep 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="OzPmiQbc"
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DF14AD17
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340608; cv=none; b=U2rRnUjQ1knSlrG6p6ozRe/aOoQ2CKGXQGVX16wa0TuCgCo2r1ZurmGeqtjceALKs8n8Chb0aL9sQVVJ5hrTUMXLHflXLuDjYAw4PKZ4KO/qgIOopJbwsmfuqspdt3XOTt3dpJBYZEfQljKGRLMTITcpVHNP9vLtTvj8JpUODqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340608; c=relaxed/simple;
	bh=4AupH/BviNHtaHpZmQ9S7ipD1OFuKiaMUUbNa6H3IJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7aCPALxW1XsssVcYczou7+jPK8RvetCcUFXocOHOsQ/1GEl+TLvCnI9tDfy1NC+tvk89gPX7G5xrPslVhNwrJ7buBEPc/56SKwvn7nekAnPX2pRetwYZSkHOqgS56bM+LjHQ+IfVUMb3wFwjilBjkqIUf/MhH2RGMTLauuv8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=OzPmiQbc; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id tk9GsxGjg8U42tk9HsMf3E; Thu, 26 Sep 2024 10:46:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1727340416; bh=4AupH/BviNHtaHpZmQ9S7ipD1OFuKiaMUUbNa6H3IJQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=OzPmiQbcYU4Tn8TiRv+eEu4jTjOm+vCSLoKQsHKWwlwjmvqh2y6n7mERYvSKNTCro
	 vr3l0S8kphfyniViG6Ic5bxhkPIr+bB4LKVtjxw/24wH7cU1Ee/lR8A510FcohlgSd
	 aLlTidJqVOkx55UtptgbUZtoGTZLQm/fLP3B7/dOn2kRFuyKNfKtrem+r4LkiNmTfA
	 VbXndxp5XvWK1+fnvslma51qBsC/rZA3UquRfn/FVMydUVtB3SZzPq6Qqg6yNiQwmk
	 vPiCWBCZ88WMD1kGH5EtK53UjAWwchTFuyJeq8VNHfKk1nhu6GWMI6RbcZQNJ3408z
	 xPQCUIxdO5k7A==
Message-ID: <e88f2d6f-033a-41b5-afdb-8a3f6bcf3d06@enneenne.com>
Date: Thu, 26 Sep 2024 10:46:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
To: "Hall, Christopher S" <christopher.s.hall@intel.com>
Cc: "Mohan, Subramanian" <subramanian.mohan@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>, "N, Pandith" <pandith.n@intel.com>,
 "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
 "Zage, David" <david.zage@intel.com>,
 "Chinnadurai, Srinivasan" <srinivasan.chinnadurai@intel.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <20240823070109.27815-1-subramanian.mohan@intel.com>
 <20240823070109.27815-3-subramanian.mohan@intel.com>
 <2024082456-kitchen-astride-7892@gregkh>
 <801c7a93-667b-4c23-9493-4cbe979847a2@enneenne.com>
 <2024090304-viewing-lavish-c05e@gregkh>
 <PH7PR11MB69787046B1F9CDA610523FE5C2692@PH7PR11MB6978.namprd11.prod.outlook.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <PH7PR11MB69787046B1F9CDA610523FE5C2692@PH7PR11MB6978.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMug2r+xb8fM0qHgPmLgkam22qBK9bSW3EXeA1dfwYDwXC3Mp2LaQFKs5Arg1qfTvDxefz5LtFt1wWsN7Z6DM0eqhlfEhqFMV/JhZHjDlfasJQTPH+vq
 gLGIHG8oGtycnDEVSfAFWdeIZ0eirMwJc2UZXHvhOFG0rBWAeiPdTCptyNy9q+YUlG0gr+q/oUdoOMOkflsO16AevFd0trnw7VAx7AW85CJjaqw9eR+mOk24
 +nFvVtMXNEFk9jFpZOK65n9/22PwptVXMcwwccOkt3U6B7UiE5NIkHgHCtgbpDNbTRE6jXZ8xvmAxKWSNWGxNSIlpidYHbfL0iXB5kfS8UZuu7r7cqeTqNqJ
 N2zsrLXkG6FnyhLfc935uUHwes6QU5mP3024YI0zJ3kc2o9j+MP4/7TRp8VlBXGbqyspuGLLpdoUfvI0azyyzpC1CSpNScJj9HUhLQgAca5O0rUWDWRJoqh0
 j015aasJRrn8vRAcKFhRKa5FDXV2WYtEM1QMbWG6CJZJCP+RL2RsiaTP8NOHyt+Vf9OyjEsyTJLEh/lwVo3LCg72IfE8NkqaWGQZ+NUf+AYRUQzFwV3xSi3M
 +koHSS0/Gx1xtfkwwGMCpJ3juwcAfdRCzap/5k5HKc0JJZm3UFs4eUDVsnzdWaTF+W8=

On 25/09/24 23:55, Hall, Christopher S wrote:
> Hi Rodolfo,

Hello.

>> From: Greg KH <gregkh@linuxfoundation.org>
>> Sent: Tuesday, September 03, 2024 3:25 AM
>> To: Rodolfo Giometti <giometti@enneenne.com>
> 
>> Subject: Re: [PATCH v12 2/3] Documentation: driver-api: pps: Add Intel Timed
>> I/O PPS generator
>>
> 
>>> If you are willing to stop the inclusion due this fact maybe its time to add
>>> such PPS generators interface... on the other hand, if you agree for
>>> inclusion we can do this job as soon as the code has been included, in order
>>> to fix this anomalous status.
>>
>> Please make a generic pps subsystem for this, it would make it simpler
>> for everyone.
> 
> What is required to move this? We can certainly test the code and do some
> of this work, but I would look to you to define the interface.

The problem is that a pps-generator has no related device, then no sysfs entries.

I think the right-thing(TM) to do is adding a new class named "pps-generator", 
so we will get the directory /sys/class/pps-generator with several devices as 
pps-generator0, pps-generator1, etc. For each device we should add at least 
these sysfs entries:

- system       : This file return "1" if the generator takes the timing from
                  the system clock, while it returns "0" if not (i.e. from a
                  peripheral device clock).

- time         : This file contains the current time stored into the generator
                  clock as two integers representing the current time seconds and
                  nanoseconds.

- enable       : This write-only file enables or disables generation of the
                  PPS signal.

- period       : This file defines the period for the generator signal. When
                  read, by default, it returns "1 0" which represent the period
                  second and nanoseconds (i.e. a PPS signal). When written, it
                  sets the period accordingly or ENOTSUPP if not supported.

- start_time   : This file defines the starting time for the the generator
                  signal. When read, by default, it returns "0 0" which means
                  "now". When written, it sets the starting time accordingly or
                  ENOTSUPP if not supported.

Please, let me know what do you think about this proposal. I'm going to provide 
a draft in the next weeks since I'm stuck on another project right now. :(

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


