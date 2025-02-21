Return-Path: <linux-kernel+bounces-525555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E8A3F142
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B53817E848
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A1D204C0F;
	Fri, 21 Feb 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="g482ex5v"
Received: from mail72.out.titan.email (mail72.out.titan.email [209.209.25.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530E1EE03C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132060; cv=none; b=a1NcD4rBL3HpH9Hg2iRksJjmRyK0Aqbm1CP9bPfqSLkEIMVJq3an+12VQE9eHRrgCEfu7UIoIelWh6cpoKOnMja6qDRixdjZIpdgORVGV1KUSSaaqGnhv0V3YKXgV5WpkpPJ/rraOU+dALMTPzGz1172/SpnW0ZXHObd8LjQUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132060; c=relaxed/simple;
	bh=liz61iMC2dN+NGZ2MuvcUbLugzJeLLt6ts5YA7v4yfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQVINmWnYmJtwq2RknXjw2tYw6lu1HobJV3k02Iqtf2mLbAqoL0abYNqKV/3W0QOCFzTC9+xbQSeC2fu9wsmb7CX35Mw6lYPKoG1zb8aLyBsG4M6hncdGFa4WANfrJyCj2v396Y4Po+9Ug++tWtyJNU8qI5MTe6fPl/gQef7nbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=g482ex5v; arc=none smtp.client-ip=209.209.25.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
DKIM-Signature: a=rsa-sha256; bh=NJF/4Q5i/hO0u3nwWRv/Ok82S5dpU6jme2vhYIxvsto=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=mime-version:subject:references:to:message-id:in-reply-to:date:from:cc:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1740131535; v=1;
	b=g482ex5vnAdoSbH9pyNapbsiini2QP+277DSiMoYx65/+O86FCpgXdSI6GgmNvPMd3fPzJ5s
	CYSX69rkl4j5YlLV5f95lxM7mCeFjAGCFBPgToVHLUhdgqr1o8ZjMaxN/sNULmRocT2lTnIlmln
	HII4VrcIvGtPZ/GI+2koJu4A=
Received: from studio.local (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id E3D87100156;
	Fri, 21 Feb 2025 09:52:07 +0000 (UTC)
Date: Fri, 21 Feb 2025 17:52:05 +0800
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, song@kernel.org, colyli@kernel.org, 
	yukuai3@huawei.com, dan.j.williams@intel.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, ira.weiny@intel.com, dlemoal@kernel.org, yanjun.zhu@linux.dev, 
	kch@nvidia.com, hare@suse.de, zhengqixing@huawei.com, john.g.garry@oracle.com, 
	geliang@kernel.org, xni@redhat.com, colyli@suse.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 05/12] badblocks: return error if any badblock set fails
Message-ID: <4qo5qliidycbjmauq22tqgv6nbw2dus2xlhg2qvfss7nawdr27@arztxmrwdhzb>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-6-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221081109.734170-6-zhengqixing@huaweicloud.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1740131535703117256.29396.5359946764536724318@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=bq22BFai c=1 sm=1 tr=0 ts=67b84ccf
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=i0EeH86SAAAA:8
	a=7AGAggHtapFrYZIn-HwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Fri, Feb 21, 2025 at 04:11:02PM +0800, Zheng Qixing wrote:
> From: Li Nan <linan122@huawei.com>
> 
> _badblocks_set() returns success if at least one badblock is set
> successfully, even if others fail. This can lead to data inconsistencies
> in raid, where a failed badblock set should trigger the disk to be kicked
> out to prevent future reads from failed write areas.
> 
> _badblocks_set() should return error if any badblock set fails. Instead
> of relying on 'rv', directly returning 'sectors' for clearer logic. If all
> badblocks are successfully set, 'sectors' will be 0, otherwise it
> indicates the number of badblocks that have not been set yet, thus
> signaling failure.
> 
> By the way, it can also fix an issue: when a newly set unack badblock is
> included in an existing ack badblock, the setting will return an error.
> ···
>   echo "0 100" /sys/block/md0/md/dev-loop1/bad_blocks
>   echo "0 100" /sys/block/md0/md/dev-loop1/unacknowledged_bad_blocks
>   -bash: echo: write error: No space left on device
> ```
> After fix, it will return success.
> 
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/badblocks.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>

NACK.   Such modification will break current API.

Current API doesn’t handle partial success/fail condition, if any bad block range is set it should return true.

It is not about correct or wrong, just current fragile design. A new API is necessary to handle such thing. This is why I leave the return value as int other than bool.

Thanks.

Coly Li


 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 1c8b8f65f6df..a953d2e9417f 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -843,7 +843,6 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  	struct badblocks_context bad;
>  	int prev = -1, hint = -1;
>  	unsigned long flags;
> -	int rv = 0;
>  	u64 *p;
>  
>  	if (bb->shift < 0)
> @@ -873,10 +872,8 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  	bad.len = sectors;
>  	len = 0;
>  
> -	if (badblocks_full(bb)) {
> -		rv = 1;
> +	if (badblocks_full(bb))
>  		goto out;
> -	}
>  
>  	if (badblocks_empty(bb)) {
>  		len = insert_at(bb, 0, &bad);
> @@ -916,10 +913,8 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  			int extra = 0;
>  
>  			if (!can_front_overwrite(bb, prev, &bad, &extra)) {
> -				if (extra > 0) {
> -					rv = 1;
> +				if (extra > 0)
>  					goto out;
> -				}
>  
>  				len = min_t(sector_t,
>  					    BB_END(p[prev]) - s, sectors);
> @@ -986,10 +981,7 @@ static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  
>  	write_sequnlock_irqrestore(&bb->lock, flags);
>  
> -	if (!added)
> -		rv = 1;
> -
> -	return rv;
> +	return sectors;
>  }
>  
>  /*
> @@ -1353,7 +1345,7 @@ EXPORT_SYMBOL_GPL(badblocks_check);
>   *
>   * Return:
>   *  0: success
> - *  1: failed to set badblocks (out of space)
> + *  other: failed to set badblocks (out of space)
>   */
>  int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  			int acknowledged)
> -- 
> 2.39.2
> 

-- 
Coly Li

