Return-Path: <linux-kernel+bounces-529985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC1A42D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF01889977
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B852040BD;
	Mon, 24 Feb 2025 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qreTVj6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CE3B2A0;
	Mon, 24 Feb 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427429; cv=none; b=hgrnAFg+LoC2wfqcPEdmjlblHo+37J2vMZimTTmCmwNWT/PeuHh2IhQAtM0TZDfkGxTiDC5hUl5Zmifd5fbgfS54bNj+iHHd6j8F8h/KbZ7IlT2KiVvexTNrIZaXY3ZS8v3paTtOBd2ZJDBekr6dO9WkhqQjQvPpKBFXucVchMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427429; c=relaxed/simple;
	bh=q+d7nm16qN8obUZdl22kTIu5V70Mi/RYYzCCy6bqBeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMlHCbpZUmid/Q4WT4BKniUpFj5MZ3EsOqIGxEVuR5Wfg7Pkf2euNlLFG3GomIWukMulUwbJlEooBXKUBYRkBaEgLV7jqNPxuklUpydShU6hmG31+cdJPOE7y7XwyxHvVn7eXkGLW8pXcMyX5B84GAUH8ZvEEiwSXSxFLMNi0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qreTVj6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD12C4CED6;
	Mon, 24 Feb 2025 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427429;
	bh=q+d7nm16qN8obUZdl22kTIu5V70Mi/RYYzCCy6bqBeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qreTVj6NyKUm6lrRKJbd3QXAxIqqOAJWW8G16C5zFxWhZCQDN1BM6OAGYPLK8+CyZ
	 1FRGrGG5N7qqtX5xzjmsQYb8/ojIngs7HVgz2F6fXoXPi0coG24ncjg578qVp1tL6V
	 CTsoZeST5a0x5h1xMyu0fuWWkWEkOVvIpp9G9PaHC2W3yNb8M4ibhsIUNMKB5dojV4
	 kmpAIrzQk1gIPOzxo1dJ7Pkv4QD1dpfdlV/bNRrqNEEHL5Kd+g3HFabCw85n+SVN0q
	 sIX/kHXEUh1r4I/KgO/yF9HVqbfplwRbkd+TsnyVKxb+IupTJ0hZjpXP1SlA2uRG7l
	 pefph794JXEvA==
Date: Mon, 24 Feb 2025 14:03:47 -0600
From: Rob Herring <robh@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org,
	cristian.ciocaltea@collabora.com, neil.armstrong@linaro.org,
	yubing.zhang@rock-chips.com, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH 1/6] dt-bindings: display: rockchip: Add schema for
 RK3588 DPTX Controller
Message-ID: <20250224200347.GA4011821-robh@kernel.org>
References: <20250223113036.74252-1-andyshrk@163.com>
 <20250223113036.74252-2-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250223113036.74252-2-andyshrk@163.com>

On Sun, Feb 23, 2025 at 07:30:24PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The Rockchip RK3588 SoC integrates the Synopsys DesignWare DPTX
> controller. And this DPTX controller need share a USBDP PHY with
> the USB 3.0 OTG controller during operation.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
>  .../display/rockchip/rockchip,dw-dp.yaml      | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
> new file mode 100644
> index 000000000000..b48af8c3e68b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-dp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip DW DisplayPort Transmitter
> +
> +maintainers:
> +  - Andy Yan <andy.yan@rock-chips.com>
> +
> +description: |
> +  The Rockchip RK3588 SoC integrates the Synopsys DesignWare DPTX controller
> +  which is compliant with the DisplayPort Specification Version 1.4 with the
> +  following features:
> +
> +  * DisplayPort 1.4a
> +  * Main Link: 1/2/4 lanes
> +  * Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
> +  * AUX channel 1Mbps
> +  * Single Stream Transport(SST)
> +  * Multistream Transport (MST)
> +  *Type-C support (alternate mode)

???   ^

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

