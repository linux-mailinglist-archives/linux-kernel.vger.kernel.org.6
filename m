Return-Path: <linux-kernel+bounces-263460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D193D649
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DB2B23508
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888AA17BB2B;
	Fri, 26 Jul 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AH4kgKxo"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA632AEFE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008422; cv=none; b=fRUmvYQ7OO1/cqexrJH9LaODCsyogavAw/XVoXHOHua42YtxlMysqvHiKMcw+zxniKC4ZNjzh3EZHskHK/CWQuo3GEFwOebg+voICIt/L9GcO1UByDwp41pppRJDo+DycRp8+9LZQSm5VUJhu8uZPAkx8CTg5GY8SDwTJYyw6gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008422; c=relaxed/simple;
	bh=3WZ1GCu2PQ11mGFhbE6KLXgJDLNhnI59Ju+26cSOLII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKdIX8IMd9aFjjyK/9R7gmJQPBRdqmfbkq/7AwOeubhUaoOBF44IotRaCe1H+D72rmjeGXGLosmmqBYSi3NbrNRSE0enh4rIw55NdNH06JjWCzv7UQIuDa46b2QYJVIgd4g0hVKuE4TbBbdun4OYO4oCvrjVrdoxmR6qlE7lUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=AH4kgKxo; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66526e430e0so24026527b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722008419; x=1722613219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HAzgWJlJpCD2Vol+/+Es1U+1ag5fps+FrtZGtWYn50=;
        b=AH4kgKxotnqQCZci80b6Zxmvw9VKcHOYynIv+sjAr96wdnkzhd1TZC8/OFJJwNddD7
         jzhMfIhKD8RyDB5xys56+124/I6RtnaExEbQA1EaA/sNi+QRkJYiML4w1YhmpAl2mT31
         IfpZkVprTfQlRisteVIziQmU+58jdHwSWL98Ldm5X4qX2urH6d46PyxHrZ9BtgDKAdyT
         81a2Pag9ofQF0Bf8f1C9BarCFmu9UEubVNePfQ/MvD8tAOLEqQ03jIkeYOQ/FTDjKjdb
         8SCBeeyBKl2MT6ft5VKxg1RbqzyQv7x1Zvp+8to9H5AvqxV/48n7d4D/JmAdYBUrVBQW
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008419; x=1722613219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HAzgWJlJpCD2Vol+/+Es1U+1ag5fps+FrtZGtWYn50=;
        b=NUsj7+KglYcRKFi0QiGD8NXOaZ617xDngfELnLk+NyRpCumnN2/EnGdyzzVm7vUF8Y
         vdbp7g6OnF/104BT8+1c3QglcdXyXUO4xYeg0hFKxRB7Wl53h/B257HMVv8CQEsDIWof
         F8eUgTBwUw4O7Dsv2yXrsOHA+eY5AlBO1Cg2friQ1R064wVXUMmGxW0l0DbBzRjSppjX
         zogIiwpUukX37GDqdv6O8HKTvJ84FrssR/YpKhHoColy50Ql0aD4v6UKbufge9t0aMQq
         /v+5JqDArwr0syPjOMRh5KRtBATXsKyTNa+lBrkFy1QUzr6d0VMUIfP+y/5ovm/GH8/d
         5kcg==
X-Forwarded-Encrypted: i=1; AJvYcCU/EpoHg9otoui58rJrMRrQIjEfd/QTNqAVSgUtjANzXyZIPY06UIvF5yk1kZFjJg4xxPz1Qgkq9fNQ6z4ppkHT4JQNSKr8xl5MX36+
X-Gm-Message-State: AOJu0YxRTmkqrQLDjG0aUQffy/O7SYXIBL1WUPmgC4reWlxco0wbpCqV
	GxI2PZgLuKi7lCpWZh9ieSM8xq2bIj2SiDzSqhoYLwWnuBl9l+wB/T6mRl/xtdU=
X-Google-Smtp-Source: AGHT+IG3lKJ9bPYbwM2Mj6I4DQJOWOog7UGB2uv/wdSJihFYDGPOyX8h2dkvldSMgO5w0eDfOWUaKA==
X-Received: by 2002:a0d:ef43:0:b0:65f:aaf1:9dd3 with SMTP id 00721157ae682-67a051e8450mr2097137b3.2.1722008418975;
        Fri, 26 Jul 2024 08:40:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bc9ec37sm9127747b3.106.2024.07.26.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:40:18 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:40:17 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: yangyun <yangyun50@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fuse: add support for no forget requests
Message-ID: <20240726154017.GE3432726@perftesting>
References: <20240726083752.302301-1-yangyun50@huawei.com>
 <20240726083752.302301-3-yangyun50@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726083752.302301-3-yangyun50@huawei.com>

On Fri, Jul 26, 2024 at 04:37:52PM +0800, yangyun wrote:
> FUSE_FORGET requests are not used if the fuse file system does not
> implement the forget operation in userspace (e.g., fuse file system
> does not cache any inodes).
> 
> However, the kernel is invisible to the userspace implementation and
> always sends FUSE_FORGET requests, which can lead to performance
> degradation because of useless contex switch and memory copy in some
> cases (e.g., many inodes are evicted from icache which was described
> in commit 07e77dca8a1f ("fuse: separate queue for FORGET requests")).
> 
> Just like 'no_interrupt' in 'struct fuse_conn', we add 'no_forget'.
> But since FUSE_FORGET request does not have a reply from userspce,
> we can not use ENOSYS to reflect the 'no_forget' assignment. So add
> the FUSE_NO_FORGET_SUPPORT init flag.
> 
> Besides, if no_forget is enabled, 'nlookup' in 'struct fuse_inode'
> does not used and its value change can be disabled which are protected
> by spin_lock to reduce lock contention.
> 
> Signed-off-by: yangyun <yangyun50@huawei.com>
> ---
>  fs/fuse/dev.c             |  6 ++++++
>  fs/fuse/dir.c             |  4 +---
>  fs/fuse/fuse_i.h          | 24 ++++++++++++++++++++++++
>  fs/fuse/inode.c           | 10 +++++-----
>  fs/fuse/readdir.c         |  8 ++------
>  include/uapi/linux/fuse.h |  3 +++
>  6 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 932356833b0d..10890db9426b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -238,6 +238,9 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
>  {
>  	struct fuse_iqueue *fiq = &fc->iq;
>  
> +	if (fc->no_forget)
> +		return;
> +
>  	forget->forget_one.nodeid = nodeid;
>  	forget->forget_one.nlookup = nlookup;
>  
> @@ -257,6 +260,9 @@ void fuse_force_forget(struct fuse_mount *fm, u64 nodeid)
>  	struct fuse_forget_in inarg;
>  	FUSE_ARGS(args);
>  
> +	if (fm->fc->no_forget)
> +		return;
> +
>  	memset(&inarg, 0, sizeof(inarg));
>  	inarg.nlookup = 1;
>  	args.opcode = FUSE_FORGET;
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 6bfb3a128658..833225ed1d4f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -236,9 +236,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  				fuse_force_forget(fm, outarg.nodeid);
>  				goto invalid;
>  			}
> -			spin_lock(&fi->lock);
> -			fi->nlookup++;
> -			spin_unlock(&fi->lock);
> +			fuse_nlookup_inc_if_enabled(fm->fc, fi);
>  		}
>  		if (ret == -ENOMEM || ret == -EINTR)
>  			goto out;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b9a5b8ec0de5..924d6b0ad700 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -860,6 +860,9 @@ struct fuse_conn {
>  	/** Passthrough support for read/write IO */
>  	unsigned int passthrough:1;
>  
> +	/** Do not send FORGET request */
> +	unsigned int no_forget:1;
> +
>  	/** Maximum stack depth for passthrough backing files */
>  	int max_stack_depth;
>  
> @@ -1029,6 +1032,27 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
>  	rcu_read_unlock();
>  }
>  
> +static inline void fuse_nlookup_inc_if_enabled(struct fuse_conn *fc, struct fuse_inode *fi)
> +{
> +	if (fc->no_forget)
> +		return;
> +
> +	spin_lock(&fi->lock);
> +	fi->nlookup++;
> +	spin_unlock(&fi->lock);
> +}
> +
> +static inline void fuse_nlookup_dec_if_enabled(struct fuse_conn *fc, struct fuse_inode *fi)
> +{
> +	if (fc->no_forget)
> +		return;
> +
> +	spin_lock(&fi->lock);
> +	fi->nlookup--;
> +	spin_lock(&fi->lock);
> +}

This naming scheme is overly verbose, you can simply have

fuse_inc_nlookup()
fuse_dec_nlookup()

Thanks,

Josef

