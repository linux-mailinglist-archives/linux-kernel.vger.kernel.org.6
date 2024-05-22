Return-Path: <linux-kernel+bounces-185827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9EA8CBB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94C31C2164A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27179B84;
	Wed, 22 May 2024 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="07PPa+uj"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7F74E3D;
	Wed, 22 May 2024 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360813; cv=none; b=sYhT41268BMXTp6JJ+XP8/0BzFSjENb8DhhojMq/50BcZxlI7sPqxcZ3rBW7fSnxEIpKMvaT/qryyb+k1BPotgNwdR6ZJ3zyREB5NbhhAcw3MjR0AsIIxUmahFePlxspnp4C4Ld5k1tm6GPg4TAk9vXg+VpfmQk5+T1CzmIU0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360813; c=relaxed/simple;
	bh=0mAkOOhMcbnebMfj3VoT6zoaOWdTvUepTjv2NCjvS8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+12mBVH6hbR+/Vtnf+o97DLfkM4sjC38cWkiEdhsRxvRANLqc09aaOihb/rvYVxRLC8kHFiRTTkfcPpEGl4qbXZ4K9KVL0XchMv54K53Yf/gv+HGQf983VVoQ4N9ghjppDxMnJK9rjC1pbJK3Cif2n6XtgiQO280i4tGiXs2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=07PPa+uj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=wCsD+31ajuIXtxvWN+GeqHb82CwWDjQT/JUQKKBx8cc=;
	t=1716360811; x=1716792811; b=07PPa+ujrpvD6UaYCylsz8vC/xdLUMQjLuVopZkB5hEqOgn
	XHiDqMzUz+nlVJcuNaSGP1NAPBPJc8HfrVPcrO6ZLEWNi8JGK8Lx97/4f6rEXoWzbAgF91Y6+Ssiq
	Gyt3t2EKaNWiowdWYkq68X75eAbX0CZQunn3npGv4MjC5EmmojfFdbh79NuwYnudqbFUwOduUwFV2
	k5qzSbCN4es2XM/X/KpmxOSsq1l3dc4SYeo1gyzOm8DM4vl+1WhWuHhQelM84dnp4lQXeL9pPwuVU
	+/DOfhgjywGD6tT1Mda5Yl+c1oA188CuLcIX3uSnuG39rOt6lom9O6PuYjJnH/CA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s9fqh-0008O2-FW; Wed, 22 May 2024 08:53:19 +0200
Message-ID: <44151fe7-1822-4b95-8981-9a1f1884d662@leemhuis.info>
Date: Wed, 22 May 2024 08:53:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev
 entries
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
 Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com,
 sboyd@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk>
 <7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net>
 <ZkfYqj+OcAxd9O2t@shell.armlinux.org.uk>
 <4ea9cc83-c7ca-47b8-8d43-dab16193108f@roeck-us.net>
 <ZkfqKMqkUc/Sr7U2@shell.armlinux.org.uk>
 <646bd149-f29a-4c91-ab00-4f6d2fce23fd@roeck-us.net>
 <ZkhSOvkaAwsTe7Dm@shell.armlinux.org.uk>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <ZkhSOvkaAwsTe7Dm@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716360811;6e228e67;
X-HE-SMSGID: 1s9fqh-0008O2-FW

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 18.05.24 09:01, Russell King (Oracle) wrote:
> On Fri, May 17, 2024 at 08:24:19PM -0700, Guenter Roeck wrote:
>> On 5/17/24 16:37, Russell King (Oracle) wrote:
>>> On Fri, May 17, 2024 at 04:34:06PM -0700, Guenter Roeck wrote:
>>>> On 5/17/24 15:22, Russell King (Oracle) wrote:
>>>>> On Fri, May 17, 2024 at 03:09:12PM -0700, Guenter Roeck wrote:
>>>>>> On Fri, Mar 15, 2024 at 11:47:55AM +0000, Russell King (Oracle) wrote:
>>>>>>> Report an error when an attempt to register a clkdev entry results in a
>>>>>>> truncated string so the problem can be easily spotted.
>>>>>>>
>>>>>>> Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
>>>>>>> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>>>>>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>>>>>
>>>>>> With this patch in the mainline kernel, I get
>>>>>>
>>>>>> 10000000.clock-controller:corepll: device ID is greater than 24
>>>>>> sifive-clk-prci 10000000.clock-controller: Failed to register clkdev for corepll: -12
>>>>>> sifive-clk-prci 10000000.clock-controller: could not register clocks: -12
>>>>>> sifive-clk-prci 10000000.clock-controller: probe with driver sifive-clk-prci failed with error -12
>>>>>> ...
>>>>>> platform 10060000.gpio: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>>>> platform 10010000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>>>> platform 10011000.serial: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>>>> platform 10040000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>>>> platform 10050000.spi: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>>>> platform 10090000.ethernet: deferred probe pending: platform: supplier 10000000.clock-controller not ready
>>>>>>
>>>>>> when trying to boot sifive_u in qemu.
>>>>>>
>>>>>> Apparently, "10000000.clock-controller" is too long. Any suggestion on
>>>>>> how to solve the problem ? I guess using dev_name(dev) as dev_id parameter
>>>>>> for clk_hw_register_clkdev() is not or no longer a good idea.
>>>>>> What else should be used instead ?
>>>>>
>>>>> It was *never* a good idea. clkdev uses a fixed buffer size of 20
>>>>> characters including the NUL character, and "10000000.clock-controller"
>>>>> would have been silently truncated to "10000000.clock-cont", and thus
>>>>>
>>>>>                           if (!dev_id || strcmp(p->dev_id, dev_id))
>>>>>
>>>>> would never have matched.
>>>>>
>>>>> We need to think about (a) whether your use of clk_hw_register_clkdev()
>>>>> is still appropriate, and (b) whether we need to increase the size of
>>>>> the strings.
>>>>
>>>> It isn't _my_ use, really. I only run a variety of boot tests with qemu.
>>>> I expect we'll see reports from others trying to boot the mainline kernel
>>>> on real sifive_u hardware or other hardware using the same driver or other
>>>> drivers using dev_name() as dev_id parameter. Coccinelle finds the
>>>> following callers:
>>>
>>> Using dev_name() is not an issue. It's when dev_name() exceeds 19
>>> characters that it becomes an issue (and always has been an issue
>>> due to the truncation.) clk_get(dev, ...) uses dev_name(dev) to match
>>> against its entry in the table.
>>>
>>> As I say, dev_name() itself is not an issue. The length used for the
>>> name is.
>>>
>>
>> Maybe, but the existence of best_dev_name() suggests that this has been seen
>> before and that, as you mentioned, it is not a good idea. Anyway, the patch
>> below fixes the problem for me. I don't know if it is acceptable / correct,
>> so it might serve as guidance for others when fixing the problem for real.
> 
> I get the impression that there's a communication problem here, so I'm
> not going to continue replying. Thanks.

Hmmm. Communication problem aside, this in the end seems to be a
regression that is caused by a change of yours. Maybe not a major one
that is making a fuzz about, but still one that would be good to get
fixed. So who will take care of that? Alternatively:

Guenter, I assume we could simply fix this by reverting the culprit if
Linus wanted to?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

