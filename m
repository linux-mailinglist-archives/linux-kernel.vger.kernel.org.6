Return-Path: <linux-kernel+bounces-361370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077999A750
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A881F247B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840F919415E;
	Fri, 11 Oct 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGOE41rp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD544360;
	Fri, 11 Oct 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659667; cv=none; b=dKkyhuJcIVY6Ip76QscbN1NAGR1tCwi/ELq2B9sAhbPvrexQhZVvygIQcaY2KMVftoWzvMo51DZSGHXcYEVQnH73aQothK8lp0pKQM3rjkbBx5tol0eax21UPvOzKEieNbBHmemqV9dKOnPRuFcW6Zga4crQrIy/QEEUhLa4U6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659667; c=relaxed/simple;
	bh=gUQu/qGPZbWbjcZCsj4kNLDENBFqtKIe1VImg2TkbKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boX9wWk3S2vyTiiJl9rtlWOjpHCc1F+Pp6ryHW6+mTBIN5x6ZSaPtOKUMwZEQT9DHZaXgxSAuPOCVqNvbfOza6EzsTBSXFWx8jUANeKaieOmOannxirS4+E4UI3YRY92eUVZC7Unve7pOz0+G6FtN57VyWs75fD/FL01ckJ/fW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGOE41rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282FEC4CEC3;
	Fri, 11 Oct 2024 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659666;
	bh=gUQu/qGPZbWbjcZCsj4kNLDENBFqtKIe1VImg2TkbKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGOE41rpQBAXTwIbUxp6QUpTdflcHu5sLrb3mPZJwj+3sH/Pdcl/ZwtWIzaBfHO7s
	 LaYgTlVbq3yBeQx+irIM5J1xHXbyenM1y4hKi9KapSCzwbowFscu3KGhyj9tfQoWRp
	 XEjR3LP2k55+5gh6+WfvUKVIhJwsZyKXvX3b8xnQ8YebyUxqA2/2dCtHXIoa+E2LO5
	 kPZwLRzGh0StFzyr11E97cLQf6LqPRliiIizvS54N41wZi62/erqi3c2yLI685eSXO
	 3wfi6YHxcKfqe8RsZH8NwWk3aJRLlYHKJtkJZV169wnfbkzNkSzbgvStRGXn9n7QD0
	 76Dy1/tUcuRwA==
Date: Fri, 11 Oct 2024 10:14:24 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pengfei Li <pengfei.li_1@nxp.com>, krzk+dt@kernel.org,
	abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com,
	aisheng.dong@nxp.com, frank.li@nxp.com, kernel@pengutronix.de,
	festevam@gmail.com, linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: Add i.MX91 clock definition
Message-ID: <20241011151424.GB2426751-robh@kernel.org>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
 <20241011045736.308338-3-pengfei.li_1@nxp.com>
 <posan34opc4p3crccwstomt7fwvtt3dm6urtcmcrm4wwduoli6@mmzj5qdjp374>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <posan34opc4p3crccwstomt7fwvtt3dm6urtcmcrm4wwduoli6@mmzj5qdjp374>

On Fri, Oct 11, 2024 at 04:40:35PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Oct 10, 2024 at 09:57:35PM -0700, Pengfei Li wrote:
> > i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
> > Add i.MX91 related clock definition.
> > 
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  include/dt-bindings/clock/imx93-clock.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> > index 787c9e74dc96..6c685067288b 100644
> > --- a/include/dt-bindings/clock/imx93-clock.h
> > +++ b/include/dt-bindings/clock/imx93-clock.h
> > @@ -204,6 +204,10 @@
> >  #define IMX93_CLK_A55_SEL		199
> >  #define IMX93_CLK_A55_CORE		200
> >  #define IMX93_CLK_PDM_IPG		201
> > -#define IMX93_CLK_END			202
> 
> This is supposed to be separate patch, because you are removing
> something from ABI.

But "end" defines are not part of the ABI.

> 
> If your maintainer NAKed it, then do not sneak it some other way. Sort
> the problem with maintainer or entire patchset cannot enter.
> 
> Best regards,
> Krzysztof
> 

