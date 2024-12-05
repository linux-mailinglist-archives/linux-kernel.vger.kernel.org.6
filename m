Return-Path: <linux-kernel+bounces-433275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A89E55D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1738164D36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BFD218AB7;
	Thu,  5 Dec 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KZSgg/eG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A01773A;
	Thu,  5 Dec 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403126; cv=none; b=aeZs3Mj7kyH2eqWxDG6WqAkDv0BrCwB4568zopMnowJxUH60zWMzjVrytxhN1TZd0GMegDZCP2v8qLQDoyGM7z8s1rInc/2vr0jzS0HdYTNcAJG4lLh14AakI70gDVLhPxfgedWtOA/wzJLNR/my7ofrbrjRRgjSb+95MxQfC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403126; c=relaxed/simple;
	bh=YFG6FkeYF20hfhB+H5eEVSa+7PdyoD2Fi7/VWdKN8TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwXG/wtJODywjGSVJJYU4Lq9snoGLtk0R8K3pBRivrzQIKWyFJRA6EjbDClIthyNnzyE83ldAn7BeBT0VGt2bk2xbrMIExhqNq3WnNk2q82r2rUzjYbxPrj9sYJkeD+WRGf8voTNsE5Dlgm/3vGArCcQRhrGG/gk6YtJOmY3Iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KZSgg/eG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733403118;
	bh=YFG6FkeYF20hfhB+H5eEVSa+7PdyoD2Fi7/VWdKN8TA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KZSgg/eG+4pJoYg5IOAh4jn0QexhOcRzFpHycAlWZdQ3PQcacmRwLiViHhCfpCyx3
	 SgEYLUIW373laCBE2ZpsVyDd/WarbyA/3w8WsmvjLxdC3wbM7KXhxZg29W12e6Q5Yk
	 f62XrD6L0AXoNwVkg4Te7ORJJZQOuaRSLUyMbq7+kugsJChxp0He5LzsethuHQ4dqA
	 Ti7n1SPjPhNcVlgCeqR+J37KfmLt48dhu4XSMKk4G+U5VEBQ8gGtKmO6wRe0Av5FF8
	 haU1hnrwnZYE3aPFxBtiyO+022xaK2ZXxKWNcseJ1bO05wdokYUrZuTTNOXCbJCnu1
	 WxwkoVLcByjRw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D3C8717E36AF;
	Thu,  5 Dec 2024 13:51:57 +0100 (CET)
Message-ID: <a70a0521-985d-43a4-a1fa-36eb733d5ca9@collabora.com>
Date: Thu, 5 Dec 2024 13:51:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
To: =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 Nicolas Prado <nfraprado@collabora.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com"
 <tiwai@suse.com>, "perex@perex.cz" <perex@perex.cz>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
 <a10dbdf265194e77a69b6e40afa3df9636b3ab14.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <a10dbdf265194e77a69b6e40afa3df9636b3ab14.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/12/24 13:17, Trevor Wu (吳文良) ha scritto:
> On Tue, 2024-12-03 at 17:07 -0300, Nícolas F. R. A. Prado wrote:
> 
>>
>> Currently, booting the Genio 700 EVK board with the MT8188 sound
>> platform driver configured as a module (CONFIG_SND_SOC_MT8188=m)
>> results
>> in a system hang right when the HW registers for the audio controller
>> are read:
>>
>>    mt8188-audio 10b10000.audio-controller: No cache defaults, reading
>> back from HW
>>
>> The hang doesn't occur with the driver configured as builtin as then
>> the
>> unused clocks are still enabled.
>>
>> Enable the apll1 clock during register read/write to prevent the
>> hang.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>   sound/soc/mediatek/mt8188/mt8188-afe-clk.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
>> b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
>> index
>> e69c1bb2cb239596dee50b166c20192d5408be10..fb8cf286df3f02ac076528b898f
>> d0d7a708ec1ea 100644
>> --- a/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
>> +++ b/sound/soc/mediatek/mt8188/mt8188-afe-clk.c
>> @@ -587,6 +587,8 @@ int mt8188_afe_enable_reg_rw_clk(struct
>> mtk_base_afe *afe)
>>          mt8188_afe_enable_clk(afe, afe_priv-
>>> clk[MT8188_CLK_AUD_A1SYS_HP]);
>>          mt8188_afe_enable_clk(afe, afe_priv-
>>> clk[MT8188_CLK_AUD_A1SYS]);
>>
>> +       mt8188_afe_enable_clk(afe, afe_priv-
>>> clk[MT8188_CLK_APMIXED_APLL1]);
>> +
>>          return 0;
>>   }
> Hi Nicolas,
> 
> If I understand correctly, APLL1 should be the parent clock of
> AUD_A1SYS_HP and AUD_A1SYS, so it should be enabled automatically by
> CCF.
> 
> I'm not sure why you resolved the hang issue after enabling APLL1.
> Could you share more details about the solution?
> 

Hmm. Now I see what's happening here...

Nicolas, Trevor,

Possible parents for top_a1sys_hp are:
  - clk26m
  - apll1_d4

...what's happening here most probably is that after the clock gets disabled as
unused, it gets parented to clk26m by default as that is parent index 0... and
something else in AFE needs APLL1 to feed a clock to .. something .. to allow
register access.

Trevor, do you know why is this IP unaccessible when A1SYS is parented to clk26m?

That might give Nicolas a definitive hint about how to resolve this issue.

Cheers,
Angelo

> Thanks,
> Trevor
> 
>>
>> @@ -594,6 +596,8 @@ int mt8188_afe_disable_reg_rw_clk(struct
>> mtk_base_afe *afe)
>>   {
>>          struct mt8188_afe_private *afe_priv = afe->platform_priv;
>>
>> +       mt8188_afe_disable_clk(afe, afe_priv-
>>> clk[MT8188_CLK_APMIXED_APLL1]);
>> +
>>          mt8188_afe_disable_clk(afe, afe_priv-
>>> clk[MT8188_CLK_AUD_A1SYS]);
>>          mt8188_afe_disable_clk(afe, afe_priv-
>>> clk[MT8188_CLK_AUD_A1SYS_HP]);
>>          mt8188_afe_disable_clk(afe, afe_priv-
>>> clk[MT8188_CLK_AUD_AFE]);
>>
>> ---
>> base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
>> change-id: 20241203-mt8188-afe-fix-hang-disabled-apll1-clk-
>> b3c11782cbaf
>>
>> Best regards,
>> --
>> Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>>


