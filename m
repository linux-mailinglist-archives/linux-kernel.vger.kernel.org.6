Return-Path: <linux-kernel+bounces-375065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9589A906F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2839D1C22C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFBC1D0E1F;
	Mon, 21 Oct 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc8jiIGq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A631C7B68;
	Mon, 21 Oct 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540699; cv=none; b=IL+/8w5SKcX4xp4VV7vd/wxYR/Zb6/BWhZlujVGLs5igkZExq949+kmg8Plc+z9+cI/MPhzYfKHL8O82YHGCpPNA03EAaE7maSMsNFiXdzTy0HNexSskCz0ozCDKPV8WmW/7v2hg9JY36adAlVT3aQTeDDz85DbG3jjAMLtcKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540699; c=relaxed/simple;
	bh=lXIBaUAgVxYKmWP0jHTA9ghGsdQnCx4CIkRiLLtakKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnIy839v9TR2JPKH7IVQZDn22HIpn/mfYAT9zKA5zqpC4oHNYV2G85q4os9HZqp1h3jZKQbjqb3nLetFhFY7DM5WHBz85zN4H2YwuzVnyJZJIm0qPzPDYG1JFml4KW9w8FsyHJ+51sk7Oz0OwJ7LsRHGysPl5+u9ahIfB62iN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc8jiIGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF228C4CEC3;
	Mon, 21 Oct 2024 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729540699;
	bh=lXIBaUAgVxYKmWP0jHTA9ghGsdQnCx4CIkRiLLtakKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cc8jiIGqUGfG6tK0tstHmXnSsMy29ps0WLKmuuYhd2N+aOD9//6aXxvLwFkXqGfSc
	 KKGJpAIrrOnvUMTqIMXIAlPcZcklAYCl0vGfjI22WxRmKwEcyQpbVWO7qmWKkJ1B79
	 cUTNvgQPmHnspB/hWZFBzvXqhm8Xbz+rsQivQysIQDjoEOQssntdfo/Bw1wjcx3Gaa
	 P6ATBdx+Rw5unPqqT51Alc2ograXjg0+5hflByIjibpjWzyNggcDpp6r1qVZOQfhec
	 wkO1/GC4KCijghMXyHbNUO+Oo7UoEeVdYREqcvDpiXpQreCU/FKBoPm7l+2xWrczin
	 KrFZ29+/j7Nvw==
Date: Mon, 21 Oct 2024 14:58:17 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v9 1/4] dt-bindings: display: Add powertip,st7272 as DT
 Schema description
Message-ID: <20241021195817.GA1028343-robh@kernel.org>
References: <20241021100224.116129-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021100224.116129-1-lukma@denx.de>

On Mon, Oct 21, 2024 at 12:02:21PM +0200, Lukasz Majewski wrote:
> This patch provides the DT Schema description of powertip,st7272 320 x
> 240 LCD display.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> 
> Changes for v9:
> - New patch
> ---
>  .../display/panel/powertip,st7272.yaml        | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
> new file mode 100644
> index 000000000000..f09450da44a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/powertip,st7272.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/powertip,st7272.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Powertip Electronic Technology Co."320 x 240 LCD panel"

If there's another version, drop the quotes.

Reviewed-by: Rob Herring <robh@kernel.org>

