Return-Path: <linux-kernel+bounces-449166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3607E9F4AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56A0188853C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27F1F03D6;
	Tue, 17 Dec 2024 12:17:54 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220E1EC4E8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437873; cv=none; b=XcIn6iMoZ+/ktC+f2uhDjJ12WilzMf1jokBAnd098EQgLaJ0OV3KJeftRVfHExfR++iuzE/axAA5+T6HZ3qwzxLZvtafbgBOkJPwssLRvs8C3CjnbAJU6c0zVaHja5ISPgH4Mi4Unqm+vqr90CnAI8+oqcLwWQdHrwJSBE2j6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437873; c=relaxed/simple;
	bh=k7YBf0rdf0xqQyBSG3I0iekw+lsiRtmisK2JdxmHFM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fprsIwkGdIgVhqxsG3rGR6lc1OBpv14gSR8OuiiFg9+UM2ncggUgrQMzW/Bm0CUXyR5LzKHu5/NgkPetoTINx59ZOz8m9v3VUKcMMQKDAreK7bmPa2MzGWSY1g3M8e+bHZCsTa+QQk+wI+H52AyIrQC2Csov1aHC3PKR8441hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.172])
	by sina.com (10.185.250.21) with ESMTP
	id 67616BDD0000481A; Tue, 17 Dec 2024 20:17:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1572283408430
X-SMAIL-UIID: 7A77DD752B584FEC93758E7F177B3A93-20241217-201736-1
From: Hillf Danton <hdanton@sina.com>
To: linux-kernel@vger.kernel.org
Subject: Re: some works in 2024
Date: Tue, 17 Dec 2024 20:17:25 +0800
Message-ID: <20241217121726.224-1-hdanton@sina.com>
In-Reply-To: <20240719112012.1562-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 19:20:12 +0800 Hillf Danton <hdanton@sina.com>
> 
> 121 Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
> https://lore.kernel.org/lkml/000000000000256e74061d863f41@google.com/
> 
some works in 2024 (continued II)

122 Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
https://lore.kernel.org/lkml/00000000000061a872061e30e33b@google.com/
123 Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_file_mmap
https://lore.kernel.org/lkml/000000000000462ef2061e42a15a@google.com/
124 Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_xtp_rx_cts
https://lore.kernel.org/lkml/000000000000720d29061f020b8a@google.com/
125 Subject: Re: [syzbot] [pm?] INFO: trying to register non-static key in netdev_unregister_kobject
https://lore.kernel.org/lkml/00000000000072c34e061f29f8c9@google.com/
126 Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
https://lore.kernel.org/lkml/000000000000669deb061f5db34e@google.com/
127 Subject: Re: [syzbot] [btrfs?] general protection fault in __alloc_workqueue
https://lore.kernel.org/lkml/00000000000003cef3061ffcdca7@google.com/
128 Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_nfs_sync_lock
https://lore.kernel.org/lkml/0000000000008434460620fa2585@google.com/
129 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_frame
https://lore.kernel.org/lkml/00000000000071231f06210e069b@google.com/
130 Subject: Re: [syzbot] [wireless?] INFO: rcu detected stall in ieee80211_handle_queued_frames
https://lore.kernel.org/lkml/0000000000002d0b9a06214937b9@google.com/

131 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
https://lore.kernel.org/lkml/000000000000f5d0460621677cbb@google.com/
132 Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get_not_dead (2)
https://lore.kernel.org/lkml/0000000000005ec5bb06217b2833@google.com/
133 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
https://lore.kernel.org/lkml/0000000000004f672f0621ed3c3d@google.com/
134 Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
https://lore.kernel.org/lkml/0000000000007999780621ff7e3b@google.com/
135 Subject: Re: [syzbot] [media?] KASAN: use-after-free Read in em28xx_close_extension (2)
https://lore.kernel.org/lkml/66ee02e7.050a0220.3195df.001c.GAE@google.com/
136 Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
https://lore.kernel.org/lkml/66ee9b7a.050a0220.3195df.0049.GAE@google.com/
137 Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
https://lore.kernel.org/lkml/20240927112516.1136-1-hdanton@sina.com/
138 Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in binder_release_work
https://lore.kernel.org/lkml/66fdf142.050a0220.9ec68.0030.GAE@google.com/
139 Subject: Re: [syzbot] [mm?] BUG: corrupted list in do_compact_page
https://lore.kernel.org/lkml/66fe81a3.050a0220.28a3b.0211.GAE@google.com/
140 Subject: Re: [syzbot] [can?] WARNING: refcount bug in sk_skb_reason_drop
https://lore.kernel.org/lkml/66ff39a0.050a0220.49194.03f5.GAE@google.com/

141 Subject: Re: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
https://lore.kernel.org/lkml/67010d6e.050a0220.49194.04b9.GAE@google.com/
142 Subject: Re: [syzbot] [media?] WARNING in uvc_status_unregister
https://lore.kernel.org/lkml/6714ca54.050a0220.10f4f4.0030.GAE@google.com/
143 Subject: Re: [syzbot] [fuse?] kernel BUG in fuse_dev_do_write
https://lore.kernel.org/lkml/6714d683.050a0220.1e4b4d.003f.GAE@google.com/
144 Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
https://lore.kernel.org/lkml/67178c80.050a0220.1e4b4d.0075.GAE@google.com/
145 Subject: Re: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release (2)
https://lore.kernel.org/lkml/6720ce7e.050a0220.4735a.025b.GAE@google.com/
146 Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
https://lore.kernel.org/lkml/6723ad43.050a0220.35b515.0162.GAE@google.com/
147 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
https://lore.kernel.org/lkml/6725845a.050a0220.3c8d68.091a.GAE@google.com/
148 Subject: Re: [syzbot] [mm?] general protection fault in swap_reclaim_full_clusters
https://lore.kernel.org/lkml/672ea3e7.050a0220.138bd5.0036.GAE@google.com/
149 Subject: Re: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
https://lore.kernel.org/lkml/6737e4bc.050a0220.85a0.0007.GAE@google.com/
150 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
https://lore.kernel.org/lkml/67381142.050a0220.57553.0044.GAE@google.com/

151 Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (4)
https://lore.kernel.org/lkml/67393ab2.050a0220.e8d8d.016e.GAE@google.com/
152 Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
https://lore.kernel.org/lkml/673dc4b8.050a0220.3c9d61.015f.GAE@google.com/
153 Subject: Re: [syzbot] [bluetooth?] WARNING in hci_recv_frame
https://lore.kernel.org/lkml/673dd46c.050a0220.3c9d61.0160.GAE@google.com/
154 Subject: Re: [syzbot] [ext4?] WARNING: locking bug in get_page_from_freelist
https://lore.kernel.org/lkml/67445b0b.050a0220.1cc393.0076.GAE@google.com/
155 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __timer_delete
https://lore.kernel.org/lkml/67485a16.050a0220.253251.0081.GAE@google.com/
156 Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
https://lore.kernel.org/lkml/674871fe.050a0220.253251.0086.GAE@google.com/
157 Subject: Re: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev
https://lore.kernel.org/lkml/6753bf5b.050a0220.a30f1.0150.GAE@google.com/



[0] Subject: some works in 2024
https://lore.kernel.org/lkml/20240605113316.1899-1-hdanton@sina.com/
[1] some works in 2024 (continued I)
https://lore.kernel.org/lkml/20240719112012.1562-1-hdanton@sina.com/

