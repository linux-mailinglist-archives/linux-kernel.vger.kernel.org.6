Return-Path: <linux-kernel+bounces-373750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0C9A5C09
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3792D28285D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1CD1D0E3F;
	Mon, 21 Oct 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfzXrX/Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813B1CF5FF;
	Mon, 21 Oct 2024 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494301; cv=none; b=BA7l9dOKbRvE5QhAqR0gT9zb2IvqIr0wS37NbJgsKCUViWK2nOdtxpNyxf4oNQ0IVwDvaT12i4FkxrTrOzTJ059dJS2gP5b6LqeR3MANWtSQct9zpIwWlsRJe8cxieHWwztFqojvZ9UW51drdp5Banbch9vwOBii9eKuN9LEmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494301; c=relaxed/simple;
	bh=t7yRMIhncxD5+5ivHnFBGTUt+ZsgxuwNNequQzRbrtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6X94IM+Sy9MQ3fYz986UeQaHNUFHsaDRKB1rRAIJsD2amtGKSpF1838CALcXLJZkQyBnMR+x7SEKr0m49VzL6QfQ0zXMbzZOxplUPnHWGSLJW7b9eKyUnFrvyIHg0Dy3LLD6jMNDrivl43r7Z1cifHKwxPapDqCMW5h6scVL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfzXrX/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F80BC4CEC3;
	Mon, 21 Oct 2024 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729494301;
	bh=t7yRMIhncxD5+5ivHnFBGTUt+ZsgxuwNNequQzRbrtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfzXrX/Z+cw97e+fLs8l1tNAQCvh0xIWYOK5AKUqfDJ1nNej49QvPdsUJ+lPehF7W
	 qaOeCrr796lW2GnD5x2KCORVhDDyR5dGdi7IA75JZMtVz3wfLnHiQOPI7zkl4bo2sG
	 AJT6mNX1aMcaiCoUk5pprDs+ORw/k/xa6hF4kJ9k5i67scbQUy7jxlFyJj2ZAy7vSK
	 538kdG2LSvNX5ypjXdjKRezjfhuvDOVvhJSROOFIOL7o+a7qJLeP+pwsGrnA2FjMwp
	 m/U/wAJY5iG8sBIDHBUuAxUEONmJmZwIZFSsoTJxe6tDpwR2E8zOwAhvzJ3U/BGFlw
	 ZT8ib1zh63zag==
Date: Mon, 21 Oct 2024 09:04:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 12/23] ARM: socfpga: dts: add a10 clock binding yaml
Message-ID: <v4gqnsyhqjccdac3kgmo7y2aunigqquqc3f7n7wgt5hiv3rnip@jfmoq3is4rjh>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-13-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020194028.2272371-13-l.rubusch@gmail.com>

On Sun, Oct 20, 2024 at 07:40:17PM +0000, Lothar Rubusch wrote:
> Convert content of the altera socfpga.txt to match clock bindings for
> the Arria10 SoC devicetrees. Currently all altr,* bindings appear as
> error at dtbs_check, since these bindings are only written in .txt
> format.
> 

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../bindings/clock/altr,socfpga-a10.yaml      | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> new file mode 100644
> index 000000000..795826f53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/altr,socfpga-a10.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device Tree Clock bindings for Altera's SoCFPGA platform

This wasn't tested or you have some very, very old dtschema.


> +
> +maintainers:
> +  - TODO

We should not be taking unmaintained stuff.

> +
> +description:
> +  This binding uses the common clock binding[1].
> +
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt

Drop description or describe the hardware.

> +
> +properties:
> +  compatible:
> +    description: |
> +      shall be one of the following
> +        - "altr,socfpga-a10-pll-clock" - for a PLL clock
> +        - "altr,socfpga-a10-perip-clk" - The peripheral clock divided from the
> +            PLL clock.
> +        - "altr,socfpga-a10-gate-clk" - Clocks that directly feed peripherals
> +            and can get gated.

Drop description.

> +    enum:
> +      - altr,socfpga-a10-pll-clock
> +      - altr,socfpga-a10-perip-clk
> +      - altr,socfpga-a10-gate-clk

Why are you adding bindings per clock? Usually that's a no-go, you
should be describing here clock controller unit.

Best regards,
Krzysztof


