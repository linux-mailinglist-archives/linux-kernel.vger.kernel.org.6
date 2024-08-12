Return-Path: <linux-kernel+bounces-283475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF994F564
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251781C20FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFC9189B9A;
	Mon, 12 Aug 2024 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3iWuxEk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838B187FFD;
	Mon, 12 Aug 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481721; cv=none; b=PLZZCIYg5+7DFPAaDDwdKu/Tt8MDw13Ok2ov8StIuJDPWguqA9fWWE0xsE7vYrmqPgAWJ7RWskJxnqfqqrhomHnbnMOBCgCScFIqQrCPQ5jBMIY2ssOEZofmcqurVAh3W6XcbjlWvQ5Gd/lUV6cFs3oa7XW8z7b2zJEX4vNr9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481721; c=relaxed/simple;
	bh=Vb2XtNRntq4/BfBGg/dDnr4sqyICgaky81/gFEhOMkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQflL+WCgIGLo0Y/oPCyHRN4yv5vwBi70bo3YkOSBNgra5KldkLbHrlSOsmFpldnGfRGY1pyLkeQOdLz6B1uRGmAKQvXumkI4061yKvrT0A5vf9cnohpN+kfD7Ef3MTajfgix5etiUs+/YIgwhuNkEatvH0yw7oH9peL6rP9YUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3iWuxEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB85C32782;
	Mon, 12 Aug 2024 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481721;
	bh=Vb2XtNRntq4/BfBGg/dDnr4sqyICgaky81/gFEhOMkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U3iWuxEkDmoLexaYQLRUxJslOKdQWcV3/VKx7OcEIEXDd+rUepBmMsmztAuFpC+VK
	 V8bncF191dnbAwu8lk+gL1zzjOsr0IuCAP3DTWhVhLNavUNI0WYMa9M8u3gnTSahR1
	 ZMRx4q2Yn6fy4q+gZCn92wlF2iEmIAjUqsc6qk0d7WFg82KCRVKbCOGFK/vxTHpOjV
	 DA6GEhO5Qol/QKrwvDwTm64UKbfIjtO5zLE3WwEhEYgy3wKjKEYQJkuCXxK2LezX3C
	 neHZTNL8jJMD+ruJJesWflZ35TnyDzj2bUUDDn+qGAwvSdZXbIdJAnRSeae9E17e6p
	 lk3PAQS4bjK9Q==
Date: Mon, 12 Aug 2024 10:55:19 -0600
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, arm-scmi@vger.kernel.org,
	james.quinlan@broadcom.com, justin.chen@broadcom.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/2] dt-bindings: sram: Document reg-io-width property
Message-ID: <20240812165519.GA1260568-robh@kernel.org>
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
 <20240810214621.14417-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810214621.14417-2-florian.fainelli@broadcom.com>

On Sat, Aug 10, 2024 at 02:46:20PM -0700, Florian Fainelli wrote:
> Some SRAMs need to be accessed with a specific access width, define
> the 'reg-io-width' property specifying such access sizes.

IMO, those SRAMs should have a specific compatible. That restriction 
makes them less usable.

OTOH, it is a standard property. Shrug.

> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/sram/sram.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> index 0922d1f71ba8..18e42fb36846 100644
> --- a/Documentation/devicetree/bindings/sram/sram.yaml
> +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> @@ -101,6 +101,12 @@ patternProperties:
>            IO mem address range, relative to the SRAM range.
>          maxItems: 1
>  
> +      reg-io-width:
> +        description:
> +          The size (in bytse) of the IO accesses that should be performed on the
> +          SRAM.
> +        enum: [1, 2, 4, 8]
> +
>        pool:
>          description:
>            Indicates that the particular reserved SRAM area is addressable
> -- 
> 2.25.1
> 

