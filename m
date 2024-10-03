Return-Path: <linux-kernel+bounces-348895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C44E98ED46
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C7A282187
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7158A15098A;
	Thu,  3 Oct 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVTYgZhj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990B3D68;
	Thu,  3 Oct 2024 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952381; cv=none; b=eZfeSlmKODfZDC32HTzgp/bZVEQWzY5Y9Y9q2FxFYP9jA+RdxyvtNvY8uktPsuSPXz6gIFBY+LBpWKsxZS3WJMXzf9xx53t90hq36oHfZkThnrt4/o6POmHHg8pKVoBIFlQoIM+XDkgul4ANhyff9VNG8QuNKppg/j0UGtam5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952381; c=relaxed/simple;
	bh=m9/K6VvhKFRFfOMebN3I5d+4T6RrW1K2nP92qcHvI6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHsmVe+zCWcZFnvq63RhGgSl5Qrm/f4lbgy7eDeXcBiFhoHsCkU1qtJE10cfkBm0KUGReGsgTYeDM1vnELD30o1aZo68KhqyXbjL8j2YIRDcDYMVnzryhgATXDPiPf9Cr5pUqSwxXVzaWXzSylQQelTt3cHrGI0wShzw9K+VpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVTYgZhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132C5C4CEC5;
	Thu,  3 Oct 2024 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727952381;
	bh=m9/K6VvhKFRFfOMebN3I5d+4T6RrW1K2nP92qcHvI6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVTYgZhjNCrm6XEtRVAvqp8LGSFWQsn68WS1I68rxULa62NDQHN45W2HAGtGnZF+V
	 n8TWskvwAXqxF8mLnG/z8+Pb0BUVlDrymNvVvYW20yE3+02GDGNxDHPA+XVxXrI12E
	 pM/g9eyFGc/uOnMzA7WNcCqkgQAM8qfrLTSQUl7KcTtPnNrw8UNGwC73yjM0ZENW9W
	 9j2fIvsN2mNXlvmrdfPLlXaLhrKLyjgSde+L/euq+2mBrmFTtDvCC0Q0ufduWQm4Rz
	 JuwecyTgFEB3yrmkmBEoBwVXfU5GTasKyPAlNU5iua3xQrFqTSwItUcYTO9qdgPqBb
	 2FXjOksl5l8kA==
Message-ID: <82db5037-bbd3-4005-bde9-02df1bf4c475@kernel.org>
Date: Thu, 3 Oct 2024 12:46:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: clock: imx8m-anatop: support spread
 spectrum clocking
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <20240928083804.1073942-1-dario.binacchi@amarulasolutions.com>
 <20240928083804.1073942-2-dario.binacchi@amarulasolutions.com>
 <566859c1-a397-4465-987e-0682b07a703e@kernel.org>
 <CABGWkvqqg-PGAZTCz=MMLRx5F93jaN_=z8zJt1sDd3PHXd80PQ@mail.gmail.com>
 <6c3e6071-822f-4230-b76b-276330de07ef@kernel.org>
 <CABGWkvrU507BHoP94Y7fEyFr=chuuy3o=oBHtuWRvwTw3GnxXw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CABGWkvrU507BHoP94Y7fEyFr=chuuy3o=oBHtuWRvwTw3GnxXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/10/2024 08:29, Dario Binacchi wrote:
> On Mon, Sep 30, 2024 at 8:45 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 29/09/2024 22:00, Dario Binacchi wrote:
>>>>
>>>>
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      contains:
>>>>> +        enum:
>>>>> +          - fsl,imx8mm-anatop
>>>>> +
>>>>> +then:
>>>>> +  properties:
>>>>> +    fsl,ssc-clocks:
>>>>
>>>> Nope. Properties must be defined in top-level.
>>>>
>>>>> +      $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>> +      description:
>>>>> +        The phandles to the PLLs with spread spectrum clock generation
>>>>> +        hardware capability.
>>>>
>>>> These should be clocks.
>>>
>>> Sorry, but I can't understand what you're asking me.
>>> Could you kindly explain it to me in more detail?
>>
>> You added new property instead of using existing one for this purpose:
>> 'clocks'.
> 
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> I added this new property specifically for managing spread-spectrum.
> Indeed, not all clocks/PLLs
> managed by the node/peripheral support spread-spectrum, and the added
> properties specify
> parameters for enabling and tuning SSC for each individual PLL based
> on the index of each list.
> If I were to use the 'clocks' property and add a clock to this list
> that does not support SSC, IMHO
> the pairings would be less clear.

You duplicate property with argument "pairings shall match". Well, I am
not happy with the duplication. Clocks have specific order, thus it is
explicit which one needs tuning. Your other properties can match them as
well, just index from clocks is offset...


> 
> AFAIK the confusion arises from the fact that this node, which is a
> clock controller, was used only
> to export its base address, but perhaps it should have also exported
> its clocks, which the other
> clock controller does, as shown in:
> Documentation/devicetree/bindings/clock/imx8m-clock.yaml.

You use it as clocks, so I don't understand this comment.

> If I consider its 'compatible' entries:
> - 'fsl,imx8mm-ccm' -> drivers/clk/imx/clk-imx8mm.c
> - 'fsl,imx8mn-ccm' -> drivers/clk/imx/clk-imx8mn.c
> - 'fsl,imx8mp-ccm' -> drivers/clk/imx/clk-imx8mp.c
> the probe function, triggered by fsl,imx8m{m,n,p}-ccm (and not
> fsl,imx8m{m,n,p}-anatop),
> retrieves the anatop node solely to get its base address, also
> registering its clocks, which
> I would have expected to be registered by another driver, specifically
> the one for anatop:
> 
> static int imx8mn_clocks_probe(struct platform_device *pdev)
> {
> struct device *dev = &pdev->dev;
> struct device_node *np = dev->of_node;
> void __iomem *base;
> struct imx_pll14xx_ssc pll1443x_ssc;
> int ret;
> 
> clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>                            IMX8MN_CLK_END), GFP_KERNEL);
> if (WARN_ON(!clk_hw_data))
>     return -ENOMEM;
> 
> clk_hw_data->num = IMX8MN_CLK_END;
> hws = clk_hw_data->hws;
> 
> hws[IMX8MN_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
> hws[IMX8MN_CLK_24M] = imx_get_clk_hw_by_name(np, "osc_24m");
> hws[IMX8MN_CLK_32K] = imx_get_clk_hw_by_name(np, "osc_32k");
> hws[IMX8MN_CLK_EXT1] = imx_get_clk_hw_by_name(np, "clk_ext1");
> hws[IMX8MN_CLK_EXT2] = imx_get_clk_hw_by_name(np, "clk_ext2");
> hws[IMX8MN_CLK_EXT3] = imx_get_clk_hw_by_name(np, "clk_ext3");
> hws[IMX8MN_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
> 
> np = of_find_compatible_node(NULL, NULL, "fsl,imx8mn-anatop");
> base = devm_of_iomap(dev, np, 0, NULL);
> of_node_put(np);
> if (WARN_ON(IS_ERR(base))) {
>     ret = PTR_ERR(base);
>     goto unregister_hws;
> }
> 
> hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel",
> base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel",
> base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> hws[IMX8MN_VIDEO_PLL_REF_SEL] = imx_clk_hw_mux("video_pll_ref_sel",
> base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));

Sorry, I am not going to dwell into drivers code. We talk here about
bindings and new properties.

Best regards,
Krzysztof


