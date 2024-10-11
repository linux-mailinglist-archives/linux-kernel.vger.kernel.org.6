Return-Path: <linux-kernel+bounces-361369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64C99A74D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CD11F249B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A333195811;
	Fri, 11 Oct 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8fHGVVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBEE194A44;
	Fri, 11 Oct 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659610; cv=none; b=PACrLi24NJY0kizsFooxzeVwdvB9+XRagSN5yhd4aAGPNEmJfohukU2OJ11vQ6F9AMKWE62zFWKQVqkINN2ThLow7rjCRegGUJshcXoRsCP92aJxzcwmWS2dcL9d+gbZtT6x7SvT8Yimy7HkOa1EuOPejDQ5Q1jexqVKNqCF6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659610; c=relaxed/simple;
	bh=bOpU7frSd/AQvijRJzrX1P4Fght1mmTLP9I8bGw6Jes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Teq4FSDa1y3vGzSVN0B3a85bFN+nGpN0MIr4sN5h1TReBhtcsZGvShF368cM0EEBt7E+bpzzfeOMqPmhJnkuYLZEYLBo/XHF9Yjs+ABxoc/pznNH/9nHgaH0IDXUMo1RK3RVp8zNwmRu70j6pIX3M1v/L3r/ZUuHVt0QN8fjWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8fHGVVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A1DC4CECF;
	Fri, 11 Oct 2024 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728659610;
	bh=bOpU7frSd/AQvijRJzrX1P4Fght1mmTLP9I8bGw6Jes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8fHGVVw92Y5uhFMf0J+Vj5ngZ8lHQRc32SvYchwkeI8rHG5sQDE2cG6VkVlnPU4S
	 ArnvIhxMjsEQko7pfmY//yew61S8fclVQnZwQwYb4ftuI+m+y1A7LQFJ6ga0Geqbf+
	 QXxhI1CH3zzfdgikznOlSMIDNwVi4hVjP9KrP7N8mCtrFhoNzjPK7+hPq/BvhXjtpA
	 JY59ndpm/oYGiHJ0ZnWb7pzd10zGB8DAHr7O46/qAFYRy05cpCqlN/vMXxmeP6S28z
	 wfNHsuy4GvwSRIAkSX+EP0tHm5K8gN3d1R+IHzrLAoHmKKq5bggHcANv1dO1YEJke7
	 sesBEAfiw6T0A==
Date: Fri, 11 Oct 2024 10:13:28 -0500
From: Rob Herring <robh@kernel.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, abelvesa@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, ping.bai@nxp.com, ye.li@nxp.com,
	peng.fan@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: Add i.MX91 clock definition
Message-ID: <20241011151328.GA2426751-robh@kernel.org>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
 <20241011045736.308338-3-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011045736.308338-3-pengfei.li_1@nxp.com>

On Thu, Oct 10, 2024 at 09:57:35PM -0700, Pengfei Li wrote:
> i.MX91 is similar with i.MX93, only add few new clock compared to i.MX93.
> Add i.MX91 related clock definition.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/dt-bindings/clock/imx93-clock.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

This belongs with the binding patch.

> 
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> index 787c9e74dc96..6c685067288b 100644
> --- a/include/dt-bindings/clock/imx93-clock.h
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -204,6 +204,10 @@
>  #define IMX93_CLK_A55_SEL		199
>  #define IMX93_CLK_A55_CORE		200
>  #define IMX93_CLK_PDM_IPG		201
> -#define IMX93_CLK_END			202
> +#define IMX91_CLK_ENET1_QOS_TSN     202
> +#define IMX91_CLK_ENET_TIMER        203
> +#define IMX91_CLK_ENET2_REGULAR     204
> +#define IMX91_CLK_ENET2_REGULAR_GATE		205
> +#define IMX91_CLK_ENET1_QOS_TSN_GATE		206
>  
>  #endif
> -- 
> 2.34.1
> 

