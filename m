Return-Path: <linux-kernel+bounces-211153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81226904DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888791C22649
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C6716C861;
	Wed, 12 Jun 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q0RWbMR9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E345948;
	Wed, 12 Jun 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179952; cv=none; b=B/lwLnw+SLU3iDvuaAL5KYgmi4kL2UQqYv7S46r5KBfArvqbj8hcoLK8pyktn6fA831hLqVx1pq0P1YcEQFylRXuLeT/Igdvq9Isqi7l4SQnk6xjBGDBjjGH/fQEr5uGpBrtDpG3vC3ploWBSCaY4w0J9/96bTFWJNE3AYoFiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179952; c=relaxed/simple;
	bh=rLJunDbeQeAUOd1JejIPRVqX35zvCbzWB9CqhTOod/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDECe7T+TdOtYL0WcoQthltxcFNkt6TfV+SeSsX65z9t/ELftMk9+3td6bZU/mFyf5uVAKLPNE4M1KB7X+gOsXoSZBXOsrhHewOEfEs6YQRgX8zmlCH3qAiZ2EBJsugfcwlVHKLoplJ9BTLlEvAp5x0PbqwLH3hTrHCOM5VNJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q0RWbMR9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718179949;
	bh=rLJunDbeQeAUOd1JejIPRVqX35zvCbzWB9CqhTOod/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q0RWbMR9uA0R0gEmNo/Y42AKdEY0c8S2LtxkiNObYUUoOkwdu26EjDos8f9ExotJ1
	 pv7VbPZZDqiBgjCuO3kHA3+PdUXqj1G1N0dIGS2D5UyRZgvm0AyOsUIwLLbX6s7xjx
	 7vusY0GZrdJdkzFMks1JOJ83fMKjFYUwCiZ4VWPOiWs1r2S3tu/gyN6itwc7U9ksDK
	 Pm+02wXMtSckWKMOUuD/K1ZquWNrilL7dr7UzW2Nbl3ldSAshzuzyJknCp4TiNfZVW
	 clvAMte8TGX23djR8BpQ9hpyiAALcGMkdHtywsbf6SpRT4To25jen3L0Gvepm5aKXo
	 8zRzswiHzBYgQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC54D37820A9;
	Wed, 12 Jun 2024 08:12:27 +0000 (UTC)
Message-ID: <ea604d75-e571-4d63-a7e2-aa1393588c75@collabora.com>
Date: Wed, 12 Jun 2024 10:12:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: add missing MODULE_DESCRIPTION() macros
To: neil.armstrong@linaro.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Imre Kaloz <kaloz@openwrt.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <20240611-md-drivers-soc-v1-1-8f0fc9fff234@quicinc.com>
 <a314c676-3dbd-46f8-826a-2e59367d30ce@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a314c676-3dbd-46f8-826a-2e59367d30ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/06/24 09:58, Neil Armstrong ha scritto:
> On 12/06/2024 07:50, Jeff Johnson wrote:
>> With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/imx/soc-imx8m.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-qmgr.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/ixp4xx/ixp4xx-npe.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>> drivers/soc/mediatek/mtk-cmdq-helper.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in 
>> drivers/soc/amlogic/meson-clk-measure.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> This is the last of the issues that I see in the soc directory
>> ---
>>   drivers/soc/amlogic/meson-clk-measure.c | 1 +
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org> # for 
> amlogic/meson-clk-measure.c
> 
>>   drivers/soc/imx/soc-imx8m.c             | 1 +
>>   drivers/soc/ixp4xx/ixp4xx-npe.c         | 1 +
>>   drivers/soc/ixp4xx/ixp4xx-qmgr.c        | 1 +
>>   drivers/soc/mediatek/mtk-cmdq-helper.c  | 1 +
>>   5 files changed, 5 insertions(+)
>>

MediaTek:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but I'm not sure how we should apply this? :-)

Either Arnd takes it directly, or you split it per-soc... and I don't have any
preference anyway.

(P.S.: Added Arnd to the loop)

Cheers,
Angelo

>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c 
>> b/drivers/soc/mediatek/mtk-cmdq-helper.c
>> index 046522664dc1..dd70d4d2bed7 100644
>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>> @@ -526,4 +526,5 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>>   }
>>   EXPORT_SYMBOL(cmdq_pkt_finalize);
>> +MODULE_DESCRIPTION("MediaTek Command Queue (CMDQ) driver");
>>   MODULE_LICENSE("GPL v2");
>>
>> ---
>> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
>> change-id: 20240611-md-drivers-soc-1780b1939627
>>
> 



