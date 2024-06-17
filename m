Return-Path: <linux-kernel+bounces-216712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CA90A399
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE60E282080
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DF51836C7;
	Mon, 17 Jun 2024 06:03:07 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843391862;
	Mon, 17 Jun 2024 06:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604186; cv=none; b=EqVZJBbnXjsx2bqsr/NrdlO0v1luNLWLk/a8BjWeLh7PtRbzCjR5c0xMS7M8PyaHhE25RzfSQcXsU0hRDNpeO894BAjUXTS+LGqzZzC+kwXMC5OKjzlkTHHmjLKlqTAIRCchO/lX099oZz3ubUpqsxqbwsOklXxYWVrLWRi4GXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604186; c=relaxed/simple;
	bh=2rHzh3kycopZORQBSrH6E0q8rKCoDv6HyCNx6PBtZ5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNF2MmX+LSFXMOD4VgDdEOGeeICqzqPyl2VdTmj3cHvl0DXi/vLDtkipXB9xuE6OkMMJlCc/lY8OhWqtQItkkeNjR6VcDDuZmS0B9m0Ed+oB9OMS7rpGdI6D4mBRahjax7IgA6G+WzUq87oAGfVxt+i0XEFgsxiT58IqDl7riLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Mon, 17 Jun 2024 06:02:50 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 7/9] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <20240617060250.GA4068816@ofsar>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>
 <20240616225314.GA3988639@ofsar>
 <tencent_6863DCC298D59097467C3E0641106D0D4707@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6863DCC298D59097467C3E0641106D0D4707@qq.com>

Hi Yangyu

On 10:10 Mon 17 Jun     , Yangyu Chen wrote:
> 
> 
> > On Jun 17, 2024, at 06:53, Yixun Lan <dlan@gentoo.org> wrote:
> > 
> > On 01:20 Mon 17 Jun     , Yangyu Chen wrote:
> >> Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> >> 
> > .. snip
> >> + uart0: serial@d4017000 {
> >> + compatible = "intel,xscale-uart";
> > are you sure the uart IP is fully compatible with xscale?
> > otherwise I'd suggest to introduce a vendor specific one..
> > 
> 
> Sounds like a good idea. I will add it soon.
> 
> >> + reg = <0x0 0xd4017000 0x0 0x100>;
> >> + interrupts = <42>;
> >> + clock-frequency = <14000000>;
> >> + reg-shift = <2>;
> >> + reg-io-width = <4>;
> >> + status = "disabled";
> >> + };
> >> + };
> >> +};
> > it's better to also add other uart nodes, I feel it's more complete
> > 
> 
> I should test it before adding them. However, if I remember correctly,
> there is only one UART on BPI-F3.
I'm not talking about BPI-F3 specifically, but from the SoC perspective
you can check vendor's dts file of k1-x.dtsi, there are uart0-uart9(uart1 is
missing)..

> 
> > -- 
> > Yixun Lan (dlan)
> > Gentoo Linux Developer
> > GPG Key ID AABEFD55

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

