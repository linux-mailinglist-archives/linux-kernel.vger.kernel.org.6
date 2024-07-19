Return-Path: <linux-kernel+bounces-257228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38A937714
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC031C210A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A985952;
	Fri, 19 Jul 2024 11:20:40 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774A2AF11
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388040; cv=none; b=GRl/mRiwLY2Uf6BZO1gNHw23qEs0b6Ye1d08KjfujZyn8iWdKJ2EULcsF+6Ca8ZRa1Yb0YAdQCR517AmXW9uk/p8dowlcrP1Lo8L+hr9ofU6tIovxLpbBWiaBhAtAi+U35KnUt55KAaxHX47fRaTlMGvNHAQQfFNLBfs12HL+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388040; c=relaxed/simple;
	bh=HpSH8TGxq1TGqmd69s6BvlS6xXy4h0EEfTivghn7UM4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtvJPJlSsnPAJUBrZDSYi3rAWf63bJ1C8tHaybvbRRXHygIp4hcLStzCeysyiTHypLBE06so84xf/cqpxtFyb28CgVUNWSqbjSItGs+nQd9bZpsjmYdHynaYR9zg7BVkeaXknFRpMpGC3c7/Zl/0sg8yAEicH18pr1Upncjzodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.136])
	by sina.com (10.185.250.22) with ESMTP
	id 669A4BF600007059; Fri, 19 Jul 2024 19:20:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1545667602734
X-SMAIL-UIID: 567F430FD0DE4734813C729C40C34BAA-20240719-192026-1
From: Hillf Danton <hdanton@sina.com>
To: linux-kernel@vger.kernel.org
Subject: Re: some works in 2024
Date: Fri, 19 Jul 2024 19:20:12 +0800
Message-Id: <20240719112012.1562-1-hdanton@sina.com>
In-Reply-To: <20240605113316.1899-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  5 Jun 2024 19:33:16 +0800 Hillf Danton <hdanton@sina.com>
> 100 Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer dereference in __hrtimer_run_queues
> https://lore.kernel.org/lkml/00000000000087580e061a1072ae@google.com/

some works in 2024 (continued I)

101 Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
https://lore.kernel.org/lkml/00000000000049d431061ad8502a@google.com/
102 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock (2)
https://lore.kernel.org/lkml/000000000000db5e4b061b1408c9@google.com/
103 Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_publish_rx_avail
https://lore.kernel.org/lkml/000000000000a17918061b281ffd@google.com/
104 Subject: Re: [syzbot] [net?] INFO: task hung in addrconf_verify_work (8)
https://lore.kernel.org/lkml/0000000000007ed9ca061b705cb2@google.com/
105 Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
https://lore.kernel.org/lkml/000000000000cb2a2f061b76e9da@google.com/
106 Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
https://lore.kernel.org/lkml/000000000000baa654061b887cb2@google.com/
107 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sk_skb_reason_drop
https://lore.kernel.org/lkml/000000000000250dcc061bb59cf8@google.com/
108 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in l2tp_tunnel_del_work
https://lore.kernel.org/lkml/0000000000006017fa061bf244a3@google.com/
109 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
https://lore.kernel.org/lkml/000000000000a20256061bde46c2@google.com/
110 Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid context in lock_sock_nested (3)
https://lore.kernel.org/lkml/00000000000035d35b061c074ebd@google.com/

111 Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
https://lore.kernel.org/lkml/000000000000971697061c441663@google.com/
112 Subject: Re: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map
https://lore.kernel.org/lkml/000000000000f51ec8061c55a5d5@google.com/
113 Subject: Re: [syzbot] [bluetooth?] BUG: workqueue leaked atomic, lock or RCU: kworker/u9:NUM[NUM]
https://lore.kernel.org/lkml/000000000000ab3812061cf76701@google.com/
114 Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid context in synchronize_net
https://lore.kernel.org/lkml/000000000000349146061d175ed1@google.com/
115 Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
https://lore.kernel.org/lkml/000000000000eb1758061d1db5aa@google.com/
116 Subject: Re: [syzbot] [io-uring] general protection fault in tomoyo_socket_bind_permission
https://lore.kernel.org/lkml/000000000000229f19061d1e1afb@google.com/
117 Subject: Re: [syzbot] [kernel?] kernel BUG in binder_inc_ref_for_node
https://lore.kernel.org/lkml/0000000000006ad1d3061d215bf2@google.com/
118 Subject: Re: [syzbot] [crypto?] KASAN: slab-use-after-free Read in handle_mm_fault
https://lore.kernel.org/lkml/000000000000422161061d5cb3ee@google.com/
119 Subject: Re: [syzbot] [fs?] WARNING: lock held when returning to user space in ns_ioctl
https://lore.kernel.org/lkml/000000000000abc9fc061d8451a5@google.com/
120 Subject: Re: [syzbot] [net?] WARNING: suspicious RCU usage in dev_deactivate_queue
https://lore.kernel.org/lkml/000000000000cf70b8061d83fbdf@google.com/

121 Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
https://lore.kernel.org/lkml/000000000000256e74061d863f41@google.com/


[0] Subject: some works in 2024
https://lore.kernel.org/lkml/20240605113316.1899-1-hdanton@sina.com/

