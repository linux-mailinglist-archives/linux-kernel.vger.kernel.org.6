Return-Path: <linux-kernel+bounces-576606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A6A711BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB44175BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289619FA93;
	Wed, 26 Mar 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atJQTBWa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF99142E67;
	Wed, 26 Mar 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975793; cv=none; b=rpOHoVK3M/rioGx5NHzcWqG+PZ4gF4MIVgHQusz5qDVi2O6klSPKypNTWdWnzsK0Xdp1vv8LvJQAzzwwb8Fop5REKwiVHVXeL+Fhu1lRuLqx7xdMpxo3ziloSx6eGjZbii/lNDQ6Q/dujcYQWJhn75BfHzCKvphcc09jB3AIHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975793; c=relaxed/simple;
	bh=93M97Q5kVlONcYkIQD1oTLgBJrmsEdqoHZ4roV1qLOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUBnhjfnst/NDV1GK5NbeRAAEIlKMckqv0FjEpJ8qZGs6KHfAGiMaZMp6B1hIOXgRduAqIdSPxgLUsp5K6q/7JpJRC62o+2d2Qi7vT2BV3EMLgaZnin7nH+qzO6WvdLATeiY+1hY7GiQQbEmV5scQ2Jfv3jLDJaifok0SVxoVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atJQTBWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90007C4CEE2;
	Wed, 26 Mar 2025 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742975792;
	bh=93M97Q5kVlONcYkIQD1oTLgBJrmsEdqoHZ4roV1qLOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atJQTBWaSaSbmkMwadDwCo4Hfkoqb5TImfMBBTK35qPENk6X8U/WCXyE/HKpiXmwG
	 o7g/Tfy6tsesiE5L2JKbHnB8Tw9tXZoFn9sLsPtgekTVx559DoTXQCVAFc6a35lLrp
	 4JfBdjXxmFSm0DiPAa+8woSlls3S6SutNrTv/GAQ+ngqtklHo9Via3liBfIehZyyNo
	 O0BXr1H29a26C9U9Cluz6PXekohLGCrRauJ37s92HgoeGwfhJC29yf50IxBuA6OEvE
	 pLB02aG1Eh7Uo5H2P4e2R8h+llNlXwi6+QuFINzBcY7pjB6k94B09v0DSqKdMX2y1g
	 0LLbw4peq9NKw==
Date: Wed, 26 Mar 2025 08:56:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Crystal Guo <crystal.guo@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v3,1/2] dt-bindings: memory-controllers: Add MediaTek DRAM
 controller interface
Message-ID: <20250326-courageous-cobra-of-promise-2c839e@krzk-bin>
References: <20250326063041.7126-1-crystal.guo@mediatek.com>
 <20250326063041.7126-2-crystal.guo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326063041.7126-2-crystal.guo@mediatek.com>

On Wed, Mar 26, 2025 at 02:30:31PM +0800, Crystal Guo wrote:
> A MediaTek DRAM controller interface to provide the current DDR
> data rate.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  .../memory-controllers/mediatek,dramc.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml

Where is the rest of the patchset in DT patchwork? Where is any
changelog? Cover letter? What changed here?

I receive dozen or hundreds of emails, so if you want to make
it difficult for me to review, I will just ignore the patch.

I mark it as changes requested.

Best regards,
Krzysztof


