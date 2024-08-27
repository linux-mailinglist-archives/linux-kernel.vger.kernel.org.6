Return-Path: <linux-kernel+bounces-303685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A99613B2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39B51F23899
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577FA1C9446;
	Tue, 27 Aug 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAyEszhD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919681A0726;
	Tue, 27 Aug 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775042; cv=none; b=NoK0hqiAgsZ+7s4s4LhtWMUOUS2oDKidxG6aIQACqH5uWc4rLZUZurxjEQGZ7/EJfz7UIeWh0yN3C0j50utaD7s1jxfT4ydsTN1rICblBSZZDvsIOJxnRl9diOq4htWpbTXfGcG6l0vOH9A3mrKUp7yS/ul1Oqv3U7+8mMEQgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775042; c=relaxed/simple;
	bh=rsMK+WS/og+jqf0Ax+XTax5KTIhTXnY2zH/DcNq7X18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux1SGKuji6k+6me/bSE3R4a8FPdQNvNNXRhh+T5YzFwQlzNVT0KGXkqWAr6WraEytLNnnND6SQg9kMsekjdcamO9MRNxcecRY86Bh8XPV5I8B+WX27eOo7p4LRUSO2uz5U+I611RsyiuD8lgOK+3PkJH09vFaggpedGSuzZB3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAyEszhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4B4C4AF18;
	Tue, 27 Aug 2024 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724775041;
	bh=rsMK+WS/og+jqf0Ax+XTax5KTIhTXnY2zH/DcNq7X18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAyEszhDG5Ff3JVRYqAYq7vvJR8Ir51D8dhZPd+EqVqbE2Yd1kqGDuJdQMXzDiZzU
	 +R3Rvo2R+tM0iMgdxWclnLY4bA0IwYNvOcEbeu/BnmZoOFPbZQED+8fjjmeiSYW1mh
	 NTq1BF3saBfLzzyNGg740queAa9KTNMJXgnLfsypA/fkj1NWQE4/OFIV/762w7tOJ+
	 1PKsWqhsNk8HM9G4ETchaO83v7yr/+egfpxeac8XfSG1LI3eWwhxMY3QbM/7o+cj82
	 Da8c9wD/NhGcVIyNeNpf1GYIFoyeLROr/y1/+3B0fItIpzItSaqe6XZX2FDjl/qdcP
	 ICOdNI/cGTIZA==
Date: Tue, 27 Aug 2024 11:10:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] spi: dt-bindings: mxs-spi.yaml: Add clock property to
 mxs spi controller
Message-ID: <172477503807.4053459.6398789752039927421.robh@kernel.org>
References: <20240827151616.2256401-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827151616.2256401-1-lukma@denx.de>


On Tue, 27 Aug 2024 17:16:16 +0200, Lukasz Majewski wrote:
> The controller can have 'clocks' property to assign correct clock
> during configuration.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/spi/mxs-spi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


