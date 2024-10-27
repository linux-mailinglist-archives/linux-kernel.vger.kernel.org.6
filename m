Return-Path: <linux-kernel+bounces-383797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BA09B204D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45481F21B1F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4717C9A3;
	Sun, 27 Oct 2024 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpJOVy1l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB079C2;
	Sun, 27 Oct 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060603; cv=none; b=uC4xE7tea4nGHwkWiPNpjpnsKWDgnYHpD01UazeZ6pGlIJnfdMpciJwluP3PoihxW/FOMK5Ys8EjkVlvOIK/IG7xmY4zHINbMhqCPQimcRTIW1PuZzfGmtnbJv82b3IDmj1uayxWrGIt5s40ZFVhSxWoTuRFPHF5El2no1p0k3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060603; c=relaxed/simple;
	bh=l+KLEU/TejY89e8DOEnhG5YxQLO2/xSSIb74ARcfb3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1jcNzFYHmm4S8nbw6C6slFiHa3AbF/2l1tys+F2N8PpIq5jend/7TB4drHFWTYtp6gB6ovqjukYI1uclPNmVwwzXLzudWuaQwRN5n0tvbmYYe0ZDoDrbEtGLJdnjmYhVTpI37u2YdJXCo98XvfntDykIjxJf+Zgfo9FNqzcwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpJOVy1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC4EC4CEC3;
	Sun, 27 Oct 2024 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730060603;
	bh=l+KLEU/TejY89e8DOEnhG5YxQLO2/xSSIb74ARcfb3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpJOVy1lJNeWJFSfuJ23rNyQ+BiRQMF7CwLBem5hMHaDoJuaf3xkysD+clkOWSQG3
	 eoIrIYZeCuBgAiWKXUergxjSeKvANIYUoN3eaV4rZjFv5bIhQJt/+aI3wJxhFgeAXf
	 BPPuyIsgZOmC674mkQBO9DQfEqpoFBsOTa0O3Bp2qb78PKP+j7YJ3p0QO2AcV6m82H
	 yGIFwyx7Vuk2XE0S6mnAh7BUj6AJMvT14XxqFmg+p79x6WFYjesXwnhMGLTyynLBAv
	 x7rhsQ1OoZDvS8PHOowNAt2CtEPw5FcQYkcjVj73w/SGVnV2atxoonSGvciiEfrWeI
	 iw1ePNyAcRK2A==
Date: Sun, 27 Oct 2024 21:23:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, a.fatoum@pengutronix.de, 
	conor+dt@kernel.org, dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 11/22] dt-bindings: net: snps,dwmac: add support for
 Arria10
Message-ID: <kaaldxod6vrs7dmf23xmpwebjgfq2jfuf2anexowx775lgupnf@n37epl54kcpx>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
 <20241027143654.28474-12-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241027143654.28474-12-l.rubusch@gmail.com>

On Sun, Oct 27, 2024 at 02:36:43PM +0000, Lothar Rubusch wrote:
> The hard processor system (HPS) on the Inte/Altera Arria10 provides

s/Inte/Intel/

> three Ethernet Media Access Controller (EMAC) peripherals. Each EMAC
> can be used to transmit and receive data at 10/100/1000 Mbps over
> ethernet connections in compliance with the IEEE 802.3 specification.
> The EMACs on the Arria10 are instances of the Synopsis DesignWare
> Universal 10/100/1000 Ethernet MAC, version 3.72a.
> 
> Support the Synopsis DesignWare version 3.72a, which is used in Intel's
> Arria10 SoC, since it was missing.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 15073627c..d26bb77eb 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -26,6 +26,7 @@ select:
>            - snps,dwmac-3.610
>            - snps,dwmac-3.70a
>            - snps,dwmac-3.710
> +          - snps,dwmac-3.72a

This is incomplete. This is a list of fallbacks. Where is the actual
specific compatibler (see existing compatibles and their specific
bindings).

Best regards,
Krzysztof


