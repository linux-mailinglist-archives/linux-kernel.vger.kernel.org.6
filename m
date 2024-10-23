Return-Path: <linux-kernel+bounces-377522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894569ABFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2C5B2558A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4971547E9;
	Wed, 23 Oct 2024 07:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFpJiThV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9463487BE;
	Wed, 23 Oct 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667806; cv=none; b=dSsxEKG+viXzx22Ksp28KU5YczHpBFQTHp/0UspcSsAK7/lv0oxTYbrObAMkn6q/YGtox6hrVelhrmIFs9o9XlQP5KZQqjGeiZmPgWO1tGJaDpjAcGeP2dmMg6pSEEqC+zG8vhUF8HrnVK31WL1XLSWqr9Ap2KLdwrP0JbJ3ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667806; c=relaxed/simple;
	bh=DCuXBhNSmpJbKPA1H6hyuILhm8VSuGuorecsJgBpq6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBXYNE5x0Zm3Q+oXM6DZa73o2ZX9+FidpDhHt5AiGGAPNsF/uV4dEDIqI24wDG+wDEL6tjlPYseBM6m1jXihT8qjcPBU+PDpmF1M4DaB9c/K//PSm75+/wlMJwNrS6Oh+scbxbXwfLPU8FjP8LgIOh3coklTjdbHaiPSe6lshOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFpJiThV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2659CC4CEC6;
	Wed, 23 Oct 2024 07:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729667805;
	bh=DCuXBhNSmpJbKPA1H6hyuILhm8VSuGuorecsJgBpq6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFpJiThVkih+4uWPi5B0JyYxg7/P2O523Ym6MKGoWnHZcyFwZkrDNXsOtr755HX2w
	 Fe0NNH/BkyVjlAvgHhjy7xdP7+0O+Rit+wxkF/NvuT0eCOgy7U9V9GNlSmZnQ3Uu9p
	 /aEJZ0qhkl1NoX6pmdpkwTJJSqAs6LD5W0hMR3+ubGCmCC1ZNoe3L3q2mTGvqEs/t0
	 d/o16iZUlBqHkj9VOIwnkBkdNVhVV04LeUd6TrEG/ZsyhCj1VqowV6M4w1UeQbiHii
	 DjkuHzQGBpqItkFCQfPrtgEN4GAXfKX+RAyRmt5HHnQ0XdI0JnK0RDU9+6dxuxFlLx
	 tm/4/g8i9D/tw==
Date: Wed, 23 Oct 2024 09:16:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/5] dt-bindings: display: panel: Add Samsung
 S6E88A0-AMS427AP24 bindings
Message-ID: <yvuur7pa2msafmh4my4ojtrlir3nenvyqqr2fbb5jt2bevlbm4@iqh5iokm3knx>
References: <cover.1729630039.git.jahau@rocketmail.com>
 <25370285451d9c22204dfbaa368d48c22efd1eef.1729630039.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25370285451d9c22204dfbaa368d48c22efd1eef.1729630039.git.jahau@rocketmail.com>

On Tue, Oct 22, 2024 at 11:33:36PM +0200, Jakob Hauser wrote:
> Add bindings for Samsung AMS427AP24 panel with S6E88A0 controller.
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> Patch is based on current branch drm-misc-next.
> 
> Changes in v2:
>  - Adapted property "flip-horizontal" to being moved to "panel-common.yaml".
> ---
>  .../panel/samsung,s6e88a0-ams427ap24.yaml     | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
> 


A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +            #address-cells = <1>;
> +            #size-cells = <0>;

Use 4 spaces for example indentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


