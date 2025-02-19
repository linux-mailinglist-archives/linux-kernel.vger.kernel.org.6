Return-Path: <linux-kernel+bounces-521405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39707A3BCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992F5171E95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F101DF96C;
	Wed, 19 Feb 2025 11:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dpk7DRDT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396261DF72D;
	Wed, 19 Feb 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964564; cv=none; b=SQKnUh4A2PGG5M1a+5z9CyFHxWQeYqDg15N682bJuXFHJFQi+tdJYNtHkzIXxX4PbFnmYOpSGFx2OXs3IwyO+XXows1L3dTMYEyUOcJ45J3k7WBMglG33FYecU2ANCKboH4R045T9lcRzmLuwGXY1lcQad7MA8s2tWczmbY64SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964564; c=relaxed/simple;
	bh=Uuiwp5a925+mqRbjAQSitBZGlf30fFYVlceOO8DU7tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKLltSvimO7Rs6mg9ozuxah8R980D5okB3DzryAG4TQRKQV3/KX82M43utz15o+4fR+AvXuB2lETzcsW4I2F21PGbQgvqHSu98iWFqa8VgBpESj7b5tI8qi3MhJWd0acluMEbOVba86k8RbSbSLX0YXlcgAnYR9VJPsAymPwZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dpk7DRDT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739964554;
	bh=Uuiwp5a925+mqRbjAQSitBZGlf30fFYVlceOO8DU7tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dpk7DRDTDqGrV2K4HKfSwGNO/jbFgRGc/0iJ+9dx/sI8mMKmXJFUcOk6/NKEYcROg
	 0jqMrUWIuvkXZVKnpFDxQFOlBg5guB4z24PiOXJ0juzqXLgMUvVyW9jNbIvTnaVMg/
	 1jnzKBYrNAByALxj653jsFeuX0DgOlEGUoxRfpTcCdgVbR3MIhXWqcOUlBc+AXXtpp
	 2vvWnzBsfRcyMznFjayhJPxkSJIvDf5r1lVUkomPs2hjP919XW2xAQtcFADOp2gFe8
	 lEsinOw7o7IzAnb8KLADSWyfhOKuriotj8fi1SDiyDhN/s7hwLYCkNSI7AkSL8TAm/
	 m+4LruStF3G5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C15017E0E92;
	Wed, 19 Feb 2025 12:29:14 +0100 (CET)
Message-ID: <6cd2be03-a3e8-4bdc-b91e-51b3e1029782@collabora.com>
Date: Wed, 19 Feb 2025 12:29:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ASoC: mediatek: mt8188: Support DMIC in AFE
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 parkeryang <Parker.Yang@mediatek.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-4-6bc653da60f7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250218-genio700-dmic-v1-4-6bc653da60f7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
> From: parkeryang <Parker.Yang@mediatek.com>
> 
> Add the AFE routes that connect the DMIC (I004-I011) to the UL9 frontend
> (O002-O009) and register the mt8188-dmic DAI driver during probe.
> 
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   sound/soc/mediatek/mt8188/Makefile            |  1 +
>   sound/soc/mediatek/mt8188/mt8188-afe-common.h |  1 +
>   sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    | 24 ++++++++++++++++++++++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/sound/soc/mediatek/mt8188/Makefile b/sound/soc/mediatek/mt8188/Makefile
> index 1178bce45c50ba252672a32b3877732a5a76c610..b9f3e4ad7b07ba9e21c846706371c53269f894db 100644
> --- a/sound/soc/mediatek/mt8188/Makefile
> +++ b/sound/soc/mediatek/mt8188/Makefile
> @@ -6,6 +6,7 @@ snd-soc-mt8188-afe-y := \
>   	mt8188-afe-pcm.o \
>   	mt8188-audsys-clk.o \
>   	mt8188-dai-adda.o \
> +	mt8188-dai-dmic.o \
>   	mt8188-dai-etdm.o \
>   	mt8188-dai-pcm.o

The Makefile addition doesn't belong to this commit. Please fix.

The rest looks good.

Cheers,
Angelo

