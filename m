Return-Path: <linux-kernel+bounces-331398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A897AC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF071C21892
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA414A62E;
	Tue, 17 Sep 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GMTNj07v"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2882D98;
	Tue, 17 Sep 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559164; cv=none; b=ZGXN/k0MWKLVbNczxM2FoYGniARPS+JCBY4G2+yyRQTFUmwT+zKyff/J4/5Pn6lthujfMl5D7vzYEPdvwx/y+6rOGj1ken7C5S422+I4RG4EMjtGszsWl+IRtt1juT8jYI/OxqfkqzwtqsigNX5nG2ZQ3Jbyv/dkEtpZIeHLHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559164; c=relaxed/simple;
	bh=x+0wJ4cJX9+ICI32gYblCANCl/cc296DmLw3hduBRCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBj4DGtem/ryYJ7ENBeZVR+Lm+r2Qqo/DUNumnsqgC77WJ5Su+nqz1MBIwjLeoNj3mJR/PlYOi1eZgJfMSCgZRqbIvFmOpDxqelkk1ZBppNBg86wxiFaW1ucTc2YjHOqenjSNxhhEdL3THnzlqNVt7hTj5JFOvJ7EYX1d6i/Utg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GMTNj07v; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6A8781F9C7;
	Tue, 17 Sep 2024 09:45:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1726559150;
	bh=0ctxh6EHatNfEKj/a1TCaaMo+DnREyCVRKDJamzJcTA=; h=From:To:Subject;
	b=GMTNj07vlNNAvHSkjs9h+CXYzHd3oI0JfRiZ/HOZ3AKx3Syqt2ZbRfgZ02g3ByEqI
	 sFrv0aqx8qzPsSIhkDhEW/fQe7S4WC02W9mvZv2GFE659P3e3cjTr8ZracM0IW3Q3D
	 6ZBhoKXOqK5sZGuWLcH/Ovzs31BEsTKsK3p2lpxY3kr4gw+OH684fXtaJCR67DiJ80
	 10AkWd1dLoWFGniJy14/vu2xp2ONRvs476xdVIponkHV2NTAg80445XDSNMKnO3TaB
	 i7/Hd1AQertKt/B9sQZ7k90O7CIqTgZTszEctaozmfsC/w+ssz7bofteSSqnzDocYy
	 qulu7vIvg0FYw==
Date: Tue, 17 Sep 2024 09:45:44 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: colibri-imx8x: Add ad7879_ts label to
 touchscreen controller
Message-ID: <20240917074544.GA7916@francesco-nb>
References: <20240910152213.2072743-1-ghidoliemanuele@gmail.com>
 <1cfe3f3a-28a3-4030-b6ba-3892a2a7bc79@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cfe3f3a-28a3-4030-b6ba-3892a2a7bc79@linaro.org>

Hello Krzysztof,
it seems that this patch requires more explanation, maybe something
that should be part of the commit message, let's see ...

On Mon, Sep 16, 2024 at 06:10:55PM +0200, Krzysztof Kozlowski wrote:
> On 10/09/2024 17:22, Emanuele Ghidoli wrote:
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > 
> > The device tree defines the touchscreen controller, but it cannot be
> > enabled because it lacks a reference label.
> 
> It can be. Just enable it...

colibri-imx8x is a SoM, it's not a complete self-contained device. The
display touch controller is part of the SoM, however it is kept disabled
since you need an actual touchscreen to make any use of it.

This label would be used where an actual touchscreen is defined, this can
happen with a DT overlay, for example.

> > This commit adds a label to allow it to be referenced and enabled.
> 
> You changed here nothing. For me this patch is churn and pointless.
> You add the label when you need to use it.

DT files from the Linux kernel GIT are used also outside the Linux kernel
sources, see for example U-Boot OF_UPSTREAM [1], to me it's fair to add
a label for an out-of-tree user, am I wrong?

Francesco

[1] https://lore.kernel.org/all/20240222093607.3085545-1-sumit.garg@linaro.org/

