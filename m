Return-Path: <linux-kernel+bounces-533200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0AA456CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C81176CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6DC26B082;
	Wed, 26 Feb 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="Q0EIeIls"
Received: from smtpdh17-1.aruba.it (smtpdh17-1.aruba.it [62.149.155.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547A23CE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555606; cv=none; b=GyGNwdVepppqh0y1UtlxaJztdOtok/YnbvOWMObeFFApYHhKBe8UCN0G52n80xcy+UQ89kjCX4K7kFJzyvtP9nIQZhdpiEVQk+qOfjK75Zx+N3jnZLcufzCLFGMAMLIJpWGxB4UZYJc9xsnSBxRbe2/GmLKeqNqINakzIdSyEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555606; c=relaxed/simple;
	bh=z9uMgxmSd8WikcaOz4esIraMDBlBvPHGcwn1PZzUzpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPR/tX8Wa7KNHnUHJw4O3qSrMDgZ8rU9D3O8Oxj6aI9iNA1uP/JfiqbVp2D2iFZ3A5kk+/xO4uzWZ4stFovmVLrZv4Ex2uHz1r/oChQF0pKN/1yJe24wWp5LNjYG8y1EVySvZ7pVmanCSmJuO/RE7fVztMlOw21iAbHt8CzXRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=Q0EIeIls; arc=none smtp.client-ip=62.149.155.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id nByMtOGKmfFewnByMtImKO; Wed, 26 Feb 2025 08:36:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1740555410; bh=z9uMgxmSd8WikcaOz4esIraMDBlBvPHGcwn1PZzUzpU=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Q0EIeIlsEsmgJyUkG1TSPIPPwZmmrK11Ex/2Vg+7Lf2FnoOihcqWrPlBtu/Gltuft
	 6ftE7AQFNitR2em6KibWe8JPuZgT6qhndjZcMb52jxkbTMBUpAjFnCibp9DyJ0lRgQ
	 GJxkOM1d8SH2ph1tpr/zs4NkHx60ZKte/HlaYkkhVMCYUCjqR77sRsrDOti1jMFCO2
	 4y7cWkwxEoc9hCgp4k7JHGCszL492jIkdsUYEiGq7CKvIvSlKbFDuBmefzYOiI9/g1
	 efE7zMa85nU0NDHIB5ZSxHxK0ea7mpNdCjv/Rq3ApvjjOGWpDKeahrx/5Oxmwf/GIq
	 XbX8ggu7hrYQw==
Message-ID: <f6bed779-6d59-4f0f-8a59-b6312bd83b4e@enneenne.com>
Date: Wed, 26 Feb 2025 08:36:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: add epoll support
Content-Language: en-US
To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <11965b8b6101487996df902d35ba2ea3@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <11965b8b6101487996df902d35ba2ea3@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLax7mSWaQ5/v5jlFUsJbg1g+7Cs/aSCr396rhLdiOUg2HoNXtV1GHnBcHJT0vkV1ScdQKjKBOuvUIhakJTDjMoyIR8EtVJCRKM9z069foK6xzGGf4qB
 YwP3NpwaeayfGiYJd57M6xJyVTbgsq1oPiTJ4n/MNKCUnahX+jrAVUt5/1bFBOhHtQABIOFNFPPME4Dr5UR7qmG/+wbrSDWBvti2WL2ODh70InDSH+T2qzxY
 5Y3nK51HyC9VBnwrwV9fEQ==

On 25/02/25 17:34, Denis OSTERLAND-HEIM wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Rodolfo Giometti <giometti@enneenne.com>
>> Sent: Tuesday, February 25, 2025 3:24 PM
>> To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] pps: add epoll support
>>   
> [snip]
>>
>>> If I start multiple user space programs data races are visible.
>>>
>>> ```
>>> # for i in 0 1 2 3 4 5 6; do PpsPollTest /dev/pps1 > log$i & done
>>> # sleep 6
>>> # tail log*
>>> ==> log0 <==
>>> timeout
>>> assert: 196
>>> time: 1520599554.276752928
>>> assert: 197
>>> time: 1520599555.300692704
>>
>> This is the same behavior we have when working with a serial port: if more than
>> one process gets access to it, data is stolen.
> Okay, then lets choose your suggestion.
> 
>>
>>> >From my point of view it would be great to fix this bug without such an limitation.
>>
>> I disagree, it is not a limitation! It is like a normal char device work.
>>
>> What we have to test now is if your initial goal has been addressed! That is, in
>> an application that has more to do than just dealing with one PPS device, we can
>> use poll()/select() in order to avoid using threads.
> I will do the final test.

Try poll() by using a process workin on multiple pps sources.

> I expect that it works with your patch.

:)

> Shall I prepare the patch?

Yes.

> Shall I add you as Co-author?

Yes. Add my name in the Signed-off-by: line and, please, send to me a preview.

> Or do you want to send your patch with me in reported-by and tested-by?
> 
> Fixes: eae9d2ba0cfc ("LinuxPPS: core support")?

OK.

> CC stable?

     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     Andrew Morton <akpm@linux-foundation.org>

And explain the goal of the patch within the description.

Thanks a lot!

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


