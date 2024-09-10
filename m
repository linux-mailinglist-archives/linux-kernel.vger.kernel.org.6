Return-Path: <linux-kernel+bounces-322632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD487972BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8243C1F26426
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5BE18EFC6;
	Tue, 10 Sep 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P6+nbddx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="MSdY733J"
Received: from a7-46.smtp-out.eu-west-1.amazonses.com (a7-46.smtp-out.eu-west-1.amazonses.com [54.240.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF318E744;
	Tue, 10 Sep 2024 08:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955723; cv=none; b=kVl73/6Ng24mvPUnzxqHrdn/ujsxuCl/JjFpfM8LTGzz58knyul1WnrDZe8xxW++K8BnRFC5ZZDF6iZK1zlaWDXMHDKwa3nt0K1W9KjeYUDE5De+WkZ77F5oE1kkdCDWSG3WYyVE/DCvrX+zdOgeIjaqMC4G34+TI1WJgyKn1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955723; c=relaxed/simple;
	bh=CMzM2OmUAjHBG7xyXlb5CqeG7AYsJx3XrH0ReYN+K80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evwpgnMC5ieqKugIA/rJw9F+KVO7NPRrWOkMJUPYpPfud3OmESdp3OnBxm8Kqo8rgJvFOqR+NHfaWx3vNJSB8YFUlrXnsy2zrSHNfHeVwXNGGlRogjG9QStOnieXYZuSeWrxPb+9v9eTusyIX0dxTt9brrIFMmrrEZz+duZk7ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P6+nbddx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=MSdY733J; arc=none smtp.client-ip=54.240.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725955720;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CMzM2OmUAjHBG7xyXlb5CqeG7AYsJx3XrH0ReYN+K80=;
	b=P6+nbddx9e8GQe8AEJCW5t1Wu7f5l0l96bnP+ujVgcAgIROuRWvJIdBhySUQsOtw
	j7Lt8UqBZNfztPGgr2ARPCEnl56LBm9jkfZf0QVfToehnx62GnGlNRMErQ+ChNLBb4Z
	r2GGVsh0pt3C//K7D2A6oQuCNUMNRSSF/Y65xC2lWU6p7bUmjbMiaq2iLsXx7oOVKOV
	I95MP0BzEtmWEcJQG134t3/sHo5NuSb3dODZ0MyM2H1QE/JpGjQmDxicFxhZNED7pR+
	aEL7JGQC1PCW1LWMH5FtGsZjq/xJ6X8hrh9SbVIkDmgqXdiae8NqFmflFz4f1lyifQv
	2ZI1Aee8lA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725955720;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=CMzM2OmUAjHBG7xyXlb5CqeG7AYsJx3XrH0ReYN+K80=;
	b=MSdY733JFvyqSrkXqPdO6T2dgUOs8csMz301DyjJ3BBiuHbsC/UDV8fx4LaXZQae
	oY+V2/L9RO7BgNdUoLzsEsTCawwLhgru3Q4yqIi4sL3zoBjs3KA5BjJm/se1Ny4FoA7
	1ZmGsBhP2uozcYc/b6rxC2EQEW0DD71Dfujeh9cc=
Message-ID: <01020191dafa43a8-cca2fb3f-7eda-4e39-9ca1-eccb78c566a4-000000@eu-west-1.amazonses.com>
Date: Tue, 10 Sep 2024 08:08:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] dt-bindings: display: mediatek: Add OF graph
 support for board path
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"sui.jingfeng@linux.dev" <sui.jingfeng@linux.dev>, 
	"wenst@chromium.org" <wenst@chromium.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, 
	=?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, 
	=?UTF-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>, 
	"michael@walle.cc" <michael@walle.cc>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"robh@kernel.org" <robh@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"airlied@gmail.com" <airlied@gmail.com>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"kernel@collabora.com" <kernel@collabora.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	=?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"amergnat@baylibre.com" <amergnat@baylibre.com>
References: <20240618101726.110416-1-angelogioacchino.delregno@collabora.com>
 <20240618101726.110416-2-angelogioacchino.delregno@collabora.com>
 <3e58a224e6323e28c370d460fa72e23b958bcf62.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <3e58a224e6323e28c370d460fa72e23b958bcf62.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.10-54.240.7.46

Il 08/08/24 05:45, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Tue, 2024-06-18 at 12:17 +0200, AngeloGioacchino Del Regno wrote:
>> The display IPs in MediaTek SoCs support being interconnected with
>> different instances of DDP IPs (for example, merge0 or merge1) and/or
>> with different DDP IPs (for example, rdma can be connected with either
>> color, dpi, dsi, merge, etc), forming a full Display Data Path that
>> ends with an actual display.
>>
>> The final display pipeline is effectively board specific, as it does
>> depend on the display that is attached to it, and eventually on the
>> sensors supported by the board (for example, Adaptive Ambient Light
>> would need an Ambient Light Sensor, otherwise it's pointless!), other
>> than the output type.
>>
>> Add support for OF graphs to most of the MediaTek DDP (display) bindings
>> to add flexibility to build custom hardware paths, hence enabling board
>> specific configuration of the display pipeline and allowing to finally
>> migrate away from using hardcoded paths.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>> Tested-by: Alexandre Mergnat <amergnat@baylibre.com>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
> 
> [snip]
> 
>>   
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
>> index 677882348ede..98db47894eeb 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
>> @@ -110,6 +110,28 @@ properties:
>>         include/dt-bindings/gce/<chip>-gce.h, mapping to the register of display
>>         function block.
>>   
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    description:
>> +      Input and output ports can have multiple endpoints, each of those
>> +      connects to either the primary, secondary, etc, display pipeline.
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description: ETHDR input, usually from one of the MERGE blocks.
> 
> Sorry, I find one question now.
> I think ETHDR may have multiple input, and ETHDR receive data from all input at the same time.
> Why here has only one input port?
> 
> MERGE -->+-----------------+
>           |                 |
> MERGE -->|                 |
>           |      ETHDR      |
> MERGE -->|                 |
>           |                 |
> MERGE -->+-----------------+
> 

Because ETHDR takes one input (ex. "one image", or "one data stream") port, which
is composed of multiple input endpoints (where each endpoint is a MERGE block) :-)

Cheers,
Angelo

> Regards,
> CK
> 
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          ETHDR output to the input of the next desired component in the
>> +          display pipeline, for example one of the available MERGE blocks,
>> +          or others.
>> +
>> +    required:
>> +      - port@0
>> +      - port@1
>> +
>>   required:
>>     - compatible
>>     - reg
>>


