Return-Path: <linux-kernel+bounces-217601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848DA90B1FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6471F25CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE21B29B6;
	Mon, 17 Jun 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlAH4DUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3219068F;
	Mon, 17 Jun 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631924; cv=none; b=HS7kDSg9NTB+B1XKEd546zR1PyM7pLl2TbJxTJhg8OAsOxF6VYgjNm34qPa1PpmbSL7UGT321FeZwDWcFJdBDToIMO9Lxj69dCp9Q2EqCs3gWmDOmQzi98tpyM5AaO3IZRDconnxt7tugxi2oq+wBGFDZGGOCCyBttU73/tK91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631924; c=relaxed/simple;
	bh=4iVfyEz9rC5f5VhbEizq/D4gDbwzw56EP8r/d+CALXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7WRTBVZC0TqobbgJ66q4iJVtXXBaJGWm7eq4uPM27llHWcOaZi+hepOATkr2zdtVOgFRvTW8Q0dI3XZiTR+na9Bo+aWjZrwSzRPDkOnXz8pvjn2b1DNJSF6WjulzcCPVVdz/1FrPmanE/G4u6MlYkjw6LgIDgkbxtaDCOL9OOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlAH4DUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64783C2BD10;
	Mon, 17 Jun 2024 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718631923;
	bh=4iVfyEz9rC5f5VhbEizq/D4gDbwzw56EP8r/d+CALXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlAH4DUkW1fOUYBYa90CiYLEhyPwhHj7gWkqqw8iS7jJJmVEDYBMUZtl2LDO6+4kR
	 NAQlfwuYGf5OH8S/RabV+UY1lvNd615atdQLwJiLtMMCHHznPNIagjH+6JIFvMLWcn
	 fOKmrJom+rr3vJXeB/BrG5ErfCQY2Vu4i8OaIjMQJ1CcNRgvq0LEqMjg6sxAQCrWFW
	 WL9WIyL3mMg4hkLHD3m5npeG2PBCO+NefrJQm8umO8P0brhsQ+JQS60HZO0I6IvndQ
	 9xqtwnS38uxG0R9MfwbU84d93oWeNZH9zFSM2MizMZMdCzGQjGLGWKifHdsL0ZAouw
	 Fu1/kjOZ6/SAw==
Date: Mon, 17 Jun 2024 21:31:17 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] riscv: dts: add initial SpacemiT K1 SoC device
 tree
Message-ID: <ZnA6pZLkI2StP8Hh@xhacker>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>
 <ZnAw9QrSD-svYqQ5@xhacker>
 <20240617-carat-poise-ee63ed6a224e@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617-carat-poise-ee63ed6a224e@wendy>

On Mon, Jun 17, 2024 at 02:29:46PM +0100, Conor Dooley wrote:
> On Mon, Jun 17, 2024 at 08:49:57PM +0800, Jisheng Zhang wrote:
> > On Mon, Jun 17, 2024 at 01:20:52AM +0800, Yangyu Chen wrote:
> > > Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
> > > 
> > > Key features:
> > > - 4 cores per cluster, 2 clusters on chip
> > > - UART IP is Intel XScale UART
> > > 
> > > Some key considerations:
> > > - ISA string is inferred from vendor documentation[2]
> > > - Cluster topology is inferred from datasheet[1] and L2 in vendor dts[3]
> > > - No coherent DMA on this board
> > >     Inferred by taking vendor ethernet and MMC drivers to the mainline
> > >     kernel. Without dma-noncoherent in soc node, the driver fails.
> > > - No cache nodes now
> > >     The parameters from vendor dts are likely to be wrong. It has 512
> > >     sets for a 32KiB L1 Cache. In this case, each set is 64B in size.
> > >     When the size of the cache line is 64B, it is a directly mapped
> > >     cache rather than a set-associative cache, the latter is commonly
> > >     used. Thus, I didn't use the parameters from vendor dts.
> > > 
> > > Currently only support booting into console with only uart, other
> > > features will be added soon later.
> > 
> > Hi Yangyu,
> > 
> > Per recent practice of cv1800b and th1520 upstream, I think a complete
> > initial support would include pinctrl, clk and reset, I have received
> > the complains from the community. So can you please bring the pinctrl
> > clk  and reset at the same time?
> 
> What sort of complaints have you got? That the support is too minimal to
> be useful?

For example https://lore.kernel.org/linux-riscv/95c20c6c-66cd-4f87-920b-5da766317e19@sifive.com/

Now, I think it's better to "model the clocks/resets/other dependencies"
in the initial support. So lacking of pinctrl, clk and reset doesn't
fully describe the hardware.

