Return-Path: <linux-kernel+bounces-191316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A10C8D09C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9D01C2209D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0E915F404;
	Mon, 27 May 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gbZ8nyH6"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3431DDC9;
	Mon, 27 May 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833531; cv=none; b=shoL27b2kY6ARNtfPJFE8lYqXCwyln1capaRbBc8pRXzoVave5dH4wWdEzgeJ9pGBC5qL/D9lNMciqSa3/nxSXsnWNvA2aZs7gqs2D9EiUo+rX88gd5o/Ad6RHWLeYrDlNyDnW89E3rmghb0Rr3mgI9tWJrg3h1kKNoLX4Ge6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833531; c=relaxed/simple;
	bh=vyOPeMDydjG+3mtefSP68GvSsts0LUWn9Mx0JVnwW1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXaqgor8G9VT2gP3hmTVYjX2RpUDN1QcpokSmuMo7X8W/ATTzpPrEbqlbt3yfWp5IH6+MpXcG69u49I05YTRw0nqCynibQSUR/v/KvI9HBit6dwMYyObaDf/BUA7XPXCVhJRmDOmY0TQJN/ePIBQ27yWtNVSCt/0b+fjmwjNu/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gbZ8nyH6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECA69240002;
	Mon, 27 May 2024 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716833526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84tR/MeWeFcIW4v7f6DJplwGROoeC+MxszrPF8W46tc=;
	b=gbZ8nyH6pTNk7Q6vldoWwK/CoNlpxOkcJiJ5DMsp6UH91YzFPiS8OuNKTpWqe/p6bHhPK4
	4vnED5Twr6ceiP2ABdMkobMY4NBihJG/Mw5UuB4UjF4MtY7WLDOnZOsW4650dt/Vl8N+sh
	qOtKyO09LMhFg1JdHEGvrD1O46UjAYEy8JQYFk7etGuTWpE0t5tYC4jOcQYAfmaGU9l/3f
	XnOEeO58kdR0NbsI993o1UnjSywrJWrEuZGBKsOON+Z8D9OcAt6cqy7ek2XxyuhcbE9Qhp
	XPJlTZaY+ie139w7cTNLtfVAnCG/3NRgfKTX3WOE0ytNxge6BFTyzd0CzQ292w==
Message-ID: <1b1d8d54-5440-40f1-9324-8476ebf4678f@bootlin.com>
Date: Mon, 27 May 2024 20:12:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>, Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com



On 5/27/24 12:28 PM, Thomas Bonnefille wrote:
> LicheeRV Nano [1] is an embedded development platform base on the SOPHGO
> SG2002 chip.
> 
> Add only support for UART.
> 
> Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html
> [1]
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>   arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>   .../boot/dts/sophgo/sg2002-lichee-rv-nano.dts      | 25 ++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 57ad82a61ea6..5759b21805dc 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2002-licheerv-nano.dtb
>   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
>...
> +++ b/arch/riscv/boot/dts/sophgo/sg2002-lichee-rv-nano.dts

I'm really sorry, it seems that I made a mistake here with git, the 
device tree should not have an hyphen in its name, I'll send a new 
version soon to correct this.

