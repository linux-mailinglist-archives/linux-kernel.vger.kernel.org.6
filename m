Return-Path: <linux-kernel+bounces-358725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCFF9982DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E84D281D96
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB81BD039;
	Thu, 10 Oct 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="fl0RUeSP"
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8A1BC092
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554032; cv=none; b=SgWMSYyeFIpcYcCq+S4+kxv4GYxLiN6wj+ajVrmf72EAP5ISTmbNS9KvPKa2zT541WurVo/QkLJVJgXtDskRkEuc6UIfz4We8sqzs8mOiJzStmdOLEMKYBEwfju3rKocGnUH/JfC8BQ0jDisBjw3SLs0CuPIGEizVcI6HFTZNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554032; c=relaxed/simple;
	bh=gkluOhCEVP/sbivB9JIfnCAkFGmMUsQJbIZF6GonPuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHyPMyPKtNJ6VRYEspHa3N0hbto2DrSsyGQiMtxt16ndlvicS9dfIWGmKxglFlRViVcHRiagUYhtXYQa4IH5IAFSNKpK81I41Pjf2hFidCb/bpILwaZXR8X9g1Le8xOS9gBk+rRK3X2OZOEOSalzMh5FOLqutFaobccTXaMaY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=fl0RUeSP; arc=none smtp.client-ip=62.149.156.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id yprcso0rw7AmWyprcsMf1B; Thu, 10 Oct 2024 11:53:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728554026; bh=gkluOhCEVP/sbivB9JIfnCAkFGmMUsQJbIZF6GonPuo=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=fl0RUeSPXQk9bhSiE+AKV8EvKT804iq8hc1cmg/MBru9a300q4st0Gqu/K80P0wIL
	 axZf9TE3H+VU+Y9Ao7Lh+lQCRZ3DEtnK3SCdBQOA4ShSH/HhKHXU0kO98bcCSQ0/0v
	 y6hhJM+tkqMJnHna5gjO3ouUXZVv/731ijDGbo5LIZao3YbPwIoiITYnI9DrI04Y2a
	 QFS/CpBJY2dtbEZIqFspwCMrPgoiT5/dmTm1vil+Hn+8N1pNhSJueiR0V4aeuuBODB
	 cJ6pVVqT7q4VD3PttfYL/fBzwvj2tVqio5j154OQJAcTr7+Rg6H9YspiB8du3OwnF3
	 ICjkw1paZxPTw==
Message-ID: <253ff116-6ead-42f1-a3a7-0d627ac90b5e@enneenne.com>
Date: Thu, 10 Oct 2024 11:53:44 +0200
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
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <2024101002-viscous-egomaniac-04d3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDG0EGOzieghxLLlgbucQc5oI/bLMrAZN9K9ngTyvhwA6tMQ2wcyaH+s5/kly3Z403QJVrIuy/LuUuVL99j579Cs+11aMIdVg+7FNpeCygMiD2qm4s7o
 i0tu8Esuj4lf9Q+tUGAYTvCK84kmOCIDDe5Y4Ml5S7AhnYRgmMLQ0kLZjGr6JwQqhmynJE3riChRdcBacib+fZpSjSCmFca1y166xUaS4e/ENGv1MzcjOIqk
 PKJW9/lBpEuwPtF/+VKIiWarWWZi+n1rEI7+228tMbeSb17k33Xl+tRr/403+hGmo3V5m434WFjcVa6IbslxakmpdrmYWhkHAnmwgx2Iga9DuqoRAqdmUCM4
 OoRugYyHu0oqP/MS5KKzPooECsVwhvYcEe2RoLUz+3xwj1aWcmCB6/aCb48o+YATAA+P/Q0vcV7KRb02lyhkl95P6v2EBL/HeZ8FfPs9rmQD+T3RfFCO8nfv
 31+C8N9w98H4QLBsdq3g3t7IAmQXz1uIWTjNWFx43pJ1v2BuBa0uyixX+jlQ+uZcOq7SvyoEHYX6DdbCSi2vof3f9cTmPQfftxXziMeVOw06Ir3kq1IDApi5
 PS0S+Tv/8VmiF0Jsghu3QECogv4LPfJY4/jsKa9VUSE7S7woTNEizmls2lrncfSL4l/S8iQYhkOcGwVuYfE3g0+x

On 10/10/24 09:54, Greg KH wrote:
> On Thu, Oct 10, 2024 at 09:32:22AM +0200, Rodolfo Giometti wrote:
>> On 10/10/24 09:15, Greg KH wrote:
>>> On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
>>>>>> +#ifdef CONFIG_COMPAT
>>>>>> +static long pps_gen_cdev_compat_ioctl(struct file *file,
>>>>>> +		unsigned int cmd, unsigned long arg)
>>>>>> +{
>>>>>> +	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
>>>>>> +	return pps_gen_cdev_ioctl(file, cmd, arg);
>>>>>> +}
>>>>>> +#else
>>>>>> +#define pps_gen_cdev_compat_ioctl	NULL
>>>>>> +#endif
>>>>>> +
>>>>>> +static struct pps_gen_device *pps_gen_idr_get(unsigned long id)
>>>>>> +{
>>>>>> +	struct pps_gen_device *pps_gen;
>>>>>> +
>>>>>> +	mutex_lock(&pps_gen_idr_lock);
>>>>>> +	pps_gen = idr_find(&pps_gen_idr, id);
>>>>>> +	if (pps_gen)
>>>>>> +		kobject_get(&pps_gen->dev->kobj);
>>>>>> +
>>>>>> +	mutex_unlock(&pps_gen_idr_lock);
>>>>>
>>>>> Doesn't an idr have a lock in it?  I can never remember...
>>>>
>>>> As far as I know we must use a mutex...
>>>
>>> If you do, someone will come along and remove it, please see:
>>> 	https://lore.kernel.org/r/b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr
>>> as an example (with links that show it is not needed).
>>
>> Here is an example about ida API, but I'm using idr API.
> 
> Why not use ida then?  :)

Because we need an ID associated with a pointer.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


