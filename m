Return-Path: <linux-kernel+bounces-330140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB9979A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3881283AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3711CF93;
	Mon, 16 Sep 2024 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b9uVfDF0"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AB1CA85;
	Mon, 16 Sep 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726459186; cv=none; b=i3aNkO7G5mNYM99cW61693c5fSKfjzEiMIeRP+UUJwkjSdiC8cpNzudhvJq37TjK5avQz7cmdNW11I90kRH95hEW3CJSuppgB6/kguVkzuV6UlLaDCYL/p6Li15Bjv4ohvt74DYRJgviS4gA6fsRGOHWUAbpuSSwaHGN2J5vOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726459186; c=relaxed/simple;
	bh=Jm9CVHT6Nki6sfPskZNpOtxETbbWb6rDe8kRKEGe3m0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzLTsKVxp0XSWwSh6cQrNOvaXRN7xDzsjMBKti2IKPFUVtYdD6ilWYg5EvHBXWEtPJ16X5pPhfGPWWJqtFqr/C7A/RJuamdQ/9pxc9hA3kpK8KXmnb747RgQfGtP9J08TX+dvTnjNjXto3mcvHm+IrZMS+TpuzDAWyvpFBbS+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b9uVfDF0; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=mj2XNLHRDudyI5E50DFBA5B0CTYLSBZ5eydMr4cy/Jo=;
	b=b9uVfDF0Npalzi0Nsul2KQn6zyiSzgHNpB9pId3AU3ofKAf3Cee/EJBPbZJI3g
	wZOzgC0cuZpgMegl2gPWXUnrHPD7QTF8sV6TTeJX4Q+oLhm79XeOZY1Lsf4fZrcH
	uA/JpozC90+m4m+RkPG8nphIBC5LoM2665qPmLV7HZTaw=
Received: from [10.79.243.159] (unknown [113.57.237.78])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDnb1LMrOdm2ADKBg--.14234S2;
	Mon, 16 Sep 2024 11:58:04 +0800 (CST)
Message-ID: <d0daa272-91ac-4e02-9b07-2d3141c3b7de@163.com>
Date: Mon, 16 Sep 2024 11:58:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/3] Add initial support for Canaan Kendryte K230 pinctrl
To: Inochi Amaoto <inochiama@gmail.com>, linus.walleij@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 conor@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 jesse@rivosinc.com, cyy@cyyself.name, inochiama@outlook.com,
 jszhang@kernel.org, kevin.z.m@hotmail.com
References: <ZubtZKlxqejnCFx_@jean.localdomain>
 <qecfx4gepop65xivvnk2w7waikvadrl2bp4evyehp4kgaegsdp@dmluqpj3xune>
Content-Language: en-US
From: Ze Huang <18771902331@163.com>
In-Reply-To: <qecfx4gepop65xivvnk2w7waikvadrl2bp4evyehp4kgaegsdp@dmluqpj3xune>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnb1LMrOdm2ADKBg--.14234S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW3AF4DXF18tw1DJFWkWFg_yoW8trWxpw
	4fCF9IkF17Gr4fJFWftwn5WFyavan3Jr1jg3Waq347WF43ZFyDGrnxGFW8Xr4DGr47Wr4j
	vr45W348u3W5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRCkskUUUUU=
X-CM-SenderInfo: zpryllqrzqjjitr6il2tof0z/1tbiJw5comXAn1RRvAAAsU


On 9/16/24 6:56 AM, Inochi Amaoto wrote:
> On Sun, Sep 15, 2024 at 10:21:24PM GMT, Ze Huang wrote:
>> This patch series introduces support for the pinctrl driver of the Canaan
>> K230 SoC. The K230 SoC features 64 IO pins, each of which can be configured
>> for up to five different functions.
>> 							
>> The controller manages the entire pin configuration and multiplexing
>> through a single register, which control features such as schmitt trigger,
>> drive strength, bias pull-up/down, input/output enable, power source, and
>> mux mode.
>>
>> The changes have been tested on the K230 development board.
>> 							
>> The pin function definition can be found here [1], and most of the DTS data
>> was converted from the vendor's code [2].
>>
>> Link: https://developer.canaan-creative.com/k230/dev/_downloads/a53655a81951bc8a440ae647be286e75/K230_PINOUT_V1.1_20230321.xlsx [1]
>> Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/uboot/arch/riscv/dts/k230_canmv.dts [2]
>>
>> Ze Huang (3):
>>    dt-bindings: pinctrl: Add support for canaan,k230 SoC
>>    pinctrl: canaan: Add support for k230 SoC
>>    riscv: dts: canaan: Add k230's pinctrl node
>>
>>   .../bindings/pinctrl/canaan,k230-pinctrl.yaml | 128 ++++
>>   arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi  | 318 +++++++++
>>   arch/riscv/boot/dts/canaan/k230-pinctrl.h     |  18 +
>>   arch/riscv/boot/dts/canaan/k230.dtsi          |   2 +
>>   drivers/pinctrl/Kconfig                       |  10 +
>>   drivers/pinctrl/Makefile                      |   1 +
>>   drivers/pinctrl/pinctrl-k230.c                | 674 ++++++++++++++++++
>>   7 files changed, 1151 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml
>>   create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
>>   create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.h
>>   create mode 100644 drivers/pinctrl/pinctrl-k230.c
>>
>> -- 
>> 2.46.1
> You should send your patched as a thread. I think you
> forgot to set (or set wrong) in-reply-to?

Thank you for pointing that out. I apologize for the oversight. I will
resend the patch series as a thread and ensure that the in-reply-to headers
are set correctly.

Thank you for your patience.


