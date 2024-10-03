Return-Path: <linux-kernel+bounces-348732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084F98EB23
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5BC1F22EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28B137905;
	Thu,  3 Oct 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAXw7Q5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD512DD95;
	Thu,  3 Oct 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943228; cv=none; b=JJE3ZqWU5RCV6EY5YUKhhMub0s57dLd8sWiQXRgr4/qFFVuXd6n/pR+qKdi9/2Qp/KwCDzfqBGWjlV6dEyFwvSF6QSBNzVqDt0hK/JpX1M/psRJjoH4POZMYSwc5HFbUXKizROwo3F0E+IqKDVO2vgukITq37i2EnR4CVZ3VHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943228; c=relaxed/simple;
	bh=Itl0lNG3SHyzps1B6SjVO8EibEF/9aynPeJRbif+49g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT0T9ebT5TggZk0zAjOko7SN81ZGMesabvDM1d0sC36BSP/cmyVjNjDvUxYj3GaA5ri4Q0SbPqnW4NtKu6WFsF6yhIWpN2b9bVVpSaFFWIrn0XUfc5c+7bIW6gUDeY+ERIgKjYfiY/0aJyBXmVICsDLMP9kUUoKtCQarj8Z09eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAXw7Q5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEADC4CEC7;
	Thu,  3 Oct 2024 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727943227;
	bh=Itl0lNG3SHyzps1B6SjVO8EibEF/9aynPeJRbif+49g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAXw7Q5M0keCOif6SbQ75a0Xvs+MmWKWITYiRBIFE5fEnxvwQSdHwSYDh/7K05bqa
	 +laZ7ZA+sMwFgKh6dLhZM487lJ4IaUpjSYsSH7+CRlhpD6U/5zZFbPHPq4L8XiXeke
	 gQ5OGvEbxEwq4vFRnWvT571Y/G28kzb/l/snDduc4iZyyMWf+A5hV77Mkidg3WfCGy
	 hIZYBrnvKECo8vTEtJMBXeKAoMDBDXxwpB3psujRpiIYJdICVRmWhqpJl2jH3OXrQp
	 2tiHTLWKNpDB7HAxI+HjYBTfXaM6f8I3ppEaih7n0CBG/CGO5oFq2Vdm2gxXQ6b4A0
	 Tf6Lp9DikBGcQ==
Date: Thu, 3 Oct 2024 10:13:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/6] dt-bindings: nvmem: mediatek: efuse: Reuse
 mt8186-efuse in mt8188
Message-ID: <74uvqyd2n6cxzi4z3miqh5ay7xun2qapjuse7bav5thr44rlml@pr44cvxsngfe>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <559fc2a5-631c-440a-812f-2907f84b16b4@collabora.com>

On Wed, Oct 02, 2024 at 09:42:32AM +0200, AngeloGioacchino Del Regno wrote:
> Il 02/10/24 08:11, Krzysztof Kozlowski ha scritto:
> > On Wed, Oct 02, 2024 at 10:21:35AM +0800, Pablo Sun wrote:
> > > mt8188 has the same GPU speed binning efuse field just
> > > like mt8186, which requires post-processing to convert to the
> > > bit field format specified by OPP table.
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

No, just nothing provided the background that such change is
intentional. Please mention in commit msg that the preferred way from
now on is not using the generic fallback.  Maybe even add it to the
binding itself as comment, so people won't grow the enum with fallback.

Best regards,
Krzysztof


