Return-Path: <linux-kernel+bounces-184127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FDC8CA2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5161F220D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2E1384BF;
	Mon, 20 May 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LokIiB5c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBAF8C06;
	Mon, 20 May 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234584; cv=none; b=PgxbWxFvnsxAE+8JbUos170QUDy4Ctx+rDWpgkx0PI/e4r+ZuMwkI6dz+vd2KkK+ZdQiAV6dUAPpUOkLbqvlaTnRyJ2AVHNH+T4x54Koo6M4Guytc2KiqUUZ85WIepLbT5DtXsttgSS6gbSpsSjJ55thg+IfQZduNx3r8eWjuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234584; c=relaxed/simple;
	bh=sxGLsR90KSF7S/Z2DpAE5FYChE2YFZRSsoBsCOYL/jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7vzoFuZiJO1y2FmL7h7YGpGNqBBzRUPcwyJvgxCjRZwY84w3fTnIC+hKKZOrIgy3PM95BB/hRrexFk7qb0bb1ecwj1BEsgZ0nrTJpCLjPymtdcVp4CBSx5JNUzQ1CMDj2sSgbeFt3x99vMcynistdPcbTZfjs+G6YD6tSjCzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LokIiB5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB53C2BD10;
	Mon, 20 May 2024 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234583;
	bh=sxGLsR90KSF7S/Z2DpAE5FYChE2YFZRSsoBsCOYL/jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LokIiB5cDH+jczaMcXHV9n9aGU9hsuiS5ZCmmORHHX7LpVIA9pTpyxJFYadpst+ov
	 jQtiJclC0PLGotuHkrM4D0+xd+pfg6RZZU40vSSbh17BUhJXeoHpYScXa2Fs0EagWw
	 FXkueSw0JGnvcDPyVlmIvyZmJLTk0bMhMYC3WuloQ6m4af5jasnNdDU0xwz5kyVQlm
	 1cCJyrQ8PGZIDhjBQDzKpRuikbIowuooKYcpCW+DoNOxiYA4Vsm0FMip4mk2d7JGKf
	 9t2hE/w1mhW+bypcMJ43PGzWB15qQNLniui7JfBCVidjebVlLCYQrD0IT+G9EvwxsO
	 qLeuiIdz6h9NA==
Date: Mon, 20 May 2024 14:49:42 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linus.walleij@linaro.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, festevam@gmail.com,
	imx@lists.linux.dev, aisheng.dong@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: arm,scmi: Add properties for i.MX95
 Pinctrl OEM extensions
Message-ID: <20240520194942.GA1374705-robh@kernel.org>
References: <20240516073012.1699795-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516073012.1699795-1-peng.fan@oss.nxp.com>

On Thu, May 16, 2024 at 03:30:12PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 Pinctrl is managed by System Control Management Interface(SCMI)
> firmware using OEM extensions. No functions, no groups are provided by
> the firmware. So add i.MX95 specific properties.
> 
> To keep aligned with current i.MX pinctrl bindings, still use "fsl,pins"
> for i.MX95.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  There is already a v6 version for i.MX95 pinctrl with binding got reviewed by
>  Rob, https://lore.kernel.org/all/20240513-pinctrl-scmi-oem-v3-v6-1-904975c99cc4@nxp.com/
>  But after NXP internal discussion, to keep "fsl,pins" for i.MX95 would make
>  it aligned with current i.MX93/8M/7 bindings which people are familiar with,
>  and easy to understand.
> 
>  Sorry to bring back so late after your reviewing in previous generic binding
>  patch. This is not to reject the v6 patch, just wanna to see whether you are
>  happy with "fsl,pins" for i.MX95. If people are happy to accept, I will post
>  out driver together with this patch in new patchset to reject v6. If people are
>  not happy, we could continue with v6.

It is fine for me.

Rob

