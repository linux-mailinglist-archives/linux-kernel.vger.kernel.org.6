Return-Path: <linux-kernel+bounces-548938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D4A54B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB9D7A3DB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8A11DD9AC;
	Thu,  6 Mar 2025 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0dgUpT3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1417BA9;
	Thu,  6 Mar 2025 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265302; cv=none; b=PLFGMLSLH9G3rojfMHdvLRkXrZ+gUEG7y4N9NAw7qrxrhWevFbvj588IUraqmscCc6jvYwy91ZjwBHxNc02BjLekCq6mUWyTeUlMHt0Z2WXt/9TFkrroqYZHy2omr71Nl5LbJiUTxMmka6WEo8kv+stkI0L3DaWMkujZ3SX4b88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265302; c=relaxed/simple;
	bh=5C7aROZo8+xCUQ9LcbbPat4a/6LWWgnqoOkYrP/axQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NU2Es5qM7AeikqO1lCuWuXnVBo8d4d/349BMYYyEfObcmCHJiGWjpkaLYRRI8F218X/yIFYOelQkkDTi7AXk9Y/mR8wCSdM1uCK+bS4k6+kqZslIKpivt9wVRzQU3/VF3u9EgLI7Y3rJAcj4t3ulESvbRZutmMeCUTtUjHaUARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0dgUpT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0894C4CEE0;
	Thu,  6 Mar 2025 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741265301;
	bh=5C7aROZo8+xCUQ9LcbbPat4a/6LWWgnqoOkYrP/axQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C0dgUpT3AcWMxxfCM0o8x+nvhUdzFJXIQ1okOfU996ZWHfSQYOAPJg7BGS9veGuAC
	 UpwoAePiIHwN3xuLBJp7nEtY6+TIVVLsx0RSOXhptZj61m8wfNAxT8D4w1tIw2azgU
	 Puf95ciKBzaPBefD4qJ9Ob6p7WTR1W3wZvt9SqqadCeE5cboZPsmB/WVbEFSA1j7Vh
	 R7lI/8Maafiky0wzs6tnUbnnsAKnOg1wsvvKZMWscd8Nr8bBnsHIZIF2xRhzJAH8io
	 QjV3QccuD1ThV1FyAYAJUN7BSsHsMLfTRw6efSHvql2Ed+VbCHh9meYKyD9ANmZ521
	 wtRgCRvpkJ+Hw==
Message-ID: <463ca2df-a0ee-4b9e-a988-12f316ae7d1a@kernel.org>
Date: Thu, 6 Mar 2025 13:48:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250221074846.14105-1-friday.yang@mediatek.com>
 <20250221074846.14105-2-friday.yang@mediatek.com>
 <0dcb2efd-6bbb-4701-960a-74930eb457e4@collabora.com>
 <264f78c1067e363c69e146543ebb77dbedfbd181.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <264f78c1067e363c69e146543ebb77dbedfbd181.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 13:45, Friday Yang (杨阳) wrote:
>>> +          const: mediatek,mt8188-smi-larb
>>> +        mediatek,larb-id:
>>> +          oneOf:
>>
>> Are you really sure that you need 'oneOf' here? :-)
>>
>> Regards,
>> Angelo
> 
> Yes, I have tested it. If I try to modify the 'examples'
> like this. That is:
>   change the compatible to "mediatek,mt8188-smi-larb",
>   add 'mediatek,larb-id = <10>;'
> 
> examples:
>   - |+
>     #include <dt-bindings/clock/mt8173-clk.h>
>     #includ
> e <dt-bindings/power/mt8173-power.h>
> 
>     larb1: larb@16010000 {
>       compatible = "mediatek,mt8188-smi-larb";
>       reg = <0x16010000 0x1000>;
>       mediatek,smi = <&smi_common>;
>       mediatek,larb-id = <10>;
>       power-domains = <&scpsys MT8188_POWER_DOMAIN_VDEC>;
>       clocks = <&vdecsys CLK_VDEC_CKEN>,
>                <&vdecsys CLK_VDEC_LARB_CKEN>;
>       clock-names = "apb", "smi";
>     };
> 
> The 'dt_binding_check' could give the following
> errors:
> 
> Documentation/devicetree/bindings/memory-controllers/mediatek,smi-
> larb.example.dtb: larb@16010000: 'resets' is a required property
> from schema $id: 
> http://devicetree.org/schemas/memory-controllers/mediatek,smi-larb.yaml#
> Documentation/devicetree/bindings/memory-controllers/mediatek,smi-
> larb.example.dtb: larb@16010000: 'reset-names' is a required property
> from schema $id:  
> http://devicetree.org/schemas/memory-controllers/mediatek,smi-larb.yaml#
> 
> And this is what I want to achieve. On the MediaTek MT8188 SoC
> platform, 'resets' and 'reset-names' are only required for SMI LARBs
> located in image, camera and ipe subsys. Others can be ignored. And the
> 'larb-id' of these SMI LARBs are shown in this array: [ 9, 10, 11, 12,
> 13, 16, 17, 18, 19, 20 ].
> 
> Please feel free to let me know if you have any doubts.

You did not really answer the question. Where is anything about oneOf in
your reply?

I am dropping this patchset from my queue.

Best regards,
Krzysztof

