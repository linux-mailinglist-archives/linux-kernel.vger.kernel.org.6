Return-Path: <linux-kernel+bounces-396569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391259BCEFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE8FAB219E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274E1D90A5;
	Tue,  5 Nov 2024 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE6oQ7H0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB731D63C4;
	Tue,  5 Nov 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816342; cv=none; b=RPrbSrB1gyCfHMTeUonIBUTZ//FwbQZtrJsABZ2dWS2zsJus5FFm/czx9iKeHuKYcl3TOt3LcdIACI3E2AWsBFUT80LSiNLanudvSkJlM7JXJCjVOMnii+P8LbODUqDMugEV1L9K987tyHw4zK9WVkFjqkuQ2vrgyhlVZmrTmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816342; c=relaxed/simple;
	bh=yDEteXzj+wkANYRbZ2/8j1vE3zjlLibNLSifgq7pYSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEjMABqFTcpgWfXtCl6qzShnyR5PXA2c3egtui6/LgqShYbOjVUhYt2Fn4FekBQWvFf6zVCWqW6klK9ZTk87hYt6A3/oMx0B83i7Mr7UqBlcBD3phGNfXupsrcabiolmI4flEEB+fzD64gGw9OCVxe2Yqa3cvdSXxZgZgmUTudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE6oQ7H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33020C4CECF;
	Tue,  5 Nov 2024 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816342;
	bh=yDEteXzj+wkANYRbZ2/8j1vE3zjlLibNLSifgq7pYSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gE6oQ7H0EUgsS1B6FvmY2KI383i+2h3gtC3TXwM/hyZ0xw/jiwV5FyvyD1m9etQGV
	 3j9AMRtvabcHfLWYJBuk+JdihA33Tklk5w5lY0qIafeZNQeEzk6N5yXLOc0OG1kHO9
	 F++j/XhFppmDr230G6um/9knosDBrT9peFmEsx9HKbJYZ8lsBieNbgUmMDgh+7+nag
	 t9ULd3afMcwLEH44KhOPTfXspCyEqp++CTFLGtkzSX6hkYIlYrav0qz1gjgw0GtlL+
	 CNDV5LKXUJ8a3dkvA6J8dkHD7zmglXr5LkhCz5GIbQtZ9iYdESgzbHTpQd6RoNGAqe
	 Evcp5MLdH8RNg==
Date: Tue, 5 Nov 2024 08:19:00 -0600
From: Rob Herring <robh@kernel.org>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: display: panel: Rename
 rg35xx-plus-panel back to WL-355608-A8
Message-ID: <20241105141900.GA3110982-robh@kernel.org>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
 <20241105055239.1577275-2-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105055239.1577275-2-kikuchan98@gmail.com>

On Tue, Nov 05, 2024 at 02:52:29PM +0900, Hironori KIKUCHI wrote:
> A panel assembly is changed in the recent revision of Anbernic RG35XX
> Plus, so the `anbernic,rg35xx-plus-panel` identifier is neither suitable
> nor unique for the panel anymore.
> 
> Fortunately, the panel can be distinguished by a label printed on the
> FPC cable, so use the label "WL-355608-A8" as an identifier instead.
> 
> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> ---
>  ...rg35xx-plus-panel.yaml => anbernic,wl-355608-a8.yaml} | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/display/panel/{anbernic,rg35xx-plus-panel.yaml => anbernic,wl-355608-a8.yaml} (83%)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-panel.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,wl-355608-a8.yaml
> similarity index 83%
> rename from Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-panel.yaml
> rename to Documentation/devicetree/bindings/display/panel/anbernic,wl-355608-a8.yaml
> index 1d67492ebd3..5e8afbea690 100644
> --- a/Documentation/devicetree/bindings/display/panel/anbernic,rg35xx-plus-panel.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/anbernic,wl-355608-a8.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/display/panel/anbernic,rg35xx-plus-panel.yaml#
> +$id: http://devicetree.org/schemas/display/panel/anbernic,wl-355608-a8.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Anbernic RG35XX series (WL-355608-A8) 3.5" 640x480 24-bit IPS LCD panel
> @@ -16,13 +16,14 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> -      - const: anbernic,rg35xx-plus-panel
> +      - const: anbernic,wl-355608-a8
>        - items:
>            - enum:
>                - anbernic,rg35xx-2024-panel
>                - anbernic,rg35xx-h-panel
>                - anbernic,rg35xx-sp-panel
> -          - const: anbernic,rg35xx-plus-panel
> +              - anbernic,rg35xx-plus-panel
> +          - const: anbernic,wl-355608-a8
>  
>    reg:
>      maxItems: 1
> @@ -47,7 +48,7 @@ examples:
>          #size-cells = <0>;
>  
>          panel@0 {
> -            compatible = "anbernic,rg35xx-plus-panel";
> +            compatible = "anbernic,wl-355608-a8";

This is an ABI break. You can't just change compatibles.

The old panel should correspond to the existing compatible. Add a new 
compatible for the new panel. The names might not be ideal, but you are 
stuck with them.

There's exceptions if things are new and not yet in use, but you have to 
explain that in the commit msg.

Rob

