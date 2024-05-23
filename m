Return-Path: <linux-kernel+bounces-187113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06A8CCD4A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6FB1F21FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678B39FD6;
	Thu, 23 May 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M2qG3/j5"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA8171C4
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450472; cv=none; b=PKmbURNX56duSOI2DL7lD+C2+O5VEIVqdjYB6oUBkAqH0t3WogpVvKi0uiq/wK7FDH7Jq3uob1tIFgNkKXhlQrJNj/RNgfkwN21e85JHHu5c4V2uEOUSyulVglpP9xVo9DJth533JtwY1C0Ylp7e6Ml/BdcfNdj18Nf5zGhKqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450472; c=relaxed/simple;
	bh=3VcyvrFnO7doF59IEE6uY58W6g/UohPkURgPYmCd9BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXalVSpYslxzCSHH6dczIYJ9eYoqUPBfeqkqyvGAlAzhyA23tCw8nJBwGQMlvzKazsSkt4PajvuqftyVwWEsWH5HYgznYQe4VIuu2C10P468lmcLAJXaEYzB8HzqjOmy3JmIjOJuxUyVAHDG2UKR6ZQWZItRQANACCR2VH07suw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M2qG3/j5; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yukuai1@huaweicloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716450468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34wC+r4eDKWNrguibnYho4habD3+PHHInxhgG8ZZ6+s=;
	b=M2qG3/j5npO2qd52j1LiOg4Npg5g+fRu99+v55ZrMUiYSS2+DKdnjVoC3Oa78F/aORl3um
	HtexQNkuRidwejUhkNgOEGEw2dwH9LAR39Zr7lKIJVfPoh9ui4Cv2mMkf3PbxU+Whx6v46
	eCjcqGjjELz6H3x7+YBljbRGi+KKEX0=
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: yi.zhang@redhat.com
X-Envelope-To: dlemoal@kernel.org
X-Envelope-To: hare@suse.de
X-Envelope-To: johannes.thumshirn@wdc.com
X-Envelope-To: kch@nvidia.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: bvanassche@acm.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yukuai3@huawei.com
X-Envelope-To: yi.zhang@huawei.com
X-Envelope-To: yangerkun@huawei.com
Message-ID: <48a8a735-d735-45dd-9811-2557ffbc545d@linux.dev>
Date: Thu, 23 May 2024 09:47:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] null_blk: fix null-ptr-dereference while configuring
 'power' and 'submit_queues'
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, yi.zhang@redhat.com,
 dlemoal@kernel.org, hare@suse.de, johannes.thumshirn@wdc.com,
 kch@nvidia.com, zhouchengming@bytedance.com, bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240523153934.1937851-1-yukuai1@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240523153934.1937851-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 23.05.24 17:39, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Writing 'power' and 'submit_queues' concurrently will trigger kernel
> panic:
>
> Test script:
>
> modprobe null_blk nr_devices=0
> mkdir -p /sys/kernel/config/nullb/nullb0
> while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
> while true; do echo 1 > power; echo 0 > power; done
>
> Test result:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000148
> Oops: 0000 [#1] PREEMPT SMP
> RIP: 0010:__lock_acquire+0x41d/0x28f0
> Call Trace:
>   <TASK>
>   lock_acquire+0x121/0x450
>   down_write+0x5f/0x1d0
>   simple_recursive_removal+0x12f/0x5c0
>   blk_mq_debugfs_unregister_hctxs+0x7c/0x100
>   blk_mq_update_nr_hw_queues+0x4a3/0x720
>   nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
>   nullb_device_submit_queues_store+0x79/0xf0 [null_blk]
>   configfs_write_iter+0x119/0x1e0
>   vfs_write+0x326/0x730
>   ksys_write+0x74/0x150
>
> This is because del_gendisk() can concurrent with
> blk_mq_update_nr_hw_queues():
>
> nullb_device_power_store	nullb_apply_submit_queues
>   null_del_dev
>   del_gendisk
> 				 nullb_update_nr_hw_queues
> 				  if (!dev->nullb)
> 				  // still set while gendisk is deleted
> 				   return 0
> 				  blk_mq_update_nr_hw_queues
>   dev->nullb = NULL
>
> Fix this problem by resuing the global mutex to protect
> nullb_device_power_store() and nullb_update_nr_hw_queues() from configfs.
>
> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after an instance has been configured")
> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v2:
>   - remove the unrelated code.

Thanks. I am fine with it.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>
>   drivers/block/null_blk/main.c | 40 +++++++++++++++++++++++------------
>   2 files changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5d56ad4ce01a..eb023d267369 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -413,13 +413,25 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
>   static int nullb_apply_submit_queues(struct nullb_device *dev,
>   				     unsigned int submit_queues)
>   {
> -	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
> +	int ret;
> +
> +	mutex_lock(&lock);
> +	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
> +	mutex_unlock(&lock);
> +
> +	return ret;
>   }
>   
>   static int nullb_apply_poll_queues(struct nullb_device *dev,
>   				   unsigned int poll_queues)
>   {
> -	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
> +	int ret;
> +
> +	mutex_lock(&lock);
> +	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
> +	mutex_unlock(&lock);
> +
> +	return ret;
>   }
>   
>   NULLB_DEVICE_ATTR(size, ulong, NULL);
> @@ -468,28 +480,31 @@ static ssize_t nullb_device_power_store(struct config_item *item,
>   	if (ret < 0)
>   		return ret;
>   
> +	ret = count;
> +	mutex_lock(&lock);
>   	if (!dev->power && newp) {
>   		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
> -			return count;
> +			goto out;
> +
>   		ret = null_add_dev(dev);
>   		if (ret) {
>   			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
> -			return ret;
> +			goto out;
>   		}
>   
>   		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
>   		dev->power = newp;
>   	} else if (dev->power && !newp) {
>   		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
> -			mutex_lock(&lock);
>   			dev->power = newp;
>   			null_del_dev(dev->nullb);
> -			mutex_unlock(&lock);
>   		}
>   		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
>   	}
>   
> -	return count;
> +out:
> +	mutex_unlock(&lock);
> +	return ret;
>   }
>   
>   CONFIGFS_ATTR(nullb_device_, power);
> @@ -1932,15 +1947,12 @@ static int null_add_dev(struct nullb_device *dev)
>   	nullb->q->queuedata = nullb;
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
>   
> -	mutex_lock(&lock);
>   	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
> -	if (rv < 0) {
> -		mutex_unlock(&lock);
> +	if (rv < 0)
>   		goto out_cleanup_disk;
> -	}
> +
>   	nullb->index = rv;
>   	dev->index = rv;
> -	mutex_unlock(&lock);
>   
>   	if (config_item_name(&dev->group.cg_item)) {
>   		/* Use configfs dir name as the device name */
> @@ -1969,9 +1981,7 @@ static int null_add_dev(struct nullb_device *dev)
>   	if (rv)
>   		goto out_ida_free;
>   
> -	mutex_lock(&lock);
>   	list_add_tail(&nullb->list, &nullb_list);
> -	mutex_unlock(&lock);
>   
>   	pr_info("disk %s created\n", nullb->disk_name);
>   
> @@ -2020,7 +2030,9 @@ static int null_create_dev(void)
>   	if (!dev)
>   		return -ENOMEM;
>   
> +	mutex_lock(&lock);
>   	ret = null_add_dev(dev);
> +	mutex_unlock(&lock);
>   	if (ret) {
>   		null_free_dev(dev);
>   		return ret;

-- 
Best Regards,
Yanjun.Zhu


