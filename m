Return-Path: <linux-kernel+bounces-304370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26CB961F19
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D18F1F24CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6751553B3;
	Wed, 28 Aug 2024 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stgk8XDC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2944154BEB;
	Wed, 28 Aug 2024 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825437; cv=none; b=V0fSLoJe56CQFwTX9L/JVg+Y7Uz//xKLOaWW9odQ6hfcwM2Rbhs/0HIPb7m/I+0Jx8l9ady6iduT3w8dOTMRvbPhHL+i1mYhX1qL8ebk1UlyxphDIJBP4ytXkiLne4xwA1SaL+wwwWu2EnHy2FfrVJq7sgz7pmnansIkFoXnlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825437; c=relaxed/simple;
	bh=xHoDsiwlXv3u19OOqWpN2NWa+iTlBrIoUnqU28yV7xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwiYR06e/LerSnJ73dsY5fKZ2aQQDW1GzqvRqJsDd7gcngsvK/7HNm9Rjlc3P5xJIooyGaruuwOR4xiaZn4XKHJuCM5ZIvtAetFzO7tTqgKZq3XTfwymHe/luaTB71WAX2WMmPKzRZg+8Ct0IAvkXB5t+vGuRQFHh4X8mJdi44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stgk8XDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E723C32786;
	Wed, 28 Aug 2024 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825436;
	bh=xHoDsiwlXv3u19OOqWpN2NWa+iTlBrIoUnqU28yV7xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stgk8XDC8B3SIoQUIRzqQivCuuwFpcl68pY9bPTe/SgOVpcTpfYB8jbe1pqLIvMDi
	 if5KzQoNibL3hdhyk3lYr84lfkLAtPNBm5KUfWUbKGOWcsl0FMdDQct/np61Qzh+VH
	 fZZzGk45HNm/2nBKCfh4gbBzOUOjTziqqV821Fcx/2j2mzS0WQjAYvX2EQvCY8RMXR
	 3AGvhXzqIMXHkeWp1rbUJU/WyN2oPe8IoDtjBEtkcJ/z+ZX8WK3Wq4JtBkASnYCt0o
	 nBKqq3hhWqynJVigmti6Uwe0nzYcQLd0jk0o0oFcQotYlTG5mbZrLHoKgBRgjMrRza
	 DnLLAmeJZt/Rw==
Date: Wed, 28 Aug 2024 08:10:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: misc: fsl,qoriq-mc: remove ref for
 msi-parent
Message-ID: <gpq556m4k4x5qfnnoxgazjvqc4pxcsexnlq6quakfezuup3w2k@waz2swdiwigd>
References: <20240827180028.1009902-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827180028.1009902-1-Frank.Li@nxp.com>

On Tue, Aug 27, 2024 at 02:00:25PM -0400, Frank Li wrote:
> msi-parent is standard property. Needn't ref to phandle.
> Fix below warning:
>   arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: fsl-mc@80c000000: msi-parent:0: [16, 0] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
> index 01b00d89a9921..8c64e2f7bc3c3 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
> @@ -113,7 +113,6 @@ properties:
>  
>    msi-parent:
>      deprecated: true
> -    $ref: /schemas/types.yaml#/definitions/phandle

Instead:
maxItems: 1

... or anything else with proper explanation in commit msg.

Best regards,
Krzysztof


