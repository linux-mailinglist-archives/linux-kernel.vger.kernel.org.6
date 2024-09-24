Return-Path: <linux-kernel+bounces-336439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2A1983AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC50B22C56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0129463;
	Tue, 24 Sep 2024 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ4uQ+Wg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995198C06
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727140726; cv=none; b=ca8uYtuURCkP70qiCmoOSC0LqwlmAB0LDoXTCAzCV5HZvpWrwkecGgun+84IaZPwpamU6CdcJz/4TeuxTxmprzxrlfe1OrisTwbQRvlJcU20go1Mgugpw/kt5o41s936BT1fh3jq/3NxR1vCH/lWn6wqYA4xV03ElHDbm86KI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727140726; c=relaxed/simple;
	bh=wOoDaYvorsKuiMpU6ETftUFar58R0m0KF7yRCSBKyY0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NHt8li89FPBBiEst4ZheyFTBvlplxz469P9xlqMcaI5XayEmnlsUNyhjeDv4ergNcf4Kx/0T7p4M/3TdWfZ71J5144ACUvd487pg+uFoOOCmU1srNM1d54spSM7AnR0XD0KinK2SxWA9Aord/mLUiwoZm/uFsvmPYPJxkaVy5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ4uQ+Wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B1FC4CECD;
	Tue, 24 Sep 2024 01:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727140726;
	bh=wOoDaYvorsKuiMpU6ETftUFar58R0m0KF7yRCSBKyY0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iJ4uQ+WgkIo9eNr6lOfaUAg+KPRaS8ZVnro8E7dovz4GiSqHyaUZb9Z4mCTCNG6wb
	 Nc5zXPm4y041vnrrAV4MF9HZ1PxAosZIGz+BuAbjQuK1gAjswuFz3PlNw+xPywhVja
	 vYoemYQTZK6dTLvQ7goj62PXgMNWzerDKLz+o87uwHj36StfKDopaxp1L2Z2Jc3rIo
	 g1mLTlVrex8MExwxz1VYxUHe4rKBoflUkL3aTC+uL37xN0xJ3Av/EqAtUFR60dJLH4
	 CEEremfW7aY23AssIOM7RNXCahLWLWPPUyr98jlfFvRvC9Tdtgd45n5xqa9QnIcZDy
	 OVxiJn6/GgfKA==
Message-ID: <96f8f5e1-41d1-4730-a9d3-73c296ce0c00@kernel.org>
Date: Tue, 24 Sep 2024 09:18:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daeho43@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce device aliasing file
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240913212810.912171-1-daeho43@gmail.com>
 <cef0eeba-6089-44c6-b08e-308f8ee36f6a@kernel.org>
 <CACOAw_xW_UsNLy-j6tySmOLzqR6LDDDCZnpx4Uj8PF=ZTuVRag@mail.gmail.com>
 <ff63da2f-77f8-40f3-a111-1defec6adb04@kernel.org>
 <ZvGFxTDW-6aa3FUe@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZvGFxTDW-6aa3FUe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/9/23 23:14, Jaegeuk Kim wrote:
> On 09/23, Chao Yu wrote:
>> On 2024/9/20 23:38, Daeho Jeong wrote:
>>> On Thu, Sep 19, 2024 at 6:14 AM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2024/9/14 5:28, Daeho Jeong wrote:
>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>
>>>>> F2FS should understand how the device aliasing file works and support
>>>>> deleting the file after use. A device aliasing file can be created by
>>>>> mkfs.f2fs tool and it can map the whole device with an extrent, not
>>>>> using node blocks. The file space should be pinned and normally used for
>>>>> read-only usages.
>>>>>
>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>> ---
>>>>>     fs/f2fs/data.c         |  5 +++++
>>>>>     fs/f2fs/extent_cache.c | 10 ++++++++++
>>>>>     fs/f2fs/f2fs.h         |  5 +++++
>>>>>     fs/f2fs/file.c         | 36 ++++++++++++++++++++++++++++++++----
>>>>>     fs/f2fs/inode.c        | 10 ++++++++--
>>>>>     fs/f2fs/sysfs.c        |  2 ++
>>>>>     6 files changed, 62 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 6457e5bca9c9..9ce92093ba1e 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -3423,6 +3423,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>>>>>
>>>>>         if (!f2fs_lookup_read_extent_cache_block(inode, index,
>>>>>                                                  &dn.data_blkaddr)) {
>>>>> +             if (IS_DEVICE_ALIASING(inode)) {
>>>>> +                     err = -ENODATA;
>>>>> +                     goto out;
>>>>> +             }
>>>>> +
>>>>>                 if (locked) {
>>>>>                         err = f2fs_reserve_block(&dn, index);
>>>>>                         goto out;
>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>> index fd1fc06359ee..03883963b991 100644
>>>>> --- a/fs/f2fs/extent_cache.c
>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>> @@ -401,6 +401,11 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
>>>>>         if (atomic_read(&et->node_cnt) || !ei.len)
>>>>>                 goto skip;
>>>>>
>>>>> +     if (IS_DEVICE_ALIASING(inode)) {
>>>>> +             et->largest = ei;
>>>>> +             goto skip;
>>>>> +     }
>>>>> +
>>>>>         en = __attach_extent_node(sbi, et, &ei, NULL,
>>>>>                                 &et->root.rb_root.rb_node, true);
>>>>>         if (en) {
>>>>> @@ -463,6 +468,11 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
>>>>>                 goto out;
>>>>>         }
>>>>>
>>>>> +     if (IS_DEVICE_ALIASING(inode)) {
>>>>> +             ret = false;
>>>>> +             goto out;
>>>>> +     }
>>>>> +
>>>>>         en = __lookup_extent_node(&et->root, et->cached_en, pgofs);
>>>>>         if (!en)
>>>>>                 goto out;
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index ac19c61f0c3e..59179b9b3a83 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -208,6 +208,7 @@ struct f2fs_mount_info {
>>>>>     #define F2FS_FEATURE_CASEFOLD                       0x00001000
>>>>>     #define F2FS_FEATURE_COMPRESSION            0x00002000
>>>>>     #define F2FS_FEATURE_RO                             0x00004000
>>>>> +#define F2FS_FEATURE_DEVICE_ALIAS            0x00008000
>>>>>
>>>>>     #define __F2FS_HAS_FEATURE(raw_super, mask)                         \
>>>>>         ((raw_super->feature & cpu_to_le32(mask)) != 0)
>>>>> @@ -3001,6 +3002,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>>>>>     #define F2FS_DIRSYNC_FL                     0x00010000 /* dirsync behaviour (directories only) */
>>>>>     #define F2FS_PROJINHERIT_FL         0x20000000 /* Create with parents projid */
>>>>>     #define F2FS_CASEFOLD_FL            0x40000000 /* Casefolded file */
>>>>> +#define F2FS_DEVICE_ALIAS_FL         0x80000000 /* File for aliasing a device */
>>>>>
>>>>>     #define F2FS_QUOTA_DEFAULT_FL               (F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
>>>>>
>>>>> @@ -3016,6 +3018,8 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
>>>>>     /* Flags that are appropriate for non-directories/regular files. */
>>>>>     #define F2FS_OTHER_FLMASK   (F2FS_NODUMP_FL | F2FS_NOATIME_FL)
>>>>>
>>>>> +#define IS_DEVICE_ALIASING(inode)    (F2FS_I(inode)->i_flags & F2FS_DEVICE_ALIAS_FL)
>>>>> +
>>>>>     static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
>>>>>     {
>>>>>         if (S_ISDIR(mode))
>>>>> @@ -4478,6 +4482,7 @@ F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>>>>>     F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
>>>>>     F2FS_FEATURE_FUNCS(compression, COMPRESSION);
>>>>>     F2FS_FEATURE_FUNCS(readonly, RO);
>>>>> +F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
>>>>>
>>>>>     #ifdef CONFIG_BLK_DEV_ZONED
>>>>>     static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>> index 168f08507004..0f4af6b303ff 100644
>>>>> --- a/fs/f2fs/file.c
>>>>> +++ b/fs/f2fs/file.c
>>>>> @@ -727,6 +727,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>>>>
>>>>>         trace_f2fs_truncate_blocks_enter(inode, from);
>>>>>
>>>>> +     if (IS_DEVICE_ALIASING(inode) && from) {
>>>>> +             err = -EINVAL;
>>>>> +             goto out_err;
>>>>> +     }
>>>>> +
>>>>>         free_from = (pgoff_t)F2FS_BLK_ALIGN(from);
>>>>>
>>>>>         if (free_from >= max_file_blocks(inode))
>>>>> @@ -741,6 +746,21 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>>>>                 goto out;
>>>>>         }
>>>>>
>>>>> +     if (IS_DEVICE_ALIASING(inode)) {
>>>>> +             struct extent_tree *et = F2FS_I(inode)->extent_tree[EX_READ];
>>>>> +             struct extent_info ei = et->largest;
>>>>> +             unsigned int i;
>>>>> +
>>>>> +             for (i = 0; i < ei.len; i++)
>>>>> +                     f2fs_invalidate_blocks(sbi, ei.blk + i);
>>>>> +
>>>>> +             dec_valid_block_count(sbi, inode, ei.len);
>>>>> +             f2fs_update_time(sbi, REQ_TIME);
>>>>> +
>>>>> +             f2fs_put_page(ipage, 1);
>>>>> +             goto out;
>>>>> +     }
>>>>> +
>>>>>         if (f2fs_has_inline_data(inode)) {
>>>>>                 f2fs_truncate_inline_inode(inode, ipage, from);
>>>>>                 f2fs_put_page(ipage, 1);
>>>>> @@ -776,7 +796,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>>>>         /* lastly zero out the first data page */
>>>>>         if (!err)
>>>>>                 err = truncate_partial_data_page(inode, from, truncate_page);
>>>>> -
>>>>> +out_err:
>>>>>         trace_f2fs_truncate_blocks_exit(inode, err);
>>>>>         return err;
>>>>>     }
>>>>> @@ -994,7 +1014,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>>>>                 return -EPERM;
>>>>>
>>>>>         if ((attr->ia_valid & ATTR_SIZE)) {
>>>>> -             if (!f2fs_is_compress_backend_ready(inode))
>>>>> +             if (!f2fs_is_compress_backend_ready(inode) ||
>>>>> +                             IS_DEVICE_ALIASING(inode))
>>>>>                         return -EOPNOTSUPP;
>>>>>                 if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
>>>>>                         !IS_ALIGNED(attr->ia_size,
>>>>> @@ -1855,7 +1876,7 @@ static long f2fs_fallocate(struct file *file, int mode,
>>>>>                 return -EIO;
>>>>>         if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
>>>>>                 return -ENOSPC;
>>>>> -     if (!f2fs_is_compress_backend_ready(inode))
>>>>> +     if (!f2fs_is_compress_backend_ready(inode) || IS_DEVICE_ALIASING(inode))
>>>>>                 return -EOPNOTSUPP;
>>>>>
>>>>>         /* f2fs only support ->fallocate for regular file */
>>>>> @@ -3264,6 +3285,9 @@ int f2fs_pin_file_control(struct inode *inode, bool inc)
>>>>>         struct f2fs_inode_info *fi = F2FS_I(inode);
>>>>>         struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>>
>>>>> +     if (IS_DEVICE_ALIASING(inode))
>>>>> +             return -EINVAL;
>>>>> +
>>>>>         if (fi->i_gc_failures >= sbi->gc_pin_file_threshold) {
>>>>>                 f2fs_warn(sbi, "%s: Enable GC = ino %lx after %x GC trials",
>>>>>                           __func__, inode->i_ino, fi->i_gc_failures);
>>>>> @@ -3294,6 +3318,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>>>>>         if (f2fs_readonly(sbi->sb))
>>>>>                 return -EROFS;
>>>>>
>>>>> +     if (!pin && IS_DEVICE_ALIASING(inode))
>>>>> +             return -EOPNOTSUPP;
>>>>> +
>>>>>         ret = mnt_want_write_file(filp);
>>>>>         if (ret)
>>>>>                 return ret;
>>>>> @@ -4711,7 +4738,8 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>>>>>         else
>>>>>                 return 0;
>>>>>
>>>>> -     map.m_may_create = true;
>>>>> +     if (!IS_DEVICE_ALIASING(inode))
>>>>> +             map.m_may_create = true;
>>>>>         if (dio) {
>>>>>                 map.m_seg_type = f2fs_rw_hint_to_seg_type(sbi,
>>>>>                                                 inode->i_write_hint);
>>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>>> index aef57172014f..f118e955ba88 100644
>>>>> --- a/fs/f2fs/inode.c
>>>>> +++ b/fs/f2fs/inode.c
>>>>> @@ -367,6 +367,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>>>>                 return false;
>>>>>         }
>>>>>
>>>>> +     if ((fi->i_flags & F2FS_DEVICE_ALIAS_FL) && !f2fs_sb_has_device_alias(sbi)) {
>>>>> +             f2fs_warn(sbi, "%s: inode (ino=%lx) has device alias flag, but the feature is off",
>>>>> +                       __func__, inode->i_ino);
>>>>> +             return false;
>>>>> +     }
>>>>
>>>> Do we need to do sanity check device_alias feature flag w/
>>>> sb.devs[].path format? and related inode?
>>>
>>> Sorry, I am not sure I got your point. Could you elaborate it more?
>>
>> Oh, sorry, I misunderstand it. alias_filename won't be stored in sb.devs[].path,
>> please ignore it.
>>
>> Another point is: what do you think of doing sanity check on extent_info of
>> device_alias inode?
>>
>> we can check whether its extent points to whole region of target alias device or
>> not?
> 
> Chao, I think we can add this later, as I'd like to queue this in the merge
> window. Wdyt?

Sure.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>>> +
>>>>>         return true;
>>>>>     }
>>>>>
>>>>> @@ -818,8 +824,6 @@ void f2fs_evict_inode(struct inode *inode)
>>>>>         f2fs_bug_on(sbi, get_dirty_pages(inode));
>>>>>         f2fs_remove_dirty_inode(inode);
>>>>>
>>>>> -     f2fs_destroy_extent_tree(inode);
>>>>
>>>> For hardlink inode, it missed to call f2fs_destroy_extent_tree()?
>>>
>>> Got it.
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> -
>>>>>         if (inode->i_nlink || is_bad_inode(inode))
>>>>>                 goto no_delete;
>>>>>
>>>>> @@ -874,6 +878,8 @@ void f2fs_evict_inode(struct inode *inode)
>>>>>                 goto retry;
>>>>>         }
>>>>>
>>>>> +     f2fs_destroy_extent_tree(inode);
>>>>> +
>>>>>         if (err) {
>>>>>                 f2fs_update_inode_page(inode);
>>>>>                 if (dquot_initialize_needed(inode))
>>>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>>>> index fee7ee45ceaa..bf64f4cc3522 100644
>>>>> --- a/fs/f2fs/sysfs.c
>>>>> +++ b/fs/f2fs/sysfs.c
>>>>> @@ -1281,6 +1281,7 @@ F2FS_SB_FEATURE_RO_ATTR(sb_checksum, SB_CHKSUM);
>>>>>     F2FS_SB_FEATURE_RO_ATTR(casefold, CASEFOLD);
>>>>>     F2FS_SB_FEATURE_RO_ATTR(compression, COMPRESSION);
>>>>>     F2FS_SB_FEATURE_RO_ATTR(readonly, RO);
>>>>> +F2FS_SB_FEATURE_RO_ATTR(device_alias, DEVICE_ALIAS);
>>>>>
>>>>>     static struct attribute *f2fs_sb_feat_attrs[] = {
>>>>>         ATTR_LIST(sb_encryption),
>>>>> @@ -1297,6 +1298,7 @@ static struct attribute *f2fs_sb_feat_attrs[] = {
>>>>>         ATTR_LIST(sb_casefold),
>>>>>         ATTR_LIST(sb_compression),
>>>>>         ATTR_LIST(sb_readonly),
>>>>> +     ATTR_LIST(sb_device_alias),
>>>>>         NULL,
>>>>>     };
>>>>>     ATTRIBUTE_GROUPS(f2fs_sb_feat);
>>>>
>>


