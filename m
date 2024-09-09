Return-Path: <linux-kernel+bounces-321334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E939718EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B72F1C226EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC91B5ECD;
	Mon,  9 Sep 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBxsXAHN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88129CE8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883613; cv=none; b=OSSDXHH3iKmBRYO9Sg7DuBy5ccEhcDt1Zf2b6psJbSvui3XouPoeUbGWK8MgKN1IMvHqJuRXDKlf+5p2J26blauVzVBky8ijCJzGFXdRuEJZmmSbGxSZiNFMaMUh66XtZmQbInC4qrvS2IqtD6q1aFqvR6SoaZhX0YJuef800sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883613; c=relaxed/simple;
	bh=7ipeaEY8+DijjGSRjG0k4nvdXVFe2f9lsAW9HHU7zbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtYBZdINLWr/LlXPPGMmMA1TQQkGzrYYGP0vjEmFpcqK3Chlmli8fJe9RqqVMMoLx8nKRYNT3MG/Y2o5HLttbbG3qojK2DKpXDQV57u/r8g+5+xE0fjc7YuDQHdOXqnIHcif05vx+ITSObUK7UUOcigZ2nB0zg0n3eJkb740L9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBxsXAHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01958C4CEC5;
	Mon,  9 Sep 2024 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725883613;
	bh=7ipeaEY8+DijjGSRjG0k4nvdXVFe2f9lsAW9HHU7zbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FBxsXAHNAlVamRlGUyn924bBKaqV5vVbmnTCcpXBdI5ixCeRAomlr0OXe3eDmn7Gg
	 HmBRMapCc4WbwjAQ4cM06+rvMccXjDKm03HWPEPz5VYKnhVyZSebP8FnUoPlYnDngg
	 sAf+AZ4+id7xKwx0g8EZBKqc/+1eXbjsCI/fumudJmQ3GQuuX4HwAc9s3Rl+1/5lMB
	 PLyqZLPZuSGWUbIcwqUOphgBt+ezEMj34I+gf/7aOR9amVb0AvvTJ4FTBjnHvU4zip
	 fvxUvYojLIdhCQ5S6WoOgVm9SVy3RaDCYeuM9aQMJC8clQwrvRDdvxBy0B5fsCsp90
	 YjvbViSQN2Tkg==
Message-ID: <7c11a60d-1632-4383-b9fb-2236f3859e23@kernel.org>
Date: Mon, 9 Sep 2024 20:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [moderation] [f2fs?] WARNING: still has locks held in
 f2fs_ioc_start_atomic_write
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzkaller-upstream-moderation
 <syzkaller-upstream-moderation@googlegroups.com>,
 LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
 yuchaochina@hotmail.com
References: <000000000000f20106061fc9699c@google.com>
 <e8ce9858-87ab-4f0b-85a8-8817ec376986n@googlegroups.com>
 <CACT4Y+YkXFCQ8sUX7rgL9j23_mxKpoxR15_w=5+aJ=A_cg3C0w@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <CACT4Y+YkXFCQ8sUX7rgL9j23_mxKpoxR15_w=5+aJ=A_cg3C0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dmitry,

On 2024/9/5 16:16, Dmitry Vyukov wrote:
> Hi Chao,
> 
> The commands should not have space at the beginning of the line, and
> also preferably sent not in HTML (I did n't check what is in the
> plain/text section of your email).
> You can always check if syzbot has received your command at the bug page:
> https://syzkaller.appspot.com/bug?extid=a2197ed0ab131bbc9d02
> 
> But thanks for marking it as fixed:
> 
> #syz fix: f2fs: atomic: fix to forbid dio in atomic_file

Thanks for reminding me that!

I have one question, why this [moderation][f2fs?] tagged bug report not
be Cced f2fs mailing list?

Thanks,

> 
> On Thu, 5 Sept 2024 at 08:49, Chao Yu <yuchaochina@gmail.com> wrote:
>>
>>   #syz fix: f2fs: atomic: fix to forbid dio in atomic_file
>>
>> 在2024年8月16日星期五 UTC+8 17:16:28<syzbot> 写道：
>>>
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit: 9e6869691724 Add linux-next specific files for 20240812
>>> git tree: linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=14d27ae5980000
>>> kernel config: https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a2197ed0ab131bbc9d02
>>> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> CC: [ch...@kernel.org jae...@kernel.org linux-f2...@lists.sourceforge.net linux-...@vger.kernel.org]
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+a2197e...@syzkaller.appspotmail.com
>>>
>>> ====================================
>>> WARNING: syz.0.454/7910 still has locks held!
>>> 6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
>>> ------------------------------------
>>> 1 lock held by syz.0.454/7910:
>>> #0: ffff888011f98f50 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
>>> #0: ffff888011f98f50 (&fi->i_gc_rwsem[READ]){+.+.}-{3:3}, at: f2fs_ioc_start_atomic_write+0x2ed/0xac0 fs/f2fs/file.c:2163
>>>
>>> stack backtrace:
>>> CPU: 0 UID: 0 PID: 7910 Comm: syz.0.454 Not tainted 6.11.0-rc3-next-20240812-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
>>> Call Trace:
>>> <TASK>
>>> __dump_stack lib/dump_stack.c:94 [inline]
>>> dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>> do_exit+0x1b67/0x28e0 kernel/exit.c:969
>>> do_group_exit+0x207/0x2c0 kernel/exit.c:1088
>>> get_signal+0x176f/0x1810 kernel/signal.c:2936
>>> arch_do_signal_or_restart+0x96/0x830 arch/x86/kernel/signal.c:337
>>> exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>>> exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>>> __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>>> syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
>>> do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>> RIP: 0033:0x7f7ba21779f9
>>> Code: Unable to access opcode bytes at 0x7f7ba21779cf.
>>> RSP: 002b:00007f7ba2fa4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>> RAX: fffffffffffffffb RBX: 00007f7ba2306208 RCX: 00007f7ba21779f9
>>> RDX: 0000000000000000 RSI: 000000000000f501 RDI: 0000000000000005
>>> RBP: 00007f7ba21e58ee R08: 0000000000000000 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>> R13: 0000000000000001 R14: 00007f7ba2306208 R15: 00007ffc9069b428
>>> </TASK>
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzk...@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-upstream-moderation" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-upstream-moderation+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-upstream-moderation/e8ce9858-87ab-4f0b-85a8-8817ec376986n%40googlegroups.com.


