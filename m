Return-Path: <linux-kernel+bounces-348250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1495D98E4A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96E62841B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851F217321;
	Wed,  2 Oct 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzDVLEy4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BD1D1E60;
	Wed,  2 Oct 2024 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903492; cv=none; b=KqyTeFbwfF5ifETsgqV9Bb37rFb7AmvPf082WWLgufN+73v1Zv/EBffF85cxQsWW1TUoVigC9Mw4J39Kpz53oi++ICYJl9qBgEeoixMmoDQ54zNuBLF61Cj1+SMxYr+kXnVeY774HoysFFYSfTAjcx949wodF1jDYAcAKaK4KZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903492; c=relaxed/simple;
	bh=9IhvjBCGhybrdL+0lMh6vB5lwKL1Q0u0iBdV/bSLfXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tagHRoiCNXxGuLv/WFkdiJOxk6svor8PWC5me54+PQ6/1a6L3sNzaPNAyDYN51u6xh2X6R26ggzqPbHsvAVydP5tDo32ZRbV+5LEtkNexhlk4dz2C5axfQue7fVCZucDrJ80UnRUspVimsK6cze7a44Y1PY6Qmvgzzd+/jTEi4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzDVLEy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E375C4CEC2;
	Wed,  2 Oct 2024 21:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727903491;
	bh=9IhvjBCGhybrdL+0lMh6vB5lwKL1Q0u0iBdV/bSLfXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NzDVLEy4xyfdfWBIKV/04deLmhQH7hFjnc0QcuZb+uGrZgaGvXLQbUG1QyWv9HRBT
	 i8Ou6R+DsIjO5LLY7QVERCnU9H0bX3rPTfX0MkSoeuADRrVh9yLl2jNHwX41oxypjK
	 fEPns5S1E5y9Q+BA3TdvSmu81V9dfh55MPNd+tg7DuB0XrkbHTEKINryAMe8ZhLcnq
	 w2GxgwptJW3lEj4vwwdwzHxgfC83TWpL2Gdo/mYmPyhl3PlG+rfaIyM1s/OQr0xCNv
	 Hc5r+Fvcmh9l5+kKISesh29htAXYBeaVA9yDhrIfr2x9/5cEQmfSEClMCy/OD7Mlkw
	 0d9OK2g3aRkvw==
Date: Wed, 2 Oct 2024 16:11:30 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/6] dt-bindings: nvmem: mediatek: efuse: Reuse
 mt8186-efuse in mt8188
Message-ID: <20241002211130.GA1316112-robh@kernel.org>
References: <20241002022138.29241-1-pablo.sun@mediatek.com>
 <20241002022138.29241-4-pablo.sun@mediatek.com>
 <mh7upw2y2dclyosved3chw7chpqgdg4a3j5ftwftfhm6v5uqpt@cotoeuopfbqg>
 <559fc2a5-631c-440a-812f-2907f84b16b4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559fc2a5-631c-440a-812f-2907f84b16b4@collabora.com>

On Wed, Oct 02, 2024 at 09:42:32AM +0200, AngeloGioacchino Del Regno wrote:
> Il 02/10/24 08:11, Krzysztof Kozlowski ha scritto:
> > On Wed, Oct 02, 2024 at 10:21:35AM +0800, Pablo Sun wrote:
> > > mt8188 has the same GPU speed binning efuse field just
> > > like mt8186, which requires post-processing to convert to the
> > > bit field format specified by OPP table.

What about all the other efuses? The fallback needs to be a subset of 
the 1st compatible.

> > > 
> > > Add the binding for the compatible list:
> > >    "mediatek,mt8188-efuse", "mediatek,mt8186-efuse"
> > > so mt8188 uses the same conversion.
> > > 
> > > Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> > > ---
> > >   Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > > index 32b8c1eb4e80..70815a3329bf 100644
> > > --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > > +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > > @@ -39,6 +39,10 @@ properties:
> > >                 - mediatek,mt8195-efuse
> > >                 - mediatek,mt8516-efuse
> > >             - const: mediatek,efuse
> > > +      - items:
> > > +          - enum:
> > > +              - mediatek,mt8188-efuse
> > > +          - const: mediatek,mt8186-efuse
> > 
> > And this is not compatible with generic one? This is confusing. Why are
> > you adding generic fallbacks if they are not valid?
> > 
> 
> It was my suggestion to start dropping the usage of the generic "mediatek,efuse"
> fallback, as I've seen multiple times feedback saying to not use generic fallbacks.
> 
> Was that wrong?

No, but any fallback seems seems a bit odd here. It's one of those 
things that's going to change with every chip.

Rob

