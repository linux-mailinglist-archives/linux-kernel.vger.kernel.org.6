Return-Path: <linux-kernel+bounces-358445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24C997F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B621F24FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB671CEEB9;
	Thu, 10 Oct 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="ZVc4xgbP"
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A529AF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545547; cv=none; b=vFD5sAVqeZCiCsSEwlygGFPtEAaEEGzemNSiuC4TkoZU6uf6Hf9NfoyAYwck7TqmZCyPFfv2GSU6B0K7ovrff2lXhCSdn8D7ex2OBWh5uX6EdX8L04cl6Y4CDIOQJaXecqx2JRsYNp7whSiy7eK4FcYvZ3eJ3/f+tG0crA3aZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545547; c=relaxed/simple;
	bh=KPNml1L+XHqiySHOFCtAH//tJ60Ngm2xZh/2sZMiPeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqJHZg6gjQ1S2eOCl7bHQd9wJjBJWb7WF3XCxdyZR0yUSMl/WBBz9Sy3NVs+QjV/PupGAx9qooj6BmJXv4hfAUzpyX9job4COUIPfhcbczOoa6fui9Du/CP9w1CJcXwc9qUOLA1j0rqvpZIPJ/+Q1O2OEKON33WCECTrYnDWlkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=ZVc4xgbP; arc=none smtp.client-ip=62.149.156.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id yneosmA3R7AmWyneosLPzT; Thu, 10 Oct 2024 09:32:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728545544; bh=KPNml1L+XHqiySHOFCtAH//tJ60Ngm2xZh/2sZMiPeA=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=ZVc4xgbP2ttGhNU80RPUilGgLQccqeSeNZzauwdFdd6IXADgx0UaHBixfFgi4mGUb
	 gnspM69bXmT74qJDIqMqwxYRH6kRv2Mspb2GWwQkNo7mCMhfY4HyAdBiQAyrKCyoV5
	 nIs3MzbtKQDekj3kfHobAJrmgtk6ecNmlcYFKV5Xwcf1AmkmmgyaP9Ao8PJXgffV45
	 rEU5ZWYOXGq/HU14jqROIY/16C9UOJ45mXm6mJJ8Qkaq2yMIgHw7lvKw22+szI0Dfa
	 v+7QM9KoIScrSMLyQG873NaxKkQcQErAGjiVXifg7h0TtzJYUNbydaFVl5ri+vJOkS
	 3KNvzd1uHXl5A==
Message-ID: <d42b0c9f-086e-4c07-a2ab-8f3b0d6ab580@enneenne.com>
Date: Thu, 10 Oct 2024 09:32:22 +0200
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
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <2024101013-reputably-skid-9e01@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOPkyaVC6LqebjicwZrioxjyNpUJfBqudK6X/7WNq+3/CJ0Gecp35wbwSgBddN4Dgf0Er7Ci8Pa+iknawuPdzmabrvnOVitoEBee/99C/ow1mIg6WfK+
 kjkXRmbGDNeEMCVr3+Q6out7Mr/+6gGGgy0X9V5HOq9JZrqD4vOWtdadhyndrb7Ynj+QuFIPjKINl7IyzbLvPXn44X0kxjyXfDbAsJ9yXFZU1FLnsd9rycIX
 KdCCx43qUhj7sF71T4Tgf/ZvD8C6qVZvsnNUIRHYEYuu6/is4sgnZF5o7q1T30CSd2l3x5iyXrl6xkNPtj0/89qBLrqiXFQnHo2OmsYzJ9kk7Idb+35AfKY9
 /pmsnGbIueCz9aol+Tajw8gLqc7Hgd6awf4UVLs+4+2Jy6ysRoGj0vLB32D5yh6ppfwd/62KcFkN8PGMTTQWocoXBQB81RSbYO0ptNb/qHSMp799PXd5UpNg
 CxUJv3y0GRyfJwir/xIqnZWZSp8yg+JWYJQJvFDlxlGS8JjZ2IeAZvYKXedNtDyABBNLFAUPLKlQgoAPEakBkCi4j27djPj5ZrrL/JAAdVDfeZoY7jYg3c45
 /ZSNOeRMRru9PiqZSPqzjP3v/JBSbl+eLe+T8RUXr3jhKFK+U+1//+7rH2OBig/MMKECKoiT3x6F5bttvtA8Fhoj

On 10/10/24 09:15, Greg KH wrote:
> On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
>>>> +#ifdef CONFIG_COMPAT
>>>> +static long pps_gen_cdev_compat_ioctl(struct file *file,
>>>> +		unsigned int cmd, unsigned long arg)
>>>> +{
>>>> +	cmd = _IOC(_IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), sizeof(void *));
>>>> +	return pps_gen_cdev_ioctl(file, cmd, arg);
>>>> +}
>>>> +#else
>>>> +#define pps_gen_cdev_compat_ioctl	NULL
>>>> +#endif
>>>> +
>>>> +static struct pps_gen_device *pps_gen_idr_get(unsigned long id)
>>>> +{
>>>> +	struct pps_gen_device *pps_gen;
>>>> +
>>>> +	mutex_lock(&pps_gen_idr_lock);
>>>> +	pps_gen = idr_find(&pps_gen_idr, id);
>>>> +	if (pps_gen)
>>>> +		kobject_get(&pps_gen->dev->kobj);
>>>> +
>>>> +	mutex_unlock(&pps_gen_idr_lock);
>>>
>>> Doesn't an idr have a lock in it?  I can never remember...
>>
>> As far as I know we must use a mutex...
> 
> If you do, someone will come along and remove it, please see:
> 	https://lore.kernel.org/r/b1fcc6707ec2b6309d50060fa52ccc2c892afde2.1728507153.git.christophe.jaillet@wanadoo.fr
> as an example (with links that show it is not needed).

Here is an example about ida API, but I'm using idr API.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


