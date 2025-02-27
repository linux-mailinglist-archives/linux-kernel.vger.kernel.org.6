Return-Path: <linux-kernel+bounces-536621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14DA48229
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518AB19C6F50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93B270032;
	Thu, 27 Feb 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="izF4xcrC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542C723771E;
	Thu, 27 Feb 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667346; cv=none; b=n3eWBGF2U0XUcEohFVBn1ZW6T8dngvGMvn6Ez1tdgx9DQuFn8Ds/JxElHWfqTXPDej41Q5nUodCeRnqYpVZMjyazanJsCLzABy17h8dK03ozwOK27HdWupiltl9ErIkkC9G08OoOsi7gDBeCy1Pvqsv/kQyrKAbNEHeUYPcUfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667346; c=relaxed/simple;
	bh=gw3yhjaD34XHxfwtco/3BRJayc9o3DLXMMEhaJRahdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ts2Kx9sa1VZfCueFLk6Y6DpmpjCwrsXIVVt3VZ9BgGwDsp4ulowwMoQlO0vYaUPNzneUoEmIqe0A6R2zDlYUAmLiE8DhCv3YeF2wlza6SiLOnj1Z9n+nPjS8ng84b7A16nNBXfy3Dq3wlLa1WYKRLOBbTJ/mBmTn1axKBtMamuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=izF4xcrC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740667342;
	bh=gw3yhjaD34XHxfwtco/3BRJayc9o3DLXMMEhaJRahdk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=izF4xcrCafDcNBAziKL40z+O24j05bpv7QQCpr1mlk78Prem1x3LczV3gTWAL7eN7
	 HhP+R9Z2pl3w8KIkEqQjhZc2NkU9pZM9O76ENRFuTqmF0FkP/q4Q2Ed2ohSufJT7VP
	 PP1KxeY6rZpxCogyjKSJs8EU4iGzu2ZQWSXOWESz9XpGgDaeX+8AioxzOXWDfhed/g
	 CNeURodYDSoaf82rHOFTcjrORQlR8dpPr0gYJMeu+geM67KX9OnE2ME29goZeTqDnp
	 vitS9KvVdBuFz/u9xsSVZMx0oowaCuEI3Xpj2Rm34u1aXbKMJTwrb4kCQW40+G2dsn
	 lCXKMK+0OcoYw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA0B517E05A6;
	Thu, 27 Feb 2025 15:42:21 +0100 (CET)
Message-ID: <06563381-faea-48de-86f1-4db174de394b@collabora.com>
Date: Thu, 27 Feb 2025 15:42:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8188: avoid uninitialized variable use
To: Arnd Bergmann <arnd@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 parkeryang <Parker.Yang@mediatek.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250227131939.1040168-1-arnd@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250227131939.1040168-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/02/25 14:19, Arnd Bergmann ha scritto:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The 'msk' variable has no initialization:
> 
> sound/soc/mediatek/mt8188/mt8188-dai-dmic.c:311:4: error: variable 'msk' is uninitialized when used here [-Werror,-Wuninitialized]
>    311 |                         msk |= PWR2_TOP_CON1_DMIC_FIFO_SOFT_RST_EN(i);
>        |                         ^~~
> 
> Set it to zero before the loop.
> 
> Fixes: c1e42ec04197 ("ASoC: mediatek: mt8188: Add support for DMIC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



