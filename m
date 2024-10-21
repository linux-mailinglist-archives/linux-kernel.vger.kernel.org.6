Return-Path: <linux-kernel+bounces-373835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA639A5D77
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE25280E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564851D0967;
	Mon, 21 Oct 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCEE65F4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3221E0DE6;
	Mon, 21 Oct 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496856; cv=none; b=WxolkzPFtvI517idsmRwQc91fZjnaVmsGeF4sfyaRsEGPo46TxQe8DzXtIRJ2ACF8SXQsdn2VJ3z9HrVYB4+7wVR7/daa9fZax3k8a4Mwgx5C4Y08HqINR/4BWwD+IkqyHVyQYtOmhzeMW7WW+vFtIYNh0t3DeYcWT9rMt8rIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496856; c=relaxed/simple;
	bh=E2z57wqjicubF+Rr2rf4Rbt5H8V1k7SczVU1ynpvMZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbOSc8XN1Le44uv1ZHAdJ6F7RemNkPLEcSALDvM8vAF0hIcOIG+y2fPV0tHv4XCqlMnt+MHqPVz0vh5m5jT9RvwQbMgZe3YyvpwDOB9HuaAA07EFw4wx09uyDY0gdurlG/36jUWyNLXY0RM3EOQHs/cIIRtderLJbi8kr2Kn3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCEE65F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67687C4CEC3;
	Mon, 21 Oct 2024 07:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496856;
	bh=E2z57wqjicubF+Rr2rf4Rbt5H8V1k7SczVU1ynpvMZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCEE65F4oFev2wZ92s1z4YXxtLZmMFX3E1Z13M58n1UoBounb3qIQQDTbSbnZFF8g
	 1ZPzw+BXC7FNq2g9pw0hrJYCj0IPhX+xZ8dfYUNIjtHPyl3E/CNauvWENce7DKDX2f
	 HplyMs4Js0GnQaiVDFTzdsv/liJDOjPMM6cEJMpLAVZljNnyz/7b1Inr3JATLmbOvD
	 jtwqzUIXXO03PdHFTCDUdViuApueaGPEDZHtM/7pLYCvtylg0YzFCKm3yx03AoqvEd
	 N0D/q2olbJiOvl0Qz9IF+dIj6zCXh53WPJ80hAZh482JO/lYGnMVg1zOQl0IeuJ8ep
	 yduqvvESnvsJw==
Date: Mon, 21 Oct 2024 09:47:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 18/23] dt-bindings: altera: add binding for Mercury+ SA2
Message-ID: <3sjavrvuzuk7gkimumtpavakqixvzkokk3q4ai57qsiwjkwnhj@jzdpk5j2fnbv>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-19-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020194028.2272371-19-l.rubusch@gmail.com>

On Sun, Oct 20, 2024 at 07:40:23PM +0000, Lothar Rubusch wrote:
> Update the device-tree binding for the Enclustra Mercury+ SA2 SoM.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


