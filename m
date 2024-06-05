Return-Path: <linux-kernel+bounces-202265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D848FCA80
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1771C21D4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01C14D2A7;
	Wed,  5 Jun 2024 11:33:43 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462B145341
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587222; cv=none; b=EXVGvn/TIJ8Bb0OrGsh/7WDzyIrU0bela8nJthFadxI5M6qfJ1L/iyqquG/qLqEIIERYLav/LT5wlOgTUFKu+z8flVWyM4ChEQ/j5W4G6OPrKSDP0KCDBfPpq8z0duSQdHf7ytTouPpGuq1Aa/7dGFEcN+9CI5C4aMTelcqLU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587222; c=relaxed/simple;
	bh=juO5k98xkw89BBaFWgtogbfQ7BonrT9xWoIy7hTOrnk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nRA25gvKIaILem6bG/CQ1TCvvayG924GrgZUbD8dgtqIm9IXbgCmB1NtbqCWQi9cyuoWPDuYjraHHDDmFLa8ZXF2q0q+aSvXu38yunlumiEN8H8qljIM/MH2fkdRPR9v/jJvGyNkl0aw5zaLcJdmaoiH0MhEVZnxSBlY7/MA0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.2])
	by sina.com (10.75.12.45) with ESMTP
	id 66604D05000069E1; Wed, 5 Jun 2024 19:33:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 27068631458013
X-SMAIL-UIID: 500D100A015C4039B479BAD7EC5C4FF9-20240605-193328-1
From: Hillf Danton <hdanton@sina.com>
To: linux-kernel@vger.kernel.org
Subject: some works in 2024
Date: Wed,  5 Jun 2024 19:33:16 +0800
Message-Id: <20240605113316.1899-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2024 alone

001 Subject: Re: [syzbot] [dri?] [media?] memory leak in get_sg_table
https://lore.kernel.org/lkml/0000000000008b84f1060dd95e44@google.com/
002 Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
https://lore.kernel.org/lkml/20240104050501.2766-1-hdanton@sina.com/
003 Subject: Re: [syzbot] [reiserfs?] INFO: task hung in deactivate_super (2)
https://lore.kernel.org/lkml/20240105022156.2880-1-hdanton@sina.com/
004 Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
https://lore.kernel.org/lkml/0000000000007ab6f3060e87524f@google.com/
005 Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in kill_f2fs_super
https://lore.kernel.org/lkml/000000000000a5e984060eca55cc@google.com/
006 Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in f2fs_filemap_fault
https://lore.kernel.org/lkml/000000000000e8222b060f00db3b@google.com/
007 Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
https://lore.kernel.org/lkml/0000000000003cc2fa060f0fa766@google.com/
008 Subject: Re: [syzbot] [dri?] [virtualization?] upstream boot error: INFO: task hung in virtio_gpu_queue_fenced_ctrl_buffer
https://lore.kernel.org/lkml/20240125045813.1564-1-hdanton@sina.com/
009 Subject: Re: BUG: unable to handle kernel paging request in __skb_flow_dissect
https://lore.kernel.org/lkml/20240119130141.2160-1-hdanton@sina.com/
010 Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
https://lore.kernel.org/lkml/000000000000688bc50610005a3e@google.com/

011 Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in hash_netiface4_destroy
https://lore.kernel.org/lkml/0000000000009e4bbe061073d7e9@google.com/
012 Subject: Re: [syzbot] [afs?] [net?] INFO: task hung in rxrpc_release (3)
https://lore.kernel.org/lkml/0000000000009d4ac806109bef95@google.com/
013 Subject: Re: [syzbot] [usb?] [media?] possible deadlock in vb2_video_unregister_device
https://lore.kernel.org/lkml/000000000000b4827d0610c8eef4@google.com/
014 Subject: Re: [syzbot] [usb?] [fs?] KASAN: slab-use-after-free Read in comedi_release_hardware_device
https://lore.kernel.org/lkml/000000000000cd471a0610c95277@google.com/
015 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
https://lore.kernel.org/lkml/000000000000b9c4940610ee625e@google.com/
016 Subject: Re: [syzbot] [media?] possible deadlock in v4l2_ctrl_handler_log_status
https://lore.kernel.org/lkml/00000000000060b4cd0610eecaa0@google.com/
017 Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
https://lore.kernel.org/lkml/000000000000c273340611057dc6@google.com/
018 Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
https://lore.kernel.org/lkml/20240213114151.982-1-hdanton@sina.com/
019 Subject: Re: [syzbot] [bluetooth?] WARNING in ida_free (2)
https://lore.kernel.org/lkml/000000000000398eb106114ce403@google.com/
020 Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
https://lore.kernel.org/lkml/000000000000743d8606114f5251@google.com/

021 Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
https://lore.kernel.org/lkml/000000000000757b5e0611562e3f@google.com/
022 Subject: Re: [syzbot] [bluetooth?] WARNING in ida_free (2)
https://lore.kernel.org/lkml/0000000000003557320611569d45@google.com/
023 Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
https://lore.kernel.org/lkml/20240216105137.1242-1-hdanton@sina.com/
024 Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
https://lore.kernel.org/lkml/00000000000054a54e0611f1bc01@google.com/
025 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
https://lore.kernel.org/lkml/0000000000008c49c3061215913e@google.com/
026 Subject: Re: [syzbot] [dri?] [media?] inconsistent lock state in valid_state (2)
https://lore.kernel.org/lkml/000000000000cf0c5906125b26ca@google.com/
027 Subject: Re: [syzbot] [usb?] [media?] KASAN: use-after-free Read in v4l2_fh_open
https://lore.kernel.org/lkml/00000000000060a5870612b8bc8f@google.com/
028 Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
https://lore.kernel.org/lkml/0000000000003f484a0612d6f0ae@google.com/
029 Subject: Re: [Bug] INFO: task hung in hub_activate
https://lore.kernel.org/lkml/20240304133716.1401-1-hdanton@sina.com/
030 Subject: Re: [syzbot] [usb] INFO: rcu detected stall in newfstatat (3)
https://lore.kernel.org/lkml/000000000000a2ad99061310283f@google.com/

031 Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
https://lore.kernel.org/lkml/20240309101926.1994-1-hdanton@sina.com/
032 Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Read in tty_write_room (2)
https://lore.kernel.org/lkml/0000000000007ac1c5061375a605@google.com/
033 Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
https://lore.kernel.org/lkml/00000000000082883f061388d49e@google.com/
034 Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune
https://lore.kernel.org/lkml/000000000000f82ad206138aa1c4@google.com/
035 Subject: Re: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
https://lore.kernel.org/lkml/0000000000007716da0613c2f59d@google.com/
036 Subject: Re: [syzbot] [sound?] possible deadlock in snd_timer_close_locked
https://lore.kernel.org/lkml/000000000000e993950613c380eb@google.com/
037 Subject: Re: [syzbot] [mm?] possible deadlock in move_pages
https://lore.kernel.org/lkml/000000000000615c760614159e03@google.com/
038 Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
https://lore.kernel.org/lkml/000000000000fcfa6406141cc8ac@google.com/
039 Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in hrtimer_run_queues
https://lore.kernel.org/lkml/000000000000b5a41906141ff473@google.com/
040 Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in scheduler_tick (3)
https://lore.kernel.org/lkml/000000000000d8aa6806142c8347@google.com/

041 Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in wq_worker_tick
https://lore.kernel.org/lkml/000000000000b4680106142c5155@google.com/
042 Subject: Re: [syzbot] [tipc?] BUG: soft lockup in do_sock_setsockopt
https://lore.kernel.org/lkml/0000000000003e99f806144ff1a7@google.com/
043 Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
https://lore.kernel.org/lkml/000000000000b1254406145f207b@google.com/
044 Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in kauditd_thread (4)
https://lore.kernel.org/lkml/00000000000003c53d0614ef21a4@google.com/
045 Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
https://lore.kernel.org/lkml/000000000000d2f1800614ef7685@google.com/
046 Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in usb_anchor_suspend_wakeups (2)
https://lore.kernel.org/lkml/0000000000006a37bc06151507a7@google.com/
047 Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
https://lore.kernel.org/lkml/0000000000006d7564061514aa3e@google.com/
048 Subject: Re: [syzbot] [mm?] general protection fault in shmem_get_next_id
https://lore.kernel.org/lkml/0000000000008c948706152e82f7@google.com/
049 Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
https://lore.kernel.org/lkml/00000000000012b1e306153ab1e5@google.com/
050 Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
https://lore.kernel.org/lkml/00000000000019a4fe06153c3e35@google.com/

051 Subject: Re: [syzbot] [net?] [nfc?] WARNING: locking bug in nci_close_device (2)
https://lore.kernel.org/lkml/0000000000002b103f06154b1beb@google.com/
052 Subject: Re: [syzbot] [mm?] WARNING: bad unlock balance in madvise_cold_or_pageout_pte_range
https://lore.kernel.org/lkml/000000000000171a3f06154cba0b@google.com/
053 Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
https://lore.kernel.org/lkml/000000000000dbffef0615580abe@google.com/
054 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in hci_sock_setsockopt
https://lore.kernel.org/lkml/0000000000009cdf66061566c086@google.com/
055 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in l2cap_sock_setsockopt
https://lore.kernel.org/lkml/000000000000607a7206156d63c9@google.com/
056 Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
https://lore.kernel.org/lkml/00000000000012925b06158c061e@google.com/
057 Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_xattr_inode_update_ref (3)
https://lore.kernel.org/lkml/0000000000006b8a800615d0ec20@google.com/
058 Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (2)
https://lore.kernel.org/lkml/20240409225139.1556-1-hdanton@sina.com/
059 Subject: Re: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion
https://lore.kernel.org/lkml/20240406081653.1161-1-hdanton@sina.com/
060 Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
https://lore.kernel.org/lkml/20240413120426.1889-1-hdanton@sina.com/

061 Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
https://lore.kernel.org/lkml/0000000000007c4dde06160610a3@google.com/
062 Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
https://lore.kernel.org/lkml/00000000000046a1890616069166@google.com/
063 Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (5)
https://lore.kernel.org/lkml/0000000000001b926c06160a7e73@google.com/
064 Subject: Re: [syzbot] [can?] KASAN: slab-use-after-free Read in j1939_xtp_rx_dat_one
https://lore.kernel.org/lkml/000000000000eb5fe506160b7425@google.com/
065 Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in pvr2_context_set_notify (3)
https://lore.kernel.org/lkml/000000000000b4106c06160cc803@google.com/
066 Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
https://lore.kernel.org/lkml/00000000000058d4c80616629d53@google.com/
067 Subject: Re: [syzbot] [bpf?] possible deadlock in __stack_map_get
https://lore.kernel.org/lkml/0000000000000a94b3061673ace4@google.com/
068 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
https://lore.kernel.org/lkml/000000000000d3af1b0616740146@google.com/
069 Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
https://lore.kernel.org/lkml/000000000000a008f60616cac2cd@google.com/
070 Subject: Re: [syzbot] [net?] possible deadlock in __unix_gc
https://lore.kernel.org/lkml/0000000000000dd33b0616cbabb9@google.com/

071 Subject: Re: [syzbot] [fs?] WARNING in netdev_queue_update_kobjects (2)
https://lore.kernel.org/lkml/000000000000d4049c0616cc00e4@google.com/
072 Subject: Re: [syzbot] [usb?] WARNING in wdm_rxwork/usb_submit_urb (2)
https://lore.kernel.org/lkml/00000000000040adeb0616fe88df@google.com/
073 Subject: Re: [syzbot] [input?] [ext4?] possible deadlock in uinput_request_submit
https://lore.kernel.org/lkml/000000000000578f4a061701330b@google.com/
074 Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
https://lore.kernel.org/lkml/20240426141702.3419-1-hdanton@sina.com/
075 Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem (2)
https://lore.kernel.org/lkml/000000000000548fd70617100951@google.com/
076 Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
https://lore.kernel.org/lkml/20240427231321.3978-1-hdanton@sina.com/
077 Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close (2)
https://lore.kernel.org/lkml/000000000000bfd87b061731e96f@google.com/
078 Subject: Re: [syzbot] [sound?] INFO: rcu detected stall in snd_timer_user_release (3)
https://lore.kernel.org/lkml/00000000000064c7a50617455865@google.com/
079 Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
https://lore.kernel.org/lkml/000000000000a7f8470617589ff2@google.com/
080 Subject: Re: [syzbot] [wireless?] [usb?] INFO: trying to register non-static key in skb_dequeue (3)
https://lore.kernel.org/lkml/0000000000000351a306175a9ffc@google.com/

081 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_release_head_state
https://lore.kernel.org/lkml/000000000000fbaa73061762345c@google.com/
082 Subject: Re: [syzbot] [btrfs?] kernel BUG in folio_unlock (2)
https://lore.kernel.org/lkml/000000000000831ea10617816ada@google.com/
083 Subject: Re: [syzbot] [fs] general protection fault in __ep_remove
https://lore.kernel.org/lkml/000000000000f1c99d061798ac6d@google.com/
084 Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
https://lore.kernel.org/lkml/20240504092555.2071-1-hdanton@sina.com/
085 Subject: Re: [syzbot] [net?] INFO: rcu detected stall in sock_write_iter (3)
https://lore.kernel.org/lkml/000000000000c162cd0617dcf580@google.com/
086 Subject: Re: [syzbot] [block?] [usb?] INFO: rcu detected stall in aoecmd_cfg (2)
https://lore.kernel.org/lkml/000000000000a8a7740617fa6f5c@google.com/
087 Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
https://lore.kernel.org/lkml/000000000000975906061817416b@google.com/
088 Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
https://lore.kernel.org/lkml/00000000000031b7fe06182d3bc1@google.com/
089 Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in __fput (2)
https://lore.kernel.org/lkml/00000000000096d570061849defe@google.com/
090 Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
https://lore.kernel.org/lkml/000000000000a245fb0618820327@google.com/

091 Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
https://lore.kernel.org/lkml/000000000000e257e606189b484f@google.com/
092 Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
https://lore.kernel.org/lkml/00000000000072ae2c0618b0cce7@google.com/
093 Subject: Re: [syzbot] [input?] possible deadlock in evdev_cleanup (2)
https://lore.kernel.org/lkml/0000000000007dff750618c320c9@google.com/
094 Subject: Re: [syzbot] [media?] [usb?] WARNING in usb_free_urb
https://lore.kernel.org/lkml/000000000000a132620619e00abf@google.com/
095 Subject: Re: [syzbot] [gfs2?] BUG: corrupted list in gfs2_fill_super
https://lore.kernel.org/lkml/00000000000028b0c00619e59afc@google.com/
096 Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
https://lore.kernel.org/lkml/000000000000d0687c0619e74aed@google.com/
097 Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
https://lore.kernel.org/lkml/000000000000d5767c0619fa5845@google.com/
098 Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep worning
https://lore.kernel.org/lkml/20240604105456.1668-1-hdanton@sina.com/
099 Subject: Re: [syzbot] [mm?] kernel panic: corrupted stack end in userfaultfd_ioctl
https://lore.kernel.org/lkml/000000000000a3bf64061a101538@google.com/
100 Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer dereference in __hrtimer_run_queues
https://lore.kernel.org/lkml/00000000000087580e061a1072ae@google.com/


