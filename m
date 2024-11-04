Return-Path: <linux-kernel+bounces-394296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2EA9BAD06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3A828221B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D00192B8E;
	Mon,  4 Nov 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="XvRRJCLJ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077F16190C;
	Mon,  4 Nov 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730704452; cv=none; b=Ljk9m31GiPYHCxj4n5VdQdpNcW/07BhoH/uzt0Gx+B8iHx37jOGSefMRgvi60SKKNFxL5YCU4Hjtd2peUtmw66mMA//X/KApkKaBwOgPzNYTIDW+f5wBnIf31+3PZZaLfUG70AU6FCGQ4cMJRzSUlGgc74mVf1cpoRalkbQjHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730704452; c=relaxed/simple;
	bh=Hd5MJEoVYGIKCtNh88punDf+sxA5yRWSbiMnnBIi/Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3Bb0lia0lTWpqkuEoQkQr+NE/3/e6gDP56NMBLuxHfpstq0RzYg2DajsZEQNLqQFch8mcGE000/m9UTuH1t0wgI8MACXSn+1B2KJ/Ei25SBFJsz9cO5YG0vLARA3/zkvt6BKIOsZcqHKfzEF2uz9qoAsy7v5pXR1UQOuMDLqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=XvRRJCLJ; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=N38imsf5cp7S0lOP1h1HxtPzgaChkTFKnOWU1LwG/Rs=;
	b=XvRRJCLJT1VocPWDAzaWvfoBMjG1x9on01zL9kQTaoVWwzGsWLafs9dbh4QiYQ
	Li46IFRSLI1DJ10+ktYsSiU+1lR6xgAE6wCnjl6WiEGgpokbAbHmDI+YFSmgqHhT
	ECC2K9DDyQemrK/Gs7MuccKaS72iLXGCbr5q8je04Onik=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHCagCdChnUC2mAQ--.16752S3;
	Mon, 04 Nov 2024 15:13:08 +0800 (CST)
Date: Mon, 4 Nov 2024 15:13:06 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp: add aristainetos3 board
 support
Message-ID: <Zyh0AgJZh1//17Te@dragon>
References: <20241031151238.67753-1-hs@denx.de>
 <20241031151238.67753-4-hs@denx.de>
 <ZydFO6b6oe9widaa@dragon>
 <5340fb82-bda0-d22f-23df-de620c8d61c3@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5340fb82-bda0-d22f-23df-de620c8d61c3@denx.de>
X-CM-TRANSID:Mc8vCgDHCagCdChnUC2mAQ--.16752S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUc89NDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBCNZWcoXw4+BAAAsY

On Mon, Nov 04, 2024 at 06:33:55AM +0100, Heiko Schocher wrote:
> > > +
> > > +		semtech,probe-reset;
> > > +		gpio-controller;
> > > +		interrupt-controller;
> > > +
> > > +		interrupt-parent = <&gpio1>;
> > > +		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
> > > +	};
> 
> Should I remove newlines here too?... but looking into the example from
> 
> Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
> 
> there are this newlines ... so I let this lines in... or?

Not having newlines in middle of property list is just a style that
I prefer for IMX device trees.

Shawn


