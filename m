Return-Path: <linux-kernel+bounces-321581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5F971C50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15C2B21D67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD131DA5F;
	Mon,  9 Sep 2024 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRUftkhI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A61AD5C1;
	Mon,  9 Sep 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725891532; cv=none; b=k80CGejmGc7FtV3Q64iIWI0t/JKo+7lP33SR5nYil/w+ABn93CHTVgtSNyfOnIzsQqoJWFI6cUuM1yeb93WLkPI1QXsv8KbQky01LD21mmb865SNwMZA7wp2wn8XBNEDQWNz9tPUPRXfSd5wsc1nyaZuU1dScUnxrEXJwuqMOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725891532; c=relaxed/simple;
	bh=PnmCdAiSZLqmrOvlmp6sRwwUDoGa5lxrigQUCX6Ca5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrWsWEetOa7P0zo9/SjqdkPkkMm9lJjvJaNdvY4Xiet7wGTnlFpb74z6k7dHtKR/LYdovbxIMhfCfPUzHSdLgFXWjHBmrk8wCVZf0/I1LMgxYXKDcKm4dusY5I/TUSb8hls6A5kOv3lznT1XIl3E2u8hlCzBZpE6JBejUOBTRpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRUftkhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9062DC4CEC5;
	Mon,  9 Sep 2024 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725891531;
	bh=PnmCdAiSZLqmrOvlmp6sRwwUDoGa5lxrigQUCX6Ca5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRUftkhI9KGqeBcFDi7T5YX5L7dRjrP0xnLxAzNReVrJQkzrVYQUiWGClkioSVwsv
	 xbllfR0eSdsxxnxwrraAcDCKbWG3jomU2sc01oUNf7p0SU9W0uxlwnXxPB0r4UAN9f
	 gU1Il6uhCqEDvvO9/1lZpYaVgnP7nVPY5aNFEA8WCMNpNoEbhVrk12GPN8RABPGIl3
	 uZAM+4ErcP5BG2CuG+sA1XeE4ayNo8ZHHVQFmjLJFvQ1fF3rr1jV+gJG+Gzz5f8YrR
	 bpA4M+HWFJGKrspow1qyYcDeztDIepNHb520TF1Wr9vXdSfRvCSiOO2u7Dxe6pLlDV
	 KDyfiS+MWMklg==
Date: Mon, 9 Sep 2024 09:18:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, imx@lists.linux.dev,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v7 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <172589152997.4184616.5889493628960272898.robh@kernel.org>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-2-5afd2ab74264@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-imx-se-if-v7-2-5afd2ab74264@nxp.com>


On Wed, 04 Sep 2024 16:21:18 +0530, Pankaj Gupta wrote:
> The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> creates an embedded secure enclave within the SoC boundary to enable
> features like:
> - HSM
> - SHE
> - V2X
> 
> Secure-Enclave(s) communication interface are typically via message
> unit, i.e., based on mailbox linux kernel driver. This driver enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
> 
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications, to be able to communicate over single MU.
> 
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


