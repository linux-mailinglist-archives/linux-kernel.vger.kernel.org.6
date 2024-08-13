Return-Path: <linux-kernel+bounces-285103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB995095D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9071C2180D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB231A0724;
	Tue, 13 Aug 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxl558Ed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD549654;
	Tue, 13 Aug 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563978; cv=none; b=OD8fRSJV4x5rYFqAj9tyNHG2Uy0DWe/dpNc23xK+0lPFIWnjHaryGFbPYUlVVTwkpAOHElAyK5DBjqp/upKDFI87ocogqRU540oVuc450FG1dcv5KZdl4DYIBGuWTvn9t6+T1UHRBW3gBfWubnxDegIIebLvWoeMmHgHON89v0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563978; c=relaxed/simple;
	bh=FvDI4nlATbEYWH0NbvBp6D3TEzj2s0THCNv0wUb9Nio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETMRH6mfab7/71YJio55ar2yrNuSvJvsrx/k98oG4lPsetvb9fHkhi7HWh71beh3Tn7JJX2/DytlHGlfbXk8Cnk/KfxB1SNMKem20UAFhYCaEur+CPJ3BwUkP0/iazQpeGyZbLytnoGE37ZWZaDSpqJjXJfEMraTm073efnU7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxl558Ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C02C4AF09;
	Tue, 13 Aug 2024 15:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723563977;
	bh=FvDI4nlATbEYWH0NbvBp6D3TEzj2s0THCNv0wUb9Nio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxl558EdqqOlZgrgDdD7dFRsuTIs49yoF8wlBy7H8k1X3YmBciUxBFZIkGDWLt+H7
	 geRHZohMuF69M9rlD520230TJnguWjRV7zmxiRVOkkUXUVwcbwqlUH14k4kDELN7pA
	 K6aRPCxP4YwrmH+VhR1I5XNDFjXoqOkmmctDhj/4hN+lEY/p0Cdaavoh3zZ2g+FsmI
	 hSnQFNt3yhvKCfh+AGHInbgw30H5wD1CTSoOIJzhfph/Jvb0MQtdMlwCLIouo3W0rI
	 pPncL0GrdCQQKUKZ//jkt1vFFmsBBWj/re7N+HJ57xawlMCKVPn135WN2YxQvdhdmH
	 8NnkkJUCuxkvQ==
Date: Tue, 13 Aug 2024 09:46:15 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
Message-ID: <172356397447.1008665.7000351139259690854.robh@kernel.org>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
 <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>


On Thu, 08 Aug 2024 13:44:24 +0930, Andrew Jeffery wrote:
> Squash warnings such as:
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/interrupt-controller@1e6c0080: failed to match any schema with compatible: ['aspeed,ast2400-vic']
> 
> The YAML DT schema defines an optional property, valid-sources, which
> was not previously described in the prose binding. It is added to
> document existing practice in the Aspeed devicetrees. Unfortunately
> the property seems to predate the requirement that vendor-specific
> properties be prefixed.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../interrupt-controller/aspeed,ast2400-vic.txt    | 23 --------
>  .../interrupt-controller/aspeed,ast2400-vic.yaml   | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 23 deletions(-)
> 

Applied, thanks!


