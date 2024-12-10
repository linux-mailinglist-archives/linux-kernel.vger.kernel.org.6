Return-Path: <linux-kernel+bounces-440505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD199EBF34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A233B284701
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD917211265;
	Tue, 10 Dec 2024 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EZsp/FYR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AB1AAA0F;
	Tue, 10 Dec 2024 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872707; cv=none; b=ZE8bc7AVOofaJQGA2YyBfF0+wHHrZYPplJq7Zbb88nnsS+AngBGYvoI2X8rcKaEl931cVXluaQmctUx1qtgOuz/DYrVkPObjgDNLZ5NsALOc4y8LWVV/ZP/bvlD+O3hLi6sKdU1t/JmovyArfMzjh8ph/xzT9uobyNrusoJdXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872707; c=relaxed/simple;
	bh=2xopEnnq5/pPO8ebcQ2iA7v0L/YlJ7nHPQG7P9WTTEk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LLfDK2737FEdG3Ka1oU74ObM+/mgXg3fLmC4uR5632DxyapGsM/0J9RKDKJV5WlTtNhMdux6ykK7fSfTOGqYNBDJV6R9BcpkLYOBGjHpR2AWcOmeeX5abWzY073n4skK32xttzv1B9JiTdlpwk1cquYx0i45/9GFZVWBk7iLCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EZsp/FYR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733872703;
	bh=2xopEnnq5/pPO8ebcQ2iA7v0L/YlJ7nHPQG7P9WTTEk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=EZsp/FYRIFSmUXEd2TZUjJHZYAZKXEk2H2eiauaA0UN8wgqFeaCBYlQWGoSEpQnD7
	 jFdNMcnVS6J7H5pUohRFkpVLEQ3EReBmUlNwzAusaBjaYdyLNuZCWTNBgyM3VIq0Z8
	 S19sh8M7d4kWUgDkqyOWx+khUgj4v2HjctQeWzq4l20nLNfx3UKplW1DPBlbhw7QGD
	 v3DW2aS/3Xy+tUXoANx3jX/1fWYreKuRbMQy7a3yyQrinMdlewtfJG1VvhnHRjkQNZ
	 ysMuhjr/vY3P1KqZSsSCTcGJJ01iIKq60GEsMS3pPaLnC5+VULo9xk5YO8yQLcklB/
	 3LYr+AHwfXYbQ==
Received: from [192.168.1.90] (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDF7317E0B54;
	Wed, 11 Dec 2024 00:18:22 +0100 (CET)
Message-ID: <b15c0a3b-36dc-49f8-9dfc-4bac5beece9a@collabora.com>
Date: Wed, 11 Dec 2024 01:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add support for HDMI1 output on RK3588 SoC
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com>
Content-Language: en-US
In-Reply-To: <20241207-rk3588-hdmi1-v1-0-ca3a99b46a40@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/24 11:32 PM, Cristian Ciocaltea wrote:
> The patches provide the basic support to handle the second HDMI output
> port found on Rockchip RK3588 SoC.
> 
> For now I enabled it on Radxa ROCK 5B only, the board I've been using to
> validate this.

Please ignore this revision and use v2 [1] instead, as it fixes a pin 
conflict issue occurring when having CONFIG_SPI_ROCKCHIP_SFC enabled.

Thanks,
Cristian

[1] https://lore.kernel.org/all/20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com/

