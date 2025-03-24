Return-Path: <linux-kernel+bounces-573561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B7DA6D91B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548351890A06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D725E448;
	Mon, 24 Mar 2025 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="KNwC1Hgc"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81D25E821
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815462; cv=none; b=rMFoJzdjhaGi6XJCXkNKNC8ZJLd/rI1nZjQw4nJut9lH0v089NpnN21F9kmYTNFH0cOFIDkH7SuQOJYXOnObyRvl0dxJptsJ0AwPfhP9pH3HtaRMtTO87K+GIZSNKES4HdImPYxufTtI+6QLaeeaEGUeFlkngDFUPhbv5JYB6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815462; c=relaxed/simple;
	bh=CJuhWe5ZZQUGcK2thsHhtLd9q0I50vr6PP8HUcW2ctA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kgwYMRqPT47OAIKUDHoFfqmEBx2Dyad20JizkrYS1fqvdFEow+6AVsACkNGvPIdmanWBPX3oRQB2Z12Mk4A3VLmQ+alZM11k0XpuyJgk6OW+SAV05MVcELeoET6+oqdCN5Fr7lhVYMwz8G8mE7dFnu4KwvkJMjHZyPVcKWk1GiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=KNwC1Hgc; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742815412; x=1743420212; i=spasswolf@web.de;
	bh=t4Cpapl3baAmiTt6x14k0Cj3EFlot8neELappOm/z8c=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KNwC1HgcuMKyAOyEe329rsDXD3TXLIV09LnmZSnTIgrxl5bin0+66nZWDuGj77GX
	 Mat2V9+bhSWeV5BMSTHIEYouYt17C8X/yG3FB8Y5NX7lWjVHRieYEIRyalC667XPN
	 2x+B7kMFV3mIjS9rW1vU9LX/kjMARQlxIwzapx42KrudUCryTlEPug8qe+IC8+/hh
	 z7jt2s6IlvsQmameb8alTYjsUj8Y4+oIARV1RoiUrpYdmuq0t8RsdUG7qep2/I6I9
	 vdsW/wdCfhE8jZPu2zplfb1Hu43dGZZc6arwrFapN8oLcrLY/ozOvUbqztKgHPbnr
	 ya+Xn+6Je1vr07Ha1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNwfK-1tldIS2Hfs-00S1h5; Mon, 24
 Mar 2025 12:23:32 +0100
Message-ID: <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 spasswolf@web.de
Date: Mon, 24 Mar 2025 12:23:31 +0100
In-Reply-To: <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
References: <20250322122351.3268-1-spasswolf@web.de>
	 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dDemjBujtQn+6tqcgh5+3Dn7V+R82lNECNi2xUYzGYyaT15Xyy4
 eB2q7XijRtTQiqBJ97bjJV0L9yTvjmB//qk38VzoA9EZTaOQKi6LMfrcoXPXBqluWnhqAcf
 NBJrW5/tNAguX3rF1iE276i6lQfh0ldtz531PylqfJQrlb8g+/Ja25VwMHjbrHKhHnd/aTx
 9qDCMTpwNdyMA11HA29jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZVVzgLEz+V4=;ZDBHC3VnPMdTgCtmwVxGT/xw0D0
 8DMWxVSBPAtsF15jovB4oIr4iG27XXoylRfp+oDPWq46JfwwHiMl6ifK35VqLYdWKChhm1C6h
 +8jQ6yVnd3AvvSklJ2rD0wUfeOevBk47Mm2drDm3w39xecG3NQ9ORaPagJEJjbn5Oz/tWZdeh
 iJRIPwYAbD0ZF0pDcIBZIa3CsgsTqe7rLse/TX8MjDDwGlsb9OAbpPr8/peO2h9SMytIiNAu0
 LOt97PjwAJpoFxrx9ANlAm7ONRbx21Slx/KCgUO/MMt5DF1mlIxiEea86trfpcO24HmXp+TkR
 eR91kly6oHdbgGzYII04Me935jlFg5sk1hnfIAzEOORPKUGZuTBU9XUXORD9/8Sl2Bv5xwOnS
 YRj9KmTzGDl4b7Ph9FumTPm2hGkO3qBVh/ou64xbkN36a15wOHOkeoenrNUkah8S8KnbUwio5
 pDcYg+aiPNN5KElj7Ti+J3f9zt7XKFRi+7ZuFwirUF1tpUGKUBiXqVcCO20C7zLzWaUxx6PLO
 YU4TYQIWnB2eRmsy+tjQbXAOVU7RharHYrVoEy7C/dnkZPb7EdmAQCW3Hw5gSc23z+UMKCdwj
 UluUBlv2YcFU4gzHjrjE/h8Q8MJErR/ncv1aUKle2SBRm3zeXbVTrryDCQ9nKG660ZzluLES5
 we6U9N5pVfFQYPNVg3QZutcN6p8v8lNySjg7o3cESoFunYvZSHj6t0IG/OS7fIRSkmagcHrGu
 sKfJdWDG0RJUkttp9CUGzcuo7Tg1Hu65HPmXw23IjW/L/ijf3h6POLYkMF3Fnnna8bG5TKbMg
 M3ezyPzlvh7HD+H4KoOeaKvTEiUUKh+xVtZDZsJLw3oJHlybqglEhAHtybuujOdPYc3YWDtT7
 NYSz/na5IfCwHRuAFVlCMgTME+NHlqteOjJlL1VgPs6JBeq6W5VT54D6OLS5mMk4hfEHliozQ
 Nfji/naJJFRmyauuO5JBOhKy8ms1F2BInS5vT6FyU7OaqPWkdwoylyCZJnUhWAegturKLxILO
 0YQcCmABre3pmF10gg+usWAt3TZM6VS5/GksKVdT7n8nqi57v/A9FpIScfU8qzeYkiikf7s9O
 Vssz4UZ8Sj1+PTJ8LFl+SiKQMjwpzmjyE93exAWf3WNfnZ5AGAbH6WZDaD/5L5L8HrakJ/Jiu
 HbD7ql2ASXxbEgaOuT3wBcYeRFOwNEfPxq2Y+vNOkdNOXprWy5mB0qf8/7hFVjAQxwpwyQ+Cj
 HIOHbHzgM6YU1xe8OPcoBVqEaN+SJQzZ3dHGFnN8i5lNSOXXbwe8tRB1syknDwFSHmyayfovH
 v7bAGro23OPguPKhEUX3PFuI1IQrSotzW91JOS8JRNLpn5WnvOKyNuydHMAnpni5x5Zmcio+c
 g9jWCpGJausz6j/+UEKeP7dm1uhWygPtHpDgCP+TmriLgbFO6oIY7zI3/2UlTaqWFLM+hKQdb
 SVii/rOhIr2N8jKNSv+HJ3eeR5PY=

Am Sonntag, dem 23.03.2025 um 17:51 +1100 schrieb Balbir Singh:
> On 3/22/25 23:23, Bert Karwatzki wrote:
> > The problem occurs in this part of ttm_tt_populate(), in the nokaslr c=
ase
> > the loop is entered and repeatedly run because ttm_dma32_pages allocat=
ed exceeds
> > the ttm_dma32_pages_limit which leads to lots of calls to ttm_global_s=
wapout().
> >
> > if (!strcmp(get_current()->comm, "stellaris"))
> > 	printk(KERN_INFO "%s: ttm_pages_allocated=3D0x%llx ttm_pages_limit=3D=
0x%lx ttm_dma32_pages_allocated=3D0x%llx ttm_dma32_pages_limit=3D0x%lx\n",
> > 			__func__, ttm_pages_allocated.counter, ttm_pages_limit, ttm_dma32_p=
ages_allocated.counter, ttm_dma32_pages_limit);
> > while (atomic_long_read(&ttm_pages_allocated) > ttm_pages_limit ||
> >        atomic_long_read(&ttm_dma32_pages_allocated) >
> >        ttm_dma32_pages_limit) {
> >
> > 	if (!strcmp(get_current()->comm, "stellaris"))
> > 	printk(KERN_INFO "%s: count=3D%d ttm_pages_allocated=3D0x%llx ttm_pag=
es_limit=3D0x%lx ttm_dma32_pages_allocated=3D0x%llx ttm_dma32_pages_limit=
=3D0x%lx\n",
> > 			__func__, count++, ttm_pages_allocated.counter, ttm_pages_limit, tt=
m_dma32_pages_allocated.counter, ttm_dma32_pages_limit);
> > 	ret =3D ttm_global_swapout(ctx, GFP_KERNEL);
> > 	if (ret =3D=3D 0)
> > 		break;
> > 	if (ret < 0)
> > 		goto error;
> > }
> >
> > In the case without nokaslr on the number of ttm_dma32_pages_allocated=
 is 0 because
> > use_dma32 =3D=3D false in this case.
> >
> > So why is use_dma32 enabled with nokaslr? Some more printk()s give thi=
s result:
> >
> > The GPUs:
> > built-in:
> > 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/A=
TI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> > discrete:
> > 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Nav=
i 23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
> >
> > With nokaslr:
> > [    1.266517] [    T328] dma_addressing_limited: mask =3D 0xfffffffff=
ff bus_dma_limit =3D 0x0 required_mask =3D 0xfffffffff
> > [    1.266519] [    T328] dma_addressing_limited: ops =3D 000000000000=
0000 use_dma_iommu(dev) =3D 0
> > [    1.266520] [    T328] dma_direct_all_ram_mapped: returning true
> > [    1.266521] [    T328] dma_addressing_limited: returning ret =3D 0
> > [    1.266521] [    T328] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init=
: calling ttm_device_init() with use_dma32 =3D 0
> > [    1.266525] [    T328] entering ttm_device_init, use_dma32 =3D 0
> > [    1.267115] [    T328] entering ttm_pool_init, use_dma32 =3D 0
> >
> > [    3.965669] [    T328] dma_addressing_limited: mask =3D 0xfffffffff=
ff bus_dma_limit =3D 0x0 required_mask =3D 0x3fffffffffff
> > [    3.965671] [    T328] dma_addressing_limited: returning true
> > [    3.965672] [    T328] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init=
: calling ttm_device_init() with use_dma32 =3D 1
> > [    3.965674] [    T328] entering ttm_device_init, use_dma32 =3D 1
> > [    3.965747] [    T328] entering ttm_pool_init, use_dma32 =3D 1
> >
> > Without nokaslr:
> > [    1.300907] [    T351] dma_addressing_limited: mask =3D 0xfffffffff=
ff bus_dma_limit =3D 0x0 required_mask =3D 0xfffffffff
> > [    1.300909] [    T351] dma_addressing_limited: ops =3D 000000000000=
0000 use_dma_iommu(dev) =3D 0
> > [    1.300910] [    T351] dma_direct_all_ram_mapped: returning true
> > [    1.300910] [    T351] dma_addressing_limited: returning ret =3D 0
> > [    1.300911] [    T351] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init=
: calling ttm_device_init() with use_dma32 =3D 0
> > [    1.300915] [    T351] entering ttm_device_init, use_dma32 =3D 0
> > [    1.301210] [    T351] entering ttm_pool_init, use_dma32 =3D 0
> >
> > [    4.000602] [    T351] dma_addressing_limited: mask =3D 0xfffffffff=
ff bus_dma_limit =3D 0x0 required_mask =3D 0xfffffffffff
> > [    4.000603] [    T351] dma_addressing_limited: ops =3D 000000000000=
0000 use_dma_iommu(dev) =3D 0
> > [    4.000604] [    T351] dma_direct_all_ram_mapped: returning true
> > [    4.000605] [    T351] dma_addressing_limited: returning ret =3D 0
> > [    4.000606] [    T351] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init=
: calling ttm_device_init() with use_dma32 =3D 0
> > [    4.000610] [    T351] entering ttm_device_init, use_dma32 =3D 0
> > [    4.000687] [    T351] entering ttm_pool_init, use_dma32 =3D 0
> >
> > So with nokaslr the reuqired mask for the built-in GPU changes from 0x=
fffffffffff
> > to 0x3fffffffffff which causes dma_addressing_limited to return true w=
hich causes
> > the ttm_device init to be called with use_dma32 =3D true.
>
> Thanks, this is really the root cause, from what I understand.
>
> >  It also show that for the discreate GPU nothing changes so the bug do=
es not occur
> > there.
> >
> > I also was able to work around the bug by calling ttm_device_init() wi=
th use_dma32=3Dfalse
> > from amdgpu_ttm_init()  (drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c) but =
I'm not sure if this
> > has unwanted side effects.
> >
> > int amdgpu_ttm_init(struct amdgpu_device *adev)
> > {
> > 	uint64_t gtt_size;
> > 	int r;
> >
> > 	mutex_init(&adev->mman.gtt_window_lock);
> >
> > 	dma_set_max_seg_size(adev->dev, UINT_MAX);
> > 	/* No others user of address space so set it to 0 */
> > 	dev_info(adev->dev, "%s: calling ttm_device_init() with use_dma32 =3D=
 0 ignoring %d\n", __func__, dma_addressing_limited(adev->dev));
> > 	r =3D ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
> > 			       adev_to_drm(adev)->anon_inode->i_mapping,
> > 			       adev_to_drm(adev)->vma_offset_manager,
> > 			       adev->need_swiotlb,
> > 			       false /* use_dma32 */);
> > 	if (r) {
> > 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
> > 		return r;
> > 	}
> >
>
> I think this brings us really close, instead of forcing use_dma32 to fal=
se, I wonder if we need something like
>
> uin64_t dma_bits =3D fls64(dma_get_mask(adev->dev));
>
> to ttm_device_init, pass the last argument (use_dma32) as dma_bits < 32?
>
>
> Thanks,
> Balbir Singh
>

Do these address bits have to shift when using nokaslr or PCI_P2PDMA, I th=
ink
this shift cause the increase of the required_dma_mask to 0x3fffffffffff?

@@ -104,4 +104,4 @@
       fe30300000-fe303fffff : 0000:04:00.0
     fe30400000-fe30403fff : 0000:04:00.0
     fe30404000-fe30404fff : 0000:04:00.0
-afe00000000-affffffffff : 0000:03:00.0
+3ffe00000000-3fffffffffff : 0000:03:00.0

And what memory is this? It's 8G in size so it could be the RAM of the dis=
crete
GPU (which is at PCI 0000:03:00.0), but that is already here (part of
/proc/iomem):

1010000000-ffffffffff : PCI Bus 0000:00
  fc00000000-fe0fffffff : PCI Bus 0000:01
    fc00000000-fe0fffffff : PCI Bus 0000:02
      fc00000000-fe0fffffff : PCI Bus 0000:03
        fc00000000-fdffffffff : 0000:03:00.0  GPU RAM
        fe00000000-fe0fffffff : 0000:03:00.0

lspci -v reports 8G of memory at 0xfc00000000 so I assmumed that is the GP=
U RAM.
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
[Radeon RX 6600/6600 XT/6600M] (rev c3)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Flags: bus master, fast devsel, latency 0, IRQ 107, IOMMU group 14
	Memory at fc00000000 (64-bit, prefetchable) [size=3D8G]
	Memory at fe00000000 (64-bit, prefetchable) [size=3D256M]
	Memory at fca00000 (32-bit, non-prefetchable) [size=3D1M]
	Expansion ROM at fcb00000 [disabled] [size=3D128K]

Bert Karwatzki


