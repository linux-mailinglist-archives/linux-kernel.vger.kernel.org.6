Return-Path: <linux-kernel+bounces-560580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A435EA606C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504DE19C419B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E838837;
	Fri, 14 Mar 2025 01:01:27 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB32E3372
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741914086; cv=none; b=sV48LyB3jkQmgryGYmfz6ii7yQmaP2eeU/kS0nZLC1YsM2LrYn1X/l1zCt4Yt7jV5oTckZRb9saQwaGbectrIjmO8vMqJNshuhXP4lWPbgLRwKpe7B5ttIKwfouRE8fjauuFd/ufHBMYqiBOy4sILbeGRJjv41GlzT7E2qGXNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741914086; c=relaxed/simple;
	bh=i52WRD9/AanMpcug9VdHXEE11fsfLM5Bu4wgL50PZcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opjZaLOSsc97acrcfU22YENume+fWa30mK+EdRUk8G6zMAf5mDma4GkMFz2UzBf2JxbuY7x/U4ysXPh5GcLBzu365vA/NQXhXaeFHT12dHgzPiuZhr/7KkBzV0iBey6PkuQtfyqw2C9cjdAwUtm/R8/gV4c3WwhwSdf62mPkOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d38988b8006f11f0a216b1d71e6e1362-20250314
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7e2c2608-9cc1-475e-ae18-85e454975544,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d292590464270fe945431d6853997de7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d38988b8006f11f0a216b1d71e6e1362-20250314
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 392419269; Fri, 14 Mar 2025 09:01:13 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id A6B5EB804EA4;
	Fri, 14 Mar 2025 09:01:13 +0800 (CST)
X-ns-mid: postfix-67D37FD9-567817109
Received: from [172.30.70.73] (unknown [172.30.70.73])
	by node2.com.cn (NSMail) with ESMTPA id 1F77DB80758A;
	Fri, 14 Mar 2025 01:01:10 +0000 (UTC)
Message-ID: <5fc5cea9-adae-4c70-926a-4a7f79c7cad1@kylinos.cn>
Date: Fri, 14 Mar 2025 09:00:52 +0800
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
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, yi1.lai@intel.com,
 syzkaller-bugs@googlegroups.com
References: <20250303015702.319416-1-liuye@kylinos.cn>
 <1741913782357008.47.seg@mailgw.kylinos.cn>
Content-Language: en-US
From: liuye <liuye@kylinos.cn>
In-Reply-To: <1741913782357008.47.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A8 2025/3/13 16:49, Lai, Yi =E5=86=99=E9=81=93:
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
> Hi Liu Yue,
>=20
> Greetings!
>=20
> I used Syzkaller and found that there is KASAN: slab-use-after-free Rea=
d in iommufd_test in linux-next tag - next-20250311.
>=20
> After bisection and the first bad commit is:
> "
> 35388cb1e37e mm/vmalloc: move free_vm_area(area) from the __vmalloc_are=
a_node function to the __vmalloc_node_range_noprof function
> "
>=20
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iom=
mufd_test
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iom=
mufd_test/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iom=
mufd_test/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iom=
mufd_test/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iom=
mufd_test/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250312_233425_iom=
mufd_test/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250312_=
233425_iommufd_test/bzImage_eea255893718268e1ab852fb52f70c613d109b99
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250312_233425_iom=
mufd_test/eea255893718268e1ab852fb52f70c613d109b99_dmesg.log
>=20
> "
> [   22.060519]  ? __vmalloc_node_range_noprof+0x1344/0x1420
> [   22.060529]  __asan_report_load8_noabort+0x18/0x20
> [   22.060540]  __vmalloc_node_range_noprof+0x1344/0x1420
> [   22.060552]  ? iommufd_test+0x2d8/0x4b00
> [   22.060565]  ? __pfx___vmalloc_node_range_noprof+0x10/0x10
> [   22.060575]  ? debug_smp_processor_id+0x20/0x30
> [   22.060588]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   22.060596]  ? iommufd_test+0x2d8/0x4b00
> [   22.060603]  ? __fget_files+0x204/0x3b0
> [   22.060613]  ? iommufd_test+0x2d8/0x4b00
> [   22.060623]  iommufd_test+0x2d8/0x4b00
> [   22.060629]  ? iommufd_test+0x2d8/0x4b00
> [   22.060637]  ? __this_cpu_preempt_check+0x21/0x30
> [   22.060650]  ? __pfx_iommufd_test+0x10/0x10
> [   22.060661]  ? __might_fault+0xf1/0x1b0
> [   22.060672]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   22.060683]  iommufd_fops_ioctl+0x38e/0x520
> [   22.060693]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
> [   22.060704]  ? __this_cpu_preempt_check+0x21/0x30
> [   22.060713]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [   22.060723]  ? lockdep_hardirqs_on+0x89/0x110
> [   22.060734]  ? ktime_get_coarse_real_ts64+0xb6/0x100
> [   22.060745]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
> [   22.060754]  __x64_sys_ioctl+0x1ba/0x220
> [   22.060764]  x64_sys_call+0x1233/0x2150
> [   22.060771]  do_syscall_64+0x6d/0x140
> [   22.060780]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   22.060787] RIP: 0033:0x7f60b7c3ee5d
> [   22.060793] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa=
 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   22.060800] RSP: 002b:00007ffe0d196758 EFLAGS: 00000213 ORIG_RAX: 00=
00000000000010
> [   22.060807] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6=
0b7c3ee5d
> [   22.060811] RDX: 0000000020000440 RSI: 0000000000003ba0 RDI: 0000000=
000000003
> [   22.060815] RBP: 00007ffe0d196770 R08: 00007ffe0d196770 R09: 00007ff=
e0d196770
> [   22.060820] R10: 00007ffe0d196770 R11: 0000000000000213 R12: 00007ff=
e0d1968c8
> [   22.060824] R13: 000000000040188f R14: 0000000000403e08 R15: 00007f6=
0b800d000
> [   22.060835]  </TASK>
> [   22.060840]
> [   22.072913] Allocated by task 1316:
> [   22.073094]  kasan_save_stack+0x2c/0x60
> [   22.073298]  kasan_save_track+0x18/0x40
> [   22.073499]  kasan_save_alloc_info+0x3c/0x50
> [   22.073723]  __kasan_kmalloc+0x88/0xa0
> [   22.073926]  __kmalloc_cache_node_noprof+0x1d0/0x470
> [   22.074179]  __get_vm_area_node+0xf7/0x260
> [   22.074391]  __vmalloc_node_range_noprof+0x25c/0x1420
> [   22.074650]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   22.074888]  iommufd_test+0x2d8/0x4b00
> [   22.075085]  iommufd_fops_ioctl+0x38e/0x520
> [   22.075308]  __x64_sys_ioctl+0x1ba/0x220
> [   22.075517]  x64_sys_call+0x1233/0x2150
> [   22.075719]  do_syscall_64+0x6d/0x140
> [   22.075917]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   22.076171]
> [   22.076261] Freed by task 1316:
> [   22.076428]  kasan_save_stack+0x2c/0x60
> [   22.076628]  kasan_save_track+0x18/0x40
> [   22.076833]  kasan_save_free_info+0x3f/0x60
> [   22.077054]  __kasan_slab_free+0x3d/0x60
> [   22.077258]  kfree+0x28d/0x440
> [   22.077423]  vfree+0x2ce/0x910
> [   22.077590]  __vmalloc_node_range_noprof+0xeca/0x1420
> [   22.077854]  __kvmalloc_node_noprof+0x2a9/0x6a0
> [   22.078094]  iommufd_test+0x2d8/0x4b00
> [   22.078293]  iommufd_fops_ioctl+0x38e/0x520
> [   22.078512]  __x64_sys_ioctl+0x1ba/0x220
> [   22.078724]  x64_sys_call+0x1233/0x2150
> [   22.078931]  do_syscall_64+0x6d/0x140
> [   22.079128]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   22.079388]
> [   22.079478] The buggy address belongs to the object at ffff88804f5ce=
500
> [   22.079478]  which belongs to the cache kmalloc-64 of size 64
> [   22.080073] The buggy address is located 8 bytes inside of
> [   22.080073]  freed 64-byte region [ffff88804f5ce500, ffff88804f5ce54=
0)
> [   22.080655]
> [   22.080744] The buggy address belongs to the physical page:
> [   22.081024] page: refcount:0 mapcount:0 mapping:0000000000000000 ind=
ex:0x0 pfn:0x4f5ce
> [   22.081415] flags: 0xfffffc0000000(node=3D0|zone=3D1|lastcpupid=3D0x=
1fffff)
> [   22.081742] page_type: f5(slab)
> [   22.081917] raw: 000fffffc0000000 ffff88800d4418c0 dead000000000122 =
0000000000000000
> [   22.082297] raw: 0000000000000000 0000000000200020 00000000f5000000 =
0000000000000000
> [   22.082678] page dumped because: kasan: bad access detected
> [   22.082956]
> [   22.083045] Memory state around the buggy address:
> [   22.083287]  ffff88804f5ce400: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   22.083646]  ffff88804f5ce480: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   22.084004] >ffff88804f5ce500: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   22.084361]                       ^
> [   22.084542]  ffff88804f5ce580: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   22.084903]  ffff88804f5ce600: fa fb fb fb fb fb fb fb fc fc fc fc f=
c fc fc fc
> [   22.085263] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   22.085708] Disabling lock debugging due to kernel taint
> [   22.087471] ------------[ cut here ]------------
> [   22.087732] Trying to vfree() bad address (000000006b1be3e6)
> [   22.088039] WARNING: CPU: 1 PID: 1317 at mm/vmalloc.c:3231 remove_vm=
_area+0x1c2/0x220
> [   22.088421] Modules linked in:
> [   22.088590] CPU: 1 UID: 0 PID: 1317 Comm: repro Tainted: G    B     =
          6.14.0-rc6-next-20250311-eea255893718 #1
> [   22.089126] Tainted: [B]=3DBAD_PAGE
> [   22.089308] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   22.089869] RIP: 0010:remove_vm_area+0x1c2/0x220
> [   22.090112] Code: c3 cc cc cc cc e8 7e e2 a4 ff 49 81 ee 00 10 00 00=
 e9 51 ff ff ff e8 6d e2 a4 ff 4c 89 e6 48 c7 c7 a0 eb fa 85 e8 ce 71 63 =
ff <0f> 0b 45 31 ed eb bb 45 31 ed eb b6 e8 ed d2 0f 00 e9 10 ff ff ff
> [   22.090996] ------------[ cut here ]------------
> [   22.091042] RSP: 0018:ffff888022b77978 EFLAGS: 00010292
> [   22.091274] Trying to vfree() bad address (00000000e905f2d4)
> "
>=20
> Hope this cound be insightful to you.
>=20
> Regards,
> Yi Lai
>=20
> ---
>=20
> If you don't need the following environment to reproduce the problem or=
 if you
> already have one reproduced environment, please ignore the following in=
formation.
>=20
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used=
 v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f=
65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,rea=
donly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>=20
> After login vm(virtual machine) successfully, you could transfer reprod=
uced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>=20
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your p=
c has
>=20
> Fill the bzImage file into above start3.sh to load the target kernel in=
 vm.
>=20
>=20
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc -=
-enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>=20

This patch has been dropped, and this patch and the introduced UAF issue =
will be fixed in the next version.

Thanks=EF=BC=8C
Liu Ye

