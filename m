Return-Path: <linux-kernel+bounces-312590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E18D969887
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF60281DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E91AD248;
	Tue,  3 Sep 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="CfUET6Si"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D419F424;
	Tue,  3 Sep 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355011; cv=none; b=BG4DYOpdtHWZck98vWlFzNCTcGX/Ye1OSpD1NBnkFAgnQHOwLxcEYKKM4LYTUlKHfhV70yhmaMXd9qBoeDuqJ8z8WqV8gswu2kvEmVhM5//XL1u8mvTX/jpHbHW2C570CNwcWCkDZlf2bgywoHX1VuBOhtdLvwof5c7DP5ph0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355011; c=relaxed/simple;
	bh=wq41NyGesv5AiC3lz0mAa+Qwn/W/Aee7WAkCJ0rGTuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDc5/G3CDGz/uo7ewX08bl0Wjgur4zZed/bjZ0Aob4hc3Vyp6GHHlEfdumag+3qQf5iEreYV/9MAFSGsg3pGqVCG2GrlUzpyH9v3iEbx34oLj20Wk7we4jLyRrljtFK76UWQ4QtuzwS+YF6yive87FqrhKPXS0eb68wuO5LED1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=CfUET6Si; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 64CFF22A41;
	Tue,  3 Sep 2024 11:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1725355007;
	bh=V1pTTV07r2NfNzXvB7UF/0OyUgDKTfKdvuu61Td5x2c=; h=From:To:Subject;
	b=CfUET6Sijl4iBdpA33iyK3zf+5ljUrPiYBHVhHvSTayEB7HzHdkcRIcJW2jHr2xI9
	 Paozik73jl7zkvBSErv3gP6zvvEJ6tCJ7D/6jROw2qhRkWcgNXmOtYaT71CRbnb9lb
	 e8o1yj23QyRTpwdy/LpleZaoiSokRgmeF9hXBddIkPtcGHRA4c8hX9t2Ilf9W5NUNP
	 Lzm2FMX117ijzxybmb7C7ccrXpY6gN4xaxoyIXeFxogqrmfOsDNtnZ2GrGhww2Nysb
	 0kKNxh3SiZ6vYCpFWv72QDsbiLNxC7cGDLDoNBXOae3bJdq+wXl2A8WbP2A0ayMKIs
	 RgLU2ZwdwWNeA==
Date: Tue, 3 Sep 2024 11:16:43 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] arm64: dts: imx8-apalis: Various improvements and
 additions
Message-ID: <20240903091643.GA20172@francesco-nb>
References: <20240826221541.15669-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826221541.15669-1-francesco@dolcini.it>

Hello Shawn,

On Tue, Aug 27, 2024 at 12:15:36AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series improves Toradex Apalis iMX8Q support adding:
>  - correct thermal zones
>  - analogue audio
>  - USB Host (Apalis USBH4 interface)
> 
> In addition to these it also removes the adma_pwm from the i.MX8QM SoC dtsi, as
> this IP is not available on this specific SoC.
> 

FYI, I just sent a v2 of this series to correctly sort the I2C nodes,
this is the same change you requested a few days ago on colibri-imx8x.

Francesco


