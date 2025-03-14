Return-Path: <linux-kernel+bounces-560582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B057A606CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E33197A8377
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5C8837;
	Fri, 14 Mar 2025 01:03:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AD2E336D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741914228; cv=none; b=EvJ0s26yz7Rfb02aFoOE7224lu2b+37TmJP9nTuxJ9eYv5ZlJ/Xug+cn2Tb8Ty3a6OQXQUtNHWOyQEmuJY4bf4zZiWDfZlV1eoUIPbe2af5Hf3GSSVbxvwkRAaxXK4Ho3uCjJ3hIixKSSUaN0w/ZaktzI7jSVMlvQQlngR3W31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741914228; c=relaxed/simple;
	bh=pVqc5pcbYcchfv4v0P0txVNeG1ociywUxs+LhQLUIJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMnMVuNq47hsIk80LdNgZr8odyTT8mKzJGfIfVyYMZb/A/CKuwU4kp6xrFNw0+c+Xkh5RWWf+cnGE7xNjLc97UKWs5TFzjT7uGIGARp9YpAEwfbOWdSo3mk3dIDC/TQ174wvhO5DWccqrdifqxiE/0RepFe6v6FHn0dWC0N0bVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 29c4b39c007011f0a216b1d71e6e1362-20250314
X-CID-CACHE: Type:Local,Time:202503140901+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b3a18592-cbe3-4df0-acf2-72e609b1e8ca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d292590464270fe945431d6853997de7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 29c4b39c007011f0a216b1d71e6e1362-20250314
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1474753070; Fri, 14 Mar 2025 09:03:38 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 5A64CB804EA4;
	Fri, 14 Mar 2025 09:03:38 +0800 (CST)
X-ns-mid: postfix-67D3806A-237724116
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id 6C2E4B80758A;
	Fri, 14 Mar 2025 01:03:37 +0000 (UTC)
Message-ID: <b16df734-2d28-4e7a-b957-fb5fa16750b1@kylinos.cn>
Date: Fri, 14 Mar 2025 09:03:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: Move free_vm_area(area) from the
 __vmalloc_area_node function to the __vmalloc_node_range_noprof function
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, yi1.lai@intel.com
References: <20250303015702.319416-1-liuye@kylinos.cn>
 <1741913791967613.48.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <1741913791967613.48.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/3/13 17:18, Lai, Yi =E5=86=99=E9=81=93:
> On Mon, Mar 03, 2025 at 09:57:02AM +0800, Liu Ye wrote:
>> Moved free_vm_area from the __vmalloc_area_node function to the
>> __vmalloc_node_range_noprof function so that allocation and freeing
>> of the area can be paired in one function for better readability.
>>
>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>> ---
>>  mm/vmalloc.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index a6e7acebe9ad..dc658d4af181 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3651,7 +3651,6 @@ static void *__vmalloc_area_node(struct vm_struc=
t *area, gfp_t gfp_mask,
>>  		warn_alloc(gfp_mask, NULL,
>>  			"vmalloc error: size %lu, failed to allocated page array size %lu"=
,
>>  			nr_small_pages * PAGE_SIZE, array_size);
>> -		free_vm_area(area);
>>  		return NULL;
>>  	}
>> =20
>> @@ -3844,8 +3843,10 @@ void *__vmalloc_node_range_noprof(unsigned long=
 size, unsigned long align,
>> =20
>>  	/* Allocate physical pages and map them into vmalloc space. */
>>  	ret =3D __vmalloc_area_node(area, gfp_mask, prot, shift, node);
>> -	if (!ret)
>> +	if (!ret) {
>> +		free_vm_area(area);
>>  		goto fail;
>> +	}
>> =20
>>  	/*
>>  	 * Mark the pages as accessible, now that they are mapped.
>> --=20
>> 2.25.1
>>
>=20
> Another issue is also bisected to this commit: there is KASAN: slab-use=
-after-free Read in io_create_region
>=20
>=20
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250313_124102_io_=
create_region/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250313_124102_io_=
create_region/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250313_124102_io_=
create_region/repro.report
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250313_124102_io_=
create_region/eea255893718268e1ab852fb52f70c613d109b99_dmesg.log
>=20
> "
> [   24.707888]  __asan_report_load8_noabort+0x18/0x20
> [   24.707895]  __vmalloc_node_range_noprof+0x1344/0x1420
> [   24.707901]  ? __lock_acquire+0x1bad/0x5d60
> [   24.707915]  ? io_create_region+0x6ca/0xe00
> [   24.707933]  ? __pfx___vmalloc_node_range_noprof+0x10/0x10
> [   24.707940]  ? debug_smp_processor_id+0x20/0x30
> [   24.707958]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   24.707969]  ? io_create_region+0x6ca/0xe00
> [   24.707979]  ? io_create_region+0x6ca/0xe00
> [   24.707992]  io_create_region+0x6ca/0xe00
> [   24.708002]  ? io_create_region+0x6ca/0xe00
> [   24.708015]  ? __pfx_io_create_region+0x10/0x10
> [   24.708025]  ? __this_cpu_preempt_check+0x21/0x30
> [   24.708035]  ? lock_release+0x440/0x870
> [   24.708046]  ? __pfx_lock_release+0x10/0x10
> [   24.708056]  io_create_region_mmap_safe+0xaf/0x150
> [   24.708067]  ? __pfx_io_create_region_mmap_safe+0x10/0x10
> [   24.708081]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   24.708096]  __do_sys_io_uring_register+0xb90/0x2b10
> [   24.708110]  ? __pfx___do_sys_io_uring_register+0x10/0x10
> [   24.708127]  ? trace_hardirqs_on+0x51/0x60
> [   24.708145]  ? __audit_syscall_entry+0x39c/0x500
> [   24.708157]  __x64_sys_io_uring_register+0x9f/0x100
> [   24.708168]  ? syscall_trace_enter+0x14d/0x280
> [   24.708179]  x64_sys_call+0x1eef/0x2150
> [   24.708188]  do_syscall_64+0x6d/0x140
> [   24.708199]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   24.708206] RIP: 0033:0x7f9276c3ee5d
> [   24.708217] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa=
 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   24.708224] RSP: 002b:00007ffd41ff7c18 EFLAGS: 00000202 ORIG_RAX: 00=
000000000001ab
> [   24.708234] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9=
276c3ee5d
> [   24.708238] RDX: 0000000020003300 RSI: 0000000000000022 RDI: 0000000=
000000003
> [   24.708242] RBP: 00007ffd41ff7c30 R08: 00007ffd41ff7c30 R09: 00007ff=
d41ff7c30
> [   24.708246] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ff=
d41ff7d88
> [   24.708250] R13: 00000000004017f5 R14: 0000000000403e08 R15: 00007f9=
276f77000
> [   24.708260]  </TASK>
> [   24.708262]=20
> [   24.719961] Allocated by task 1208:
> [   24.720136]  kasan_save_stack+0x2c/0x60
> [   24.720336]  kasan_save_track+0x18/0x40
> [   24.720529]  kasan_save_alloc_info+0x3c/0x50
> [   24.720744]  __kasan_kmalloc+0x88/0xa0
> [   24.720933]  __kmalloc_cache_node_noprof+0x1d0/0x470
> [   24.721174]  __get_vm_area_node+0xf7/0x260
> [   24.721380]  __vmalloc_node_range_noprof+0x25c/0x1420
> [   24.721622]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   24.721848]  io_create_region+0x6ca/0xe00
> [   24.722049]  io_create_region_mmap_safe+0xaf/0x150
> [   24.722291]  __do_sys_io_uring_register+0xb90/0x2b10
> [   24.722539]  __x64_sys_io_uring_register+0x9f/0x100
> [   24.722782]  x64_sys_call+0x1eef/0x2150
> [   24.722976]  do_syscall_64+0x6d/0x140
> [   24.723159]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   24.723405]=20
> [   24.723491] Freed by task 1208:
> [   24.723648]  kasan_save_stack+0x2c/0x60
> [   24.723841]  kasan_save_track+0x18/0x40
> [   24.724035]  kasan_save_free_info+0x3f/0x60
> [   24.724247]  __kasan_slab_free+0x3d/0x60
> [   24.724450]  kfree+0x28d/0x440
> [   24.724610]  vfree+0x2ce/0x910
> [   24.724769]  __vmalloc_node_range_noprof+0xeca/0x1420
> [   24.725017]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   24.725240]  io_create_region+0x6ca/0xe00
> [   24.725442]  io_create_region_mmap_safe+0xaf/0x150
> [   24.725682]  __do_sys_io_uring_register+0xb90/0x2b10
> [   24.725934]  __x64_sys_io_uring_register+0x9f/0x100
> [   24.726177]  x64_sys_call+0x1eef/0x2150
> [   24.726365]  do_syscall_64+0x6d/0x140
> [   24.726549]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   24.726796]=20
> [   24.726882] The buggy address belongs to the object at ffff8880166bf=
b80
> [   24.726882]  which belongs to the cache kmalloc-64 of size 64
> [   24.727442] The buggy address is located 8 bytes inside of
> [   24.727442]  freed 64-byte region [ffff8880166bfb80, ffff8880166bfbc=
0)
> [   24.727990]=20
> [   24.728078] The buggy address belongs to the physical page:
> [   24.728344] page: refcount:0 mapcount:0 mapping:0000000000000000 ind=
ex:0x0 pfn:0x166bf
> [   24.728712] anon flags: 0xfffffc0000000(node=3D0|zone=3D1|lastcpupid=
=3D0x1fffff)
> [   24.729034] page_type: f5(slab)
> [   24.729196] raw: 000fffffc0000000 ffff88800d4418c0 0000000000000000 =
dead000000000001
> [   24.729562] raw: 0000000000000000 0000000080200020 00000000f5000000 =
0000000000000000
> [   24.729922] page dumped because: kasan: bad access detected
> [   24.730189]=20
> [   24.730274] Memory state around the buggy address:
> [   24.730503]  ffff8880166bfa80: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   24.730839]  ffff8880166bfb00: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   24.731179] >ffff8880166bfb80: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   24.731518]                       ^
> [   24.731696]  ffff8880166bfc00: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   24.732032]  ffff8880166bfc80: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   24.732369] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   24.732787] Disabling lock debugging due to kernel taint
> [   24.734673] ------------[ cut here ]------------
> [   24.734907] Trying to vfree() bad address (00000000ea48f0e7)
> [   24.735229] WARNING: CPU: 0 PID: 1207 at mm/vmalloc.c:3231 remove_vm=
_area+0x1c2/0x220
> [   24.735601] Modules linked in:
> [   24.735760] CPU: 0 UID: 0 PID: 1207 Comm: repro Tainted: G    B     =
          6.14.0-rc6-next-20250311-eea255893718 #1
> [   24.736307] Tainted: [B]=3DBAD_PAGE
> [   24.736477] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   24.737002] RIP: 0010:remove_vm_area+0x1c2/0x220
> [   24.737230] Code: c3 cc cc cc cc e8 7e e2 a4 ff 49 81 ee 00 10 00 00=
 e9 51 ff ff ff e8 6d e2 a4 ff 4c 89 e6 48 c7 c7 a0 eb fa 85 e8 ce 71 63 =
ff <0f> 0b 45 31 ed eb bb 45 31 ed eb b6 e8 ed d2 0f 00 e9 10 ff ff ff
> [   24.738072] RSP: 0000:ffff88804dbc78b8 EFLAGS: 00010292
> "
>=20
> Hope this cound be insightful to you.
>=20
> Regards,
> Yi Lai

This patch has been dropped, and this patch and the introduced UAF issue =
will be fixed in the next version.

Thanks=EF=BC=8C
Liu Ye

