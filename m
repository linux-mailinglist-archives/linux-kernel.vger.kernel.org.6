Return-Path: <linux-kernel+bounces-421270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149A9D88D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE13163275
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BDD1B21BA;
	Mon, 25 Nov 2024 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvWoQhRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73CA157465
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547401; cv=none; b=H3w4cmm/V047Q3TauD3hyzpcuoIs/U5CCXbFZDZjytDXQkv1h6TvcD6x9fZue0XM+VAn84Bievymj90NfCP3+ZNqsw+a9L3wmWvurMMQBYIsOHCkJF4jMAP04CBGmEncfAzQIp/hmfS7GtpA//7S+loyblJVDsXzOIbBij+a/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547401; c=relaxed/simple;
	bh=AaaAPFJGZp2LBZRcY6RK8JEEDW9gxNwMYtG0oEKWzxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSZlCMue70u0M4hTSacgmr8qaeASEWs6xf/nuwwU4sjxnZJB3osLeYnlTU36yaxy8F8jH9jGcj4v8wxQ7Byag6Q/WXdNchWE5YVUvF4WP4Auusqe0X+PemeZvwGoA1pnttjunnwrx8GUyjZStatyGPWJSrFjFfIvBt/JK1wmPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvWoQhRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E252BC4CECE;
	Mon, 25 Nov 2024 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732547401;
	bh=AaaAPFJGZp2LBZRcY6RK8JEEDW9gxNwMYtG0oEKWzxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvWoQhRuB4aZNFKG5yXtkv9mm/py0uiCAtfh8yuPaOdAXssmU7ieGRl2ynsJyxSbP
	 qfEsTA6gn2HlUo8xCAYl/H1B1rJAqLmNnaZ8I2cFgrSwF6TBQob8Z29r2x5DHAte2H
	 0y4M5k6o6bnn4rHWTa/roMlz/Fem+I3wntDwppXQplF6fqokTIt4ta6h+G3ES2cmf5
	 Jdn7y2DSljDBu9dlwAxn0MT+6kJydprPQsmF0b+2tuxDuhzixZEOdjcgAbl19NMYGC
	 AFI4K5z0zdZhV2QlHHNBqaYWVEhgOgTRAXUb36GiGxk2XsLCNNeAi2sIx5kRsWbhl5
	 8/3Wz+HGm8+SQ==
Date: Mon, 25 Nov 2024 10:09:59 -0500
From: Sasha Levin <sashal@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
Message-ID: <Z0STR6VLt2MCalnY@sashalap>
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118100623.2674026-1-catalin.marinas@arm.com>

On Mon, Nov 18, 2024 at 10:06:23AM +0000, Catalin Marinas wrote:
>  - MTE: hugetlbfs support and the corresponding kselftests

Hi Catalin,

It looks like with the new feature above, LTP manages to trigger the
following warning on linus-next:

[  100.133691] hugefork01 (362): drop_caches: 3
tst_hugepage.c:84: TINFO: 2 hugepage(s) reserved
tst_tmpdir.c:316: TINFO: Using /scratch/ltp-CckaqgMrC1/LTP_hug5PSMw8 as tmpdir (ext2/ext3/ext4 filesystem)
tst_test.c:1085: TINFO: Mounting none to /scratch/ltp-CckaqgMrC1/LTP_hug5PSMw8/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:1860: TINFO: LTP version: 20240930
tst_test.c:1864: TINFO: Tested kernel: 6.12.0 #1 SMP PREEMPT @1732504538 aarch64
tst_test.c:1703: TINFO: Timeout per run is 0h 02m 30s
<4>[  100.355230] ------------[ cut here ]------------
<4>[  100.356888] WARNING: CPU: 0 PID: 363 at arch/arm64/include/asm/mte.h:58 copy_highpage+0x1d4/0x2d8
<4>[  100.359160] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
<4>[  100.363578] CPU: 0 UID: 0 PID: 363 Comm: hugefork01 Not tainted 6.12.0 #1
<4>[  100.365113] Hardware name: linux,dummy-virt (DT)
<4>[  100.365966] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
<4>[  100.366468] pc : copy_highpage+0x1d4/0x2d8
<4>[  100.366780] lr : copy_highpage+0x78/0x2d8
<4>[  100.367090] sp : ffff80008066bb30
<4>[  100.368094] x29: ffff80008066bb30 x28: ffffc1ffc3118000 x27: 0000000000000000
<4>[  100.369341] x26: 0000000000000000 x25: 0000ffff9ce00000 x24: ffffc1ffc3118000
<4>[  100.370223] x23: fff00000c47ff000 x22: fff00000c4fff000 x21: ffffc1ffc3138000
<4>[  100.370739] x20: ffffc1ffc3138000 x19: ffffc1ffc311ffc0 x18: ffffffffffffffff
<4>[  100.371285] x17: 0000000000000000 x16: ffffa302fd05bcb0 x15: 0000ffff9d2fdfff
<4>[  100.372778] x14: 0000000000000000 x13: 1ffe00001859f161 x12: fff00000c2cf8b0c
<4>[  100.374124] x11: ffff80008066bd70 x10: ffffa302fe2a20d0 x9 : ffffa302fb438578
<4>[  100.374877] x8 : ffff80008066ba48 x7 : 0000000000000000 x6 : ffffa302fdbdf000
<4>[  100.376152] x5 : 0000000000000000 x4 : fff00000c2f239c0 x3 : fff00000c33e43f0
<4>[  100.376962] x2 : ffffc1ffc3138000 x1 : 00000000000000f4 x0 : 0000000000000000
<4>[  100.377964] Call trace:
<4>[  100.378736]  copy_highpage+0x1d4/0x2d8 (P)
<4>[  100.379422]  copy_highpage+0x78/0x2d8 (L)
<4>[  100.380272]  copy_user_highpage+0x20/0x48
<4>[  100.380805]  copy_user_large_folio+0x1bc/0x268
<4>[  100.381601]  hugetlb_wp+0x190/0x860
<4>[  100.382031]  hugetlb_fault+0xa28/0xc10
<4>[  100.382911]  handle_mm_fault+0x2a0/0x2c0
<4>[  100.383511]  do_page_fault+0x12c/0x578
<4>[  100.384913]  do_mem_abort+0x4c/0xa8
<4>[  100.385397]  el0_da+0x44/0xb0
<4>[  100.385775]  el0t_64_sync_handler+0xc4/0x138
<4>[  100.386243]  el0t_64_sync+0x198/0x1a0
<4>[  100.388759] ---[ end trace 0000000000000000 ]---

-- 
Thanks,
Sasha

