Return-Path: <linux-kernel+bounces-517578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9E2A38298
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17A4188852E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F6218EB8;
	Mon, 17 Feb 2025 12:07:02 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27021A44D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794022; cv=none; b=pr2N8xCTsdfJRT8aP9jDVUvols+tJREGI5JL1A9NS4cX/V5IXchUZPA25YBfGX5S7uyRi82M0CRt3HDqe4mFEbByF+K8Dav4+RX/PXBQwLctRGOmpuf4g4Yw1HcTQn1ommmxrwafLHMu2hHUkyaE2ntQueHXigjCm0ImJd1TAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794022; c=relaxed/simple;
	bh=X/KpQNA1qmybhn2eemCkawYW7o05VCaGU6XdYv22Az4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5fF46Rz8kU7GrTV3tTFG1UrBmxyYTeJx7QTffrcJMjkdY/w0VfqSIR7yM5q8R1VX6VPzvD45UAuD+QxkwSKcS7aYHDB1ZGDuko5f+FR0Pt5S3Fi7AhFmpJrsT1rmJE3CJmH9rQweaEfdO+GlIfLg1g429EGiU4Nqdy8d4vUWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1F3A43181;
	Mon, 17 Feb 2025 12:06:49 +0000 (UTC)
Message-ID: <a14347d2-6189-49bc-a1cc-e5959e76e6c2@ghiti.fr>
Date: Mon, 17 Feb 2025 13:06:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is
 never less than zero.
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-riscv@lists.infradead.org
References: <202502171326.j4Xd3I0j-lkp@intel.com>
 <20250217092445.GA29568@lst.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250217092445.GA29568@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhephfduteegueelkeelgeejfeeigffhkeefhedvffdugeeuvddtudfhuefgkeffgfeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpihhnfhhrrgguvggrugdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeellegvheemfhgrtdgsmeejiedvugemudgssghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeellegvheemfhgrtdgsmeejiedvugemudgssghfpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeellegvheemfhgrtdgsmeejiedvugemudgssghfngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeejpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehovgdqkhgsuhhil
 hguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Christoph,

On 17/02/2025 10:24, Christoph Hellwig wrote:
> On Mon, Feb 17, 2025 at 01:53:08PM +0800, kernel test robot wrote:
>> New smatch warnings:
>> fs/xfs/xfs_buf.c:1534 xfs_buf_submit_bio() warn: unsigned '_x' is never less than zero.
> Looks like this is an issue in the riscv virt_to_page implementation
> which also shows up in various other places.  Any chance this could get
> fixed in the riscv code?


To me, the only test that could give rise to this warning is the last 
part of:

#define is_linear_mapping(x) \
         ((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < 
PAGE_OFFSET + KERN_VIRT_SIZE))

But given that the config is a 32-bit config, it should not be evaluated 
at all.

Could that be a false-positive and then an issue in smatch?

Thanks,

Alex


>
>> Old smatch warnings:
>> fs/xfs/xfs_linux.h:283 kmem_to_page() warn: unsigned '_x' is never less than zero.
>> fs/xfs/xfs_buf.c:761 xfs_buf_get_map() error: we previously assumed 'bp' could be null (see line 743)
>> arch/riscv/include/asm/atomic.h:218 arch_atomic_fetch_add_unless() warn: inconsistent indenting
>>
>> vim +/_x +1534 fs/xfs/xfs_buf.c
>>
>>    1518	
>>    1519	static void
>>    1520	xfs_buf_submit_bio(
>>    1521		struct xfs_buf		*bp)
>>    1522	{
>>    1523		unsigned int		size = BBTOB(bp->b_length);
>>    1524		unsigned int		map = 0, p;
>>    1525		struct blk_plug		plug;
>>    1526		struct bio		*bio;
>>    1527	
>>    1528		bio = bio_alloc(bp->b_target->bt_bdev, bp->b_page_count,
>>    1529				xfs_buf_bio_op(bp), GFP_NOIO);
>>    1530		bio->bi_private = bp;
>>    1531		bio->bi_end_io = xfs_buf_bio_end_io;
>>    1532	
>>    1533		if (bp->b_flags & _XBF_KMEM) {
>>> 1534			__bio_add_page(bio, virt_to_page(bp->b_addr), size,
>>    1535					bp->b_offset);
>>    1536		} else {
>>    1537			for (p = 0; p < bp->b_page_count; p++)
>>    1538				__bio_add_page(bio, bp->b_pages[p], PAGE_SIZE, 0);
>>    1539			bio->bi_iter.bi_size = size; /* limit to the actual size used */
>>    1540	
>>    1541			if (xfs_buf_is_vmapped(bp))
>>    1542				flush_kernel_vmap_range(bp->b_addr,
>>    1543						xfs_buf_vmap_len(bp));
>>    1544		}
>>    1545	
>>    1546		/*
>>    1547		 * If there is more than one map segment, split out a new bio for each
>>    1548		 * map except of the last one.  The last map is handled by the
>>    1549		 * remainder of the original bio outside the loop.
>>    1550		 */
>>    1551		blk_start_plug(&plug);
>>    1552		for (map = 0; map < bp->b_map_count - 1; map++) {
>>    1553			struct bio	*split;
>>    1554	
>>    1555			split = bio_split(bio, bp->b_maps[map].bm_len, GFP_NOFS,
>>    1556					&fs_bio_set);
>>    1557			split->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
>>    1558			bio_chain(split, bio);
>>    1559			submit_bio(split);
>>    1560		}
>>    1561		bio->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
>>    1562		submit_bio(bio);
>>    1563		blk_finish_plug(&plug);
>>    1564	}
>>    1565	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
> ---end quoted text---
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

