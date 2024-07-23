Return-Path: <linux-kernel+bounces-260394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4DE93A851
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF6D1C226B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F651442F7;
	Tue, 23 Jul 2024 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiv+Q9Pe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105613D898;
	Tue, 23 Jul 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767767; cv=none; b=eSgQ70XiFpT3viEnY9BVY0t4AtHor8KZDAB90bh+faEo8SR/Q715aT/BSgMk78y0hVL5xN6Puh8sMduP6Xq8e4mdUAqQYwfndFK7Kl4LWY+TBgzp7pCmGJqGur4hFka57DY/Ff3y4hYomfzrN2VJuZdRNBwIInxDwxWMNu+VNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767767; c=relaxed/simple;
	bh=WJ2xSllwDlW1uWAOaPxK82Mamgif2S5J9MFYlEXW+0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmsnuJ0j4+Jb6PPyW5+aTxK05ZIN95RpWYEivivllJBoB9BvDiX07pyKPeh5//HbXPD4YwWWkpog7BSoKWWYtBuvK76WXzyDhchm8Z7Vc2D2IZjBPBFZKunRkV6XzLBnYd7UNPrIlaQcJoXbih5o4la0N8j7a7mxgaySG5kDLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiv+Q9Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CFBC4AF0A;
	Tue, 23 Jul 2024 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721767766;
	bh=WJ2xSllwDlW1uWAOaPxK82Mamgif2S5J9MFYlEXW+0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiv+Q9Pe1mTyLEfpD1OEn4KXVRJbI3QgPTYAJ02pQDK3BhEHyL64YUp7k9FRgvO6+
	 poK9a6ZV2tmlGvKd7xvgpF4yKn6Ai7NM8AbxHffyrZwhay+Ulax/j58H/QnJChERq/
	 TQcQFMONycpN8e3czxs1lT0zMcP520g5mko9f2B9tKuVU+9ut2+/THRmDf5kbBAExj
	 4LTTK+yBcBYdoFRuY0K45xu9t2FDP0sVtl+2+CjCyRnhrskjX4hb1iUhcKFh/WK1sD
	 waDFOoMn795LltmU6p01LndCgG1MgGl8U42hJqcjjFaRYpdq9ARvDrGSe8NMJNnoxh
	 HAMsLanK/xxCQ==
Date: Tue, 23 Jul 2024 15:49:25 -0500
From: Rob Herring <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Borne <jborne@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>,
	Jules Maselbas <jmaselbas@zdiv.net>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 03/37] dt-bindings: Add binding for
 kalray,kv3-1-intc
Message-ID: <20240723204925.GA1047494-robh@kernel.org>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-4-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722094226.21602-4-ysionneau@kalrayinc.com>

On Mon, Jul 22, 2024 at 11:41:14AM +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray kv3-1 core interrupt controller.
> 
> Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: Fixed bindings to adhere to dt schema
> ---
>  .../kalray,kv3-1-intc.yaml                    | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
> new file mode 100644
> index 0000000000000..9c8bb2c8c49dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-intc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray kv3-1 Core Interrupt Controller
> +
> +maintainers:
> +  - Jonathan Borne <jborne@kalrayinc.com>
> +  - Julian Vetter <jvetter@kalrayinc.com>
> +  - Yann Sionneau <ysionneau@kalrayinc.com>
> +
> +description: |
> +  The Kalray Core Interrupt Controller is tightly integrated in each kv3 core
> +  present in the Coolidge SoC.
> +
> +  It provides the following features:
> +  - 32 independent interrupt sources
> +  - 2-bit configurable priority level
> +  - 2-bit configurable ownership level
> +
> +properties:
> +  compatible:
> +    const: kalray,kv3-1-intc

Why is this defined here and in the cpu schema? It is simple enough, I 
would just put it in the cpu schema.

Rob

