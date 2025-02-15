Return-Path: <linux-kernel+bounces-515979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB735A36B84
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398F61891E97
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95690156C7B;
	Sat, 15 Feb 2025 02:57:12 +0000 (UTC)
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3EEACE;
	Sat, 15 Feb 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739588232; cv=none; b=uhkSuAvI4TCOSkSbPxFxSavhcxqz3p8DkS8Lyg2JgdyPjhXrc3p6oKT60LnP4DVQipg/ZIlzi5ghU9HPSFfVenE7EiCSFMe9kZa1M2VjyAMNBmC/cbZW0U53B6fsgRSb3i7ie3s7b3XGWNMcioeJNgCHtrOUUTIMjWV8FLcZBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739588232; c=relaxed/simple;
	bh=EoTZuuJoPyVxMsuTCokuFc8buEwD/kVAsKGwm9OUyo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDv4dYOG8UWU3s9Jpq6IYx8StVRom3QqbI+7GTJPkcjI7NS9BBzHBFVDY0x8Eb8BMS4nThJEZwnfVvsr/PXz5ene2BBb14CMjvYGsiyxJB+Tap6UIRiT3XOLBeM4c9Ft2xtPlnQgQCi9sqBuhcbDJFUVd4ZMJFPO8fPi3LNjPHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from [IPV6:2409:8a00:7877:4fa0:2422:9311:83f6:4833] (unknown[2409:8A00:7877:4FA0:2422:9311:83F6:4833])
	by rmsmtp-lg-appmail-30-12044 (RichMail) with SMTP id 2f0c67b0027d029-677ac;
	Sat, 15 Feb 2025 10:57:04 +0800 (CST)
X-RM-TRANSID:2f0c67b0027d029-677ac
Message-ID: <fe5b927d-92dd-4728-81c8-1b022d5ed5ab@139.com>
Date: Sat, 15 Feb 2025 10:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] platform/x86:lenovo-wmi-hotkey-utilities
To: Kurt Borja <kuurtb@gmail.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 W_Armin@gmx.de, dongeg1@lenovo.com, Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20250214154033.5483-1-xy-jackie@139.com>
 <D7SBOZQ502TY.1FO1QG2GHPM6W@gmail.com>
Content-Language: en-US
From: Jackie Dong <xy-jackie@139.com>
In-Reply-To: <D7SBOZQ502TY.1FO1QG2GHPM6W@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/25 00:52, Kurt Borja wrote:
> On Fri Feb 14, 2025 at 10:40 AM -05, Jackie Dong wrote:
>> Tested on below samples.
>> ThinkBook 13X Gen4 IMH
>> ThinkBook 14 G6 ABP
>> ThinkBook 16p Gen4-21J8
>> ThinkBook 16 G8 IRL
>> ThinkBook 16 G7+ ASP
> 
> Part of the commit message is missing from the previous version. The
> short commit message is also missing
> 
> ": Support for mic and audio mute LEDs"
> 
> Also, the MAINTAINERS entry is still missing.
> 
Hi Kurt,
For me, it's first new a driver file in Linux kernel based on my limited 
Linux kernel development knowledge. I am willing to improve it after I 
get kernel maintainers' comments and suggestions.
Sorry to trouble you again and again.
I have updated the patch based on your comments and sent it as v8.
Pls review it, again.
Many thanks,

Jackie Dong


