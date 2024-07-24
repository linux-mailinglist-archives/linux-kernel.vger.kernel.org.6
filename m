Return-Path: <linux-kernel+bounces-260597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A56D93AB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B381F2378E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7117C7F;
	Wed, 24 Jul 2024 02:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uEIXDM2g"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1C28F7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789125; cv=none; b=S6VZ4neMVKO2VP0xt8W3J2YXzD00RpRTjf30uRZ493k7QhW5uiya++o9BSTpPPRk9jqBOmH8fWIjQpnIDWvDB41PHy7l4lzk+t4uJkeg7OcVEQqDkfVqasQrFWO6uGmj8NeevkmxzjDbTX6GMXGhw6aUNfDW4lzCcKFdQkji2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789125; c=relaxed/simple;
	bh=UTH2mQlhEOJ7hv8euy8HWisnrAWUMH499Z7PoKf6q/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB9DitOA5PuQYci+wHNqOYH8Oz8fJrwY+3eA+OWF1sxWqPjqjF7VR/QSnJHem5bYyeJR0psoKh3t8b17L6HzubP8/EDAJvsz2ZRJUhozE9zqsg4j1efGZsqAfRI8VyeC+Mkwif821Z3jCO3gnc/ENUVGOpscazjLZuLMsHV0ue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uEIXDM2g; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721789114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UncQ0rYfgkpA5fLsd9G82bNMqodLN9BEWnby9Sjuo1s=;
	b=uEIXDM2g/v8GF3jcrljnw3et8fFhhsMyZ2sN3Lufc6ZSDzLe7KgF33U0Dy+jMwHHMa0V+1+KhHiVT/gaDzR/9f4VWcWCmlz5F+7Pa7+w1Bi+IQ1B0kHelMGRYxNOfaQNjdEEGFmnJlvw5n9A6FggSlSwVLPgKL2+QSVeEuO9T00=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0WBC4A2E_1721789112;
Received: from 30.97.48.195(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBC4A2E_1721789112)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 10:45:13 +0800
Message-ID: <96238616-071e-43f8-9a14-5d4beab64217@linux.alibaba.com>
Date: Wed, 24 Jul 2024 10:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, xiang@kernel.org, chao@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240724020721.2389738-1-nichen@iscas.ac.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240724020721.2389738-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/24 10:07, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: 84a2ceefff99 ("erofs: tidy up stream decompressors")

I think typos are bugfixes, so I will drop this label.

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Will apply, thanks.

Thanks,
Gao Xiang

