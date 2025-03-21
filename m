Return-Path: <linux-kernel+bounces-571997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AACA6C530
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AFC189ECBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64434230BC1;
	Fri, 21 Mar 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syEkVpux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E82A1C9;
	Fri, 21 Mar 2025 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592673; cv=none; b=WBUMs5rlFdot6sLs2QF2wYSbUgCW8eorRG7wawVx1rbTt8pa17jgbj3sL7jYcmf9mps3FO1zJSr2/P+ix/wj8UQpIwQpLtuSxE9N6Gm7FkjWkc2haDhkTF/UeAfNQS47JZ8TJ61TiesyfUe9hh4yXWdBGx0Y1RIGE77a1kCVKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592673; c=relaxed/simple;
	bh=+f32SRn/DhI5x9BgYlZ2PYxvre6UQhJsBBuq0rXKjAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mieXixSKo92+gPXD9U/a5QC3Lw70zAlI1GuwQW5taS3SZ1W8Au7BNIZsHWeGZLgJbNa/BbCUMCfxabcnOn0NsYW8xK0MhmZcKD+VC+NymJ0wi7Pe9PHoYj/SWqrdthCJ+xnM2S8RsfkYLEthQTDcoD1rRCya6rEKQTrq5Erv3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syEkVpux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B5BC4CEE3;
	Fri, 21 Mar 2025 21:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742592673;
	bh=+f32SRn/DhI5x9BgYlZ2PYxvre6UQhJsBBuq0rXKjAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syEkVpux+zdu6y0+JrMVHXsj0id+RPBgMSJRyjmL+naIk5mt42IQWs6Dd3nAj+928
	 KBLOzfA12Nwm5/7lbqEvDsuKjgqQnN7A49uAgr+JDdLUoPjEfvv6CJxQbq6StoUHVW
	 K/2wSMPZhEffNaZV1hEZAcAXlF4NU8TyD5pMDqJv8qPo+n9UfaFvx5VWijvmQw5+1c
	 Z4pfn3XllVxigqeLX3+gX1KhKAGLUgWf6cPdH6KKopA+lEiFIZDftk7nizKc1yz3S0
	 iwcyhZ6RgELBGZw2Oni5ZMUbxyuGNgCtIY+Z4Bqd2e3LJCusxE3U1urKBu+q0DU5nQ
	 86W4XQIgRjVEA==
Date: Fri, 21 Mar 2025 16:31:12 -0500
From: Rob Herring <robh@kernel.org>
To: Jason Hsu <jasonhell19@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, patrick@stwcx.xyz,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	yang.chen@quantatw.com, jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Message-ID: <20250321213112.GA4137938-robh@kernel.org>
References: <20250321123731.1373596-1-jason-hsu@quantatw.com>
 <20250321123731.1373596-2-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321123731.1373596-2-jason-hsu@quantatw.com>

On Fri, Mar 21, 2025 at 08:37:30PM +0800, Jason Hsu wrote:
> Document the new compatibles used on Meta Ventura.
> Add subject prefix for the patch.
> 
> Signed-off-by: Jason Hsu <jason-hsu@quantatw.com>

The author and Sob don't match. You need to fix your git author to your 
quantatw.com address.

> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 01333ac111fb..a86b411df9a5 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -87,6 +87,7 @@ properties:
>                - facebook,greatlakes-bmc
>                - facebook,harma-bmc
>                - facebook,minerva-cmc
> +              - facebook,ventura-rmc
>                - facebook,yosemite4-bmc
>                - ibm,blueridge-bmc
>                - ibm,everest-bmc
> --
> 2.34.1
> 

