Return-Path: <linux-kernel+bounces-399567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6809C00E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D411C2117D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734F1DF990;
	Thu,  7 Nov 2024 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jb7Em/BW"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5FF19CC36;
	Thu,  7 Nov 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970649; cv=none; b=sYzV1OzOHUp+v87LmXCZqVgq1yPIq8dHuqeL7W0tw4rpN+9MrSNu+ThgH/FYV68G6DQouNNNlN+amJKoPjnrCVSdc1GHhBm/jduQnHua4yTeRzTXkpFE5sXbCtgZjuKnn1QFFTxsaF7Hj6b/IgvWkO/mFS5II6xawdocK3Hbwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970649; c=relaxed/simple;
	bh=XFbXvqD/jQw/+iOBT3KvNI1VPhFdHlmpiR2+WzKl1ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjxoAdDAOO6BzPVr8OkS1L21EVEOfMzlF+i3Z3ghyrrWjdQ81EP51ec4xAv3npdSYvE1J59LNv5jwLn+5DtzaBQXXT4y2HD9g4p7zIs25XOBngnhpTw5JuofKkz8taNtqU1P9O+jCDpuZp/9iWC6KyyRcVZmdvTedliMHNNHPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jb7Em/BW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=cl5PL/KuYw8ZhPK6A/ezmssuClpkjogZlBtDO8rhwuQ=; t=1730970646;
	x=1731402646; b=jb7Em/BWiNrKHc7SW6Dk7kg48FbHo3nL94QFzWbU83Bd0sEhjR1iCyVMAaKcj
	5qQhdadzj5/noFTuF/FnbhJ/B8mXgqGXV8Shf6qDMe+lAyrtg1poFdEtfXu4TL4RPUHxGQJdQYmG9
	Ktj8B82OnXVyp845QxZtEV8ol/QW4KSy/6hG2LD44Q/rov74K4q5tphEFbKc+BcoJWuLTOFJ7BJt0
	UXYzxN/bwXvz/o4NSlAC0RHteFk8YTUONZp9zTvKOF0cxunsbu9aDm5w+yUNvdqBDwWzou85KJD++
	1WRgHGTeNQiNAxFpUbUSTeg9tO+F4dhys+hEr03vHpHswrLIpg==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t8yXG-00058N-HI; Thu, 07 Nov 2024 10:10:38 +0100
Message-ID: <937c258b-f34c-4f63-949d-a5e7c8db714d@leemhuis.info>
Date: Thu, 7 Nov 2024 10:10:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] wifi problems since tg3 started throwing rcu stall
 warnings
To: Mingcong Bai <jeffbai@aosc.io>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>, sakiiily@aosc.io
References: <b8da4aec-4cca-4eb0-ba87-5f8641aa2ca9@leemhuis.info>
 <ZxjLQzHKuR-w16hF@pavilion.home>
 <2b25a988-6965-48e4-a788-58dd8a776e06@leemhuis.info>
 <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-MW
In-Reply-To: <e2ffd3d06fad236ea900d4fb439b2240@aosc.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1730970646;d18e9836;
X-HE-SMSGID: 1t8yXG-00058N-HI

On 05.11.24 08:17, Mingcong Bai wrote:
> (CC-ing the laptop's owner so that she might help with further testing...)
> 在 2024-10-23 18:22，Linux regression tracking (Thorsten Leemhuis) 写道：
>> On 23.10.24 12:09, Frederic Weisbecker wrote:
>>> Le Wed, Oct 23, 2024 at 10:27:18AM +0200, Linux regression tracking
>>> (Thorsten Leemhuis) a écrit :
>>>>
>>>> Frederic, I noticed a report about a regression in bugzilla.kernel.org
>>>> that appears to be caused by the following change of yours:
>>>> 55d4669ef1b768 ("rcu: Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU
>>>> invocation")
>>> Are you sure about the commit? Below it says:
>> Not totally, but...
>>
>>>> As many (most?) kernel developers don't keep an eye on the bug tracker,
>>>> I decided to write this mail. To quote from
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=219390:
>>>>
>>>>>  Mingcong Bai 2024-10-15 13:32:35 UTC
>>>>> Since aa162aa4aa383a0a714b1c36e8fcc77612ddd1a2 between v6.10.4 and
>>> Now that's aa162aa4aa383a0a714b1c36e8fcc77612ddd1a2 which I can't
>>> find in vanilla
>>> tree.
>> ...quite, as that is the commit-id of the backport to v6.10.5; and the
>> reporter reverted it there. Ideally of course that would have happened
>> on recent mainline. If you doubt, ask Mingcong Bai to check if a revert
>> there helps, too.
> Do we need any further information/testing on this issue? Please let me
> know if there's anything we can do as the issue still persists in 6.12.

Hmm, no reply from Frederic. Not sure why, maybe he is just away from
the keyboard for a few days. But if the reporter has a minute, it might
be wise to check if reverting that commit on top of 6.12-rc6 or newer
also fixes the problem, to rule out any interference from changes
specific to the stable series.

Ciao, Thorsten

>>> Also I'm failing to see an immediate issue between the below stacktrace
>>> and the above commit. So are we sure about that reference?
>>>
>>> Thanks.
>>>
>>>
>>>>> v6.10.5, the Broadcom Tigon3 Ethernet interface (tg3) found on Apple
>>>>> MacBook Pro (15'', Mid 2010) would throw many rcu stall errors during
>>>>> boot up, causing peripherals such as the wireless card to misbehave:
>>>>>
>>>>> [   24.153855] rcu: INFO: rcu_preempt detected expedited stalls on
>>>>> CPUs/tasks: { 2-.... } 21 jiffies s: 973 root: 0x4/.
>>>>> [   24.166938] rcu: blocking rcu_node structures (internal RCU debug):
>>>>> [   24.177800] Sending NMI from CPU 3 to CPUs 2:
>>>>> [   24.183113] NMI backtrace for cpu 2
>>>>> [   24.183119] CPU: 2 PID: 1049 Comm: NetworkManager Not tainted
>>>>> 6.10.5-aosc-main #1
>>>>> [   24.183123] Hardware name: Apple Inc. MacBookPro6,2/Mac-
>>>>> F22586C8, BIOS    MBP61.88Z.005D.B00.1804100943 04/10/18
>>>>> [   24.183125] RIP: 0010:__this_module+0x2d3d1/0x4f310 [tg3]
>>>>> [   24.183135] Code: c3 cc cc cc cc 0f 1f 40 00 90 90 90 90 90 90
>>>>> 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 89 f6 48
>>>>> 03 77 30 8b 06 <31> f6 31 ff c3 cc cc cc cc 66 0f 1f 44 00 00 90 90
>>>>> 90 90 90 90 90
>>>>> [   24.183138] RSP: 0018:ffffbf1a011d75e8 EFLAGS: 00000082
>>>>> [   24.183141] RAX: 0000000000000000 RBX: ffffa04ec78f8a00 RCX:
>>>>> 0000000000000000
>>>>> [   24.183143] RDX: 0000000000000000 RSI: ffffbf1a00fb007c RDI:
>>>>> ffffa04ec78f8a00
>>>>> [   24.183145] RBP: 0000000000000b50 R08: 0000000000000000 R09:
>>>>> 0000000000000000
>>>>> [   24.183147] R10: 0000000000000000 R11: 0000000000000000 R12:
>>>>> 0000000000000216
>>>>> [   24.183148] R13: ffffbf1a011d7624 R14: ffffa04ec78f8a08 R15:
>>>>> ffffa04ec78f8b40
>>>>> [   24.183151] FS:  00007f4c524b2140(0000)
>>>>> GS:ffffa05007d00000(0000) knlGS:0000000000000000
>>>>> [   24.183153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [   24.183155] CR2: 00007f7025eae3e8 CR3: 00000001040f8000 CR4:
>>>>> 00000000000006f0
>>>>> [   24.183157] Call Trace:
>>>>> [   24.183162]  <NMI>
>>>>> [   24.183167]  ? nmi_cpu_backtrace+0xbf/0x140
>>>>> [   24.183175]  ? nmi_cpu_backtrace_handler+0x11/0x20
>>>>> [   24.183181]  ? nmi_handle+0x61/0x160
>>>>> [   24.183186]  ? default_do_nmi+0x42/0x110
>>>>> [   24.183191]  ? exc_nmi+0x1bd/0x290
>>>>> [   24.183194]  ? end_repeat_nmi+0xf/0x53
>>>>> [   24.183203]  ? __this_module+0x2d3d1/0x4f310 [tg3]
>>>>> [   24.183207]  ? __this_module+0x2d3d1/0x4f310 [tg3]
>>>>> [   24.183210]  ? __this_module+0x2d3d1/0x4f310 [tg3]
>>>>> [   24.183213]  </NMI>
>>>>> [   24.183214]  <TASK>
>>>>> [   24.183215]  __this_module+0x31828/0x4f310 [tg3]
>>>>> [   24.183218]  ? __this_module+0x2d390/0x4f310 [tg3]
>>>>> [   24.183221]  __this_module+0x398e6/0x4f310 [tg3]
>>>>> [   24.183225]  __this_module+0x3baf8/0x4f310 [tg3]
>>>>> [   24.183229]  __this_module+0x4733f/0x4f310 [tg3]
>>>>> [   24.183233]  ? _raw_spin_unlock_irqrestore+0x25/0x70
>>>>> [   24.183237]  ? __this_module+0x398e6/0x4f310 [tg3]
>>>>> [   24.183241]  __this_module+0x4b943/0x4f310 [tg3]
>>>>> [   24.183244]  ? delay_tsc+0x89/0xf0
>>>>> [   24.183249]  ? preempt_count_sub+0x51/0x60
>>>>> [   24.183254]  __this_module+0x4be4b/0x4f310 [tg3]
>>>>> [   24.183258]  __dev_open+0x103/0x1c0
>>>>> [   24.183265]  __dev_change_flags+0x1bd/0x230
>>>>> [   24.183269]  ? rtnl_getlink+0x362/0x400
>>>>> [   24.183276]  dev_change_flags+0x26/0x70
>>>>> [   24.183280]  do_setlink+0xe16/0x11f0
>>>>> [   24.183286]  ? __nla_validate_parse+0x61/0xd40
>>>>> [   24.183295]  __rtnl_newlink+0x63d/0x9f0
>>>>> [   24.183301]  ? kmem_cache_alloc_node_noprof+0x12b/0x360
>>>>> [   24.183308]  ? kmalloc_trace_noprof+0x11e/0x350
>>>>> [   24.183312]  ? rtnl_newlink+0x2e/0x70
>>>>> [   24.183316]  rtnl_newlink+0x47/0x70
>>>>> [   24.183320]  rtnetlink_rcv_msg+0x152/0x400
>>>>> [   24.183324]  ? __netlink_sendskb+0x68/0x90
>>>>> [   24.183329]  ? netlink_unicast+0x237/0x290
>>>>> [   24.183333]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>>>>> [   24.183336]  netlink_rcv_skb+0x5b/0x110
>>>>> [   24.183343]  netlink_unicast+0x1a4/0x290
>>>>> [   24.183347]  netlink_sendmsg+0x222/0x4a0
>>>>> [   24.183350]  ? proc_get_long.constprop.0+0x116/0x210
>>>>> [   24.183358]  ____sys_sendmsg+0x379/0x3b0
>>>>> [   24.183363]  ? copy_msghdr_from_user+0x6d/0xb0
>>>>> [   24.183368]  ___sys_sendmsg+0x86/0xe0
>>>>> [   24.183372]  ? addrconf_sysctl_forward+0xf3/0x270
>>>>> [   24.183378]  ? _copy_from_iter+0x8b/0x570
>>>>> [   24.183384]  ? __pfx_addrconf_sysctl_forward+0x10/0x10
>>>>> [   24.183388]  ? _raw_spin_unlock+0x19/0x50
>>>>> [   24.183392]  ? proc_sys_call_handler+0xf3/0x2f0
>>>>> [   24.183397]  ? trace_hardirqs_on+0x29/0x90
>>>>> [   24.183401]  ? __fdget+0xc2/0xf0
>>>>> [   24.183405]  __sys_sendmsg+0x5b/0xc0
>>>>> [   24.183410]  ? syscall_trace_enter+0x110/0x1b0
>>>>> [   24.183416]  do_syscall_64+0x64/0x150
>>>>> [   24.183423]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>
>>>>> I have bisected the error to this commit. Reverting it caused no
>>>>> new or
>>>>> perceivable issues on both the MacBook and a Zen4-based laptop.
>>>>
>>>> [...]
>>>>
>>>>>> Ohh, and when you say "causing peripherals such as the wireless
>>>>>> card to
>>>>>> misbehave" what exactly do you mean?
>>>>>
>>>>> When the kernel throws rcu stall messages, the wireless card on the
>>>>> MacBook may fail to discover and/or connect to wireless networks -
>>>>> not a
>>>>> consistent behaviour but I suppose that something in the kernel got
>>>>> stuck.
>>>>
>>>> See the ticket for more details and dmesg logs; the problem still
>>>> happens with 6.12-rc. The reporter is CCed.
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
>>>> hat)
>>>> -- 
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> If I did something stupid, please tell me, as explained on that page.
>>>>
>>>> P.S.: let me use this mail to also add the report to the list of
>>>> tracked
>>>> regressions to ensure it's doesn't fall through the cracks:
>>>>
>>>> #regzbot introduced: 55d4669ef1b76823083caecfab12a8bd2ccdcf64
>>>> #regzbot from: Mingcong Bai <jeffbai@aosc.io>
>>>> #regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219390
>>>> #regzbot title: rcu: wifi problems since tg3 started throwing rcu stall
>>>> warnings
>>>> #regzbot ignore-activity
>>>>
>>>
>>>
> 
> 


