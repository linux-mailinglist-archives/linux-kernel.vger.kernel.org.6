Return-Path: <linux-kernel+bounces-249861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1256692F0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B381C228FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C419F471;
	Thu, 11 Jul 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIf9qktS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88551004;
	Thu, 11 Jul 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732501; cv=none; b=FRKS6lVXdiY9sBsrSqpBJ0lI9qBWvJ1WOCPzGfeUBg5qcspqg4HSxo1jWEnKfLOSIWpTCXTk9yHW0beWw5W9WdNpKTeRIG0WZ+pa0B77MWr6xgJNuFgtiWmCZi9bG4w4xEMMuEdzpepcM3++bLvbACb4f5Plbre8SmgGIIOHQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732501; c=relaxed/simple;
	bh=z8jx8XLitvFIbm91GAY+1qBbqQDN79ywbMy4k/ZvO8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI6TF2IklvZctHi53A6qnty+8vELlzwFHhN8MnTycQ/iScU4/bkHPPiyUEWxLRm36SpXKeXvo+14pr38R6n2NTHP945HR1cCbkQiOjZfDWh9Ihpd0KzTuq9K8om3PtQVFtWiQXctbPS1KC4GjI3/rEZH4qd/I0/NZRqE3pPMv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIf9qktS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA1BC116B1;
	Thu, 11 Jul 2024 21:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720732501;
	bh=z8jx8XLitvFIbm91GAY+1qBbqQDN79ywbMy4k/ZvO8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIf9qktSiy54+akkP8iHXDMFFVJievO+tOgP80GeZmvhYnwzMvIUd12zGT643MiGq
	 DbKwfQnZ57LSekr6LWR4F+xIFPfaabI+TnF21rXOu1j5f14nskEsW1glQx6OL7Dz0H
	 JemseofGjJ1tLkapw35eXNDlNoFrJqsmCdAxGQq3Q1TWSWs1SwCPuLaGe89t4kTS11
	 vx4YJGiFwS5Q7iNEJMYoc0TCwqfVIgEmmK6j9f4nJjNTkDz11duORyRXiJ16lmvhyF
	 hj+Ogecqq3L8IIxUIOaWc4BibZhEiy2jj9Je/+df87lHt+GeSq6EZ2vjuXaWnTL91P
	 Dc8MBj2b/kXGw==
Date: Thu, 11 Jul 2024 15:14:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: peng.fan@nxp.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	sboyd@kernel.org, abelvesa@kernel.org, imx@lists.linux.dev,
	s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
	shawnguo@kernel.org, festevam@gmail.com, conor+dt@kernel.org,
	mturquette@baylibre.com
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: add RMII clock selection
Message-ID: <172073249908.3021877.9435881584996282557.robh@kernel.org>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
 <20240710084345.2016687-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710084345.2016687-3-wei.fang@nxp.com>


On Wed, 10 Jul 2024 16:43:43 +0800, Wei Fang wrote:
> Add RMII clock selection for ENETC0 and ENETC1.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2:
> new patch.
> ---
>  include/dt-bindings/clock/nxp,imx95-clock.h | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


