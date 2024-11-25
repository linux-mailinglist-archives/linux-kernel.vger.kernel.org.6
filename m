Return-Path: <linux-kernel+bounces-420900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8770F9D8421
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22198163AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700061957F4;
	Mon, 25 Nov 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJPmdiQe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98718B47C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533232; cv=none; b=B95cg/VX7lbyeLIHpaCHNi7ZW0V6bzARyEBMX6Q84Z236owxJuDNYivFsij/KGieQ0ecUU/wozuqAzFChXl8sK6HGB18YqmRnxza16ulW49BlrTJMiyLIyT8uJSJ3NbKfHAZpVJdpfgwf6TviUBy3592XtFEZh/NApSw/j5CaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533232; c=relaxed/simple;
	bh=em2+R4u2wEQPpLl6eVmHSeE2ZgN4ooDYI6iFZ92Y+sI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k8SqM+SS3mQgFHuhMCgB2Afh2V5czKDhzkdLq++IHGSd7D+SlLJVRCxALiM9TQN0MeX8s5yXngppCe4xTvGMbq5icQGsdI5N7trE38Z6XK39Z8ENhDQe35cTVuBpQtZAcj/e+9O56Untcbt2R1IcM1CvqQM78wtK3GO1xseTEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJPmdiQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF722C4CECE;
	Mon, 25 Nov 2024 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732533232;
	bh=em2+R4u2wEQPpLl6eVmHSeE2ZgN4ooDYI6iFZ92Y+sI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=FJPmdiQekWqfdMgE1/OmJyFKt6+URYxapD+gGJI5GzAwba32anEEa4xmEB+xMYiC2
	 Ft1UT90zHjBBJhwlrBNDhxHdIfUrabWdhpXMjaQB1XUITtrdnA7D2quZlrxoG2naAU
	 gtpk+BJNv97q+8Gj5MTbf+wiGuFZ6q7lcck45aQpbMTVJW7Yfy9aa3RewgNdpAqb1A
	 sT3K6KT7Pxt/r+ieMZkP9FpPwKCfRBSWsWFK1e1BrO/5duCkkU+ICdKYpSh/7qr8G7
	 zOODtTV3aotqEcjUx5tuYQ/FUjhxdzFgGb4KukBcr09Thx4e9sEjJCRjuuAgoBbjgO
	 koo9L7fp/OBGA==
Message-ID: <0b9efdbb-e897-45d2-8005-bd3d6f6fa2db@kernel.org>
Date: Mon, 25 Nov 2024 19:13:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYyIDEvMl0gZjJmczogZml4IHRvIHNo?=
 =?UTF-8?Q?rink_read_extent_node_in_batches?=
To: =?UTF-8?B?546L56eA57qiIChYaXVob25nIFdhbmcp?= <Xiuhong.Wang@unisoc.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>
References: <20241122065005.3772987-1-chao@kernel.org>
 <6ddf779148f44295acfbe547d9ec3aab@BJMBX02.spreadtrum.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <6ddf779148f44295acfbe547d9ec3aab@BJMBX02.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/25 11:11, 王秀红 (Xiuhong Wang) wrote:
> Hi Chao,
> 
> after tested in this weekend with these patch base on the orginal case, no issue reproduced, so
> Tested-by: Xiuhong Wang <xiuhong.wang@unisoc.com>

Hi Xiuhong,

Thanks for helping to test.

Thanks,

> 
> thanks!
> 
> -----邮件原件-----
> 发件人: Chao Yu <chao@kernel.org>
> 发送时间: 2024年11月22日 14:50
> 收件人: jaegeuk@kernel.org
> 抄送: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; Chao Yu <chao@kernel.org>; 王秀红 (Xiuhong Wang) <Xiuhong.Wang@unisoc.com>; 牛志国 (Zhiguo Niu) <Zhiguo.Niu@unisoc.com>
> 主题: [PATCH v2 1/2] f2fs: fix to shrink read extent node in batches
> 
> 
> 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> We use rwlock to protect core structure data of extent tree during its shrink, however, if there is a huge number of extent nodes in extent tree, during shrink of extent tree, it may hold rwlock for a very long time, which may trigger kernel hang issue.
> 
> This patch fixes to shrink read extent node in batches, so that, critical region of the rwlock can be shrunk to avoid its extreme long time hold.
> 
> Reported-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Closes: https://lore.kernel.org/linux-f2fs-devel/20241112110627.1314632-1-xiuhong.wang@unisoc.com/
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - no updates.
>   fs/f2fs/extent_cache.c | 69 +++++++++++++++++++++++++-----------------
>   1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c index 019c1f7b7fa5..b7a6817b44b0 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -379,21 +379,22 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode,  }
> 
>   static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
> -                                       struct extent_tree *et)
> +                               struct extent_tree *et, unsigned int
> + nr_shrink)
>   {
>          struct rb_node *node, *next;
>          struct extent_node *en;
> -       unsigned int count = atomic_read(&et->node_cnt);
> +       unsigned int count;
> 
>          node = rb_first_cached(&et->root);
> -       while (node) {
> +
> +       for (count = 0; node && count < nr_shrink; count++) {
>                  next = rb_next(node);
>                  en = rb_entry(node, struct extent_node, rb_node);
>                  __release_extent_node(sbi, et, en);
>                  node = next;
>          }
> 
> -       return count - atomic_read(&et->node_cnt);
> +       return count;
>   }
> 
>   static void __drop_largest_extent(struct extent_tree *et, @@ -622,6 +623,30 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>          return en;
>   }
> 
> +static unsigned int __destroy_extent_node(struct inode *inode,
> +                                       enum extent_type type) {
> +       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +       struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
> +       unsigned int nr_shrink = type == EX_READ ?
> +                               READ_EXTENT_CACHE_SHRINK_NUMBER :
> +                               AGE_EXTENT_CACHE_SHRINK_NUMBER;
> +       unsigned int node_cnt = 0;
> +
> +       if (!et || !atomic_read(&et->node_cnt))
> +               return 0;
> +
> +       while (atomic_read(&et->node_cnt)) {
> +               write_lock(&et->lock);
> +               node_cnt += __free_extent_tree(sbi, et, nr_shrink);
> +               write_unlock(&et->lock);
> +       }
> +
> +       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> +
> +       return node_cnt;
> +}
> +
>   static void __update_extent_tree_range(struct inode *inode,
>                          struct extent_info *tei, enum extent_type type)  { @@ -760,9 +785,6 @@ static void __update_extent_tree_range(struct inode *inode,
>                  }
>          }
> 
> -       if (is_inode_flag_set(inode, FI_NO_EXTENT))
> -               __free_extent_tree(sbi, et);
> -
>          if (et->largest_updated) {
>                  et->largest_updated = false;
>                  updated = true;
> @@ -780,6 +802,9 @@ static void __update_extent_tree_range(struct inode *inode,
>   out_read_extent_cache:
>          write_unlock(&et->lock);
> 
> +       if (is_inode_flag_set(inode, FI_NO_EXTENT))
> +               __destroy_extent_node(inode, EX_READ);
> +
>          if (updated)
>                  f2fs_mark_inode_dirty_sync(inode, true);  } @@ -942,10 +967,14 @@ static unsigned int __shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink
>          list_for_each_entry_safe(et, next, &eti->zombie_list, list) {
>                  if (atomic_read(&et->node_cnt)) {
>                          write_lock(&et->lock);
> -                       node_cnt += __free_extent_tree(sbi, et);
> +                       node_cnt += __free_extent_tree(sbi, et,
> +                                       nr_shrink - node_cnt -
> + tree_cnt);
>                          write_unlock(&et->lock);
>                  }
> -               f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> +
> +               if (atomic_read(&et->node_cnt))
> +                       goto unlock_out;
> +
>                  list_del_init(&et->list);
>                  radix_tree_delete(&eti->extent_tree_root, et->ino);
>                  kmem_cache_free(extent_tree_slab, et); @@ -1084,23 +1113,6 @@ unsigned int f2fs_shrink_age_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink
>          return __shrink_extent_tree(sbi, nr_shrink, EX_BLOCK_AGE);  }
> 
> -static unsigned int __destroy_extent_node(struct inode *inode,
> -                                       enum extent_type type)
> -{
> -       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -       struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
> -       unsigned int node_cnt = 0;
> -
> -       if (!et || !atomic_read(&et->node_cnt))
> -               return 0;
> -
> -       write_lock(&et->lock);
> -       node_cnt = __free_extent_tree(sbi, et);
> -       write_unlock(&et->lock);
> -
> -       return node_cnt;
> -}
> -
>   void f2fs_destroy_extent_node(struct inode *inode)  {
>          __destroy_extent_node(inode, EX_READ); @@ -1109,7 +1121,6 @@ void f2fs_destroy_extent_node(struct inode *inode)
> 
>   static void __drop_extent_tree(struct inode *inode, enum extent_type type)  {
> -       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>          struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
>          bool updated = false;
> 
> @@ -1117,7 +1128,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
>                  return;
> 
>          write_lock(&et->lock);
> -       __free_extent_tree(sbi, et);
>          if (type == EX_READ) {
>                  set_inode_flag(inode, FI_NO_EXTENT);
>                  if (et->largest.len) {
> @@ -1126,6 +1136,9 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
>                  }
>          }
>          write_unlock(&et->lock);
> +
> +       __destroy_extent_node(inode, type);
> +
>          if (updated)
>                  f2fs_mark_inode_dirty_sync(inode, true);  }
> --
> 2.40.1
> 


