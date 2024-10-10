Return-Path: <linux-kernel+bounces-358765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC36699835D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8976A282114
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7331BE85C;
	Thu, 10 Oct 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="GZz+cYNk"
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2C18DF81
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555521; cv=none; b=vCyX1SbhDLgNHKxthhCArMNYC+t727fDsKWMpc6vLM+NG8gY2BXMZcTIX6tzQOEkLW3Ly36/V/ujT4z3cXSq0SnH3EZQHyZ4PcuHhK680Uc1EO0IJWyf30osTWkku71P+T23wWQbRdu/7ZMIJBdcpV+nP1OhC9fV7744K9salbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555521; c=relaxed/simple;
	bh=HGo7tUpJ0rbxsrP70AzGqhphJ3htNOb2sxiOJePK9aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgLH1cDLbGMI8dNn+YA8MkepusFFfLJDVpG2TqvYkgS0clTGWejB0tp9lFlhks32Cqe5kHYDw0InvbyuTE4Zg+QMIWTmTEaFyAOTaG3ielL1bgxThBajOdxyG5rpgq6GIK8zau7kPFbbDZirJZTJ2mgvGeTWbeoS7sDnb9FNZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=GZz+cYNk; arc=none smtp.client-ip=62.149.156.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id yqFfsoNlX7AmWyqFfsMv6p; Thu, 10 Oct 2024 12:18:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728555516; bh=HGo7tUpJ0rbxsrP70AzGqhphJ3htNOb2sxiOJePK9aU=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=GZz+cYNka7JyjTw+7PXG1KTH7KSMRoeqjiRbc8NtZWc4TRaPLD7Dtmg61Jx5FJPua
	 ehcgYZcUuUdbp6oOqtq2HjmPjVh87M85PG5TEW63HJxuN2/Iarg3Fa0jo26OQdZNm2
	 8oaYxbX2nBuP0AdH+myqBZQuelkdoL/D5kYnpij6+q7PDjASkSZKWo7s8sdayndOrP
	 j/ZFQtOSVt5b85/rWo62eTgLwPqGqQYWQ8WgR+DD6Jx6vQHpyDfPzRunj5mKT1AOE4
	 bunATAYz9lSGbBfRQPKurvcjr/uATUSWOd3GwarT9nHdiQfTIbGEaeBwcgS6GbclsP
	 xysPr/KWLW0Hw==
Message-ID: <5a343d19-8a14-456d-b671-0712895164a6@enneenne.com>
Date: Thu, 10 Oct 2024 12:18:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] drivers pps: add PPS generators support
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
 <20241008135033.3171915-2-giometti@enneenne.com>
 <2024100855-unsecured-mammogram-001a@gregkh>
 <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>
 <2024101013-reputably-skid-9e01@gregkh>
 <d42b0c9f-086e-4c07-a2ab-8f3b0d6ab580@enneenne.com>
 <2024101002-viscous-egomaniac-04d3@gregkh>
 <253ff116-6ead-42f1-a3a7-0d627ac90b5e@enneenne.com>
 <2024101022-scoundrel-ravage-19a2@gregkh>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <2024101022-scoundrel-ravage-19a2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDyJYzkcecy/8uT58PYcSQaKWgaRWx7xiRk7uEe6cu0l1o7H3rO0iNVveDUROQGXTWUq27zw2611/HZ/5xHcPw7IWaxVraOvTl5UdJp8cE1gdqnJGlIS
 qIGqMf0ftqP2F6ahBpdjL8pVX3Zt56GnJrQf85JzVT1t58GEQD1letao5jOSYdzvaJSGYdMa/dI9fAZuhjg2SR6p5s6hIpPG52kPp4JJFAeML/xRAmc3a3bR
 LfK7OJRVUcl/5ERrt8K0vV6q6W/MbeGP+SWSJ196/g2rbfevDi1/gQDw+lScQ9mUcl1KNN3qEY0SU598YTVAC97ETH5blDBR22zNLGxdygwkXiHSRlbl8jzs
 A1TbbciGB74UEeuXSsy3Be4c7PbKQ/QDGnhwUqEKRsbEE86QLq5G0ZNvlSlvSvxBb95VBZzJV5EAyxP6Zgs6o+Tzy3qIdR/YKytT0xc/g8FlS+W+1FfcIzg7
 kWeJ9E/Oh+MJkyT+jspaFhF7n+LB0VwFhuXIkw1HfGLwHGC8plY7IG5kqQaatEajljP28O8E417SGzlTerX7XTAtljvbr67ZppHLR5EzI3R3p5ENjzw+qJHK
 PauxNoNxpLW15F5BFQ2CSah5cUq9o33tWdxPh23mKPzC2xDjpuKmuBdEwF32mKLwI19lLyH+32fBLGeUFpkkig+y

On 10/10/24 12:04, Greg KH wrote:
> On Thu, Oct 10, 2024 at 11:53:44AM +0200, Rodolfo Giometti wrote:
>> On 10/10/24 09:54, Greg KH wrote:
>>> On Thu, Oct 10, 2024 at 09:32:22AM +0200, Rodolfo Giometti wrote:
>>>> On 10/10/24 09:15, Greg KH wrote:
>>>>> On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
>>>>>>>> +#ifdef CONFIG_COMPAT
>>>>>>>> +static long pps_gen_cdev_compat_ioctl(struct file *file,
>>>>>>>> +		unsigned int cmd, unsigned long arg)
>>>>>>>> +{
>>>>>>>> +	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
>>>>>>>> +	return pps_gen_cdev_ioctl(file, cmd, arg);
>>>>>>>> +}
>>>>>>>> +#else
>>>>>>>> +#define pps_gen_cdev_compat_ioctl	NULL
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>> +static struct pps_gen_device *pps_gen_idr_get(unsigned long id)
>>>>>>>> +{
>>>>>>>> +	struct pps_gen_device *pps_gen;
>>>>>>>> +
>>>>>>>> +	mutex_lock(&pps_gen_idr_lock);
>>>>>>>> +	pps_gen = idr_find(&pps_gen_idr, id);
>>>>>>>> +	if (pps_gen)
>>>>>>>> +		kobject_get(&pps_gen->dev->kobj);
>>>>>>>> +
>>>>>>>> +	mutex_unlock(&pps_gen_idr_lock);
>>>>>>>
>>>>>>> Doesn't an idr have a lock in it?  I can never remember...
>>>>>>
>>>>>> As far as I know we must use a mutex...
>>>>>
>>>>> If you do, someone will come along and remove it, please see:
>>>>> 	https://lore.kernel.org/r/b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr
>>>>> as an example (with links that show it is not needed).
>>>>
>>>> Here is an example about ida API, but I'm using idr API.
>>>
>>> Why not use ida then?  :)
>>
>> Because we need an ID associated with a pointer.
> 
> Ah, ok, but why?  Why is the "id" here the mapping to the pointer?  Why
> not use the structures you already have to store this in (i.e. the
> normal driver model stuff?)
> 
> All you should need an idr/ida for is to pick a unique "number" for
> naming your class device.  Everything after that should already be there
> for you to get access to the structures you need to get access to.

OK, let me review the code and then I'm going to propose a new patchset.

Thanks for your suggestions. :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


