Return-Path: <linux-kernel+bounces-177980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222868C4715
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525E21C20B84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5B3BB30;
	Mon, 13 May 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA8zQk03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0283BBC9;
	Mon, 13 May 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625847; cv=none; b=cqXhn9bzjNfXC1TLHLx8VBicyaXZxDoABgq/tWW21RRtUc3SfXc5rTjlOqC67a9HaZllZ8tCGYGF4TaaAVzDKt3ymYMfeLqQeQxymOAvVRfPM6/E0vKzz6CTomAOwiWlYtpXTV5Nbr3kJd+rmkCEl5ptItEreLpLgXFevBD64oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625847; c=relaxed/simple;
	bh=WcXjsnsTDPkhfmYPfLYLMxFC0JdNHdWOZt2KFyWC9kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH75wlvAhrlkbbF6TSenMg9Zt4i34dfXrd4IYy7WM9LW2L2/p43xb3K93/0z0ocwUJS8rodUbCy2+4neEmZoRyuyurbTgWA0dL2FoHkKYo7CxFRUV3ndpYyPVBuI/YXWxrXr7bPJK2XAmJjmvsC2mcV0O5lMYL/0dEqEpEDvAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA8zQk03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BBDC113CC;
	Mon, 13 May 2024 18:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715625846;
	bh=WcXjsnsTDPkhfmYPfLYLMxFC0JdNHdWOZt2KFyWC9kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YA8zQk031Al6OQfS2Vq+vf/7SorSXU5LMglbd6lzj7zW/7dwN45Hc7NaKzGjeT5wB
	 P4cdgbH9iQjsC+yfepXVqRkcBE8EZjw/aYBek/nDzgI6FlPfXqcpSxMshtVGn4c/ot
	 bK1yLYMzxLfbfoYIJnA3t7gpg7imlEVPHUe29O024Afi4WkrRpnffyilbhIDwQp1lq
	 RJSr6zKPk1JEEUo3lXeyKxIZ6uKi7h+a6PAimWRUhVjcrt1xL8bCoPMmEhwBuYQg18
	 t7uz+APoMQrtBTt2FengjvGp/TQ6gi2c1U3zDfFkVQ6ewmSg/qQagFoaScFJROJB9C
	 OICCOjZhgiUsg==
Date: Mon, 13 May 2024 13:44:04 -0500
From: Rob Herring <robh@kernel.org>
To: matteomartelli3@gmail.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: es8311: dt-bindings: add everest es8311 codec
Message-ID: <20240513184404.GA2805391-robh@kernel.org>
References: <20240510131238.1319333-1-matteomartelli3@gmail.com>
 <20240510131238.1319333-2-matteomartelli3@gmail.com>
 <91fa1c1f-22ea-4f4a-9d87-a919ddf118cd@kernel.org>
 <4072123.0gxhY3eTYf@njaxe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4072123.0gxhY3eTYf@njaxe>

On Mon, May 13, 2024 at 05:38:16PM +0200, matteomartelli3@gmail.com wrote:
> On Monday, 13 May 2024 10.53.57 CEST Krzysztof Kozlowski wrote:
> > On 10/05/2024 15:00, Matteo Martelli wrote:
> > > Add DT bindings documentation for the Everest-semi ES8311 codec.
> > > 
> > > Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
> > > interface and I2C control.
> > > 
> > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > ---
> > >  .../bindings/sound/everest,es8311.yaml        | 52 +++++++++++++++++++
> > >  1 file changed, 52 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/everest,es8311.yaml b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > > new file mode 100644
> > > index 000000000000..54fb58b9ab58
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/everest,es8311.yaml
> > > @@ -0,0 +1,52 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/sound/everest,es8311.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Everest ES8311 audio CODEC
> > 
> > This looks exactly like es8316, except of later added port. Are you sure
> > you are not planning to add port later, which would make both schemas
> > identical?
> 
> I did not pay enough attention to audio-graph-port property which is in
> fact supported and could be added as well. Thus the es8311.yaml would be
> identical to es8316.yaml. My guess is that I should just add the
> "everest,es8311" compatible string to the existing es8316.yaml even if the
> two drivers are separate (like for instance mediatek,mt8186-clock.yaml). Is
> this correct?

Yes.

> If that's the case:
> * should the evereset,es8316.yaml file be renamed to evereset,es831x.yaml?

No.

> * should I also add myself to the maintainers list of that schema?

That's up to you. Do you want to be CCed on future changes to it?

Rob

