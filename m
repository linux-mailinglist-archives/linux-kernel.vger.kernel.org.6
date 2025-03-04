Return-Path: <linux-kernel+bounces-543130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43597A4D1D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C291171BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42818179BD;
	Tue,  4 Mar 2025 02:48:50 +0000 (UTC)
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0F13BAF1;
	Tue,  4 Mar 2025 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741056529; cv=none; b=XPz/5vN33iE7ThNeeDXHPtr29iIP/pKgo3NG+C5WGDsZ6qzv8OUzKtyoqlznJpRXMGVNFYzHgDC5MkomS4pDo8hUYYISt5tEUTsVasdD+bvYYZcO8JBXSFpyfrwPGpLL8gaFm1QRHRwMRX+BgdZ3qVRtZnIdYhBFry6UFwrYG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741056529; c=relaxed/simple;
	bh=GlGhSKtWweNbJZVAgn7q6HCo+dUeVMyy/L/JejjCF1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJL8UU++IDdEQQrkr1tysMD3FyaEhPpsKuTlw1lU21Gy5ejzLUrkS6SF/dZEJAAixufhFwIuC7nw3GR4Y8kGV3B6RJWNeIlh8PmR6tFDBIZKJz82xmNOECboepKUy/8odepDzQWxu1R2hJapqhltBHO7oLWs/1YjN3tbKhv8VeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from [10.103.133.35] (unknown[123.114.236.251])
	by rmsmtp-lg-appmail-43-12057 (RichMail) with SMTP id 2f1967c66945b21-2bde8;
	Tue, 04 Mar 2025 10:45:28 +0800 (CST)
X-RM-TRANSID:2f1967c66945b21-2bde8
Message-ID: <5a033664-4290-4327-8417-3148e4bc1704@139.com>
Date: Tue, 4 Mar 2025 10:45:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] platform/x86:lenovo-wmi-hotkey-utilities.c:Support
 for mic and audio mute LEDs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 kuurtb@gmail.com, W_Armin@gmx.de, dongeg1@lenovo.com,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250222114532.4105-1-xy-jackie@139.com>
 <174101234673.8641.771885577184828253.b4-ty@linux.intel.com>
Content-Language: en-US
From: Jackie Dong <xy-jackie@139.com>
In-Reply-To: <174101234673.8641.771885577184828253.b4-ty@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/25 22:32, Ilpo Järvinen wrote:
> On Sat, 22 Feb 2025 19:45:31 +0800, Jackie Dong wrote:
> 
>> Implement Lenovo utility data WMI calls needed to make LEDs
>> work on Ideapads that support this GUID.
>> This enables the mic and audio LEDs to be updated correctly.
>>
>> Tested on below samples.
>> ThinkBook 13X Gen4 IMH
>> ThinkBook 14 G6 ABP
>> ThinkBook 16p Gen4-21J8
>> ThinkBook 16 G8 IRL
>> ThinkBook 16 G7+ ASP
>>
>> [...]
> 
> 
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.
> 
> The list of commits applied:
> [1/1] platform/x86:lenovo-wmi-hotkey-utilities.c: Support for mic and audio mute LEDs
>        commit: 61250669eaa9fd480e0f1c3cec107924b6a06b46
> 
> --
>   i.
> 
Hi Ilpo,
   Thanks for your confirmation and help for this patch.

   Best Regards,
   Jackie Dong


