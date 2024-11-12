Return-Path: <linux-kernel+bounces-405263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DEE9C4F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34111F215FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8920A5D9;
	Tue, 12 Nov 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="cQhDfvj+"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259284C66;
	Tue, 12 Nov 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731395758; cv=none; b=SkiLS4JxYr3Ekt1jGQnXDv18ryRmNkougZP1o6kw2YNlvvrhsfNdPbqwRjdqc/f5+1kd/WbL03BCXAusGwncZdrc1NrlHZywKo7uHzV/9O2p4Q+7WZgxMFp1pZKDkWMce7ybBT42cdxf/Q0waXLDCoFzl9P8gbSSVbbaeV585pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731395758; c=relaxed/simple;
	bh=liliEvd9ddHo2X14IIvSZ1Kn2E1WmCo2dfpJ2tBnXXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRVNqAzsK6JgtQKMklBWC1Keik9O7jfj7+J/eInd9wgoRjLHxgjUHaIWhJRcjHJODDO/tJvQCfgnxZreZ4HkFHAiEnHxJDMvRmXV3q3X6lznZqRK1mxbvGJpQ1uU87+3nMjlrFSbo7Tc8vTF5xq4WVKjtXEk0mumZ5XqZ1GZnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=cQhDfvj+; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.106.0.15] (unknown [103.155.100.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AFA8B3F136;
	Tue, 12 Nov 2024 07:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731395752;
	bh=zLx7YEby17Ysu5FXkGYZBmRyjc793eGzAB0RXrS6JJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=cQhDfvj+QH1Xp3HFKyLefv6GUEyQIWuSZ/81Q74Ms4rNarHcaRfM9vBim2kpJTQUh
	 CY9HJXS9asGRlc/DWWWcv4K7jr6wR8L9zwGw+MYI4drinIS82jkm8VfGXzeAXStvCX
	 A6qTUsVX94gPIuACe2LIC0ZvkntMWKFcHOTwl2ULogSsAQl3OIYpY1L6l5Y1xfL+wm
	 8fiYCZvU5SxMz4FZFI7Um94rCjCr7zq7hBadKB3rPNA7y+1nN00Qm4DV2zIAwo3n+k
	 xa2vzAlwCsUFiGh3Db9VFIvA/ND9GSfQy+DDmE03f3DRw3k3bO2EokSVeYC9z4gIPm
	 Z4Q4+fZLNcQPg==
Message-ID: <53ed1dd8-2949-4f05-a180-39c12fbe2597@canonical.com>
Date: Tue, 12 Nov 2024 15:15:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO
 operation APIs
To: "Xu, Even" <even.xu@intel.com>
Cc: "bentiss@kernel.org" <bentiss@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "jikos@kernel.org" <jikos@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Zhang, Rui1" <rui1.zhang@intel.com>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "Sun, Xinpeng" <xinpeng.sun@intel.com>
References: <20241024081023.1468951-5-even.xu@intel.com>
 <da650a93-6d21-444b-adb7-045566f53d5a@canonical.com>
 <IA1PR11MB6098D581A332E576528FD30DF4582@IA1PR11MB6098.namprd11.prod.outlook.com>
 <1a8f80ab-135e-4e57-b9b7-1940e4bfb4f3@canonical.com>
 <IA1PR11MB6098DE17D19343A9C077F248F4582@IA1PR11MB6098.namprd11.prod.outlook.com>
Content-Language: en-US
From: Aaron Ma <aaron.ma@canonical.com>
In-Reply-To: <IA1PR11MB6098DE17D19343A9C077F248F4582@IA1PR11MB6098.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Even,

After tested on 8086:a848, the multitouch doesn't work like 4 finger 
touch, rotation and zoom.

Could help check if those features can be supported?

Regards,
Aaron


On 11/11/24 3:10 PM, Xu, Even wrote:
> Hi, Aaron,
>
> That's OK. Glad to know it works.
> Thanks for testing!
>
> Best Regards,
> Even Xu
>
>> -----Original Message-----
>> From: Aaron Ma <aaron.ma@canonical.com>
>> Sent: Monday, November 11, 2024 3:08 PM
>> To: Xu, Even <even.xu@intel.com>
>> Cc: bentiss@kernel.org; corbet@lwn.net; jikos@kernel.org; linux-
>> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Rui1
>> <rui1.zhang@intel.com>; srinivas.pandruvada@linux.intel.com; Sun, Xinpeng
>> <xinpeng.sun@intel.com>
>> Subject: Re: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC PIO operation
>> APIs
>>
>> Hi Even,
>>
>> Sorry, my fault.
>>
>> The patchset is applied on 6.12-rc7.
>> Building, will let you know the test result.
>>
>> Thanks.
>> Aaron
>>
>> On 11/11/24 2:31 PM, Xu, Even wrote:
>>> Hi, Aaron,
>>>
>>> Thanks for the information.
>>> The file "intel-thc-hw.h" should be there, it was added by "[PATCH v1 03/22]
>> HID: intel-thc-hid: intel-thc: Add THC registers definition".
>>> I tested it on v6.11.
>>> Anyway, let me double check what's wrong and come back to you.
>>> Thanks!
>>>
>>> Best Regards,
>>> Even Xu
>>>
>>>> -----Original Message-----
>>>> From: Aaron Ma <aaron.ma@canonical.com>
>>>> Sent: Monday, November 11, 2024 2:19 PM
>>>> To: Xu, Even <even.xu@intel.com>
>>>> Cc: bentiss@kernel.org; corbet@lwn.net; jikos@kernel.org; linux-
>>>> doc@vger.kernel.org; linux-input@vger.kernel.or;
>>>> linux-kernel@vger.kernel.org; Zhang, Rui1 <rui1.zhang@intel.com>;
>>>> srinivas.pandruvada@linux.intel.com; Sun, Xinpeng
>>>> <xinpeng.sun@intel.com>
>>>> Subject: Re: [PATCH v1 04/22] HID: intel-thc-hid: intel-thc: Add THC
>>>> PIO operation APIs
>>>>
>>>> Hi Even,
>>>>
>>>> It fails to be applied on v6.12-rc7.
>>>>
>>>> There is no file intel-thc-hw.h.
>>>>
>>>> Regards,
>>>> Aaron


