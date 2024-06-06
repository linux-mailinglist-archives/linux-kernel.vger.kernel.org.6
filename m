Return-Path: <linux-kernel+bounces-203468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E49D8FDBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A0FB244CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6603EDDDC;
	Thu,  6 Jun 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYI26IzM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3124683;
	Thu,  6 Jun 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635214; cv=none; b=M9n32LXnhhYFikr/X0bLKCbOEls/DjVnb2z3FopH0Y0oCvF0pj51QDwhQviKKJBfruUkMKedM8+EAP5yQL+y9zrE818SVP02QueH50O0larLxUhnBt9iSBvHqiRoDLotphVPwPR8irrhoLw4GWAso9lzfc05G1CGnVZOuiqZ39Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635214; c=relaxed/simple;
	bh=y3NLehE4z6xgfNaULf7oIlI/u+h4fC3sVYtsfAAbbT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PphS0MFHsCVioPqCNn+LMrXcG2opz0sTI4XcO6/dLTnEsMIulF5McfynBAj/+pMbjFnmTBGRoo55oEw1TAwvYcjHgKCaWYFc3tvFa3/kTQrP/punfwi7hFRbBVtYgMKFWQAGSoaNldX4BMVu11fE5nMq1IWey2PIlSM4gjHNZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYI26IzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21764C2BD11;
	Thu,  6 Jun 2024 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635214;
	bh=y3NLehE4z6xgfNaULf7oIlI/u+h4fC3sVYtsfAAbbT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYI26IzMt/8KkfHDg8gdx/oyJXPQYS9VldQ9gvsjayQb1+0iERrg8miy2PjUuWOqE
	 PzUuiaAARz69Xol8Nn69nMUOez8uoOqPy0FOjZH89M5UYzSOvRfqRVEekqExYORjY8
	 XtsbcRZVR5iT1IjMRR0lBrdne9myBjkXrOA8daUU3IxgejRCQc+lakybMyi12eKhtZ
	 ZRrfyEORegzbDpRB2cwOJVxk1gP9VeXfhFMOQmdY9kYR0zzpziTqUwDj3Yexci6FLq
	 9dsS2k6IGCmf/Xi/dYGBhkJtOL8xBXdX0S3VMwTUQv2TGAZRPS9XKOAes4KfBR16q1
	 0NQ77odt9NyRQ==
Date: Wed, 5 Jun 2024 18:53:32 -0600
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: linux,spdif-dir: Convert to dtschema
Message-ID: <20240606005332.GA3526959-robh@kernel.org>
References: <20240605112301.8171-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605112301.8171-1-animeshagarwal28@gmail.com>

On Wed, Jun 05, 2024 at 04:52:55PM +0530, Animesh Agarwal wrote:
> Convert the dummy SPDIF receiver bindings to DT schema. Make bindings
> complete by adding property "#sound-dai-cells"

2 conversions of the same thing in one day:

https://lore.kernel.org/all/20240605-topic-amlogic-upstream-bindings-convert-spdif-receiver-v1-1-262465adbac2@linaro.org/

As I said there, I would just add the compatible to 
linux,spdif-dit.yaml. But this is fine too.

> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../bindings/sound/linux,spdif-dir.yaml       | 34 +++++++++++++++++++
>  .../bindings/sound/spdif-receiver.txt         | 10 ------
>  2 files changed, 34 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/spdif-receiver.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
> new file mode 100644
> index 000000000000..61767873200f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/linux,spdif-dir.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/linux,spdif-dir.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dummy SPDIF receiver
> +
> +maintainers:
> +  - Liam Girdwood <lgirdwood@gmail.com>
> +  - Mark Brown <broonie@kernel.org>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: linux,spdif-dir
> +
> +  "#sound-dai-cells":
> +    const: 0

It wasn't in the txt binding, but users also use 'sound-name-prefix' 
property, so that should be added here.

Rob

