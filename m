Return-Path: <linux-kernel+bounces-329926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C0979783
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2232E1F21AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0791C8FA8;
	Sun, 15 Sep 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ia+ggAoj"
Received: from mail-8160.188.com (mail-8160.188.com [60.191.81.60])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA61C6F72;
	Sun, 15 Sep 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.81.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413838; cv=none; b=ZkDkjZJvOA10nBFClKw2CUTsGZY/LrfrSjQC5YK8rhFFsvf8iDqcggxry8fJ7HedW3cYpPaW9CkctRekTqwPCID1pquXCmHmCRHGlS8wKRjt9WRDSFB9kKk0HCOi4T2S7xeTkjdT/e5lcA+gRUeKXuaskYOAwjhdEvD5XytQikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413838; c=relaxed/simple;
	bh=LOBNMi5ub8Uz+UkVGcS+4t3koS21XSI99zbHn6Y+3CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLlHS0aBRQbh9Jue3QN9TXm+bXN0dbxzLAI0aNfmjHmq7kVQzbvXo+8bPAjL+kteI8I6yqRerCcqUGjVi8342lCrJjtXlqnqa7fzc6ND7Y18PQKsUXOJlOB6JvDavaHPb68FDpau0pkWS/h0+Vb2pEBQ11f0nOKYuiHsJjiW54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ia+ggAoj; arc=none smtp.client-ip=60.191.81.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=jhD688CQbLc0SgiirmxYMH+D8GnL0RP+FKCVpC17j0E=;
	b=ia+ggAojH5GWYwIbVcVPtBoqXAMoGSJTBzlomTvN0jfeaLRm2WZ/77TJyakGvs
	URyNede2eGfnPCOw2cMGxyOMWKCy9hEG4ECDlo7+uldvINmyRmJUhTL3pIU4h0nB
	Zv5doD5ZytrYlWNmY/Kw5rUmceJvTwDiwOZp7m6Sd01Dw=
Received: from [10.79.243.159] (unknown [113.57.237.78])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wAHcFio++ZmTyV3Bg--.6237S2;
	Sun, 15 Sep 2024 23:22:17 +0800 (CST)
Message-ID: <320c1fd8-2f8d-414d-a6a5-23280955b9b8@163.com>
Date: Sun, 15 Sep 2024 23:22:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/3] Add initial support for Canaan Kendryte K230 pinctrl
To: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, conor@kernel.org
Cc: cyy@cyyself.name, jesse@rivosinc.com, jszhang@kernel.org,
 inochiama@outlook.com, uwu@icenowy.me, zhangmeng.kevin@spacemit.com,
 kevin.z.m@hotmail.com, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 dlan@gentoo.org
References: <ZubtZKlxqejnCFx_@jean.localdomain>
Content-Language: en-US
From: Ze Huang <18771902331@163.com>
In-Reply-To: <ZubtZKlxqejnCFx_@jean.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHcFio++ZmTyV3Bg--.6237S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWxCry5Jr48Kw4DJw15CFg_yoW8uFW3pa
	yfCrZxCr13Gr4ftFWSy3WDKry3Aan7Jr4Ygw1aq34UXF43ZFyDuwn3KrW5XrWDWr47Xw4j
	9rZ5t348ur15Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKeHgUUUUU=
X-CM-SenderInfo: zpryllqrzqjjitr6il2tof0z/1tbiNwtbomXAnREu7AAAsu


On 9/15/24 10:21 PM, Ze Huang wrote:
> This patch series introduces support for the pinctrl driver of the Canaan
> K230 SoC. The K230 SoC features 64 IO pins, each of which can be configured
> for up to five different functions.
> 							
> The controller manages the entire pin configuration and multiplexing
> through a single register, which control features such as schmitt trigger,
> drive strength, bias pull-up/down, input/output enable, power source, and
> mux mode.
>
> The changes have been tested on the K230 development board.
> 							
> The pin function definition can be found here [1], and most of the DTS data
> was converted from the vendor's code [2].
>
> Link: https://developer.canaan-creative.com/k230/dev/_downloads/a53655a81951bc8a440ae647be286e75/K230_PINOUT_V1.1_20230321.xlsx [1]
> Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/uboot/arch/riscv/dts/k230_canmv.dts [2]
>
> Ze Huang (3):
>    dt-bindings: pinctrl: Add support for canaan,k230 SoC
>    pinctrl: canaan: Add support for k230 SoC
>    riscv: dts: canaan: Add k230's pinctrl node
>
>   .../bindings/pinctrl/canaan,k230-pinctrl.yaml | 128 ++++
>   arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi  | 318 +++++++++
>   arch/riscv/boot/dts/canaan/k230-pinctrl.h     |  18 +
>   arch/riscv/boot/dts/canaan/k230.dtsi          |   2 +
>   drivers/pinctrl/Kconfig                       |  10 +
>   drivers/pinctrl/Makefile                      |   1 +
>   drivers/pinctrl/pinctrl-k230.c                | 674 ++++++++++++++++++
>   7 files changed, 1151 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml
>   create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
>   create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.h
>   create mode 100644 drivers/pinctrl/pinctrl-k230.c
>

lost base commit and prerequisite patch id here:

base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
prerequisite-patch-id: 740cbeb9fc3f3e3fd30df4914cd31e9eb148a581
prerequisite-patch-id: b5cc919a7e8e2f852569d5918944dbe4f21e6912
prerequisite-patch-id: 554cb838b7264109437359e88443cc3497ed344c


