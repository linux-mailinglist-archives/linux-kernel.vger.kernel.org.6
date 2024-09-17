Return-Path: <linux-kernel+bounces-331744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF097B0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BFF28267A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01692174EF0;
	Tue, 17 Sep 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wkFhk6gi"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511EB4C66;
	Tue, 17 Sep 2024 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579780; cv=none; b=kGdTknBtS7g5aABpTL618IqnggHTV4IzteAIWNNIB8uolhpja/3nN/tAvK3g2fkknI++ieU/bEJnr38eJOIkBsXsoUw/0fMl/apEPyapEyvBzeGVoxulto7xRRBwV0CprHG/yHkTBIUI67Jm1DoyR079Hjb0F9Tfx/Iwzj6jxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579780; c=relaxed/simple;
	bh=eldDH882dZ+EPXSBNmWCfXwvB7TGB5pJITFXykbO/HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzbY66HWhiZPKRL5RUTmCrQF9/xaDK+oipe3TF2arcNWMaKWbDB9w/x5lfHohuGZ0iLcqXc3ekExZN5j2UDpjfQgI44vF8peB90yDoVv3tbP5YI5OlSMXa8PTzMbpkA2RMcJvvBe8YCqHJXiY1rsRaQ+lah8iJ6yWXtSjdJiBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wkFhk6gi; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CAA241F910;
	Tue, 17 Sep 2024 15:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1726579773;
	bh=+17PJtQ9hXw0xsvyjaFHf6l+N2HVSiJMd9TkH1OyWKk=; h=From:To:Subject;
	b=wkFhk6gikRjOdmodnIppIFD8v8E76qRGG2r+Tgrj2tgiMaa4EAs8DdShu4APg8TOV
	 pauHmxvvUXRRVOIG2dJOejLP/CjWsuEgjyHTX33AETbeey49Iw9mjb7GFuWdClUomR
	 qpexSmcZQ3bDrBwW6aQ7SfZDsWT8xi8Puxy2fhNfB1K+sfPm4rYElF2pMLwtn0DcjA
	 2+6xwVO46djGMEwYHuK7CjNn2ibFV43AuHHQJQ5m/thOTcNjWNYScLqTdCMhgtUmWo
	 LCkD8cCQbFQ0kFYzv54YB53inbEjjunk6wwBpdsSAMU+7K2Wx8jR/jgV6ZIPcpkxdO
	 SVLhuCAWWIuUA==
Date: Tue, 17 Sep 2024 15:29:28 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
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
Message-ID: <20240917132928.GA5292@francesco-nb>
References: <20240910152213.2072743-1-ghidoliemanuele@gmail.com>
 <1cfe3f3a-28a3-4030-b6ba-3892a2a7bc79@linaro.org>
 <20240917074544.GA7916@francesco-nb>
 <99a6eec3-ed24-47b2-af07-b4764c6de6a9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a6eec3-ed24-47b2-af07-b4764c6de6a9@linaro.org>

On Tue, Sep 17, 2024 at 10:21:16AM +0200, Krzysztof Kozlowski wrote:
> On 17/09/2024 09:45, Francesco Dolcini wrote:
> > On Mon, Sep 16, 2024 at 06:10:55PM +0200, Krzysztof Kozlowski wrote:
> >> On 10/09/2024 17:22, Emanuele Ghidoli wrote:
> >>> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> >>>
> >>> The device tree defines the touchscreen controller, but it cannot be
> >>> enabled because it lacks a reference label.
> >>
> >> It can be. Just enable it...
> > 
> > colibri-imx8x is a SoM, it's not a complete self-contained device. The
> > display touch controller is part of the SoM, however it is kept disabled
> > since you need an actual touchscreen to make any use of it.
> > 
> > This label would be used where an actual touchscreen is defined, this can
> > happen with a DT overlay, for example.
> 
> DT overlay should be in the tree.
> 
> > 
> >>> This commit adds a label to allow it to be referenced and enabled.
> >>
> >> You changed here nothing. For me this patch is churn and pointless.
> >> You add the label when you need to use it.
> > 
> > DT files from the Linux kernel GIT are used also outside the Linux kernel
> > sources, see for example U-Boot OF_UPSTREAM [1], to me it's fair to add
> > a label for an out-of-tree user, am I wrong?
> 
> 
> For U-Boot or any other upstream project: yes. It's enough to point to
> lore patch or lore link. For downstream projects: I don't care, just
> churn. Downstream should upstream their stuff to be considered.

In the specific case this is a SOM dtsi that can be included in an
actual whole self-contained product DTS file. It's not just about DT overlay.

In the Linux kernel DT files we do have labels all the time into SOC
dtsi files to allow the actual board user to augment/edit the node,
even when not used (yet). As a user of SOC dtsi file this is great
to me, and the same reasoning just apply to a SOM dtsi.

While I understand you do not care, IMO it has some valid use case and
should be considered for merging.

Francesco


