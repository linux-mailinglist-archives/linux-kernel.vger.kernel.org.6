Return-Path: <linux-kernel+bounces-321406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41505971A11
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0025028678D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2BF1BA26A;
	Mon,  9 Sep 2024 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="eACSEQnT"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22141B9B24;
	Mon,  9 Sep 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886477; cv=none; b=rpo2p9pOXAT+6H31X0yP/omogk3YaviPywR0BUWgAVGU2S2vlmIq0fzALUIc6Itl+RKl4snJboJiRl0hhuTSNCbg634BVWP7rZ4v0aXypSy+YvsqsCWpxI/EIrcd5E4S8ail51nMhV1gotIqtOLFKp3Yqw+jnj90/fbABme8II4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886477; c=relaxed/simple;
	bh=9w0sSJFSbDZblgKV2bqF1IwJcU9aE1btO0FgCad6Mc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG0xfCaknYA5su258R5rRC8IuCYLoLB+KiHf91kZdvsY8ydXnrTae1W81+Og+ct1VJvPQcJEooSscIRNiTV5LSoAffnm2lTEwMlzlCzOaue4NxV7W5qQGxzSL5NhykzZnSdj+YtPGW0eDYmBYZO7vuLo0eRfR7MrZAIC1X1kavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=eACSEQnT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 213641FCD1;
	Mon,  9 Sep 2024 14:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725886464;
	bh=N+n+sNoWLrte5yaPsNU7QlZO/lCcS8hz3s32YZuFi0U=; h=From:To:Subject;
	b=eACSEQnTt45lSSQdZN0JawLzeNSnTQkZKSICFVuzeO6IvA9l4wuG12yQlgINGcKyS
	 2VavSq7wIprqvAsg46uvSbdRHliwhik0WYPhXCPPHz9TYOPK4fak+JU0C2AtoaBfL/
	 kcQsJMm4u9PQ4CHtGLpThdg8vw4CXAN2oemXuMfqn1/Z+jB3xBE/aaacwx/990zUz1
	 7ViGthwWIbjE9cQkA9ZA3rPQXOKEktSria73wfaNDTZNN8uImKhRWwqaz8n+cmlCVG
	 C6M1YDsJ6AkRxTdqXsBTb7pwkw7zE0wdd4a/aus7ieP92Zh52aA9xb2wJF1jbBPVIL
	 9ywlFJHZAjNnQ==
Date: Mon, 9 Sep 2024 14:54:19 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hiago De Franco <hiagofranco@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6qdl-apalis: Update audio card name
Message-ID: <20240909125419.GA33114@francesco-nb>
References: <20240909114902.82380-1-hiagofranco@gmail.com>
 <20240909114902.82380-2-hiagofranco@gmail.com>
 <25873dfa-fe70-4ef6-b840-795faaec1f07@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25873dfa-fe70-4ef6-b840-795faaec1f07@kernel.org>

Hello Krzysztof,
thanks for the review/feedback.

On Mon, Sep 09, 2024 at 02:09:11PM +0200, Krzysztof Kozlowski wrote:
> On 09/09/2024 13:49, Hiago De Franco wrote:
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
> > index edf55760a5c1..1c72da417011 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
> > @@ -191,7 +191,7 @@ sound {
> >  			"MIC_IN", "Mic Jack",
> >  			"Mic Jack", "Mic Bias",
> >  			"Headphone Jack", "HP_OUT";
> > -		model = "imx6q-apalis-sgtl5000";
> > +		model = "apalis-imx6";
> 
> Doesn't this break all the users? E.g. ALSA UCM and whatever
> user-space-parsing stuff you have?

I am not sure about "all" users, but for sure it's a breaking change.
There is no ALSA UCM for this board (and also not for the other twos in
this series), we just worked on it and we thought that if we want to do
such a change the moment is now.

What should we do?

Francesco




