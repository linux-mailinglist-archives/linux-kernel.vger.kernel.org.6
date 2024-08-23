Return-Path: <linux-kernel+bounces-298151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D895C31B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 04:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7D31C223A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549941B974;
	Fri, 23 Aug 2024 02:05:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D6A934
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724378735; cv=none; b=WDL9gkgQGS+nDvpc/vtprv1i8Fz4hj7MO6T08BDovj2dqEoqsRR2++i3R0c3oA+QlR+0nvVaOUZIFKdZDun0y5VnekUlqnaU82ZKVfaEyqxjUwF4hPUssQ1nGlqDFxs7v7TVI3Q/LqUZrvJmFJU10YCSxm0W3bUdNZErS4gyW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724378735; c=relaxed/simple;
	bh=hIy+stY5OX73HLJyBpa7mSSeygjenyJGuk6G56kQY0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7NeeHQZLRIzF7v2zkwOvuRTGddH4loDImNxG9+tZ7BDm8RCutZ66wpkPRqBC3mj3S8Q/EMxdhCXjSo2bxiVa6d19LlG912GVJ2za0nwgDxNUSbiQjpLffcEzmaTe9oCg+mSWZuyrMFSrkjA5uxqNulsEMCG5dpxqw6csQZWZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2479d9a660f411efa216b1d71e6e1362-20240823
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5c323620-3870-4129-9d0e-6f41e4f965dc,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:12,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:22
X-CID-INFO: VERSION:1.1.38,REQID:5c323620-3870-4129-9d0e-6f41e4f965dc,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:12,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:22
X-CID-META: VersionHash:82c5f88,CLOUDID:7e5ed1af1bca4fb18767e347eb49b346,BulkI
	D:240823100231TLMFDBFW,BulkQuantity:1,Recheck:0,SF:64|66|24|17|19|44|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 2479d9a660f411efa216b1d71e6e1362-20240823
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 493916128; Fri, 23 Aug 2024 10:05:17 +0800
From: liuye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	liuye@kylinos.cn
Subject: Re: Re: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function isolate_lru_folios
Date: Fri, 23 Aug 2024 10:04:43 +0800
Message-Id: <20240823020443.7379-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240815025226.8973-1-liuye@kylinos.cn>
References: <20240815025226.8973-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm sorry to bother you about that, but it looks like the following email send 7 days ago, 
did not receive a response from you. Do you mind having a look at this 
when you have a bit of free time please?

> > > Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-node basis")
> > 
> > Merged in 2016.
> > 
> > Under what circumstances does it occur?  
> 
> User processe are requesting a large amount of memory and keep page active.
> Then a module continuously requests memory from ZONE_DMA32 area.
> Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm reached.
> However pages in the LRU(active_anon) list are mostly from 
> the ZONE_NORMAL area.
> 
> > Can you please describe how to reproduce this?  
> 
> Terminal 1: Construct to continuously increase pages active(anon). 
> mkdir /tmp/memory
> mount -t tmpfs -o size=1024000M tmpfs /tmp/memory
> dd if=/dev/zero of=/tmp/memory/block bs=4M
> tail /tmp/memory/block
> 
> Terminal 2:
> vmstat -a 1
> active will increase.
> procs -----------memory---------- ---swap-- -----io---- -system-- -------cpu-------
>  r  b   swpd   free  inact active   si   so    bi    bo   in   cs us sy id wa st gu
>  1  0      0 1445623076 45898836 83646008    0    0     0     0 1807 1682  0  0 100  0  0  0
>  1  0      0 1445623076 43450228 86094616    0    0     0     0 1677 1468  0  0 100  0  0  0
>  1  0      0 1445623076 41003480 88541364    0    0     0     0 1985 2022  0  0 100  0  0  0
>  1  0      0 1445623076 38557088 90987756    0    0     0     4 1731 1544  0  0 100  0  0  0
>  1  0      0 1445623076 36109688 93435156    0    0     0     0 1755 1501  0  0 100  0  0  0
>  1  0      0 1445619552 33663256 95881632    0    0     0     0 2015 1678  0  0 100  0  0  0
>  1  0      0 1445619804 31217140 98327792    0    0     0     0 2058 2212  0  0 100  0  0  0
>  1  0      0 1445619804 28769988 100774944    0    0     0     0 1729 1585  0  0 100  0  0  0
>  1  0      0 1445619804 26322348 103222584    0    0     0     0 1774 1575  0  0 100  0  0  0
>  1  0      0 1445619804 23875592 105669340    0    0     0     4 1738 1604  0  0 100  0  0  0
> 
> cat /proc/meminfo | head
> Active(anon) increase.
> MemTotal:       1579941036 kB
> MemFree:        1445618500 kB
> MemAvailable:   1453013224 kB
> Buffers:            6516 kB
> Cached:         128653956 kB
> SwapCached:            0 kB
> Active:         118110812 kB
> Inactive:       11436620 kB
> Active(anon):   115345744 kB   
> Inactive(anon):   945292 kB
> 
> When the Active(anon) is 115345744 kB, insmod module triggers the ZONE_DMA32 watermark.
> 
> perf show nr_scanned=28835844. 
> 28835844 * 4k = 115343376KB approximately equal to 115345744 kB.
> 
> perf record -e vmscan:mm_vmscan_lru_isolate -aR
> perf script
> isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=2 nr_skipped=2 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=0 nr_skipped=0 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=28835844 nr_skipped=28835844 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=1 nr_requested=32 nr_scanned=28835844 nr_skipped=28835844 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=29 nr_skipped=29 nr_taken=0 lru=active_anon
> isolate_mode=0 classzone=1 order=0 nr_requested=32 nr_scanned=0 nr_skipped=0 nr_taken=0 lru=active_anon
> 
> If increase Active(anon) to 1000G then insmod module triggers the ZONE_DMA32 watermark. hard lockup will occur.
> 
> In my device nr_scanned = 0000000003e3e937 when hard lockup. Convert to memory size 0x0000000003e3e937 * 4KB = 261072092 KB.
> 
> #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
>     ffffc90006fb7c30: 0000000000000020 0000000000000000 
>     ffffc90006fb7c40: ffffc90006fb7d40 ffff88812cbd3000 
>     ffffc90006fb7c50: ffffc90006fb7d30 0000000106fb7de8 
>     ffffc90006fb7c60: ffffea04a2197008 ffffea0006ed4a48 
>     ffffc90006fb7c70: 0000000000000000 0000000000000000 
>     ffffc90006fb7c80: 0000000000000000 0000000000000000 
>     ffffc90006fb7c90: 0000000000000000 0000000000000000 
>     ffffc90006fb7ca0: 0000000000000000 0000000003e3e937 
>     ffffc90006fb7cb0: 0000000000000000 0000000000000000 
>     ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812cbd3000 
> 
> > Why do you think it took eight years to be discovered?
> 
> The problem requires the following conditions to occur:
> 1. The device memory should be large enough.
> 2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL area.
> 3. The memory in ZONE_DMA32 needs to reach the watermark.
> 
> If the memory is not large enough, or if the usage design of ZONE_DMA32 area memory is reasonable, this problem is difficult to detect.
> 
> notes:
> The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL, but other suitable scenarios may also trigger the problem.
> 
> > It looks like that will fix, but perhaps something more fundamental
> > needs to be done - we're doing a tremendous amount of pretty pointless
> > work here.  Answers to my above questions will help us resolve this.
> > 
> > Thanks.
> 
> Please refer to the above explanation for details.
> 
> Thanks.

Thanks.

