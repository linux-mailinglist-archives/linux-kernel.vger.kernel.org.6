Return-Path: <linux-kernel+bounces-276433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A125949392
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4959B1C2157E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7B1D415B;
	Tue,  6 Aug 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax2AMEUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5A18D643;
	Tue,  6 Aug 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955671; cv=none; b=q95ubIJaaU+ADU6mP5YxTtANcT4idG/99XAp59DS4EtFNB28B48lqh9wZU9CW+IskgEN/8C5drrN+yMtcCaMMLHUWnB/qF52Zdoyc1TsEXucKeDc/Gmd3OIVNzAHmkazk9hmsAIUPkWZq0TRLdLKPJ9U63R3S4HlcZQafO4ftQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955671; c=relaxed/simple;
	bh=Oaeg/txyoqvlwJ92CbsvulF5/rCthe6CFBOmFX5NHvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVz5rJOjRbL94Q7HIqqR9kxZI1dkalWWLqZUq4a+cf2l8r4hqwZGowPaIYW/gzoZTbz9+QmX960WhdV0LDrXE5ESFMkwOdW+TNCUzgA507u1UDT6qLJKazXSesdtkJzJx12Iae68ltuYZP3fZUJ0xLe1mZc1iBqqrgUW40ldJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax2AMEUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0335FC32786;
	Tue,  6 Aug 2024 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955671;
	bh=Oaeg/txyoqvlwJ92CbsvulF5/rCthe6CFBOmFX5NHvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ax2AMEUMtikPQYG7XyVX7C15S6lQ1+r7f7249Vx39YxQtDhMr3mAb584FXVjevWIR
	 HtYvnh5/PNjXusDz2b5eOszPo6wb0btgE0e71s4SmdbNEbBTqvRMjXGnnU5G7Fl8o8
	 GMxiiq4ckZVeyrMN4P0zZ+s4PkxvewhQnAnDGO/frn/7aoVRDR0ZyPyPEx1UerrzLT
	 AgoVIg3rtgtbDtlnjZQ0/9b4T9Sp0fV59awelyzALNo+jhaOFTBzdua+3VUf07O5ng
	 /UFcUVPx1QDLJQbaSGWDTCuorMfDg2qzbq+7V9ukLdsIS9qAOfvH9fpiYfla0gSxGf
	 Pd/Ra379yTybw==
Date: Tue, 6 Aug 2024 08:47:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: michal.simek@xilinx.com, Kalyani Akula <kalyani.akula@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	git@xilinx.com, monstr@monstr.eu
Subject: Re: [RESEND PATCH] dt-bindings: nvmem: Use soc-nvmem node name
 instead of nvmem
Message-ID: <172295566828.1499167.7442270315190925029.robh@kernel.org>
References: <5eeb68b920d1ef186c4f623698eaa0557e0fadc7.1722325870.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eeb68b920d1ef186c4f623698eaa0557e0fadc7.1722325870.git.michal.simek@amd.com>


On Tue, 30 Jul 2024 09:51:12 +0200, Michal Simek wrote:
> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
> why also update example to have it described correctly everywhere.
> 
> Fixes: a0cfd5e99782 ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Adding comments from origin version
> https://lore.kernel.org/r/42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com
> 
> Rob:
>  This doesn't seem like an improvement. Is there another nvmem node at
>  this level? I would fix the binding instead if not.
> 
> Michal:
> That name came from discussion with Conor. None suggested to fix dt-schema that's why soc-nvmem has been propagated to DT already and this patch is just fixing last occurrence.
> 
> commit d8764d347bd737efec00fae81133ffad0ae084bb (tag: zynqmp-dt-for-6.9)
> Author:     Michal Simek <michal.simek@amd.com>
> AuthorDate: Wed Jan 31 10:17:28 2024 +0100
> 
>     dt-bindings: firmware: xilinx: Describe soc-nvmem subnode
> 
>     Describe soc-nvmem subnode as the part of firmware node. The name can't be
>     pure nvmem because dt-schema already defines it as array property that's
>     why different name should be used.
> 
>     Acked-by: Conor Dooley <conor.dooley@microchip.com>
>     Link: https://lore.kernel.org/r/24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com
>     Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> ---
>  Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


