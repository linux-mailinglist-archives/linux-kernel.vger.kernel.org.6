Return-Path: <linux-kernel+bounces-201997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AC8FC65A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A6B1F25C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59F194A4A;
	Wed,  5 Jun 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHcFCifN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA618C324;
	Wed,  5 Jun 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575888; cv=none; b=B8ApwWWLr3PGpeR0bBcdkJIe3AXKYfPj8dzlpdZt7v6azcCcMgzfktc0CTZeEIBhe/4e6ULl/2cf/lzt+7hM2WuOLSX91g0sW36GujIQ9NuzZrcwC8SSHHr+g6Lb7/zETs3J4HhqZ50wsrCCmDixMaq+IIHa+7kRKeSDTroH1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575888; c=relaxed/simple;
	bh=nvygrpCQm6tIoTRBf/JypeEyOilo9fzXmix4PvWBWvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcHF7txWRp7l64r8JECEiX22cYYoT9HJzs996KA5l041FUCHRcAhQBRXJyFNUK4b3TVUwid9j4++RsKZQXZnIZHIeYbDqp9tazxo3PhU+0MM11e/thBZdnVX31DJgeER3F2edpZGNutc+K+eWugPs5TgFgd2PBSLiD2G3vt4Htw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHcFCifN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9082AC32781;
	Wed,  5 Jun 2024 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717575888;
	bh=nvygrpCQm6tIoTRBf/JypeEyOilo9fzXmix4PvWBWvU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sHcFCifNacAkgFK4H9YarCqWvVnI81N2jpCElBnUa8fCtorGwezkBUu8ZoEQl94Rl
	 qIHDx011cPu+PsKh3AD7RBr/Mh9AR8rKV7qEOEFmlreWg7AVjgq1Gynue2megD3uCF
	 AjtCdkRZF05gv5DWqSfGpHUoL0ys/LYzn8Uk1v26thnKXExOEIU8ht7hX4EZ3AIyxK
	 4BSr7XfMXBhcmZ4GVFuWs9fquRzk1CwsdXQxxymA0mrs9+XZDHwBdipg51nS1f9KfJ
	 ogM1Ov5CTljgWaAt20Uxf09LPfjLVMyJXlkp+GMwHBEm39PnSVulrtHx1KNXug8vDe
	 4xoKdbhAQ/kHg==
Message-ID: <6bbcf768-ecaf-4120-9a98-85528a142008@kernel.org>
Date: Wed, 5 Jun 2024 10:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] dt-bindings: clock: Add i.MX91 clock definition
To: Pengfei Li <pengfei.li_1@nxp.com>, Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, abelvesa@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
 frank.li@nxp.com, tharvey@gateworks.com, alexander.stein@ew.tq-group.com,
 gregor.herburger@ew.tq-group.com, hiago.franco@toradex.com,
 joao.goncalves@toradex.com, hvilleneuve@dimonoff.com,
 Markus.Niebel@ew.tq-group.com, m.felsch@pengutronix.de,
 m.othacehe@gmail.com, bhelgaas@google.com, leoyang.li@nxp.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
 <20240530022634.2062084-3-pengfei.li_1@nxp.com>
 <20240604150447.GA604729-robh@kernel.org>
 <ZmEBn2E1FPKiXnMc@pengfei-OptiPlex-Tower-Plus-7010>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZmEBn2E1FPKiXnMc@pengfei-OptiPlex-Tower-Plus-7010>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 02:23, Pengfei Li wrote:
> On Tue, Jun 04, 2024 at 10:04:47AM -0500, Rob Herring wrote:
>> On Wed, May 29, 2024 at 07:26:31PM -0700, Pengfei Li wrote:
>>> i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
>>> Add i.MX91 related clock definition.
>>>
>>> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
>>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  include/dt-bindings/clock/imx93-clock.h | 7 ++++++-
>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
>>> index 787c9e74dc96..ca0785f35a46 100644
>>> --- a/include/dt-bindings/clock/imx93-clock.h
>>> +++ b/include/dt-bindings/clock/imx93-clock.h
>>> @@ -204,6 +204,11 @@
>>>  #define IMX93_CLK_A55_SEL		199
>>>  #define IMX93_CLK_A55_CORE		200
>>>  #define IMX93_CLK_PDM_IPG		201
>>> -#define IMX93_CLK_END			202
>>> +#define IMX91_CLK_ENET1_QOS_TSN     202
>>> +#define IMX91_CLK_ENET_TIMER        203
>>> +#define IMX91_CLK_ENET2_REGULAR     204
>>> +#define IMX91_CLK_ENET2_REGULAR_GATE		205
>>> +#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
>>> +#define IMX93_CLK_END			207
>>
>> Drop the END define. If it can change, it's not part of the ABI.
>>
>> Rob
>>
> 
> Hi Rob Herring,
> 
> The 'IMX93_CLK_END' macro definition is indeed not a certain clock, but it is
> used in the imx93 ccm driver to indicate the number of clocks. And this macro
> already existed before this patch, so it may not be able to be deleted.

May be. Trust me. Fix your driver first.


Best regards,
Krzysztof


