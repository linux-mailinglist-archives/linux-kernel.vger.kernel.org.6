Return-Path: <linux-kernel+bounces-216528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E932790A09D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0FE1F21B46
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63F873445;
	Sun, 16 Jun 2024 22:53:34 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB14D13F;
	Sun, 16 Jun 2024 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718578414; cv=none; b=TCmSB++4tKdXbtlGdGYzVR5V99V/FWwV7T96nBYouQoExdUTnmuUEGbfmAhW5yqPzx41m7n/oxDfQi7D080KjXgwvzdLccixNMMuR1MQW84Xcy+NLSUUCmymGi5HewDY5cZL1WXpI1TtkENBS7NzWhXuKVP18288nhU58XZZn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718578414; c=relaxed/simple;
	bh=EHAngz4Pb351ADPg/GJDmja1Ezjv0UDBmrqAOfjKEfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeZARYFGFOktmz6Y9hYYBSmuv5zjlKr+zVyVox40jAPCtEcPtKq1gxwpzSIBrVlh4Q3/Sps7Y+xyYr3z9az6I3Efe+Cinue6BOErkd6XnCyfIS99NSdyCxTw/YvEaz3o3oib+8sSU8nAnlhVF5TBeESFF1GCc16/AZrzkUuJmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sun, 16 Jun 2024 22:53:14 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240616225314.GA3988639@ofsar>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>

On 01:20 Mon 17 Jun     , Yangyu Chen wrote:
> Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> 
.. snip
> +		uart0: serial@d4017000 {
> +			compatible = "intel,xscale-uart";
are you sure the uart IP is fully compatible with xscale?
otherwise I'd suggest to introduce a vendor specific one..

> +			reg = <0x0 0xd4017000 0x0 0x100>;
> +			interrupts = <42>;
> +			clock-frequency = <14000000>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +	};
> +};
it's better to also add other uart nodes, I feel it's more complete

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

