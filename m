Return-Path: <linux-kernel+bounces-322821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAA972EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D13286D27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DF18C344;
	Tue, 10 Sep 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kasm.eu header.i=@kasm.eu header.b="jP5ffxvZ"
Received: from mail02.kasm.eu (46-227-67-101.static.obenetwork.net [46.227.67.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500418C039
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.227.67.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961577; cv=none; b=KL9pHtQfg6Etae4zCN890RhYGJOyMngzDS15MIjKkm+VoWxY+n5I1twRdC1d9ZWJYQXUAqzVqdK/eZW/DspkmXkJ4FI1zGSHLiNJ00PFK+0rpKuacRb+GVO584LA81a9xSYnOlxUxIfTich1z5tM6m0Q5ZXlB6Uw9ZpOVY2MLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961577; c=relaxed/simple;
	bh=yHM+G20kcIBOE7qLpoQe9ypslEsNrIca8OGLR0YB9lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjJaA5P8XV6UXPkofJlECENg2fdT9Z/SP/AiBebf15at9WaDK/0ljD/9O7IjyFh65Rc7OUQXe9mg/G42S1sAQrOrA0NMkjC29N3Rh5mFxrBZm3Jp0lHASfiNwRAWd53gWivSkXifwEGSwY9pJqTWX7szEHtn0qdJJ2yYodJuG/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kasm.eu; spf=pass smtp.mailfrom=kasm.eu; dkim=pass (1024-bit key) header.d=kasm.eu header.i=@kasm.eu header.b=jP5ffxvZ; arc=none smtp.client-ip=46.227.67.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kasm.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kasm.eu
Received: from [IPV6:2001:6b0:1:1041:b4e6:135d:cfae:1d65] (unknown [IPv6:2001:6b0:1:1041:b4e6:135d:cfae:1d65])
	by mail02.kasm.eu (Postfix) with ESMTPSA id CA24A258FC1;
	Tue, 10 Sep 2024 11:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kasm.eu; s=default;
	t=1725961149; bh=yHM+G20kcIBOE7qLpoQe9ypslEsNrIca8OGLR0YB9lo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jP5ffxvZu0Z83d4k1Hb7yaDqrDOOw3OLFL4pz2z6400ahjSsJdmZAyRSkaSbZpLXO
	 ewpwn753ohP0OucIxFgliuwhC38I3E3E/SQupMETRGUkGbWmtomm/cd6shcdb8qrlu
	 yktR5Bjdi/8LFiIi3TZ6ft8odVCMHPtUt63e1b8A=
Message-ID: <4a554ab4-b53b-485f-beef-96001100511a@kasm.eu>
Date: Tue, 10 Sep 2024 11:39:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:locking/urgent] [jump_label] de752774f3:
 kernel_BUG_at_arch/x86/kernel/jump_label.c
To: Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <202409082005.393050e2-oliver.sang@intel.com>
 <20240909091531.GA4723@noisy.programming.kicks-ass.net>
 <20240909105623.GH4928@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Klara Modin <klara@kasm.eu>
In-Reply-To: <20240909105623.GH4928@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-09-09 12:56, Peter Zijlstra wrote:
> On Mon, Sep 09, 2024 at 11:15:31AM +0200, Peter Zijlstra wrote:
>> On Sun, Sep 08, 2024 at 09:06:55PM +0800, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "kernel_BUG_at_arch/x86/kernel/jump_label.c" on:
>>>
>>> commit: de752774f38bb766941ed1bf910ba5a9f6cc6bf7 ("jump_label: Fix static_key_slow_dec() yet again")
>>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git locking/urgent
>>>
>>> in testcase: boot
>>>
>>> compiler: clang-18
>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>>
>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20240908/202409082005.393050e2-oliver.sang@intel.com
>>
>> So the whole thing actually boots and works on my real machine, so I had
>> to resort to using this qemu nonsense, as such I did as instructed in
>> the reproduce file.
>>
>> I build the thing using clang-17 (for some reason debian is shitting
>> itself trying to install clang-18 on this machine and I don't want to
>> spend the day fighting that).
>>
>> Except, once I do:
>>
>>    bin/lkp qemu -k /usr/src/linux-2.6/tmp-build/arch/x86/boot/bzImage -m /usr/src/linux-2.6/tmp-build/mod/modules.cgz job-script
>>
>> The whole thing grinds to a halt like so:
> 
> Since I'm not able to reproduce, could you please run the thing against:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent
> 
> and see what that does?
> 

I hit this bug on today's next. Reverting 
de752774f38bb766941ed1bf910ba5a9f6cc6bf7 and applying the updated 
version (6b01e5a8c11611a3dbd3d9efd915427cbce9352a) fixed it for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

