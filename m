Return-Path: <linux-kernel+bounces-330136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53757979A31
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0723E1F22989
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF471BC23;
	Mon, 16 Sep 2024 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ANE0cFEL"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE417C69;
	Mon, 16 Sep 2024 03:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726458874; cv=none; b=gAciECZZwCqK4gQPdGxSKDmCgEXFkcRSHcF3o1T8JZuCmPesqsvsBlgKqDBsaG40TSYORDTy2a+pMCQH3cSGI90Whsy2ydHjyeFMEaps+zd8PQoru7W9PIFixVf3NBPgfCq1OPg1eRYvv5cvMyULWaERI9Bl/eoTzm1FiHREbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726458874; c=relaxed/simple;
	bh=u28P3hIdJKqVl8cP6nOS+CGxPaCEJWR5gWPifvhOTnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFl61jQD4zv4BFOXMtjajTE1V7P/2bIwWOCDDsmD5xfs2BzvnAJpnsw1YVj2UquyRGOf6Ax0SQ3e6rNWxE0zRjWEV9lZ/wlOtnQlkvOokOzx8vWC3ZYLTEVqbBa78GDdoI6m+AYhsT7j26hYAuTBvKNzuURRyB3v8y9LIteYUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ANE0cFEL; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=JBXp6u4xA7OQQ+LtZ1LNgRXSs/t4TjIGfnYriPctbLI=;
	b=ANE0cFELTvjQr4PZ9JGI/YHORRAM8s5AqxYGGIrO4WHoKviL5ZkK6wLUE7sQ0m
	NcXBqHSIREN3MOUgN6R7BamD3FI2ni/qKAUziil1bxAt4w+8I+4t8B9fSPgQE+HJ
	b4ZZiaTTeabkD1oyYG1wqcQn7g7iBLRMIq19qF9sQAxMk=
Received: from [10.79.243.159] (unknown [113.57.237.78])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wCXKBUhq+dmIxD2HQ--.24077S2;
	Mon, 16 Sep 2024 11:51:00 +0800 (CST)
Message-ID: <3013dff5-e700-49b8-8531-f4369b3fa9e6@163.com>
Date: Mon, 16 Sep 2024 11:50:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/3] Add initial support for Canaan Kendryte K230 pinctrl
To: Conor Dooley <conor@kernel.org>
Cc: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, cyy@cyyself.name, jesse@rivosinc.com,
 jszhang@kernel.org, inochiama@outlook.com, zhangmeng.kevin@spacemit.com,
 kevin.z.m@hotmail.com, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ZubtZKlxqejnCFx_@jean.localdomain>
 <320c1fd8-2f8d-414d-a6a5-23280955b9b8@163.com>
 <20240915-flinch-harness-e9e1b92f5c79@spud>
Content-Language: en-US
From: Ze Huang <18771902331@163.com>
In-Reply-To: <20240915-flinch-harness-e9e1b92f5c79@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCXKBUhq+dmIxD2HQ--.24077S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry8tFy7AF15ArWxAw43KFg_yoW5Zw1kpa
	yfCFs0kF13Jr4xt3ySvws09ryav3Z7Ar1agw1agryUJFnIvFy7Xw4fKr429FZ8Wr4UWr4j
	vrs5X34xur43Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAEfOUUUUU=
X-CM-SenderInfo: zpryllqrzqjjitr6il2tof0z/1tbiNwlcomXAnRd2pQAAs8


On 9/16/24 3:35 AM, Conor Dooley wrote:
> On Sun, Sep 15, 2024 at 11:22:16PM +0800, Ze Huang wrote:
>> On 9/15/24 10:21 PM, Ze Huang wrote:
>>> This patch series introduces support for the pinctrl driver of the Canaan
>>> K230 SoC. The K230 SoC features 64 IO pins, each of which can be configured
>>> for up to five different functions.
>>> 							
>>> The controller manages the entire pin configuration and multiplexing
>>> through a single register, which control features such as schmitt trigger,
>>> drive strength, bias pull-up/down, input/output enable, power source, and
>>> mux mode.
>>>
>>> The changes have been tested on the K230 development board.
>>> 							
>>> The pin function definition can be found here [1], and most of the DTS data
>>> was converted from the vendor's code [2].
>>>
>>> Link: https://developer.canaan-creative.com/k230/dev/_downloads/a53655a81951bc8a440ae647be286e75/K230_PINOUT_V1.1_20230321.xlsx [1]
>>> Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/uboot/arch/riscv/dts/k230_canmv.dts [2]
>>>
>>> Ze Huang (3):
>>>     dt-bindings: pinctrl: Add support for canaan,k230 SoC
>>>     pinctrl: canaan: Add support for k230 SoC
>>>     riscv: dts: canaan: Add k230's pinctrl node
>>>
>>>    .../bindings/pinctrl/canaan,k230-pinctrl.yaml | 128 ++++
>>>    arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi  | 318 +++++++++
>>>    arch/riscv/boot/dts/canaan/k230-pinctrl.h     |  18 +
>>>    arch/riscv/boot/dts/canaan/k230.dtsi          |   2 +
>>>    drivers/pinctrl/Kconfig                       |  10 +
>>>    drivers/pinctrl/Makefile                      |   1 +
>>>    drivers/pinctrl/pinctrl-k230.c                | 674 ++++++++++++++++++
>>>    7 files changed, 1151 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml
>>>    create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
>>>    create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.h
>>>    create mode 100644 drivers/pinctrl/pinctrl-k230.c
>>>
>> lost base commit and prerequisite patch id here:
>>
>> base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
>> prerequisite-patch-id: 740cbeb9fc3f3e3fd30df4914cd31e9eb148a581
>> prerequisite-patch-id: b5cc919a7e8e2f852569d5918944dbe4f21e6912
>> prerequisite-patch-id: 554cb838b7264109437359e88443cc3497ed344c
> I don't have the ability to convert those to something I can understand,
> is
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=k230-basic
> effectively the basis for your series?

Thank you for your understanding; that is indeed the basis for series.

base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
prerequisite-patch-id: 2401703b57448c9ea2c3dc7650b4502491a28944
prerequisite-patch-id: 50ccf1104191cdf22f9077880d3dc781b190a3c8
prerequisite-patch-id: f8b983b301d0c14f1448b9e4c321262a509e061e
prerequisite-patch-id: ced4a01ccd8ddab2fd308d543ddf47bd1641518a
prerequisite-patch-id: c2144cf468c57b856830a61615ba6ba501e8ec58
prerequisite-patch-id: 704efc6e76814e1877748959d7319d558c8386c1

Link: 
https://lore.kernel.org/all/tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com/ 




