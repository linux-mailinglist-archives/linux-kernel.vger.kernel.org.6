Return-Path: <linux-kernel+bounces-278359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CBE94AF2F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B185F1C21043
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DEA13DDAB;
	Wed,  7 Aug 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="U5Q2k14i"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805AD139579;
	Wed,  7 Aug 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053119; cv=none; b=t+WoZ8P1bKaayNLS50mGmtFlG/VV/cy1UN4mTwNtUWL3QpxfBGOJsmoU/8gEpIDBdNWiTR81GIygoFDnwnMsdNvTn/QWkA8Bt/8NFtv1A0aNa0XrnJNPVudj5FTdCqTYZ/aXTEHPHPtyFhXnDhpf4+YfmjHYsbjjvyo5zJ6o14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053119; c=relaxed/simple;
	bh=M8/K05CsO4l9a/Gn9WAOFc2Erc//Aa0fx5Zns7lHDpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YioT4p5elze0SV0Y2EOwl/B9ec6rBsH3SN9T/hMWs0UqKOZR40qMGe+U1fPdrd9nF1U4ztRrqin/lSxlUr7kMyGeeX08uNhpZ4XwoCeCeA3zZbc3SILYdTs0QqQ1hzqac3DbNMmZ4bZGP7okjxoMmCd30juSFHu/TSOBB+yIfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=U5Q2k14i; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C1B1021356;
	Wed,  7 Aug 2024 19:51:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723053113;
	bh=IgJHKpRaj1V7B1t0wb04bvKsKafQiNRW06ITclpickc=; h=From:To:Subject;
	b=U5Q2k14iGALDwMSVpovpFXi3fT/nJ1yXasaFcCiURQ6pJ40vLo6OCcV6k5550AR5e
	 JMqPkeCrAzAEF5BeUz+0OP6VvUxLxSVRef0t8RKtSgMRdMpLCMhRp2NxdfLc7sQDXe
	 xS01WljEFvjwFW9kJ9D2pVMqw41+YJpPBxMIUE8tsA9COTz+dC/wKs8ys234+DK6/L
	 PWM2USLynSG5qUSBge2HaDlV6maXqCOEZJ6/e6oHTgtPgB5CyDv+MzgP7J2QW6QzY7
	 OvU4Is5kPueO8irwC80o+4V9VMRxWyrPxNGMscps6BrJrIMxrvAInhiNW7JrPmBepf
	 9IdSHuKfwrRDA==
Date: Wed, 7 Aug 2024 19:51:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>, rafael.beims@toradex.com
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] arm64: dts: imx8-ss-conn: add PPS channel to the
 FEC nodes
Message-ID: <20240807175148.GA299582@francesco-nb>
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-5-francesco@dolcini.it>
 <ZrOUGLJPYC/K4MlP@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrOUGLJPYC/K4MlP@lizhi-Precision-Tower-5810>

Hello Frank,

+Rafael

On Wed, Aug 07, 2024 at 11:34:48AM -0400, Frank Li wrote:
> On Wed, Aug 07, 2024 at 04:43:49PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> > On i.MX8 the FEC PPS channel is routed to the instance 1, not to the
> > default 0.
> 
> According to my understand, it should be board level configuration. FEC
> support output pps to any one. choose which one by board design.

This seems different from the information we got from NXP some time ago,
unfortunately this was happening over some private email exchange and
not documented anywhere public. But the message was about SoC internal
routing, not something at the board level, at least for i.MX8 SoCs that
is what this patch is changing.

For example to use PPS on i.MX8QXP we need to have this

IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET0_PPS 0x06000020

pinctrl configuration _and_ use PPS channel 1. Same is for i.MX8QP.

Maybe Rafael can provide you some more details and the name of the
person that provided this information.

And maybe you can also try to double check this internally within NXP.

Depending on what we find out we can decide if this patch needs to be
dropped or not.

Francesco


