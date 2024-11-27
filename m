Return-Path: <linux-kernel+bounces-423623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38D9DAA98
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB4E167A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD01FF7C9;
	Wed, 27 Nov 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geo9siy/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA753C488;
	Wed, 27 Nov 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720593; cv=none; b=imr60zZh1YMGbzSBsbrrw/XoaaUSB/GV7yAy2h8QnPI63TI7nPVoSGwngelpFrpYLkqh5YVbbvCNMN+KC3EIw+eauPv6KAghkO5zn5GJ1lPh7yssGPcCic+4UQz4LO8NBLomE8NJEiUZvcsQqYs7y8t8kFu6q+rkfMv7L5ukcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720593; c=relaxed/simple;
	bh=73uSU84WC159XIEa9x/EDBuom42dzuqTcTszbM/yk0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku6GVR4Y+D0whthvH/C23iLqas7++uQcd39iHH9osg1cKeLt2bSfW7TkwLisGgPz8Mk4vq6FBjfYXzydXibroJtkXGokbV55f3KJlpLXEGO4RqrzmevDix9IHI/UYWwKCZQ+vw9pFoQqwGeu/wEvmmXenvVdKk9CETs/YYUbJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geo9siy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B01C4CED2;
	Wed, 27 Nov 2024 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732720592;
	bh=73uSU84WC159XIEa9x/EDBuom42dzuqTcTszbM/yk0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geo9siy/nYm1+nZ7+jxEfER0rrXEjzKbIryvpQmVcu/R9vrmoZ5I4CvT/NFNbajdm
	 8Mq8gKeYC8ptnH79jDB6rM4pcJS0aSSHg+IYdu6fl4+4XA3tGCYxYThGGUbvKqvvph
	 +gYT2sHHKwOLDuIc38gwd8Zd0sf86KLO8FQYBxCCCA43kDko9zgvs8xfqysxL27g8n
	 7ysDVIg6GGCg6C3oWyxW7AwI96XAr7d1AMDFpix2LPJYxIHxg58pjPrie8/H93fG8Z
	 EF1iiC+u7jv+PrECbwAdWe6VVxoV2SJWJ0JFIdoJH0N/3ll99sa4E6xTkd+79LNUIe
	 7/d2z3hBqE5cQ==
Date: Wed, 27 Nov 2024 09:16:30 -0600
From: Rob Herring <robh@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, marex@denx.de, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: drm/bridge: ti-sn65dsi83: Add optional
 property ti,lvds-vcom
Message-ID: <20241127151630.GA3515396-robh@kernel.org>
References: <20241127103031.1007893-1-andrej.picej@norik.com>
 <20241127103031.1007893-2-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127103031.1007893-2-andrej.picej@norik.com>

On Wed, Nov 27, 2024 at 11:30:29AM +0100, Andrej Picej wrote:
> From: Janine Hagemann <j.hagemann@phytec.de>
> 
> Add an optional property to change LVDS output voltage. This depends on
> the connected display specifications. With this property we directly set
> the LVDS_VCOM (0x19) register.
> Better register property mapping would be quite tricky. Please check
> bridge's datasheet for details on how register values set the LVDS
> data lines and LVDS clock output voltage.
> 
> Signed-off-by: Janine Hagemann <j.hagemann@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>  .../bindings/display/bridge/ti,sn65dsi83.yaml      | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> index 48a97bb3e2e0..5b2c0c281824 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> @@ -58,6 +58,12 @@ properties:
>                    - const: 2
>                    - const: 3
>                    - const: 4
> +              ti,lvds-vcom:
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                description: LVDS output voltage configuration. This defines
> +                  LVDS_VCOM (0x19) register value. Check bridge's datasheet for
> +                  details on how register values set the LVDS data lines and
> +                  LVDS clock output voltage.

Constraints? 0 - 2^32 are all valid values?

>  
>        port@1:
>          $ref: /schemas/graph.yaml#/$defs/port-base
> @@ -78,6 +84,12 @@ properties:
>                    - const: 2
>                    - const: 3
>                    - const: 4
> +              ti,lvds-vcom:
> +                $ref: /schemas/types.yaml#/definitions/uint32
> +                description: LVDS output voltage configuration. This defines
> +                  LVDS_VCOM (0x19) register value. Check bridge's datasheet for
> +                  details on how register values set the LVDS data lines and
> +                  LVDS clock output voltage.

Never good to just have 2 copies of the same thing. Move the whole port 
schema to a $defs entry and add the property there. Then just $ref it:

  port@0:
    description: Video port for MIPI DSI Channel-A input
    $ref: '#/$defs/dsi-port'


$defs:
  dsi-port:
    $ref: /schemas/graph.yaml#/$defs/port-base
    unevaluatedProperties: false
    description: Video port for MIPI DSI inputs

    properties:
      endpoint:
        $ref: /schemas/media/video-interfaces.yaml#
        unevaluatedProperties: false

        properties:
          data-lanes:
            description: array of physical DSI data lane indexes.
            minItems: 1
            items:
              - const: 1
              - const: 2
              - const: 3
              - const: 4


