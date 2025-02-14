Return-Path: <linux-kernel+bounces-514568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71080A3589D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A02216DB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B4221D90;
	Fri, 14 Feb 2025 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgl41hSb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D42080CE;
	Fri, 14 Feb 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520951; cv=none; b=UWEMg7bIQI3wbXw6PESl3h1VTBk5vpzx3b+J1ixW8Kkv5ndMwmtcoHKCAQ/PiVLMFA/BaoAWS/bQwlY9zadxu3U+PPIpMiHnJDOEnw3jf6DsHYFOE9xinxiCjteXu3u2Qpty+Xf2KRcRxYhemFn+uqdI0Rw4RgMvXhLnVdN/JJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520951; c=relaxed/simple;
	bh=UnABjtE3CSMdX2YgAQYGBOrN7rt2X9ajJE0yjI2rMWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfJR/8KaH5Rirz3Aql6gQfztxmOP02w4ikM5HXnS5oObjmIgsOroKCTHFQjs8/TLb8+g0l+Is+YW2Bi+l26BnjZ87iEUO36VF2iUBKQjCnU/ngjPFgDLMkIGCDGPKfeaVtSl9CX1HVbw9sXfQXTIUU3dA4x+p/uh3A+lyePxqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgl41hSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97063C4CEDD;
	Fri, 14 Feb 2025 08:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520951;
	bh=UnABjtE3CSMdX2YgAQYGBOrN7rt2X9ajJE0yjI2rMWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgl41hSbmW3bX2nyjNTDUHE2Nuy+gEvjgCqli7YGQatzYm+N5wNBoFRgm5mnDSvwX
	 kftq3IjU876TBa+KrXlhd1taNKyfezBL03lAW6fZutrZRiqZsqVDGbK+bIUHCtp0v4
	 hWop/HepDQMtAM5C6Q2RKucWXXl/Sy2IJVIQ0xwMgP6TWM6gEjXMauvRDsmsPBEY7o
	 jgEEUjT5LTiPc3Gu9o/Bn4FJUUKn6eGaN7FdTxIksr4dSLOeFwxNMboFHMN76b3rdd
	 wpM4hkhUtnPRVMcas1QcaFaxaPPYkayg+SO/XRnQT3Skb28r8YUwIJRYQnsBBbk+7B
	 s94x8gjHpkNJA==
Date: Fri, 14 Feb 2025 09:15:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, festevam@gmail.com, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, m.felsch@pengutronix.de, 
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH next v3 1/3] dt-bindings: usb: microchip,usb2514: add
 support for vdda
Message-ID: <20250214-literate-bullmastiff-of-advance-d8ecd5@krzk-bin>
References: <20250213094338.1611389-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213094338.1611389-1-catalin.popescu@leica-geosystems.com>

On Thu, Feb 13, 2025 at 10:43:36AM +0100, Catalin Popescu wrote:
> Microchip hub USB2514 has one 3V3 digital power supply and one 3V3
> analog power supply. Add support for analog power supply vdda.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
> v3:
> - replace "if then else" by "if not then"
> 
> v2:
> - merge "if" with "allOf" and move the whole after patternProperties
>   section
> ---
>  .../bindings/usb/microchip,usb2514.yaml       | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


