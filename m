Return-Path: <linux-kernel+bounces-278902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 512E794B653
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C052B25195
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C5118133F;
	Thu,  8 Aug 2024 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="R+Q1NsxW"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1323B184E;
	Thu,  8 Aug 2024 05:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095985; cv=none; b=ZsKN2093Z4f51JUAUNbaOzl4bdIUm7TdWR8ecbgmePQvNiWQb41+nBF4O6jEm9e8FEFCQglwL0bJc8LCwTKI3I8JY+1tg7YaDxd8uKfMWi/fEYJvFFp+Lga3jPLzzJmB4fV99kTfes0Ra/guTBKUM+0HHMdvLVSEjoMaWT52xAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095985; c=relaxed/simple;
	bh=LehBITNYfiLgWTewr4y3xjVbkgbVcBRIcPjfEd+VBgo=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Cc:Content-Type; b=j0Z2QtzCf90C83gWpXe7JzKtrgyQahKz+MtqnQMDsALCCYp8/G89gZjoDRePvoGfwX5HHu/pO5gz4MtZW20T/RM0B3fWA6gPsu3X8G+xIset3pwupI5zavnhWV9iE72f/Xrmv+VwePMqTTAdBqtT/EUflqcN+nn2WQpP4zVDTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=R+Q1NsxW; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Cc:
	Subject:Reply-To:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=IQalC81tDFrZmKHUo2m7ulS/QbWwgG6+DOHMGdElypI=; t=1723095983;
	x=1723527983; b=R+Q1NsxW2PIPwkr8MXBcCFFztv5QNAUl3rxeE8A/0w0QFBpQTgUHgHHpFZtk5
	vd3E3dtqxmAUjYpbUQqiwIhzROR/eeqgy6DQGo2koZUYTM07Z/dQXMW33GCes1tvezJXwsITQcfkC
	pcOKLLpNkraKnLDb1ztpJJ25Z7bB5haKWiBGheu8319tx2ZqTC6keLqktZAFz0k198cX2UehD8W7Q
	aCQ0WMv+w18v7AQaptxzOh7Xk/X9bJGZqr8zV3hTNor/JkRwViij7fabb6vglKPs9Goq4bEyQqrL7
	ncOhsgw+eghnPfck0akpxwQQhbPCLXr9EGm9qq/we7EtwdY4VQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sbvyX-0006VS-Ly; Thu, 08 Aug 2024 07:46:13 +0200
Message-ID: <05c3f9ea-b5f5-4341-9e4f-d44133629fe6@leemhuis.info>
Date: Thu, 8 Aug 2024 07:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] [ath11k] kernel NULL pointer in
 ath11k_mac_get_eirp_power.isra
Cc: ath11k <ath11k@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723095983;cc91cab3;
X-HE-SMSGID: 1sbvyX-0006VS-Ly

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a report about an ath11k regression in bugzilla.kernel.org. As
many (most?) kernel developers don't keep an eye on the bug tracker, I
decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219131 :

> Wifi stopped working on my laptop when updating from 6.10.3 to 6.11-rc2 kernel.
> 
> 02:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 Wireless Network Adapter (rev 01)
> wpa_supplicant-2.11-1.fc40.x86_64
> 
> wlp2s0: SME: Trying to authenticate with b2:25:4a:59:04:37 (SSID='Mecha34bb-combo' freq=6295 MHz)
> BUG: kernel NULL pointer dereference, address: 0000000000000018
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0 
> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 10 UID: 0 PID: 1308 Comm: wpa_supplicant Not tainted 6.11.0-0.rc2.23.fc41.x86_64 #1
> Hardware name: LENOVO 21K5000DMX/21K5000DMX, BIOS R2FET57W (1.37 ) 05/20/2024
> RIP: 0010:ath11k_mac_get_eirp_power.isra.0+0x5b/0x80 [ath11k]
> Code: 0f 87 7f ea 02 00 66 41 89 5d 00 84 c9 75 35 49 8b 44 24 10 0f b7 f3 69 f6 e8 03 00 00 48 8b 78 40 e8 d9 5f 60 ff 48 89 45 00 <8b> 50 18 48 8b 44 24 28 88 10 5b 5d 41 5c 41 5d e9 0b 1a ae f5 41
> RSP: 0018:ffffa725c77a3360 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000001d83 RCX: 0000000000000000
> RDX: 00000000005a8f98 RSI: 0000000000000005 RDI: 0000000000000000
> RBP: ffffa725c77a33d8 R08: ffffa725c77a33d8 R09: ffff8b7ff1b0e488
> R10: ffff8b7ff0aa2000 R11: 0000000000001883 R12: ffff8b7ff0aa2000
> R13: ffffa725c77a33d6 R14: 0000000000000000 R15: ffff8b8000cb9440
> FS:  00007f07966c4840(0000) GS:ffff8b8e21d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000018 CR3: 00000001416fa000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? __die_body.cold+0x19/0x27
>  ? page_fault_oops+0x15a/0x2f0
>  ? exc_page_fault+0x7e/0x180
>  ? asm_exc_page_fault+0x26/0x30
>  ? ath11k_mac_get_eirp_power.isra.0+0x5b/0x80 [ath11k]
>  ath11k_mac_fill_reg_tpc_info+0x3d6/0x800 [ath11k]
>  ? __entry_text_end+0x101e45/0x101e49
>  ath11k_mac_vdev_start_restart+0x412/0x4d0 [ath11k]
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? crypto_alloc_tfm_node+0x5b/0xd0
>  ath11k_mac_op_sta_state+0x7bc/0xbb0 [ath11k]
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __rhashtable_insert_fast.constprop.0.isra.0+0x17f/0x490 [mac80211]
>  drv_sta_state+0xf1/0x5f0 [mac80211]
>  sta_info_insert_rcu+0x28d/0x530 [mac80211]
>  sta_info_insert+0xf/0x20 [mac80211]
>  ieee80211_prep_connection+0x3b4/0x4c0 [mac80211]
>  ieee80211_mgd_auth+0x363/0x600 [mac80211]
>  ? __entry_text_end+0xfdd48/0x101e49
>  ? __cfg80211_get_bss+0x215/0x2e0 [cfg80211]
>  cfg80211_mlme_auth+0xb4/0x1b0 [cfg80211]
>  nl80211_authenticate+0x369/0x3d0 [cfg80211]
>  genl_family_rcv_msg_doit+0xef/0x150
>  genl_rcv_msg+0x1b7/0x2c0
>  ? __pfx_nl80211_pre_doit+0x10/0x10 [cfg80211]
>  ? __pfx_nl80211_authenticate+0x10/0x10 [cfg80211]
>  ? __pfx_nl80211_post_doit+0x10/0x10 [cfg80211]
>  ? __pfx_genl_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x50/0x100
>  genl_rcv+0x28/0x40
>  netlink_unicast+0x242/0x370
>  netlink_sendmsg+0x21b/0x470
>  ____sys_sendmsg+0x39d/0x3d0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ___sys_sendmsg+0x9a/0xe0
>  __sys_sendmsg+0xcc/0x100
>  do_syscall_64+0x82/0x160
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_sock_setsockopt+0xc1/0x180
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __sys_setsockopt+0xb1/0xe0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? syscall_exit_to_user_mode+0x10/0x220
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0x8e/0x160
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_sock_setsockopt+0xc1/0x180
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? syscall_exit_to_user_mode+0x10/0x220
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0x8e/0x160
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? syscall_exit_to_user_mode+0x10/0x220
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? do_syscall_64+0x8e/0x160
>  ? exc_page_fault+0x7e/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f079612ca14
> Code: 15 09 94 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d 35 16 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> RSP: 002b:00007ffc97d7eeb8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000055e6cd9de920 RCX: 00007f079612ca14
> RDX: 0000000000000000 RSI: 00007ffc97d7eef0 RDI: 0000000000000006
> RBP: 00007ffc97d7eee0 R08: 0000000000000004 R09: 0000000000000001
> R10: 00007ffc97d7effc R11: 0000000000000202 R12: 000055e6cdab10a0
> R13: 000055e6cd9de830 R14: 00007ffc97d7eef0 R15: 0000000000000000
>  </TASK>

See the ticket for more details. Note, you have to use bugzilla to reach
the reporter, as I sadly[1] can not CCed them in mails like this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.10..v6.11-rc2
#regzbot title: wifi: ath11k: null pointer
#regzbot from: Mikko Tiihonen
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219131
#regzbot ignore-activity

