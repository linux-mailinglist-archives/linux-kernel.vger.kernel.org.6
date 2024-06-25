Return-Path: <linux-kernel+bounces-228681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7EA916555
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0541F22C31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FCA14A61A;
	Tue, 25 Jun 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBTA/dTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856A145B32
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311825; cv=none; b=qySNZhxS/dB5WJ9MhWan6VdaSR8YEwLuEvNciIIcjvIg5NAFA5RlouAMXxmjms6C+kPKfItaDTxs2eOWoBT+RHx396ff3baS2SvM3cr39DwvxcENbEl5sDLQ3n81eRmT4lmt4QJtfW5lTYUQgoCmO+sJ+jvsSopeDAEDukm/vBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311825; c=relaxed/simple;
	bh=zfHyXq4AEEpoZTJZYYvzdLfZN8M9azfQlCbm1meZUn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Id9ejSj0TUGdRuhrGyNxbuGLR09vqzlr6BacMAdn6iAkjG3QrDT2eiwuXldu8ulGPf+PzrzRWWMmKf+eOzMq2JiU6JVXgueNoJvkhVyR3BgbkYA21U0BqX38SfqmMAL+asKwyr/u4ouqLBYcmVXhHsUZ4wsMKKOuhUkXiNDxgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBTA/dTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD496C32781;
	Tue, 25 Jun 2024 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719311825;
	bh=zfHyXq4AEEpoZTJZYYvzdLfZN8M9azfQlCbm1meZUn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qBTA/dTUbJNrtLkWjxxaJrLTWa5gadqMc3l5hWl1125xofX5AJsv6h534c8Dl8jho
	 MPwnmyMzIQTqOo0nNe1+/AXVl192GlkUfrxm1lQZjr+Iv860IjtpE5KiRKdAt49yEL
	 1m1H73LeKtCN7EPRBEBdhh2R0jFh3Wax3yZi44dOF6N6EYMFU3hwJ73nn++JAaMyJO
	 VYG4s1mvobIAsmo6691lmCGnjO47OWOQjPPhqzrNsbicwoQJrJMOtFNxbd+O4vz+3h
	 M1KWUCcNlVXlmhhesqGgwcvcr/vGv1OeSRmoDp5VyWcPGoRWxsLOLuHQUxc7cS4Frb
	 2ODlurzM8BQcA==
Message-ID: <1fe7878f-36db-4055-9e40-b39425eb5936@kernel.org>
Date: Tue, 25 Jun 2024 18:37:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHY0XSBmMmZzOiByZWR1Y2UgZXhwZW5z?=
 =?UTF-8?Q?ive_checkpoint_trigger_frequency?=
To: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>,
 "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 wangzijie <wangzijie1@honor.com>, =?UTF-8?B?546L55qTIChIYW9faGFvIFdhbmcp?=
 <Hao_hao.Wang@unisoc.com>
References: <20240625065459.3665791-1-chao@kernel.org>
 <a861d9aaf9394aa6bc77548735629f87@BJMBX02.spreadtrum.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a861d9aaf9394aa6bc77548735629f87@BJMBX02.spreadtrum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/25 16:09, 牛志国 (Zhiguo Niu) wrote:
> 
> 
> -----邮件原件-----
> 发件人: Chao Yu <chao@kernel.org>
> 发送时间: 2024年6月25日 14:55
> 收件人: jaegeuk@kernel.org
> 抄送: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org; Chao Yu <chao@kernel.org>; wangzijie <wangzijie1@honor.com>; 牛志国 (Zhiguo Niu) <Zhiguo.Niu@unisoc.com>; Yunlei He <heyunlei@hihonor.com>
> 主题: [PATCH v4] f2fs: reduce expensive checkpoint trigger frequency
> 
> 
> 注意: 这封邮件来自于外部。除非你确定邮件内容安全，否则不要点击任何链接和附件。
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> 
> We may trigger high frequent checkpoint for below case:
> 1. mkdir /mnt/dir1; set dir1 encrypted
> 2. touch /mnt/file1; fsync /mnt/file1
> 3. mkdir /mnt/dir2; set dir2 encrypted
> 4. touch /mnt/file2; fsync /mnt/file2
> ...
> 
> Although, newly created dir and file are not related, due to commit bbf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will trigger checkpoint whenever fsync() comes after a new encrypted dir created.
> 
> In order to avoid such performance regression issue, let's record an entry including directory's ino in global cache whenever we update directory's xattr data, and then triggerring checkpoint() only if xattr metadata of target file's parent was updated.
> 
> This patch updates to cover below no encryption case as well:
> 1) parent is checkpointed
> 2) set_xattr(dir) w/ new xnid
> 3) create(file)
> 4) fsync(file)
> 
> Fixes: bbf156f7afa7 ("f2fs: fix lost xattrs of directories")
> Reported-by: wangzijie <wangzijie1@honor.com>
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Reported-by: Yunlei He <heyunlei@hihonor.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/f2fs.h              |  2 ++
>   fs/f2fs/file.c              |  3 +++
>   fs/f2fs/xattr.c             | 14 ++++++++++++--
>   include/trace/events/f2fs.h |  3 ++-
>   4 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index f1d65ee3addf..f3c910b8983b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -284,6 +284,7 @@ enum {
>          APPEND_INO,             /* for append ino list */
>          UPDATE_INO,             /* for update ino list */
>          TRANS_DIR_INO,          /* for transactions dir ino list */
> +       ENC_DIR_INO,            /* for encrypted dir ino list */
>          FLUSH_INO,              /* for multiple device flushing */
>          MAX_INO_ENTRY,          /* max. list */
>   };
> @@ -1150,6 +1151,7 @@ enum cp_reason_type {
>          CP_FASTBOOT_MODE,
>          CP_SPEC_LOG_NUM,
>          CP_RECOVER_DIR,
> +       CP_ENC_DIR,
>   };
> 
>   enum iostat_type {
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index a527de1e7a2f..278573974db4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -217,6 +217,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>                  f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
>                                                          TRANS_DIR_INO))
>                  cp_reason = CP_RECOVER_DIR;
> +       else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> +                                                       ENC_DIR_INO))
> +               cp_reason = CP_ENC_DIR;
> 
>          return cp_reason;
>   }
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c index f290fe9327c4..d04c0b47a4e4 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>                          const char *name, const void *value, size_t size,
>                          struct page *ipage, int flags)  {
> +       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>          struct f2fs_xattr_entry *here, *last;
>          void *base_addr, *last_base_addr;
>          int found, newsize;
> @@ -772,9 +773,18 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>          if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
>                          !strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
>                  f2fs_set_encrypted_inode(inode);
> -       if (S_ISDIR(inode->i_mode))
> -               set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> 
> +       if (!S_ISDIR(inode->i_mode))
> +               goto same;
> +       /*
> +        * In restrict mode, fsync() always try to trigger checkpoint for all
> +        * metadata consistency, in other mode, it triggers checkpoint when
> +        * parent's xattr metadata was updated.
> +        */
> +       if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> +               set_sbi_flag(sbi, SBI_NEED_CP);
> Hi Chao,
> For this case, will it also cause the same issue with original issue when fsync_mode == FSYNC_MODE_STRICT ?
> if ckpt thread is blocked by some reasons and SBI_NEED_CP is not cleared in time, Subsequent fsync will trigger cp?

Hi Zhiguo,

If there is no dirty data after previous CP, later CP triggered by subsequent
fsync will return directly?

	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
		((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) ||
		((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
		goto out;

> +       else
> +               f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
> This patch version regardless of whether dir is encrypted or not, so this name(ENC_DIR_INO) can be rename other for more accurate?

Thanks for pointing out this, let me fix it in v5.

Thanks,

> Thanks！
>   same:
>          if (is_inode_flag_set(inode, FI_ACL_MODE)) {
>                  inode->i_mode = F2FS_I(inode)->i_acl_mode; diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h index ed794b5fefbe..e4a94995e9a8 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
>                  { CP_NODE_NEED_CP,      "node needs cp" },              \
>                  { CP_FASTBOOT_MODE,     "fastboot mode" },              \
>                  { CP_SPEC_LOG_NUM,      "log type is 2" },              \
> -               { CP_RECOVER_DIR,       "dir needs recovery" })
> +               { CP_RECOVER_DIR,       "dir needs recovery" },         \
> +               { CP_ENC_DIR,           "persist encryption policy" })
> 
>   #define show_shutdown_mode(type)                                       \
>          __print_symbolic(type,                                          \
> --
> 2.40.1
> 

