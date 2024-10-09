Return-Path: <linux-kernel+bounces-356832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D222996772
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225421F21B08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E319007D;
	Wed,  9 Oct 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiFVNfKZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5D219004E;
	Wed,  9 Oct 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470274; cv=none; b=EGHu6cKq+pVNc2rLRCJwMQDtk3bvyXa7P9KIz/UfCHQ6eccGMwRUB7GUdDO86vwHqk3zEp4sGSq9zJ155yI0qVm2JN8ilRRIT6H2BneAArB0vbBJ3E+2FGU70QBQ/XeEs6RKTkE9ODCJ8477FyskxS/zv8hxPICAlW9JVlSiiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470274; c=relaxed/simple;
	bh=bIc8VvXZyLnIE4IeFbmtymfSO2Qf0U2SpOHn3wtP1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0HMuFeXHxzl7J+aN5GYA69EfrsjidZC8MNpgcT+Dr/E4eJwKBs8BgduFH7TFYykoj+SKIXI0N8DzATGJE6oGZpS4HWOW2j+Lyr8pPOcgxA0A84bnOjlP/51T6mqvwMzb/N6MTJZ+WB8+0udP2jdNKV7mFZPIKU0/fxexuLgXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiFVNfKZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF789C4CEC5;
	Wed,  9 Oct 2024 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728470273;
	bh=bIc8VvXZyLnIE4IeFbmtymfSO2Qf0U2SpOHn3wtP1D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiFVNfKZVOe38oZcaIn/39E6h79GHIUPjPRd3ro0vuPGJWnV3TKtVk06uao7Owfjs
	 muFhSmU0M4RZaUqEdEadZXw1abGDFuyQ6e6jqk+iZTbILlTpHLw/En9jZJBqWTPDpo
	 oHd4fFqZN442BcUBPebqJ53UFItkRQl7PEwHoVqwOqVu7TRbO1RySikoqjkcWfdV3p
	 paV5lguqLE/I3wujrgST6Hig2Xn35LeUKkk09P2OkpOh2yrJ8KG6nvRVOqmKqOPiyd
	 HkuEcrULwmEQpipt5RdxJYd7Cxkgnr4ZMxglmgqFePdBLmYBIixj6PRF6+73gdD3Qm
	 E/OdUSnT2elKw==
Date: Wed, 9 Oct 2024 11:37:46 +0100
From: Lee Jones <lee@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, eddie.huang@mediatek.com,
	sean.wang@mediatek.com, alexandre.belloni@bootlin.com,
	sen.chu@mediatek.com, macpaul.lin@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v1 1/3] dt-bindings: mfd: mediatek: mt6397: Add
 start-year property to RTC
Message-ID: <20241009103746.GE276481@google.com>
References: <20240923100010.97470-1-angelogioacchino.delregno@collabora.com>
 <20240923100010.97470-2-angelogioacchino.delregno@collabora.com>
 <20241009101549.GB276481@google.com>
 <e0de3810-38b0-40a3-872d-678e9d4f72e5@collabora.com>
 <20241009103307.GD276481@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009103307.GD276481@google.com>

On Wed, 09 Oct 2024, Lee Jones wrote:

> On Wed, 09 Oct 2024, AngeloGioacchino Del Regno wrote:
> 
> > Il 09/10/24 12:15, Lee Jones ha scritto:
> > > On Mon, 23 Sep 2024, AngeloGioacchino Del Regno wrote:
> > > 
> > > > Enable evaluating the start-year property to allow shifting the
> > > > RTC's HW range.
> > > > 
> > > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > ---
> > > >   Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 2 ++
> > > 
> > > No such file.
> > > 
> > 
> > In the cover letter, I wrote:
> > 
> > 
> > For the bindings commit, this series goes on top of the MT6397 schema
> > conversion from Macpaul Lin [1].
> > 
> > This series was tested on a MT8195 Cherry Tomato Chromebook.
> > 
> > [1]: https://lore.kernel.org/all/20240918064955.6518-1-macpaul.lin@mediatek.com/
> > 
> > 
> > So, that's why. :-)
> 
> Nope, try again. :)

I guess you actually mean:

  https://lore.kernel.org/all/20240918064955.6518-2-macpaul.lin@mediatek.com/

It's on my list.  I'll place yours behind it and see how we go.

-- 
Lee Jones [李琼斯]

