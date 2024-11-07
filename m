Return-Path: <linux-kernel+bounces-399647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086659C0251
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CD91C212E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CE1E9083;
	Thu,  7 Nov 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Depln833"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA91EBA1B;
	Thu,  7 Nov 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975240; cv=none; b=uDmDy1LZWQQKjOuyVWPzTjsGnYu2GKtTINeb7UvdjTNukiiu+htzpa+ViBTnq56GtzlfLxmuCzBfmLAaPrirIVEpLoepivZ97XR871jzc5Thnoy+W4o/2O0XfUEMmMeRdBLbmkqs8Zb0JN/CftK5oRjHTjOvJDR/5uuv5+INrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975240; c=relaxed/simple;
	bh=En01lEFzgOPGQXLGM59354SFtFYp8jJ+HyqefB6L7B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAGtyQ9Yzjp/ti2M1oSsjfvHNazlgSaCYvS+3C7mrsHBi8kbVdrfKQ/Okfq6Okylpm8DD7PeGiWGagNGyuQ3Fz4YXV8EDbT5JL0A9tXtd9BUGt2fBH4hSthc/RWA3VN0ykGL0nDUwIDDqPZ/jsrPR4zYbANolvh6eEIojFnmKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Depln833; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA31EC4CECC;
	Thu,  7 Nov 2024 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730975239;
	bh=En01lEFzgOPGQXLGM59354SFtFYp8jJ+HyqefB6L7B0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Depln833HUhQdWj9mbw7EYMsxsRGv2PNoy+lUZeWyuRLxx0wfT8A4KxsOh6/D0pjm
	 zmfZhbqIZgxZvnnFkc5xsx+gfu8+yLISkeWawf/I6ZOdgiiqI45TWBM6IrB70TcDJx
	 CIpo9I3A8xm/fEorK2F1kxHvCmBr33eSjqiN+5RvtiEmo2BmdTafi4svI/CV4IjWZS
	 kNTNomDUQZ8gsebRCoKCgC+j5RXvvQ5aWCjQ44Cs3ELTFBbFg5VvFoWiLZbBuARtuz
	 FsvFYSWyxDq5PKqDW/ono8JE818OcmG99A6wL+9xEZ+3DtsxmEX60tCRbgEi7oF/88
	 zlYolXFD+nOHA==
Date: Thu, 7 Nov 2024 11:27:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, frank.li@nxp.com, 
	pankaj.gupta@nxp.com, daniel.baluta@nxp.com, silvano.dininno@nxp.com, V.Sethi@nxp.com, 
	meenakshi.aggarwal@nxp.com
Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: imx: add nvmem phandle
Message-ID: <tot4nynjw7mjvb34jxkjdcdvumhxmkhrjucle3dgcqionbjaqr@mqeo3rcj2b4o>
References: <20241107-secvio-v3-0-ea27f1e9ced4@nxp.com>
 <20241107-secvio-v3-1-ea27f1e9ced4@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107-secvio-v3-1-ea27f1e9ced4@nxp.com>

On Thu, Nov 07, 2024 at 06:42:39AM +0100, Vabhav Sharma wrote:
> nvmem phandle is required by secvio driver to
> read fuse.
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> index 557e524786c2..1cc86fed6c27 100644
> --- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> @@ -112,6 +112,9 @@ properties:
>            - const: rx2
>            - const: rx3
>            - const: gip3

Missing blank line

> +  nvmem:
> +    description:
> +      phandle of NVMEM driver provided by the SCU

driver? Please describe hardware, not driver. I think I gave you such
comment last time.

Best regards,
Krzysztof


