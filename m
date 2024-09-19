Return-Path: <linux-kernel+bounces-333510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A294197C9C7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4270DB20E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B619DF76;
	Thu, 19 Sep 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T74+YVZU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B481E4B0
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751560; cv=none; b=bk6Vgwfqnp7I88r7uMPzBVALD/zorTVLjk3dZCfW+dnR2RscrUGfIjX9bDhWfpOiQgVvNlrkaGIIZknq3NPt1YTYPrGFJdhF73sqMWSXf/wCwhU1zodQPjaBG3lhsWbBycmxmukaaHVgH4avv2A3cz7ez4zLz5eIsPC7uxKk0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751560; c=relaxed/simple;
	bh=mbKPeHX5dPDsgxkJ1kYk8sbygspVme8Eho7Kxjhv+gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+RrAD1/Fll57MmxSbVtn6fI+UKcbfXShUQROQlf/wI/sXLpkVGKSXPjnrK7ILKLh4p1qShsWSBW9l3QgvEoPe8y55DS1o4LkrS3PvisJbvtj4OSO3UB6tgpQVN7f2UWl5OiVLBAHMikZB+o16yFSagESPtZpOxEab8z4Jbt764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T74+YVZU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726751555;
	bh=mbKPeHX5dPDsgxkJ1kYk8sbygspVme8Eho7Kxjhv+gE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T74+YVZUmPw6cCqQlEIa43Em8BrGfi1YTE7GEDSgxOkWRHnWKKsm6PuemZ/v1gq52
	 X5ZGvb3IBCm3dSE+4ADp62mOBKgjDL9X8esS3O45+2ci7/eaL+kBP3f3H+lgpsExia
	 NnoAkuz35WnhQ052/t8gpCqaRiqxwXgtgqUfEiQ38tKG50zw8FQ1b92iguajWxENuH
	 zoRjcpzBpvy0uAigH03DnHc4n512HX2T80jGl0tmDhDq7Iuvd2kwS540eojo/2GCEg
	 5kHE+ppWrQX6hH/JaKLqNd8kfScBTdpPBU3wwlKrX4TqxS8mh87eq1zbwTN8eaCORz
	 BYDX4AW2s3xXg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 91A6917E14F9;
	Thu, 19 Sep 2024 15:12:34 +0200 (CEST)
Message-ID: <ff80024a-90b2-4a19-b827-23be69352f78@collabora.com>
Date: Thu, 19 Sep 2024 15:12:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/mediatek: Adjustments for mtk_gem_prime_vmap()
To: Markus Elfring <Markus.Elfring@web.de>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Alexandre Mergnat <amergnat@baylibre.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 David Airlie <airlied@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Sui Jingfeng <suijingfeng@loongson.cn>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <254d16d9-d56a-4f26-9914-db75e7aa4287@web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <254d16d9-d56a-4f26-9914-db75e7aa4287@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/24 19:34, Markus Elfring ha scritto:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 17 Sep 2024 19:16:45 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.

Hello Markus,

In my opinion, the suggested changes aren't bringing any improvement, not
in readability nor performance ... nor anything else, really.

For how I see it, the code is fine as it is, but then, that all boils down
to code style preferences and nothing else.

Cheers,
angelo

> 
> Markus Elfring (2):
>    Avoid duplicate sg_free_table(sgt) call
>    Use common error handling code
> 
>   drivers/gpu/drm/mediatek/mtk_gem.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> --
> 2.46.0
> 



