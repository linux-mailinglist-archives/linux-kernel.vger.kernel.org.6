Return-Path: <linux-kernel+bounces-392870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E4E9B9911
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6D51F22E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF31D365A;
	Fri,  1 Nov 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr8Wufq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB81D0B8B;
	Fri,  1 Nov 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490944; cv=none; b=QPBc6Ve7uK/+sdXJdYhrqYL2WEbgfxQ30ncsH0TZ0P98OVTc+n64soQQQRGX0ZhnZHzRZ3omTBwa1Zf0E7ZCoc58gf2Vi0pk34QsYLPMEnO1FGpxB2n8GqzkNmV5kfO/CxY9xn1EA2rTQMByhEK60a49D2735Y4SvSCqaXwZpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490944; c=relaxed/simple;
	bh=5P1Ty7aGq24JHAxPk7/IiX2eHffnbz10gXZws+6PBo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICETDSbpCB0jl9Foj+W3G+WQu9bHSPKjlt6o+HETw+tpCgwwNTxzaY2rqAzys1fPGdO6poeleCMA9rSTzNqIp0+DIoha8TA/4kvN+VKWbjkZzUmrNnr1/8NRHZAgy6vAoFZ54vXPyA9KAsD5+52JUUpo9M6Tx0G4+ktN9hwyTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr8Wufq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED113C4CECE;
	Fri,  1 Nov 2024 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490944;
	bh=5P1Ty7aGq24JHAxPk7/IiX2eHffnbz10gXZws+6PBo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xr8Wufq9qLFkuNMXElQveX2JfrYDAi/0glxdgmrAxKVJSVGxKN/ADWrRQibXHNYEy
	 a5zzKFOlGLC7UWbHK1wF6PooQ80w7cMoDxJtHL7gCB8v7z313p1J26BwU5ljGpnoZv
	 SpdaZzVqSFrNhUzyt8HpbvGYsu/rqHeItiPX/mXcZT0KqMMotvAMLwr0PFksqnCexz
	 hSpZVojpbQdo7eFVr9yx9pZZDOPmn+ngftf88iEZ/iARr5RO5YnKTvceSp58NzJ7F0
	 X6p0YgfPH2QPcf1kG64ra5DeZhxqRlP3qukaCsdiOkuSG7Jr+CINobrzjA6SauoVnC
	 +eJb8R+AN4cLQ==
Date: Fri, 1 Nov 2024 14:55:42 -0500
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 resend] dt-bindings: firmware: imx95-scmi: Allow
 linux,code for protocol@81
Message-ID: <20241101195542.GA4090248-robh@kernel.org>
References: <20241030095555.222143-1-alexander.stein@ew.tq-group.com>
 <20241030095555.222143-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030095555.222143-2-alexander.stein@ew.tq-group.com>

On Wed, Oct 30, 2024 at 10:55:52AM +0100, Alexander Stein wrote:
> BBM protocol supports a single power button, supported by driver
> imx-sm-bbm-key.c. By default this is KEY_POWER, but can also be overwritten
> using linux,code. Add a reference to this schema and add linux,code as a
> supported property.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Admittedly, I'm not sure if this is the correct way of referencing the
> linux,code from input.yaml.
> 
>  .../devicetree/bindings/firmware/nxp,imx95-scmi.yaml     | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> index 1a95010a546b1..112c3a3eb1980 100644
> --- a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi.yaml
> @@ -12,13 +12,18 @@ maintainers:
>  
>  properties:
>    protocol@81:
> -    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
> -    unevaluatedProperties: false
> +    type: object
> +    allOf:
> +      - $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
> +      - $ref: /schemas/input/input.yaml#
> +    additionalProperties: false
>  
>      properties:
>        reg:
>          const: 0x81
>  
> +      linux,code: true

default: ??

> +
>    protocol@84:
>      $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
>      unevaluatedProperties: false
> -- 
> 2.34.1
> 

