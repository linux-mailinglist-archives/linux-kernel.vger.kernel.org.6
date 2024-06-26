Return-Path: <linux-kernel+bounces-230754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79E91817A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE86A1C20D42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8E181CE4;
	Wed, 26 Jun 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iNweRf2o"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E95180A61
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406551; cv=none; b=MtwP6EvbepCFCL9s2TajEMB/Q3+6wfuBZxz7HyG6ca4bcmgr1bkPprizivALktq72T4KI2XK6q+hy5Lbu2ydKtQ+zkWXE9b9kiccKd8nlwYU4+EbpyUuKGn6pJped4sOrblmeUlBXVj+nSexSrtYQtQQ3L4RKNob3nZnOgoqIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406551; c=relaxed/simple;
	bh=9dDVtYM312wpemB3FjBItkXKljPIk2DK9tLk5Hx/D6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbvywEXoZfJ3fzeBs1p3pVBp72iXofZ48TSgLWHxk4/L0kpNxzKRYWgyDZ39uZI5ky2sBbpvcr5vopbmNkaHYm3YnX54TgOByYezsWLKiLVKLUPQup6TnxzqBamB1X81MWH99I9OgmCDTiXGe096XlRRsOOdbjs4uMZsajo6KkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iNweRf2o; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B5DCFFF805;
	Wed, 26 Jun 2024 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719406541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUgHBzwfiJHoFyl7QF5SoJ0zVYv+5u+hPuQntFj2wzA=;
	b=iNweRf2oqJoFPO/KjRO7cjV8L6BP4l6hPbl4o3X6gn79+tXT8VPQf/MocJk1N7puyXN35/
	+zuzY2YH5hZqddAuUCoywB1Jxgy9P8rmhhgbZS478ZYJqZiEQS/PeKqbnNNmvykDbPf52Y
	EbN+Q8NqFNyjsRFnPnzAVzDH63+WcCDb+x08y5htKr2eQ63JuEmxmR6QEC0oO6i4Xgky58
	DQAKjqpI5fvl92kIfUzj4QI61neUWGVuTkU1YzQX2gnjagMnqfQJehdPDQtPUIDVp6682I
	mKNKy+4V9juoRSZgHUtYuUfmq8LuZQ5QuiAUSLRDZwPzhoXa7/TcT82KkE/7OA==
Message-ID: <973aa216-4932-4e21-b9a1-184ce809d483@bootlin.com>
Date: Wed, 26 Jun 2024 14:55:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] pps: clients: gpio: Bypass edge's direction check
 when not needed
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240425122853.29544-1-bastien.curutchet@bootlin.com>
 <3612b36e-3350-4a5c-827e-482434753e95@enneenne.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <3612b36e-3350-4a5c-827e-482434753e95@enneenne.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Rodolfo

On 4/25/24 14:42, Rodolfo Giometti wrote:
> On 25/04/24 14:28, Bastien Curutchet wrote:
>> In the IRQ handler, the GPIO's state is read to verify the direction of
>> the edge that triggered the interruption before generating the PPS event.
>> If a pulse is too short, the GPIO line can reach back its original state
>> before this verification and the PPS event is lost.
>>
>> This check is needed when info->capture_clear is set because it needs
>> interruptions on both rising and falling edges. When info->capture_clear
>> is not set, interruption is triggered by one edge only so this check can
>> be omitted.
>>
>> Add a warning if irq_handler is left without triggering any PPS event.
>> Bypass the edge's direction verification when info->capture_clear is not
>> set.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> 

I don't think I've received any updates since you acked this. Is there 
something missing before the patch can be applied?

Best regards,
Bastien

