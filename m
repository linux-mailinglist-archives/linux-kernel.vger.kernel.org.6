Return-Path: <linux-kernel+bounces-328810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB20D97892C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827261F247D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFB1487E3;
	Fri, 13 Sep 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEPRwGYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5358146D6D;
	Fri, 13 Sep 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726257314; cv=none; b=ZAKhBHzZIQxqwaObXvdmYpTm5jhK9h6oL1DVggH4g2r5yEdawzuOwt7HTVcuDeDA/VHenwDRGtnktWKNZO63+fr2ZQgTo8PsRmkFAj9anRIzjzNFwztFLD6ORSfgMNhfDNM7VDjUeMdDqdPJfhnOhA9aXhJRidSGYx13cv9ROyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726257314; c=relaxed/simple;
	bh=0pptzHNsve6nRG0iI/Yy3BO7ZIXTXQFwTPNQzNE/ojA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/fayvhu/cmyrBYHWYl9BoPkP9eQs5usrbfSvAt7uqaWQIGiX9zM8ZxKEKUg6KX8ge5PK6Y1AolwN9G23Y/NGjzu5dF0qT+EM6UmhxSbwvs3SVoRIUsmCtq4Nee3bATZyYIKH61UKyYRhD8zbiuDBL7F7QroyHYpxFmC8LCnE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEPRwGYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D15C4CEC7;
	Fri, 13 Sep 2024 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726257314;
	bh=0pptzHNsve6nRG0iI/Yy3BO7ZIXTXQFwTPNQzNE/ojA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEPRwGYaY5gURAduPfJhCaTmFvsWW7L7Na1ih+OfH6R+IPEDbgjkYdl4oO0G9doSk
	 hcLzAOXt70vogKidE841p5kxzaXm1oxWyMff1pc6PSl0zHokAsfA5CUgXaJgsWTIaJ
	 anqWwz0R2xXF2gvOtPAuK+QMBljQLYyb3zQx/PDFqVIFWy7F9gJCuCbUmTKIpwiU2r
	 VLf28av+ZuCEPzNPVgNHjsKKtfV82JN+OfdVIOKXj2LNXnMGwY+hSdKYBiPgrhyhMA
	 ARM2StltMHvAr6iP8c0IevXOOxzFuhi7Zho+QKiC1MrPPl/EZHBR/8/sGUl0nbBZNS
	 v4klyfi5kMLqg==
Date: Fri, 13 Sep 2024 14:55:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] dt-bindings: clock: mediatek: Drop duplicate
 mediatek,mt6795-sys-clock.yaml
Message-ID: <172625731189.514249.780064376530933894.robh@kernel.org>
References: <20240910234238.1028422-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910234238.1028422-1-robh@kernel.org>


On Tue, 10 Sep 2024 18:42:37 -0500, Rob Herring (Arm) wrote:
> The compatible strings for mt6795 clocks are also documented in other
> schemas:
> 
> "mediatek,mt6795-apmixedsys" in clock/mediatek,apmixedsys.yaml
> "mediatek,mt6795-topckgen" in clock/mediatek,topckgen.yaml
> "mediatek,mt6795-pericfg" in clock/mediatek,pericfg.yaml
> "mediatek,mt6795-infracfg" in clock/mediatek,infracfg.yaml
> 
> The only difference is #reset-cells is not allowed in some of these,
> but that aligns with actual users in .dts files.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../clock/mediatek,mt6795-sys-clock.yaml      | 54 -------------------
>  1 file changed, 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> 

Applied, thanks!


