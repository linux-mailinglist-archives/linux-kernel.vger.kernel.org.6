Return-Path: <linux-kernel+bounces-358443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B6D997F77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C221AB25F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392A1EABDE;
	Thu, 10 Oct 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="j8yG8Lkk"
Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D11EABD3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545364; cv=none; b=O8pHCiLewQnJY4tjv3Xrwx8D34emzHwq4IJHciwNYVMJItfepZV2yOjb1rD7s2PtZLj0uqmXDv/Q989QCgbRU/P7sTawURhVwpIklqEyuT1fUrANVVwwYGanITwlNLmqcfGTq3PeoAgxnzgKesW5iFlToLqCiKB7zE7aYgcKmLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545364; c=relaxed/simple;
	bh=YG01dE/xnLvqxhzq1yvPegDpRLjAHw442m9JdyFpt4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMRC/xic6boGgVKAMiBHQNo5tP6MJGQDGH6m71oXOG958FOdPdBSVheC9wg7ItRusvMLDS4ZGcIWaOG1rfhePIROYd8AtdDjaIHNBN5YWwlLGuRC7O4y/C+wOQYeCXnptyb8HcHTS40TWq0cUPJw+U+h5+uGLWNtP1Y91k0BDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=j8yG8Lkk; arc=none smtp.client-ip=62.149.156.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id ynYxsm3tO7AmWynYxsLLN3; Thu, 10 Oct 2024 09:26:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1728545180; bh=YG01dE/xnLvqxhzq1yvPegDpRLjAHw442m9JdyFpt4g=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=j8yG8Lkk9dgzIZOxDpiI8MNMI3AtX8XFkCTNnZ7oeccB6WHrJMWTbsSlC4XOnFZ16
	 MgKuuxcMES9zJCcD9hSfVKajN7VY7VQT2hn9nQH4hVqcX8WgfMw4LmqQ3xVjp/pP9e
	 AC7G7GH0STi82G8o+hHA+rM+/23dZlhxpNfAPcoSBq1QoibilbtXVIbwmgH1VttHhl
	 2FagxtW2smASffH/3iBtPN5PdKb+VqoZOp+Hs9MYhw+JfRv9loSsVLXEXe2I/RW8TT
	 1K7rpXQ9XD/XHDD4kjCM9g88VTehAYtacTPXAgNvLzCT0BoMqhnAfHqW7ph8L9dcK0
	 H7Wwo1yE3VLrg==
Message-ID: <01ed8d0e-0579-419b-8a6f-1df7cb0da773@enneenne.com>
Date: Thu, 10 Oct 2024 09:26:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] Documentation pps.rst: add PPS generators documentation
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
 <20241008135033.3171915-3-giometti@enneenne.com>
 <2024100850-stunned-curve-2ba4@gregkh>
 <fcb082fd-2572-4782-b9e2-69cdbc22714d@enneenne.com>
 <2024100932-twirl-stabilize-8574@gregkh>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <2024100932-twirl-stabilize-8574@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNP9CS3i7qzHEeQ5NlHxQwvVAnw/+OvEp636GjGFKRKAyO0nsFxwCZxx1eHNXnPqG+V9Oc4bXb0H5kqS78KSOpptVThCs4ntg1dU0hTRMmjgJTk9HuNP
 ZgUoxUyKEoxyUkIzLgNKMtU+ebF0XBHgdC6j3XdWflVfZJFs/QG8DhFeY6MEFuHpN7c4BVspTAZA+mIRU19lNnT0zkss1U0qVtAXHOBDgGQ7L6q7mGcMiznr
 2stGh+Cq/r/SJ0c4FLth3RAL85SDEtXZzYPQiIqJyYrJFWJ7V3A+a9Xw8ZopuZg6ubpq0Vl3YjeFZj3soqXUx7TV5NeAIMRF37hE+OOI9WsWQ+nW94AibIUP
 WCUCbpMbo3KCNMqwjPoST7Fb8foolp/cJULpCPY5947dv0f9f6KtXOhzpMInBvXUdJ0wvaTYosk8esQ0WnaOgaSQnqztOinuSmJwyE1uJJhn/S5ZjH4vaUeL
 sVrRoxhRvzVSKuSfA/X3Ih1EzoIc/9zbXzcRtja26gcu+TRSP+SfPQFpfc1mu+Fm0OTU16LBgnyvRPo5h/z6nq1Xp49sn2v/XIhP/7iUz0vYQ3esQy1EvtPg
 U002Xkkom8lnBa55kiOVkhiGyT9d+aII2xWjrzQ6heMT129L6PL18mQT4R6xeSoKkzY9VbizyV7sYMXuNCMHR8SR

On 09/10/24 11:14, Greg KH wrote:
> On Wed, Oct 09, 2024 at 10:48:18AM +0200, Rodolfo Giometti wrote:
>> On 08/10/24 17:43, Greg KH wrote:
>>> On Tue, Oct 08, 2024 at 03:50:32PM +0200, Rodolfo Giometti wrote:
>>>> This patch adds some examples about how to register a new PPS
>>>> generator in the system, and how to manage it.
>>>>
>>>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>>>> ---
>>>>    Documentation/driver-api/pps.rst | 40 ++++++++++++++++++++++++++++++++
>>>
>>> All of this can go into the .c file and autogenerated there, no need for
>>> a separate .rst file that will quickly get out-of-date.
>>
>> I see. I'm going to add proper documentation within .c files. But since some
>> references about PPS generators are also present in this file, I think it
>> would be wise to add some notes about the new interface...
> 
> Why not just move all of the documentation into the .c files?

I see, but this is another story. :-P

At the moment I prefer to just add a note here about the new interface, and 
later we can do what you suggest.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


