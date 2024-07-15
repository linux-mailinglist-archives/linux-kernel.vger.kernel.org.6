Return-Path: <linux-kernel+bounces-252309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5193116A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A672832E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D540186E59;
	Mon, 15 Jul 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="j38gJmMf"
Received: from smtpcmd10101.aruba.it (smtpcmd10101.aruba.it [62.149.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762E41C79
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036391; cv=none; b=Wk+Btv8CjeMwcnya8ldJqWEhWKmasWGcRq9+wCfpC0/wGmVfWLX7Sz2vw3BDW3PlrVh29IxCrafPwGQdeVxueIrR3mMaZvxspz96jC/J3ctQqQPM5U3EmIHun9QrItoqSVBpvuxVQBRLZiOnRgVtdeHHySRXg7G/l9s0VTM3ZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036391; c=relaxed/simple;
	bh=zufgvo3HhWzKwxge6Fq8EmrkEJg4uQY6BLZPM6KRznk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkiAXJgFxG4FaknGrIWuHiDRvRiupJwXP7PbzlrpQ0Kh8BT4wSyWxxf+V/MGKjlGcDoaAfTnCL0IIm3FyOyEE5ZPgAXCNy1FfXKfsqQ5lZy/AL6BD3jnRF/s7FJ4KwDr6xSvR48bokeT2IMiEbMVoE5lr1YImzyZgNHW/qRKENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=j38gJmMf; arc=none smtp.client-ip=62.149.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.61] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id TI8LsKY3Xegg3TI8MsHxPO; Mon, 15 Jul 2024 11:36:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1721036199; bh=zufgvo3HhWzKwxge6Fq8EmrkEJg4uQY6BLZPM6KRznk=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=j38gJmMfd+rO3twprmDjeNWqXf0OTdENE/yidCN9B/dIqS3fpHc/ed8GOxTSHBZJM
	 ajwbCZlqcGR8I5569qpTtDSjtarez4nMQCcFmHkJDaylozSN1uJ42lrvzETl/byf/w
	 jg4v+b3h5sfa7R+9IaZ4fAuKHJrkYbyvQvxxppsctswK9Z7UDGDWJ9N9ZQcGyPgzri
	 TwyvBg3MAqxgAdCo1rttVI6WlBAuZoGewDwzeC96qW6DNQDBFxAOne6ioREX772Qhl
	 mS6CXXDNdVWzDC5cbmpekInlmVvoAm14RjYhVCtiHW4r6NMCPFQZi6uAT1XFVzGY76
	 xDuGwgVXt4Qew==
Message-ID: <5198a2c2-49b2-4a8c-8d94-d6c9811b645b@enneenne.com>
Date: Mon, 15 Jul 2024 11:36:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
To: Thomas Gleixner <tglx@linutronix.de>,
 "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "Dong, Eddie" <eddie.dong@intel.com>,
 "Hall, Christopher S" <christopher.s.hall@intel.com>,
 "N, Pandith" <pandith.n@intel.com>,
 "Mohan, Subramanian" <subramanian.mohan@intel.com>,
 "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
 <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com> <87r0bvqdsz.ffs@tglx>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <87r0bvqdsz.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfG5EVBOw/0gq5Ao++VkWdm3sUyZoiok13WrVwpeCN4vzx9l3c2lsbNPT8k4LqSk5WfabnYCKouQKENm4imV0bLEWHEpLgeE16dMrHNpysCMaAkzPHR4X
 e7rsrs/7BUozh83ePY1//yV4xd9UyGLMyknRGTHogAiRwUxByj896SCs7CyPzF7YDeuVOrj+LjDdK2SqSPJ+BFac20/POqSxHCQnJj5vWe0br8vUwxWgEFOU
 ELqHbPEM5rY6RvvShgS2hCFRJ36/f0Acbg10daJICMek+sIC13isy9Dd6SGDN6wmSYYWvcfuwLJJlMpRyNnTwUm+0z9/hd/G90VKNVjD5dlTmxsTNhLcSgSZ
 0NGt8ObE2AjAO+39Qdw8RMdN3oefmhlQR8lEDKyZRS194H+lOzoZL0NlKHOCsu8Cns4HD4nXRg6wdXtK9PmjZ28JRJIjMWUUiX9w2DEnuv3thBF3nH9ino/f
 bMvRghHHDI2CyQzQf3DIi34pMy/MGk21WbFSe5oaprQ0cB6WPTq9XQTcq3NeGt4/LpL9DvofYQMtUxRzbjJ4z6DU3sGm8t2Gem+B748XtBM+ZU6PAYVjCMi4
 v/wwEe1Flh+tE/c+vVdexP9iCo4f4utXr1up9PODEeb83FcZ7b33zbLdJb/DOdU4UZo=

On 15/07/24 10:06, Thomas Gleixner wrote:
> On Thu, Jul 04 2024 at 13:50, Rodolfo Giometti wrote:
>> On 03/07/24 16:47, D, Lakshmi Sowjanya wrote:
>>>
>>> A gentle reminder for the review of the pps patchset.
>>
>> I already acked these patchset, didn't I? =8-o
>>
>> Please let me know if I missed something.
> 
> Sorry, I missed that V10 posting. It's too late now.
> 
> Rodolfo, can you pick it up after rc1 for the next merge window. All
> prerequisites should be in Linus tree then.

LinuxPPS has no dedicated tree as other Linux subsystems. Usually I send my 
"Acked" to Greg Kroah-Hartman and Andrew Morton, and they push patches by 
themselves.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


