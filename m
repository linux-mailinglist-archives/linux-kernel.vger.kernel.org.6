Return-Path: <linux-kernel+bounces-211762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463D905685
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680A1286E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196B1822CC;
	Wed, 12 Jun 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QiH+ql88"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0217C203;
	Wed, 12 Jun 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204925; cv=none; b=CBHDdl6l0BECLP5Vh4k/oQf6rDiBqyNuDdsO+9Vq+YQ4YlU0B7qcuQOBlaR+1BnIDegrnjG927nz8yAx1NH5w+lmv6uufnT1TqzG3yxV9lQL1X5kYij2oqwoYcUjNBQoTRmQhNkZf9aoL+hbly9NHuF6g6kFMA341StCl8Wby2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204925; c=relaxed/simple;
	bh=S/A9wwU/WWut3bLdZzEuYA9bHU+Ptv0rQdN+jQqAyeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1BUBBb/AGPKaiimouthqVbGgF2ZralThyc8bbep8+1xGhkfMW59+WN99Kd6bj90XhT+uFlDB+rRUX2YeB/D+IvYyZKtlPtnNUsl4vi8WMUnfHJ5nENUyCmyBlTI0SMqZRonN31n8Hr3aYMitkv6kBkgbiCUFBojw7fwVrrflQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QiH+ql88; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FKQHO0q66SvvPBnedfd3/J8Ebod7dlEIQusHjYoxWmw=; b=QiH+ql88IDdp7u+dvcTFxgwWPC
	kBLZWGsc+OWFl0P7XPkfxZjQZv1DZVI4QCgKIXQdW20Y1j8YmzUxizcBbLvgIRRKxEeFhdCAnUri2
	/pflipIxGJew3nO0PYK/B5eAt7Q/AglYQKheYYwoME8OJJiltcOjy2SLZku5bwQ5Ghp9iUXambMkH
	HslMfcWikAfKILxelgtRI/mGcWaPhC98UGPnRcAK8OTXlyyUI/nfU5gE+48kfwO3rz0ZhPCczJn+t
	9NKyRsMz6peJU6lKOlIeqp+56pLHBoT/0Fh756ng/+3vGe2IsyRp2oRSu3P7p9H/2djLmQX6g0gcG
	osxKBAGA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHPaY-0000000D6Tw-1cRE;
	Wed, 12 Jun 2024 15:08:38 +0000
Message-ID: <15aba00e-2adf-410d-be03-b977fc1aed0e@infradead.org>
Date: Wed, 12 Jun 2024 08:08:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] ABI: pps: Add ABI documentation for Intel TIO
To: Rodolfo Giometti <giometti@enneenne.com>, lakshmi.sowjanya.d@intel.com,
 tglx@linutronix.de, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com, pandith.n@intel.com,
 subramanian.mohan@intel.com, thejesh.reddy.t.r@intel.com
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <20240612035359.7307-4-lakshmi.sowjanya.d@intel.com>
 <8b66c491-ec6a-430f-8566-114372151c3a@infradead.org>
 <9cd3e304-48d7-4a69-a70c-8937dcb62a08@enneenne.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <9cd3e304-48d7-4a69-a70c-8937dcb62a08@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/11/24 11:57 PM, Rodolfo Giometti wrote:
> On 12/06/24 06:29, Randy Dunlap wrote:
>> Hi--
>>
>> On 6/11/24 8:53 PM, lakshmi.sowjanya.d@intel.com wrote:
>>> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>>>
>>> Document sysfs interface for Intel Timed I/O PPS driver.
>>>
>>> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>>> ---
>>>   Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
>>>   MAINTAINERS                                      | 1 +
>>>   2 files changed, 8 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
>>> new file mode 100644
>>> index 000000000000..e461cea12d60
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
>>> @@ -0,0 +1,7 @@
>>> +What:        /sys/devices/platform/INTCxxxx/enable
>>> +Date:        September 2024
>>> +KernelVersion:    6.11
>>> +Contact:    Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>>> +Description:
>>> +        (RW) Enable or disable PPS TIO generator output, read to
>>> +        see the status of hardware (Enabled/Disabled).
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index aacccb376c28..9c623f167aa9 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -17946,6 +17946,7 @@ M:    Rodolfo Giometti <giometti@enneenne.com>
>>>   L:    linuxpps@ml.enneenne.com (subscribers-only)

Is the mailing list correct?
The linuxpps.org FAQ says that the Linux PPS mail list is discussions@linuxpps.org. 

>>>   S:    Maintained
>>>   W:    http://wiki.enneenne.com/index.php/LinuxPPS_support
>>
>> I can't connect to (load) that web page above (wiki...).
>> Is it correct? Does it work for other people?
> 
> The LinuxPPS wiki is at http://linuxpps.org

Great. Please have someone update the MAINTAINERS file.

Thanks.

>>> +F:    Documentation/ABI/testing/sysfs-platform-pps-tio
>>>   F:    Documentation/ABI/testing/sysfs-pps
>>>   F:    Documentation/devicetree/bindings/pps/pps-gpio.yaml
>>>   F:    Documentation/driver-api/pps.rst
>>
> 
> Ciao,
> 
> Rodolfo
> 

-- 
~Randy

