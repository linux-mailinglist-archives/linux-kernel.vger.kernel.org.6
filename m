Return-Path: <linux-kernel+bounces-383175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1809B1814
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F322B282D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFA31D5CC4;
	Sat, 26 Oct 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M966C2s3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC536217F47;
	Sat, 26 Oct 2024 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945771; cv=none; b=WLz5axU8RiSVYJphE/wjJfVuz4QZKzYe0+tL6puHOJAvk7cIj7y+V6PT07jOBk1TBm9s+K8pArdPFoLh0eg25pK/i9wRsL9A+bMu8YVIKIBVL3KS+zU0h36brc9m+A1Yrd9CAVCHkpQFx6B0PNxJh2YkhebUkkJaJ2Ai/r0es1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945771; c=relaxed/simple;
	bh=VClkAG3c65E/gr35A/dNFa0Wc2zsZ7kJuGAtv35fRzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0l1ay7fkVu1DnsPFUq+33MTrAH5++eb5q4u30xMl8VOmkACzyfG56QYknDSeEqVSKRKgFzkbneOX5oD1isiSIHRMJ5+T+aqHQy2tAYLWvQgfN0XcjDdOeYoSXmq1Y4c905kqyvLAgqe2+8VtL252jeu8+BOOhwTenJvhELtSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M966C2s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E8BC4CEC6;
	Sat, 26 Oct 2024 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945771;
	bh=VClkAG3c65E/gr35A/dNFa0Wc2zsZ7kJuGAtv35fRzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M966C2s38U2mEEPkXjC/f2JaVJaQHs+2nFHVy2lZ9GlIea9bDTn7rOzCzW67KPUBH
	 H2emhzV1Jj6of1DgHx/1z6kgQwfxE9nWHbmIDsSHL4IZgr6EOkF2kC/1cLGpp0dXmP
	 QBXHTB5xc1nvyjuvc07Yd2q3lmdATdcGr0WeuR6UJMEtNbdUjHM1BgDuxkX2qL+vst
	 dJzp/k3CLwJaexhZs9UP3KS0I8KRu+nxVx1Kyhr0Q7bgHdWt0nwU9VxKQjlItVK7Hy
	 ESw6W6lEb0B5tsVpO49KeaCF0vKpGX2ES94YJl9kT+seVwjBcWerqeb3u6XDl6XwSg
	 w6zGpb13afOhw==
Date: Sat, 26 Oct 2024 14:29:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	Neil Armstrong <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: add YAML schema for
 LXD M9189A
Message-ID: <m2jrr3stleuals5iadxn6yu5j77wxufavvdqo3e7244ckefrk5@kbvo6fbsref2>
References: <20241025141130.3179166-1-r.czerwinski@pengutronix.de>
 <20241025141130.3179166-2-r.czerwinski@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025141130.3179166-2-r.czerwinski@pengutronix.de>

On Fri, Oct 25, 2024 at 04:11:28PM +0200, Rouven Czerwinski wrote:

A nit, subject: drop second/last, redundant "YAML schema for". The
"dt-bindings" prefix is already stating that these are bindings in
schema and YAML.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> +++ b/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lxd,m9189a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LXD M9189A DSI Display Panel
> +
> +maintainers:
> +  - Rouven Czerwinski <r.czerwinski@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    const: lxd,m9189a
> +
> +  reg:
> +    maxItems: 1
> +
> +  standby-gpios:
> +    description: GPIO used for the standby pin
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO used for the reset pin
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Power regulator
> +
> +  backlight:
> +    description: Backlight used by the panel
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  port: true

This misses it's definition. You should reference proper panel schema in
top-level.

Best regards,
Krzysztof


