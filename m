Return-Path: <linux-kernel+bounces-430781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5459E3586
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EEF16921D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988A1953A1;
	Wed,  4 Dec 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EStGtzNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00B192D6B;
	Wed,  4 Dec 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301296; cv=none; b=Iw7FpwnwhZ9p262TT5x/MhaEoyHPG2iKqpr5zaactivdhXObuAELE6U7M4tRsim207KPRwAf18pq075ihEPGzZPqNfdIcsFO67ljmN/4XGXMdSFu66dxleCgjj3GBCfIbug6Y61JxKIE8y8Dn7gCfYWvyusv6YJUwkuvrc1VeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301296; c=relaxed/simple;
	bh=rSzKOzSv4FFk6DhAiPq4v58LUiP0VwC+Z1/9gQ5Xn5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuA05fkH44gUFWHocq0LpZbQKvSyMJTMKuJ2udoKK7s45MCDL7usLKbbhvasA8Th5ix7isNzjhg0H78sj6eNvm39JSCbS1lwTIG5NxVqnwMJY335G26DUwzOBe6x5ksewr+QW9JeDoDfnbYpZutDhEFjQNNIiA1PAqfKsRzAbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EStGtzNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021E7C4CED1;
	Wed,  4 Dec 2024 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733301295;
	bh=rSzKOzSv4FFk6DhAiPq4v58LUiP0VwC+Z1/9gQ5Xn5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EStGtzNqdZtWUYWgVanvABgZUlfsUkT0/LaFgHXY5scPUyyBzZS+qrMLa32+mZAmM
	 NB6+OFYhAM+tIssNK4RYxs+mnWT8KxaZ0Kuk/nN5xlEs1tkE4gVxhi/6W9yvxRdtx2
	 5yJAZAK4fVgEtDBXT0eG5euW3VmYPtqtnRJJbXUA1B7q1bR6GAb4V71ef1zPbx97I0
	 Pg1cQKpf9d66Mu1cWEsr0j5hwz85gb7fvH+eipX9CpZ06H1WxgIUa0oW6XT7a34g8K
	 SmAX/uHvMWmvUALSO7A5Yy9OoFyV25DM9GK8B7hXqy4+0Y7Fw5BxSg1KZdSyq8UlMX
	 rVOSmjpSFq0aQ==
Date: Wed, 4 Dec 2024 09:34:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: soc: ti: ti,j721e-system-controller:
 Add MAC efuse property
Message-ID: <xknwuwjuedakc2f4ln3nsvsc2lux7ma55ivcetdoao6qq7jyzo@6nqyex3h2v4n>
References: <20241203173113.90009-1-afd@ti.com>
 <20241203173113.90009-4-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203173113.90009-4-afd@ti.com>

On Tue, Dec 03, 2024 at 11:31:13AM -0600, Andrew Davis wrote:
> Add a pattern property for MAC efuse which can be part of this controller.

Can be or is? Please describe the hardware what do you have there.

> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/soc/ti/ti,j721e-system-controller.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> index ead0679b30e3f..fbaae3d1bef60 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> @@ -80,6 +80,12 @@ patternProperties:
>      description:
>        This is the PCIe control region.
>  
> +  "^ethernet-mac-syscon@[0-9a-f]+$":

Drop syscon, unless this is system controller because in such case drop
ethernet-mac.

Best regards,
Krzysztof


