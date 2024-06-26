Return-Path: <linux-kernel+bounces-229892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C49175AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012401F21F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA310958;
	Wed, 26 Jun 2024 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmPODW12"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03072E54D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365771; cv=none; b=KZwAsv3jxDf3tWzYgnTlEqAVX4bo37zt2pOoG0FSApX6TJHLgVY7fj1hbKd1aYATZdFTsJ9PzZtPaKxQfAAc8/96HqmwyoEpXeDHR4N5iAoNw/HxInCmQuRLRL4ksnurcHtoziwHp2rMj+8bacf1C79QB/a00Bh20lFuf4I4IIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365771; c=relaxed/simple;
	bh=EylTKytTiKR9UrIKOV/TB/XinEmowGbxpBbo3aAMfK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DszPjUYFUB0m8/89EsfHb3oD0wi0CJZxGTK2hYWLstIn1A8HWFUF5/K6W5VXZUlTEdUlPK3w78ofre0ILgQyEN6cKGGJ+Wxoevc7Nf+Jo6ufp5nWxuyEoZ1EGd2T4i+s/2Xq23RoHGB6AzcKSzzke5p2aHk1YFUUpUG+7FeCEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmPODW12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2E7C32781;
	Wed, 26 Jun 2024 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365770;
	bh=EylTKytTiKR9UrIKOV/TB/XinEmowGbxpBbo3aAMfK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tmPODW12+jYfkp2v954iTtNTfrXmeMgaOah3hGRH1IogwB90lD+l6TAMDg2vtcZzy
	 xt2ZQLqeFW/hB/Imbu/f5sXf/TdaaQ6TJGkVtbdInWetc6p7TQlHge4PYSOJZ61WKF
	 VU2mnLzQ++V7mBxpvPpKZWBjb4hZR8KHDhmdXSrJOlw4AZdn0rDX+qZXnU3BsU7m8H
	 Z5wOgxuNuWL77Yt7k3H4ybCjuOoMbDgWOi2Q4tXBU07CkAqa+YWzWUKd+HjqkKTK2H
	 jvdpJzAJ97pDO8abytKpDrieh4wmTafgPuPx4R2Bjt5pWrBK9RyU50E/zX+N/xeTxP
	 y95tgcpgg+5Rg==
Message-ID: <1516a462-1273-428d-aa3d-285bd00b7b69@kernel.org>
Date: Wed, 26 Jun 2024 09:36:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtmMmZzLWRldl0g562U5aSNOiBbUEFUQ0ggdjRdIGYyZnM6IHJl?=
 =?UTF-8?Q?duce_expensive_checkpoint_trigger_frequency?=
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 =?UTF-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>,
 wangzijie <wangzijie1@honor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20240625065459.3665791-1-chao@kernel.org>
 <a861d9aaf9394aa6bc77548735629f87@BJMBX02.spreadtrum.com>
 <1fe7878f-36db-4055-9e40-b39425eb5936@kernel.org>
 <CAHJ8P3Jj0SYuTgqo12r1fZxnWrx_ZH-=Cg5FUhmX4ZvRCLbROA@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3Jj0SYuTgqo12r1fZxnWrx_ZH-=Cg5FUhmX4ZvRCLbROA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/25 19:07, Zhiguo Niu wrote:
> Chao Yu <chao@kernel.org> 于2024年6月25日周二 18:38写道：
>>
>> On 2024/6/25 16:09, 牛志国 (Zhiguo Niu) wrote:
>>>
>>>
>>> -----邮件原件-----
>>> 发件人: Chao Yu <chao@kernel.org>
>>> 发送时间: 2024年6月25日 14:55
>>> 收件人: jaegeuk@kernel.org
>>> 抄送: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; Chao Yu <chao@kernel.org>; wangzijie <wangzijie1@honor.com>; 牛志国 (Zhiguo Niu) <Zhiguo.Niu@unisoc.com>; Yunlei He <heyunlei@hihonor.com>
>>> 主题: [PATCH v4] f2fs: reduce expensive checkpoint trigger frequency
>>>
>>>
>>> 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>>
>>> We may trigger high frequent checkpoint for below case:
>>> 1. mkdir /mnt/dir1; set dir1 encrypted
>>> 2. touch /mnt/file1; fsync /mnt/file1
>>> 3. mkdir /mnt/dir2; set dir2 encrypted
>>> 4. touch /mnt/file2; fsync /mnt/file2
>>> ...
>>>
>>> Although, newly created dir and file are not related, due to commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will trigger checkpoint whenever fsync() comes after a new encrypted dir created.
>>>
>>> In order to avoid such performance regression issue, let's record an entry including directory's ino in global cache whenever we update directory's xattr data, and then triggerring checkpoint() only if xattr metadata of target file's parent was updated.
>>>
>>> This patch updates to cover below no encryption case as well:
>>> 1) parent is checkpointed
>>> 2) set_xattr(dir) w/ new xnid
>>> 3) create(file)
>>> 4) fsync(file)
>>>
>>> Fixes: bbf156f7afa7 ("f2fs: fix lost xattrs of directories")
>>> Reported-by: wangzijie <wangzijie1@honor.com>
>>> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> Reported-by: Yunlei He <heyunlei@hihonor.com>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>    fs/f2fs/f2fs.h              |  2 ++
>>>    fs/f2fs/file.c              |  3 +++
>>>    fs/f2fs/xattr.c             | 14 ++++++++++++--
>>>    include/trace/events/f2fs.h |  3 ++-
>>>    4 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index f1d65ee3addf..f3c910b8983b 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -284,6 +284,7 @@ enum {
>>>           APPEND_INO,             /* for append ino list */
>>>           UPDATE_INO,             /* for update ino list */
>>>           TRANS_DIR_INO,          /* for transactions dir ino list */
>>> +       ENC_DIR_INO,            /* for encrypted dir ino list */
>>>           FLUSH_INO,              /* for multiple device flushing */
>>>           MAX_INO_ENTRY,          /* max. list */
>>>    };
>>> @@ -1150,6 +1151,7 @@ enum cp_reason_type {
>>>           CP_FASTBOOT_MODE,
>>>           CP_SPEC_LOG_NUM,
>>>           CP_RECOVER_DIR,
>>> +       CP_ENC_DIR,
>>>    };
>>>
>>>    enum iostat_type {
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index a527de1e7a2f..278573974db4 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -217,6 +217,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>>>                   f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>>>                                                           TRANS_DIR_INO))
>>>                   cp_reason = CP_RECOVER_DIR;
>>> +       else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>>> +                                                       ENC_DIR_INO))
>>> +               cp_reason = CP_ENC_DIR;
>>>
>>>           return cp_reason;
>>>    }
>>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c index f290fe9327c4..d04c0b47a4e4 100644
>>> --- a/fs/f2fs/xattr.c
>>> +++ b/fs/f2fs/xattr.c
>>> @@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>>                           const char *name, const void *value, size_t size,
>>>                           struct page *ipage, int flags)  {
>>> +       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>           struct f2fs_xattr_entry *here, *last;
>>>           void *base_addr, *last_base_addr;
>>>           int found, newsize;
>>> @@ -772,9 +773,18 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>>           if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
>>>                           !strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
>>>                   f2fs_set_encrypted_inode(inode);
>>> -       if (S_ISDIR(inode->i_mode))
>>> -               set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
>>>
>>> +       if (!S_ISDIR(inode->i_mode))
>>> +               goto same;
>>> +       /*
>>> +        * In restrict mode, fsync() always try to trigger checkpoint for all
>>> +        * metadata consistency, in other mode, it triggers checkpoint when
>>> +        * parent's xattr metadata was updated.
>>> +        */
>>> +       if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
>>> +               set_sbi_flag(sbi, SBI_NEED_CP);
>>> Hi Chao,
>>> For this case, will it also cause the same issue with original issue when fsync_mode == FSYNC_MODE_STRICT ?
>>> if ckpt thread is blocked by some reasons and SBI_NEED_CP is not cleared in time, Subsequent fsync will trigger cp?
>>
>> Hi Zhiguo,
>>
>> If there is no dirty data after previous CP, later CP triggered by subsequent
>> fsync will return directly?
>>
>>          if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
>>                  ((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
>>                  ((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
>>                  goto out;
> 
> Hi Chao,
> I mean in the case of  F2FS_OPTION(sbi).fsync_mode ==
> FSYNC_MODE_STRICT,  this will still cause the same issue with original
> question.
> Let me repost the problems I encountered .
> 
> 1.set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> 
> 2. cp threa is blocked by io resource
> #0 [ffffffc015fcb330] __switch_to at ffffffc010196350
> #1 [ffffffc015fcb390] __schedule at ffffffc01168e53c
> #2 [ffffffc015fcb3f0] schedule at ffffffc01168ed7c
> #3 [ffffffc015fcb450] io_schedule at ffffffc01168f7a0
> #4 [ffffffc015fcb4c0] blk_mq_get_tag at ffffffc0101008a4

It seems there is no free tag at that time, can you check its context
to see why IO queue can be congested once you can reproduce this issue?

If the bottleneck is performance of storage, how about using other
fsync_mode if its data consistency performace matches the requirement.

Thanks,

> #5 [ffffffc015fcb530] blk_mq_get_request at ffffffc0109241b0
> #6 [ffffffc015fcb5f0] blk_mq_make_request at ffffffc0109233bc
> #7 [ffffffc015fcb680] generic_make_request at ffffffc0100fc6ec
> #8 [ffffffc015fcb700] submit_bio at ffffffc0100fc3b8
> #9 [ffffffc015fcb750] __submit_bio at ffffffc01081a2e0
> #10 [ffffffc015fcb7d0] __submit_merged_bio at ffffffc01081b07c
> #11 [ffffffc015fcb8a0] f2fs_submit_page_write at ffffffc0100ecd3c
> #12 [ffffffc015fcb990] f2fs_do_write_meta_page at ffffffc010845738
> #13 [ffffffc015fcb9d0] __f2fs_write_meta_page at ffffffc01080a8f4
> #14 [ffffffc015fcbb60] f2fs_sync_meta_pages at ffffffc01080a684
> #15 [ffffffc015fcbca0] do_checkpoint at ffffffc01080f0a8
> #16 [ffffffc015fcbd10] f2fs_write_checkpoint at ffffffc01080e50c
> #17 [ffffffc015fcbdb0] __checkpoint_and_complete_reqs at ffffffc010810f54
> #18 [ffffffc015fcbe40] issue_checkpoint_thread at ffffffc0108113ec
> #19 [ffffffc015fcbe80] kthread at ffffffc0102665b0
> 
> 3. subsequent fsync will still issue ckpt becasue SBI_NEED_CP is set,
> and if this is a very important thread, it will cause system issue,
> such as init.
> but this is should be avoided.
> PID: 287      TASK: ffffff80f9eb0ec0  CPU: 2    COMMAND: "init"
> 
> #0 [ffffffc01389bab0] __switch_to at ffffffc010196350
> #1 [ffffffc01389bb10] __schedule at ffffffc01168e53c
> #2 [ffffffc01389bb70] schedule at ffffffc01168ed7c
> #3 [ffffffc01389bbc0] wait_for_completion at ffffffc011692368
> #4 [ffffffc01389bca0] f2fs_issue_checkpoint at ffffffc010810cb0
> #5 [ffffffc01389bd00] f2fs_sync_fs at ffffffc0107f4e1c
> #6 [ffffffc01389bdc0] f2fs_do_sync_file at ffffffc0107d4d44
> #7 [ffffffc01389be20] f2fs_sync_file at ffffffc0107d492c
> #8 [ffffffc01389be30] __arm64_sys_fsync at ffffffc0105d31d8
> #9 [ffffffc01389be70] el0_svc_common at ffffffc0101aa550
> #10 [ffffffc01389beb0] el0_svc_handler at ffffffc0100886fc
> 
> thanks!
>>
>>> +       else
>>> +               f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
>>> This patch version regardless of whether dir is encrypted or not, so this name(ENC_DIR_INO) can be rename other for more accurate?
>>
>> Thanks for pointing out this, let me fix it in v5.
>>
>> Thanks,
>>
>>> Thanks！
>>>    same:
>>>           if (is_inode_flag_set(inode, FI_ACL_MODE)) {
>>>                   inode->i_mode = F2FS_I(inode)->i_acl_mode; diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h index ed794b5fefbe..e4a94995e9a8 100644
>>> --- a/include/trace/events/f2fs.h
>>> +++ b/include/trace/events/f2fs.h
>>> @@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
>>>                   { CP_NODE_NEED_CP,      "node needs cp" },              \
>>>                   { CP_FASTBOOT_MODE,     "fastboot mode" },              \
>>>                   { CP_SPEC_LOG_NUM,      "log type is 2" },              \
>>> -               { CP_RECOVER_DIR,       "dir needs recovery" })
>>> +               { CP_RECOVER_DIR,       "dir needs recovery" },         \
>>> +               { CP_ENC_DIR,           "persist encryption policy" })
>>>
>>>    #define show_shutdown_mode(type)                                       \
>>>           __print_symbolic(type,                                          \
>>> --
>>> 2.40.1
>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

