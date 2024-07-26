Return-Path: <linux-kernel+bounces-263314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DC93D438
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60FF9B23658
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7849176AAE;
	Fri, 26 Jul 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbJq1pUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31DC17BB09;
	Fri, 26 Jul 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000849; cv=none; b=IfdNF3hjEU+JHSmklrg7rTjVgxcB5dKnWS0SeISlGOwNYu1ftU7i5zMke2NpThLWhM2rB8QRjToZ1pmys9W6EsOtlXqCg89Z04Ol+KLU9nfcbl3ai9pI6FSeFwfRYaZ1D+lYj4ChJqxFmGqyTsuFTiwDjlzg2R0oT2OcWVhgi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000849; c=relaxed/simple;
	bh=gwnxVuoN7LswP7v77zQc6e/qC4v2vnpedCk7vhQDPIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJqedqhiMJeZ8MlvhH0835orv1XapKmA+u6IbNoqsu36rzSvWT4KO9MLmmx8jM6fUN8tmIgAgCChJ0jd+aqhQutz6Tk9o5F1feAJ3AfKO5Alw4Z/EtEcwItAw208zNhswG7bN791Do6LKW7/QcTpmvVGxIqOzf64yk9SS1EtvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbJq1pUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59867C32786;
	Fri, 26 Jul 2024 13:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722000848;
	bh=gwnxVuoN7LswP7v77zQc6e/qC4v2vnpedCk7vhQDPIM=;
	h=Date:Subject:To:List-Id:Cc:References:From:In-Reply-To:From;
	b=PbJq1pUetzKP6lj7XNFrYOOTl5lJv8br/1+1uE2CMP2Dj8alrSuV8IrdinHcb3a5h
	 tECFC8hIiT8kDDA1+LpOCFLotvRRYutUJ2QaJKoBY8Lnqm5+7Nga/aQBFXS7n6bpfG
	 ABrv0ztX4nsnr7r50pBScYtkab+tyMaxk96umPr/v1SL4js/+gcgu5HQ56f1xHcAaB
	 nMBE/NNEgqln/udZJJ9yoXM+kFoDEq9GBkJNEHWiMltY0kE2Ac0JLgJ1/24pnQ0hp7
	 ZUX/KEtcx0QENKkfZVeeEHezJ6B6stnDg3BLvMMzxxmHPuP3P+O9MpmsZk5gB5U4Un
	 0Dfswh17+Ej6A==
Message-ID: <241ceb9b-b29f-41fd-8987-2feba2e5e08e@kernel.org>
Date: Fri, 26 Jul 2024 15:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/10] Introduce ASPEED AST27XX BMC SoC
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: soc@kernel.org, m.szyprowski@samsung.com, nfraprado@collabora.com,
 olof@lixom.net, will@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 andrew@codeconstruct.com.au, catalin.marinas@arm.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, u-kumar1@ti.com, arnd@arndb.de, joel@jms.id.au,
 quic_bjorande@quicinc.com, lee@kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, neil.armstrong@linaro.org,
 linux-aspeed@lists.ozlabs.org, dmitry.baryshkov@linaro.org,
 shawnguo@kernel.org, geert+renesas@glider.be,
 "Rob Herring (Arm)" <robh@kernel.org>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
 <172199921352.1507193.4411331020670815695.robh@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <172199921352.1507193.4411331020670815695.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/07/2024 15:09, Rob Herring (Arm) wrote:
> 
> On Fri, 26 Jul 2024 19:03:45 +0800, Kevin Chen wrote:
>> This patchset adds initial support for the ASPEED.
>> AST27XX Board Management controller (BMC) SoC family.
>>
>> AST2700 is ASPEED's 8th-generation server management processor.
>> Featuring a quad-core ARM Cortex A35 64-bit processor and two
>> independent ARM Cortex M4 processors
>>
>> This patchset adds minimal architecture and drivers such as:
>> Clocksource, Clock and Reset
>>
>> This patchset was tested on the ASPEED AST2700 evaluation board.
>>
>> Kevin Chen (10):
>>   dt-binding: mfd: aspeed,ast2x00-scu: Add binding for ASPEED AST2700
>>     SCU
>>   dt-binding: clk: ast2700: Add binding for Aspeed AST27xx Clock
>>   clk: ast2700: add clock controller
>>   dt-bindings: reset: ast2700: Add binding for ASPEED AST2700 Reset
>>   dt-bindings: arm: aspeed: Add maintainer
>>   dt-bindings: arm: aspeed: Add aspeed,ast2700-evb compatible string
>>   arm64: aspeed: Add support for ASPEED AST2700 BMC SoC
>>   arm64: dts: aspeed: Add initial AST27XX device tree
>>   arm64: dts: aspeed: Add initial AST2700 EVB device tree
>>   arm64: defconfig: Add ASPEED AST2700 family support
>>
>>  .../bindings/arm/aspeed/aspeed.yaml           |    6 +
>>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      |    3 +
>>  MAINTAINERS                                   |    3 +
>>  arch/arm64/Kconfig.platforms                  |   14 +
>>  arch/arm64/boot/dts/Makefile                  |    1 +
>>  arch/arm64/boot/dts/aspeed/Makefile           |    4 +
>>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     |  217 +++
>>  arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |   50 +
>>  arch/arm64/configs/defconfig                  |    1 +
>>  drivers/clk/Makefile                          |    1 +
>>  drivers/clk/clk-ast2700.c                     | 1166 +++++++++++++++++
>>  .../dt-bindings/clock/aspeed,ast2700-clk.h    |  180 +++
>>  .../dt-bindings/reset/aspeed,ast2700-reset.h  |  126 ++
>>  13 files changed, 1772 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
>>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>>  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
>>  create mode 100644 drivers/clk/clk-ast2700.c
>>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
>>  create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h
>>
>> --
>> 2.34.1
>>
>>
>>
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> New warnings running 'make CHECK_DTBS=y aspeed/ast2700-evb.dtb' for 20240726110355.2181563-1-kevin_chen@aspeedtech.com:

Kevin,
Just to clarify. Looking at the patches it was quite obvious you did not
test it with dtbs_check. For a new arm64 platform without any legacy,
having 0 warnings is a must.

Consider Documentation/process/maintainer-soc-clean-dts.rst being
implied for this platform.

Best regards,
Krzysztof


