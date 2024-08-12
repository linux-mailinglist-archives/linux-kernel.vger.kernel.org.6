Return-Path: <linux-kernel+bounces-283724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D402794F82F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA31B2180C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9CB194098;
	Mon, 12 Aug 2024 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dAudFyoO"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF441822DA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494327; cv=none; b=QTz8hcDxbFnk+eWTZ90dtCukvFLN4bCPJQUpxykh3YGLpeDsc6pSHjx3mzsY4L7xZ1D6pry83qPVIxIp1pAcTyyIM1t+h10y1QGZAUIVxTVyBmvDBJDcuEEcmakTczwFS34Yv26xxSrdlGIMRVckU8A/+s0t1rfxbCXH5PWTsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494327; c=relaxed/simple;
	bh=1QNEith+Vvhol33+aLPq5go1O8B3Avjm8Q9bsdvuS9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo7oCQ/X6DZr/QScCQOqFBNnVNjhITyqRlq3sDjDwAFAjFHVypObuSMg3Dc1n1B+fNXVqyeWUFKMEktmGZU7kzKctfpj8t6oWhpu1mZTZ9yHzPGB5D3QEc2ZOyrcIjMCyHF0qKJYvxGafsNjwdwNGTPwgrvHqiZP30J+Hhf9jp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dAudFyoO; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1837494-7411-463f-b9f6-fbdd09217423@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723494322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Bkmy6zP1fl2Mg1iKu43im3gTS8tdXysjwgG/iqJOJY=;
	b=dAudFyoOhQBVwAQv2dOLBEGD7qdICDdJs3JP3KM95yaQJAcCB2gI1bnoCAQ0nzuhq04FSJ
	OB68KXwo6eDkt2MCBBP89scLc3o/Deauhm3A8iSPZekyu9mRoqun9jdYROyXdL9pEKJvvP
	JpVfnW/TxRLm77kRy3+upLwwHchfZKI=
Date: Mon, 12 Aug 2024 16:25:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/2] net: xilinx: axienet: Add statistics
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>,
 Michal Simek <michal.simek@amd.com>, Eric Dumazet <edumazet@google.com>
References: <20240812174118.3560730-1-sean.anderson@linux.dev>
 <20240812174118.3560730-3-sean.anderson@linux.dev>
 <e78256f2-9ad6-49e1-9cd5-02a28c92d2fc@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <e78256f2-9ad6-49e1-9cd5-02a28c92d2fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/12/24 16:22, Andrew Lunn wrote:
>>  static int __axienet_device_reset(struct axienet_local *lp)
>>  {
>>  	u32 value;
>>  	int ret;
>>  
>> +	/* Save statistics counters in case they will be reset */
>> +	guard(mutex)(&lp->stats_lock);
>> +	if (lp->features & XAE_FEATURE_STATS)
>> +		axienet_stats_update(lp, true);
> 
> My understanding of guard() is that the mutex is held until the
> function completes. That is much longer than you need. A
> scoped_guard() would be better here, and it makes it clear when the
> mutex will be released.

We have to hold it until...

>> +
>>  	/* Reset Axi DMA. This would reset Axi Ethernet core as well. The reset
>>  	 * process of Axi DMA takes a while to complete as all pending
>>  	 * commands/transfers will be flushed or completed during this
>> @@ -551,6 +595,23 @@ static int __axienet_device_reset(struct axienet_local *lp)
>>  		return ret;
>>  	}
>>  
>> +	/* Update statistics counters with new values */
>> +	if (lp->features & XAE_FEATURE_STATS) {
>> +		enum temac_stat stat;
>> +
>> +		write_seqcount_begin(&lp->hw_stats_seqcount);
>> +		lp->reset_in_progress = false;
>> +		for (stat = 0; stat < STAT_COUNT; stat++) {
>> +			u32 counter =
>> +				axienet_ior(lp, XAE_STATS_OFFSET + stat * 8);
>> +
>> +			lp->hw_stat_base[stat] +=
>> +				lp->hw_last_counter[stat] - counter;
>> +			lp->hw_last_counter[stat] = counter;
>> +		}
>> +		write_seqcount_end(&lp->hw_stats_seqcount);

...here

Which is effectively the whole function. The main reason why I used guard() was to
simplify the error return cases.

--Sean

>> +	}
>> +
>>  	return 0;
>>  }
>>  
> 
> 	Andrew


