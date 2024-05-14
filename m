Return-Path: <linux-kernel+bounces-178970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6388C59F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6721EB21675
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E943617F38E;
	Tue, 14 May 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1wWoORH"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A341D545
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705646; cv=none; b=Jl1vFpM2h3cEUH37nAzjDOtJvB9EW2ziXOuJWWna0SdT7gKMPtVm9WSXIzSAdzU02w8HP6Nzhdp7Oge88xrkmx3/DNBzUf4N56h7baXIDG76zKRyQkZNBK+8n/CNnZRmx4NN0eh5gbNghv1dJxv0JQrssBdiIhD6mdAhe7aM3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705646; c=relaxed/simple;
	bh=BkM3OZr3jx/95gT12W/si2InAjjxnxbTBt98E/xh/ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJ9nAidA1yxmoLbUhqZkbs74SA5xHqC+p0mz5suGZ8PDntoqW9xWFbD5RdqGHpA8bzx8G1+oNUb+PNvMTocDoLziTGPNQKe4b/SpRvlhV8KZUY+h5YcKY/APdQJYY84GHOJWwYeDmYTaaaY/TIqUU173kXEMsw2NLq5393Ho9YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1wWoORH; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715705639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwKYwvrCkgacfNudOapr20vF6Z2dViM5qKJdT/zY9Es=;
	b=V1wWoORHtkOwggxidh4UD6sOwetGrWxoKYClXH2O60xxT+ogsroUbhUyGk+8oYAAbHrSjA
	xwVpm4F5Mx7Wf6YXt301vFcAVl6lmi2LVdZiK9wuf1YyvbnlYW7vgDQ1TTrx4XIDZ6bbGP
	NbxgZQa8mT6jiUg9EtyGvmiIIoeQWoo=
Date: Wed, 15 May 2024 00:53:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/5/15 00:22, Maxime Ripard wrote:
> Hi,
>
> On Tue, May 14, 2024 at 11:40:43PM +0800, Sui Jingfeng wrote:
>> Because a lot of implementations has already added it into their drived
>> class, promote it into drm_bridge core may benifits a lot. drm bridge is
>> a driver, it should know the underlying hardware entity.
> Is there some actual benefits, or is it theoretical at this point?


I think, DRM bridge drivers could remove the 'struct device *dev'
member from their derived structure. Rely on the drm bridge core
when they need the 'struct device *' pointer.

> Maxime

-- 
Best regards,
Sui


