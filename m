Return-Path: <linux-kernel+bounces-354006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED1993626
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF951F22B0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E81DDC36;
	Mon,  7 Oct 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL9+HteB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAF1D958F;
	Mon,  7 Oct 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325566; cv=none; b=RRtGBTPphQF1z2O4QIoCaCl23lZxue9lrffu5unp0NUJAF0vQsiWNkNxmQ2R/7C6UXjiwsOv+Mg9EfuLHy+Azg9IOCjliMuUhiKpIVxNR/xrwzpY4zxnBhFfvVUGuq224cncgRpAoVlH07vxzJy3zdBVYEhPL7PLW7nm+C+75hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325566; c=relaxed/simple;
	bh=YEnynhxrrE/6PuEr8w5deE0PsZc3kVpk08z+7Q9NWGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvQSnf4OhMez400Wb+KvHvYA0H8PntqikwkHyzcO+7HR1gnb0eOeWi/zVWQiclpNf31R6RIhhaY4AQFu+WnraFuKKG7fp0bq8zITqhn6DzrsBmtaBRD1jj6j0VsRDyUUfsFr487CrJ/8sDRn2RGK0SfXEWPOwhb9zjB71x8t4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL9+HteB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F9AC4CEC6;
	Mon,  7 Oct 2024 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728325566;
	bh=YEnynhxrrE/6PuEr8w5deE0PsZc3kVpk08z+7Q9NWGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pL9+HteBPgzPc37Qtd/TLMiHmEDjHO44Fb12d6hYP+gdF6a011Zas93xrSQqBPuo3
	 6qlKxpgfS/4low1VNm//KQzTDIs/sHa793HsRqr1Kqa5NQrLEqxLp0bbx7/pCv71k4
	 wapVho8z8T7C1kHzlS5oB2hxj7M4DhudEU3CcvOlDuZZl42E7OZ+05KZDLjklr3WOi
	 62B6ZxqQm7e46/h7IEmXTrz+ZLsITgAUvmpdkf6zhsiXGmg00nqzXz+Dl+F3SOiIjl
	 PLSW0p9vy+93x0OWN7NrZM+sH6ucOlapvnqjNiPmByE+Xc9iiu4s/EgcYPFs8EpcSM
	 tDTuqmnNCyk9w==
Date: Mon, 7 Oct 2024 13:26:05 -0500
From: Rob Herring <robh@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org,
	marex@denx.de, s.trumtrar@pengutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] ARM: dts: socfpga: add Enclustra Mercury SA1
Message-ID: <20241007182605.GA1915276-robh@kernel.org>
References: <20241007133115.1482619-1-l.rubusch@gmail.com>
 <20241007133115.1482619-5-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007133115.1482619-5-l.rubusch@gmail.com>

On Mon, Oct 07, 2024 at 01:31:11PM +0000, Lothar Rubusch wrote:
> Introduce support for Enclustra's Mercury SA1 SoM based on Intel Cyclone5
> technology as a .dtsi file.
> 
> Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../devicetree/bindings/arm/altera.yaml       |  10 ++

Bindings should be a separate patch.

>  .../socfpga/socfpga_cyclone5_mercury_sa1.dtsi | 143 ++++++++++++++++++
>  2 files changed, 153 insertions(+)
>  create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_mercury_sa1.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
> index 8c7575455..87a22d2a4 100644
> --- a/Documentation/devicetree/bindings/arm/altera.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera.yaml
> @@ -51,6 +51,16 @@ properties:
>            - const: altr,socfpga-cyclone5
>            - const: altr,socfpga
>  
> +      - description: Mercury SA1 boards
> +        items:
> +          - enum:
> +              - enclustra,mercury-sa1-pe1
> +              - enclustra,mercury-sa1-pe3
> +              - enclustra,mercury-sa1-st1
> +          - const: enclustra,mercury-sa1
> +          - const: altr,socfpga-cyclone5
> +          - const: altr,socfpga
> +
>        - description: Stratix 10 boards
>          items:
>            - enum:

