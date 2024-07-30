Return-Path: <linux-kernel+bounces-267991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37701941F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30862820F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D393189916;
	Tue, 30 Jul 2024 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rls7Fzj2"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D8184547
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362261; cv=none; b=gwTEGYLn3AVgkxvxaT+M/v/7STd2jmHeD6sWh1B7ZVLYhyFnVKjLvf8HOdac4OFmVdMhorCYzDhsqiQfwf1M7hwXMjTjth4C/M7FlCFPZ+9QAL+eSzGc6QI4VNQ+ZuIC73GFk0ZSpgVc/ngkbXfjnavd/EmfqO+fAszO3cJvFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362261; c=relaxed/simple;
	bh=aN8XLejS5eKcdTw4Fka+qGK3eZ9UApC18AQUPmc5PIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lw/8vGPQlFj7MQZ4FB9x5fWq2SPj+2TQX3va437Miw83LIoyp+nFsHM4n0SWhjyzj/j7sP7aOKLZWUl269eTNgUBhFsidsKb6OuHi2Y1mwdZZ4gbXTqUbV8GlUfWHp0gImeWfvFs2JfV/Y2V88+3IZ0zyLnxS5tTrEo/G9jzxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rls7Fzj2; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ce860f0b-2a05-451f-a2e5-90c00070370b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722362257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E6SSLdV1+BEQ9lFafavy7nOb236w9iKR5PJPw85QXo0=;
	b=rls7Fzj2PTwK6fD9FijmG7QTS/ngjrL9NKRq1MR92jYRs0P4PwfXKqIWjhFPXhi2H2cH0e
	w5SW1WO8lrKChWkPwC6PlKBq9M/zOKVUAhmOoeFRU4zqSTYoG9zgKqfRtt6+MH8sq8aT3D
	V5SiWqKynkavDIv9gtQ0EqFj/ec5/0g=
Date: Wed, 31 Jul 2024 01:57:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/2] drm/loongson: Add dummy gpu driver as a
 subcomponent
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
 <20240728152858.346211-3-sui.jingfeng@linux.dev>
 <139afaab-343e-4cb4-83b7-2695129d27b1@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <139afaab-343e-4cb4-83b7-2695129d27b1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 2024/7/29 15:15, Markus Elfring wrote:
> …
>> the driver is loaded, drm/loongson driver still need to wait all of
>                                                    needs to wait on …?
>
>
> …
>> design. Therefore, add a dummy driver for the GPU, …
> Is there a need to reconsider the categorisation and usability descriptions
> another bit for such a software component?


For honoring the framework and testing the framework purpose.


The GPU can possibly be the master of the all sub-components, this 
definitely need some extra

consideration and negotiation with the DC and the fake master device. 
Depend on  configuration

and user space expectation. The problem should be solved earlier.


> Regards,
> Markus

-- 
Best regards,
Sui


