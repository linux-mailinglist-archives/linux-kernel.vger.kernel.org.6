Return-Path: <linux-kernel+bounces-444536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908099F0883
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9A282BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD911B4131;
	Fri, 13 Dec 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpU82KBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837A1AB52F;
	Fri, 13 Dec 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083530; cv=none; b=IiWBwRRa7UoRV+BIwGBqFYjgemosaREE8H3JzgHulFEaiAjS1QFD8oaBf2M0YN8q5eIQjsNgyLI5M8+p2bfoZC137XsqxpjwshPZc6fyxaPXTraZHzeyqfVAM1pQFuCV39T8ao34rdjrzGrgbQVTTFQUIC9uGpqCMNJTVwVGvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083530; c=relaxed/simple;
	bh=BU/J16Ct4CwkI88Ev0nVluHMhJ7hjnowLd7wIxggf4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMMArTZijUL45PW2yf/a12UNdzPEYgAS5w3Tvs+eM6UKaO9e8mjNbgoEy1UKWJm22M2cV17NHQqtXjPH6Y3mAt/2jRSfLsllQjD4uaFybD9vSY2iOY0cvedOyvw1Kfq7MDIRp8HZ25JSKv3Ear2nG/iavum5SBF2GVvbdI7xjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpU82KBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2FEC4CED0;
	Fri, 13 Dec 2024 09:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734083530;
	bh=BU/J16Ct4CwkI88Ev0nVluHMhJ7hjnowLd7wIxggf4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpU82KBfxjjRWfMsNAY4DdgnA0/pQPGsdZG4rPLMTh4hEb4kOXYKKqj3b+4MOg78/
	 tRu+VhuRVOHuFerRLkA2FNKGrxRonw0Yt/+sJvxQ1PrgSE5efYjfU2mOlmszQ5sZ3M
	 ehjWxCiJlhCx2H/ycld1AGF/50FBD3YWNYoe77GrnEjUKWudhI2UFKb7qBklwN817l
	 d0CzhlbjGta7d67iylDTQ3qHs2UsAqJ4VElcZFCgFXKvjEe7uSXB6za3vclhDTIWq2
	 qwAFMBTfXCjwLcExb5lDXuXKOFQAORlytg9s3z8c5nGQEICnxQlzcHA0KjBop0Stwd
	 EvNWACQj9X6Ig==
Date: Fri, 13 Dec 2024 10:52:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Andy Yan <andyshrk@163.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: Add Raydium RM67200
Message-ID: <7uoc7higbx772dabs6k5zvrvgfmp2otai3bz2z62wnpv6pfa5s@jpe45f3qzyu2>
References: <20241210164333.121253-1-sebastian.reichel@collabora.com>
 <20241210164333.121253-2-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210164333.121253-2-sebastian.reichel@collabora.com>

On Tue, Dec 10, 2024 at 05:41:30PM +0100, Sebastian Reichel wrote:
> The Rockchip W552793DBA-V10 display/touchscreen board contains a
> Wanchanglong W552793BAA panel, which in turn is using a Raydium
> RM67200 MIPI-DSI controller. Add a DT binding for the DSI panel.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../display/panel/raydium,rm67200.yaml        | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
> new file mode 100644
> index 000000000000..d0a6d3207811
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/raydium,rm67200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raydium RM67200 based MIPI-DSI panels
> +
> +maintainers:
> +  - Sebastian Reichel <sebastian.reichel@collabora.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - wanchanglong,w552793baa
> +      - const: raydium,rm67200
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: 2.8V Logic voltage
> +
> +  iovcc-supply:
> +    description: 1.8V IO voltage
> +
> +  vsp-supply:
> +    description: positive 5.5V voltage
> +
> +  vsn-supply:
> +    description: negative 5.5V voltage
> +
> +  backlight: true
> +  port: true
> +  reset-gpios: true
> +
> +additionalProperties: false

This goes after required: field, as expressed in example-schema.

With this change:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


