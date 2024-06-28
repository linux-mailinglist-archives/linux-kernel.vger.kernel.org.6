Return-Path: <linux-kernel+bounces-233427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BD91B6ED
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A2C1F2347B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB15589C;
	Fri, 28 Jun 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G58EjGeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3D053E22;
	Fri, 28 Jun 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555675; cv=none; b=W2BnYHmG5ihV1vLKG+qghgHvTb2OoEnXM5L4R6tO0womr/06HSEorKJlEsvmQtdEsKfZlXsPUwK7ZDBi9HHMdZ6nTT/GhOHZ8H4rQ1LTFWD/N6sFcVvDUbP5TT2EZ8nKzebG81+MzP7+acqKuoFR5sA1C4uqD5TmCvhouZZNaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555675; c=relaxed/simple;
	bh=yBTv5tI3Sw2vpf33F6ktr6RkDe8svdLFayCCcurDMy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQ/f+zGBsmQti0+a7vj/KASJiTu4Q3dL4WtEKWTu2+CijtrV+bTwXQsBE0z1Twm2sksQIZgmvY9eMs/LzXBJvOPaNpJT7ukmie4ywSKMUTi/R6plBAAYXwX1zz2Lk9JQLSMxKnVUDOfhV52mxPlno+AqlTUqrZbAZUbtpX0mAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G58EjGeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E656C116B1;
	Fri, 28 Jun 2024 06:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719555675;
	bh=yBTv5tI3Sw2vpf33F6ktr6RkDe8svdLFayCCcurDMy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G58EjGeCjrdn8DXizeITnU9RyPa05/QjdYaCK1GiuLKUqD5ohnOn8HSvQFFmzA5D6
	 qA/CmX5SJN5v3kOJFMH5EbPvAxOAx5LP7SISO/RKJxxNfwbHl6BtOlsdUmFa9z1/0O
	 wXZJkSYU6MO6/dKroxDHTyLb/xvd9A7kP+YRCszTsevJWgnzzLOJNuFteiCtRS8Qup
	 mhP0HMbvyo5RsPE/EeCt9qpwtq86Z9AOluvvsm3ttWC5Q4q7aYmTf51UxP/73ePpXr
	 wb593U6nOalNTX38NmOPoeRLpNTKzovNVO+LXBF8L//zM+//PWOay0mx/RHPfmbGpv
	 D4nmqERmet7cg==
Message-ID: <79955001-132c-4eef-b741-9e6a35da1361@kernel.org>
Date: Fri, 28 Jun 2024 08:21:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
To: Peng Fan <peng.fan@nxp.com>, Pengfei Li <pengfei.li_1@nxp.com>
Cc: "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "abelvesa@kernel.org" <abelvesa@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
 Aisheng Dong <aisheng.dong@nxp.com>, Frank Li <frank.li@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
 <20240625175147.94985-2-pengfei.li_1@nxp.com>
 <39bcab8b-ed9c-4da9-b1ee-32dbfb2a23a4@kernel.org>
 <ZnqfIudepX4sH4oL@pengfei-OptiPlex-Tower-Plus-7010>
 <61c1eb8b-b8fd-4e9e-b0fc-27ce1c2eb2b1@kernel.org>
 <AM6PR04MB5941061D0DCA71B31F44497488D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <AM6PR04MB5941061D0DCA71B31F44497488D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 03:17, Peng Fan wrote:
>> Subject: Re: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
>>
>> On 25/06/2024 12:43, Pengfei Li wrote:
>>> On Tue, Jun 25, 2024 at 09:44:42AM +0200, Krzysztof Kozlowski
>> wrote:
>>>> On 25/06/2024 19:51, Pengfei Li wrote:
>>>>> IMX93_CLK_END was previously defined in imx93-clock.h to
>> indicate
>>>>> the number of clocks, but it is not part of the ABI, so it should be
>>>>> dropped.
>>>>>
>>>>> Now, the driver gets the number of clks by querying the maximum
>>>>> index in the clk array. Due to the discontinuity in the definition
>>>>> of clk index, with some gaps present, the total count cannot be
>>>>> obtained by summing the array size.
>>>>>
>>>>> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
>>>>> ---
>>>>>  drivers/clk/imx/clk-imx93.c | 25 +++++++++++++++++++++----
>>>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/imx/clk-imx93.c
>>>>> b/drivers/clk/imx/clk-imx93.c index c6a9bc8ecc1f..68c929512e16
>>>>> 100644
>>>>> --- a/drivers/clk/imx/clk-imx93.c
>>>>> +++ b/drivers/clk/imx/clk-imx93.c
>>>>> @@ -257,6 +257,20 @@ static const struct imx93_clk_ccgr
>> {  static
>>>>> struct clk_hw_onecell_data *clk_hw_data;  static struct clk_hw
>>>>> **clks;
>>>>>
>>>>> +static int imx_clks_get_num(void)
>>>>> +{
>>>>> +	u32 val = 0;
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = 0; i < ARRAY_SIZE(root_array); i++)
>>>>> +		val = max_t(u32, val, root_array[i].clk);
>>>>> +
>>>>> +	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++)
>>>>> +		val = max_t(u32, val, ccgr_array[i].clk);
>>>>> +
>>>>> +	return val + 1;
>>>>> +}
>>>>> +
>>>>>  static int imx93_clocks_probe(struct platform_device *pdev)  {
>>>>>  	struct device *dev = &pdev->dev;
>>>>> @@ -264,14 +278,17 @@ static int imx93_clocks_probe(struct
>> platform_device *pdev)
>>>>>  	const struct imx93_clk_root *root;
>>>>>  	const struct imx93_clk_ccgr *ccgr;
>>>>>  	void __iomem *base, *anatop_base;
>>>>> +	int clks_num;
>>>>>  	int i, ret;
>>>>>
>>>>> +	clks_num = imx_clks_get_num();
>>>>> +
>>>>>  	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data,
>> hws,
>>>>> -					  IMX93_CLK_END),
>> GFP_KERNEL);
>>>>> +					  clks_num), GFP_KERNEL);
>>>>>  	if (!clk_hw_data)
>>>>>  		return -ENOMEM;
>>>>>
>>>>> -	clk_hw_data->num = IMX93_CLK_END;
>>>>> +	clk_hw_data->num = clks_num;
>>>>
>>>> Why so complicated code instead of pre-processor define or array
>> size?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>
>>>
>>> Hi Krzysztof,
>>>
>>> Thanks for the comment, here are some of our thoughts.
>>>
>>> Regarding the predefined method, it's easy to forget to update the
>>> macro definition when adding some new clocks to imx93-clock.h in
>> the future.
>>
>> Somehow most developers in most platforms can do it... Anyway, that
>> would be build time detectable so no problem at all.
>>
>>>
>>> Also, we cannot use the array size method in this scenario, as some
>>> unnecessary clocks have been removed in the past, resulting in
>>> discontinuous definitions of clock indexes. This means that the
>>> maximum clock index can be larger than the allocated clk_hw array
>> size. At this point, using the maximum index to access the clk_hw array
>> will result in an out of bounds error.
>>
>> You mix bindings with array entries. That's independent or just clock
>> drivers are broken.
> 
> But there is issue that binding update and clock driver are normally in
> two patches.  So if just use the IMX93_CLK_END in this file,
> it will be easy to break `git bisect`.

There is no issue. Srsly, this would be the only, only one driver having
that issue.

How is this even possible? How adding one new define for pre-processor
would cause driver issues or some sort of bisectability problems?

These are basics of C we talk about now...

Best regards,
Krzysztof


