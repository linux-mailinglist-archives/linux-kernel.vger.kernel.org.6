Return-Path: <linux-kernel+bounces-272333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDDC945A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93732B220D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0B1C3793;
	Fri,  2 Aug 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M4QPXT/p"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61149659
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589308; cv=none; b=mtWKkVOUk1j0Joq63rSMTw8Wa6aN4mw2fvoGMPfF3F9r8Dpw+vnaSRw11xf8PiMTx9i5BMPJkfjgSb0ChOWa69CfO3xqFBhEpynt7cpMK5Z3q8P2Vy8vofVw8jMeX6ekF3hLG0m8Zh9PR85Phs8UbS29tsw8dPMDY/BSOkoaZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589308; c=relaxed/simple;
	bh=iHd0oRRdj5VAxcNdtUaMaEiKRX81SENnsPbe6vneCYU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lZTzaXb0vq/1/tECKdKgONBg0c43Y9fY+XrqFI+T/N3dOBDMBQ7OX621oTHDJUEbTbVNI75t12QW+H+h9YeXXJNdwBOwA69urKRdfKwSW3VGSycIeAG2Nu8RN0WAuoiuG4tBgjfq1W5PDxF8L2zphDh/vpSCmGDZ/mCrZhuGNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M4QPXT/p; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722589302; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=MmOD1Kd+8JiK9iMzOwNmvwMz5rOtu4BwhOC7vysWx5s=;
	b=M4QPXT/p0UFikh2SpeQmOEw2i8VTQVVDn94wIX4nrQU/lsg+fLVtuJkcILOD0MaU2N1Njv8zMKirreM+xL7d1MZtW2Pn6Vc3bO/amUMg/UZVs9pL3C3bS7XPULZwtJctrM1U+WixHFv+IFCK1I3nQ5eBfySxgsaYYttXjtW20WQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0WBwwROu_1722589300;
Received: from 30.97.48.169(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBwwROu_1722589300)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 17:01:42 +0800
Message-ID: <c7182f2f-8ca3-4b8c-b338-99a5ebd0cad0@linux.alibaba.com>
Date: Fri, 2 Aug 2024 17:01:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <Zqa8NTqKuXkTxzBw@casper.infradead.org>
 <04bbfcd0-6eb1-4a5b-ac21-b3cdf1acdc77@linux.alibaba.com>
In-Reply-To: <04bbfcd0-6eb1-4a5b-ac21-b3cdf1acdc77@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Matthew,

On 2024/7/29 06:11, Gao Xiang wrote:
> Hi,
> 
> On 2024/7/29 05:46, Matthew Wilcox wrote:
>> On Sun, Jul 28, 2024 at 11:49:13PM +0800, Gao Xiang wrote:
>>> It was found by compaction stress test when I explicitly enable EROFS
>>> compressed files to use large folios, which case I cannot reproduce with
>>> the same workload if large folio support is off (current mainline).
>>> Typically, filesystem reads (with locked file-backed folios) could use
>>> another bdev/meta inode to load some other I/Os (e.g. inode extent
>>> metadata or caching compressed data), so the locking order will be:
>>
>> Umm.  That is a new constraint to me.  We have two other places which
>> take the folio lock in a particular order.  Writeback takes locks on
>> folios belonging to the same inode in ascending ->index order.  It
>> submits all the folios for write before moving on to lock other inodes,
>> so it does not conflict with this new constraint you're proposing.
> 
> BTW, I don't believe it's a new order out of EROFS, if you consider
> ext4 or ext2 for example, it will also use sb_bread() (buffer heads
> on bdev inode to trigger some meta I/Os),
> 
> e.g. take ext2 for simplicity:
>    ext2_readahead
>      mpage_readahead
>       ext2_get_block
>         ext2_get_blocks
>           ext2_get_branch
>              sb_bread     <-- get some metadata using for this data I/O

I guess I need to write more words about this:

Although currently sb_bread() mainly take buffer locks to do meta I/Os,
but the following path takes the similar dependency:

                ...
                sb_bread
                  __bread_gfp
                    bdev_getblk
                      __getblk_slow
                        grow_dev_folio  // bdev->bd_mapping
                          __filemap_get_folio(FGP_LOCK | .. | FGP_CREAT)

So the order is already there for decades.. Although EROFS doesn't
use buffer heads since its initial version, it needs a different
address_space to cache metadata in page cache for best performance.

In .read_folio() and .readahead() context, the orders have to be

   file-backed folios
      bdev/meta folios

since it's hard to use any other orders and the file-backed folios
won't be filled without uptodated bdev/meta folios.

> 
>>
>> The other place is remap_file_range().  Both inodes in that case must be
>> regular files,
>>          if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
>>                  return -EINVAL;
>> so this new rule is fine.

Refer to vfs_dedupe_file_range_compare() and vfs_lock_two_folios(), it
seems it only considers folio->index regardless of address_spaces too.

>>
>> Does anybody know of any _other_ ordering constraints on folio locks?  I'm
>> willing to write them down ...
> 
> Personally I don't think out any particular order between two folio
> locks acrossing different inodes, so I think folio batching locking
> always needs to be taken care.


I think folio_lock() comment of different address_spaces added in
commit cd125eeab2de ("filemap: Update the folio_lock documentation")
would be better to be refined:

...
  * in the same address_space.  If they are in different address_spaces,
  * acquire the lock of the folio which belongs to the address_space which
  * has the lowest address in memory first.
  */
static inline void folio_lock(struct folio *folio)
{
...


Since there are several cases we cannot follow the comment above due
to .read_folio(), .readahead() and more contexts.

I'm not sure how to document the order of different address_spaces,
so I think it's just "no particular order between different
address_space".

Thanks,
Gao Xiang


