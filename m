Return-Path: <linux-kernel+bounces-261847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B7793BCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4261F21D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9D16F0EC;
	Thu, 25 Jul 2024 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="c+3rQU+3"
Received: from smtpdh17-2.aruba.it (smtpdh17-2.aruba.it [62.149.155.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104716DC1E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721891299; cv=none; b=a3ob4vgR/Wjbo52RPQHDUTTwpGxD4PRg8Ap4qeh9yXXAyjXHprrZZ1qOG6HQPwJLBU/Fwrfa1qwlsABmBcHzgvl0O7noTI9LmQG0/IpsHSKXbOFJ0womteH3CKVzTDJ2yUGXbQCtsCegkXoNxc6mSjcZX9KeTHgsCFpbrcqoDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721891299; c=relaxed/simple;
	bh=bnFmeGo9PexfLFa86gvj1kTcinbxiRNGlqHQdMHDXYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAubp7a+R5FSSrUrQIdD8Pacy44Isdcs6SBa5tQu8baJITOQ1O/neuai09pFtapwVTYK8InzrKP2Zaeq6mKADb+9vSYtHCw6rAa737uD5a41jxS9j9g0V7N9z35E3JMbqI1l7nVEHVfu+Mm69iF2G7sFPR18DqpRsrfqkd0sOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=c+3rQU+3; arc=none smtp.client-ip=62.149.155.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id WsX9sQXBhJLbHWsX9scMEX; Thu, 25 Jul 2024 09:05:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1721891105; bh=bnFmeGo9PexfLFa86gvj1kTcinbxiRNGlqHQdMHDXYQ=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=c+3rQU+3x2H1cUwRd3eD5wmWujbPMRJ97LXlML4WBIEPy8TvDGWT8RKSu39ZonTYH
	 LhwAavKC8VU6/xDAH+lJm8HRBUpGZ+/9acORfO7Fw/dmdnP7mPGISZhY49xOQxrWRu
	 l11WY0YLnw9UHux808haCu8hrkWeiB37uAMRHQ6seIUFa5iXHHGO5fwiGG6qyK7zaK
	 3TTUSb97Rzbw0cmt2exAwq8xUqi4BiqWfEwCUuSi+sYTFaP5cX6RTkWF5yvfuxEPMg
	 YLSxmErrjja6OMIPIjAo9UeXYG2ILYzmh+xLLWFSBxragFLy5uYYQvXMmPXMkqclwz
	 1juSSDZ4/BEbw==
Message-ID: <c785136d-40bc-4fa3-b982-e9e4417c0b73@enneenne.com>
Date: Thu, 25 Jul 2024 09:05:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
To: "Hall, Christopher S" <christopher.s.hall@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Dong, Eddie" <eddie.dong@intel.com>,
 "N, Pandith" <pandith.n@intel.com>,
 "Mohan, Subramanian" <subramanian.mohan@intel.com>,
 "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "Zage, David" <david.zage@intel.com>
References: <20240612035359.7307-1-lakshmi.sowjanya.d@intel.com>
 <CY8PR11MB736490B761DBA045513AF078C4DD2@CY8PR11MB7364.namprd11.prod.outlook.com>
 <d463bd28-9890-47a5-97cc-14f96db2db22@enneenne.com> <87r0bvqdsz.ffs@tglx>
 <5198a2c2-49b2-4a8c-8d94-d6c9811b645b@enneenne.com>
 <PH7PR11MB6978F12032F4F3EBA83BFE10C2AA2@PH7PR11MB6978.namprd11.prod.outlook.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <PH7PR11MB6978F12032F4F3EBA83BFE10C2AA2@PH7PR11MB6978.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKkEkjY3S8yPyWjrW8W9W3VTG7lrwHFgPnjMSQ8jMc3xq+7+ZizvRw3Z++ujRmZEBbCW4nBxoyBUz0XloIP9UZQVXIUHK4GsWPWQjJ3aecK0Tr6lOiuG
 nWrkyWvSjBdb7Xf8Xx3mH1iAVdUeeMCpd39O3V4heaCDUQHDTyyCp99TroOh7T/IsyZreVG55N5XFUz5sXf474mEMdhwxYGHIVwKcRWiNM3qOaqtulxxVjrr
 BqBfZO0r3D7tKdfFQ3yK/e5hppJXsnYjphMPwv1GB31GXGH7+jzauj6jTnG1t/7l0TD9RwE3rze2Fbj3wQHKxmDKXw7zFCoj3SzoKWobU4derDKi1ief2Mpu
 5w6OZOfXlg2s2qkEgBFlKl7ivSTj7I04f2ihyaBH9p8YjxNspCe39R/gnRQlf93skC5hv1mDgCIwp9+nl8UF/3byW4Ldf3tMicEaGOxPfeAIoF4dHaNTXddx
 H11Oan5rMm1rfwK9JbmOUYE+luaJQBBR/eUlO2gNfJF8lF64T+19tduCw0yDAXoBIKQHILaBUzQChWWXX3PSDfFhDXyGCFYTXByJZWzXb7TJo7ughAB+Nmtu
 YgNYjRb1QN9UcKfiGH5GjYfX4JYjBlBDQMSZ5VjecB94xJHl7RVB/4wueUZBNoaK57AlS2LdjK7gADoOtm9WKY71

On 24/07/24 23:39, Hall, Christopher S wrote:
> Hello Rodolfo,
> 
>> From: Rodolfo Giometti <giometti@enneenne.com>
>> Sent: Monday, July 15, 2024 2:37 AM
> 
>> Subject: Re: [PATCH v10 0/3] Add support for Intel PPS Generator
>>
>> On 15/07/24 10:06, Thomas Gleixner wrote:
>>> On Thu, Jul 04 2024 at 13:50, Rodolfo Giometti wrote:
>>>> On 03/07/24 16:47, D, Lakshmi Sowjanya wrote:
>>>>>
>>>>> A gentle reminder for the review of the pps patchset.
>>>>
>>>> I already acked these patchset, didn't I? =8-o
>>>>
>>>> Please let me know if I missed something.
>>>
>>> Sorry, I missed that V10 posting. It's too late now.
>>>
>>> Rodolfo, can you pick it up after rc1 for the next merge window. All
>>> prerequisites should be in Linus tree then.
>>
>> LinuxPPS has no dedicated tree as other Linux subsystems. Usually I send my
>> "Acked" to Greg Kroah-Hartman and Andrew Morton, and they push patches
>> by
>> themselves.
> 
> Is the PPS driver on track to be included in the 6.11 release candidate?

I hope so! ^_^"

Unluckily the LinuxPPS is a minor subsystem with no dedicated tree, and 
inclusion is not under my control.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


