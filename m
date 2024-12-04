Return-Path: <linux-kernel+bounces-430660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C79E3431
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105AC280F67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0CE18C907;
	Wed,  4 Dec 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyg8RjUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E5213D281;
	Wed,  4 Dec 2024 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297979; cv=none; b=NT3fMrlIFMsAjry5/IP6aTAwa3iwuNVh/v9r4RIFUgKhicjkeMHWr8MInFIbUjCCiuTrTQQVH22H+qp4P3JiIvqJGoQXcSAepBxCps42Poip0beTdymEdWZIyFgAvBLsIkOyi+p7KKEGccnZRpXGXycanvCtjShgO/qV4AMxE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297979; c=relaxed/simple;
	bh=OZXyxFp5uWXU4+gtNDcxN94xsKibQqokm4SOMt4Xt5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSHjB/uMFKkfUePk38OjAKtQynghOB8ZH1LWsl/AxJwWAgZfatnuNUF9JDLWepiHi/IsNwbjermdECs2v4IceXfpFEygzBReFeZTguAZBL4VROD2/HtsuqwzLwQO3Eia5AO0lzxOZfwMK5XlGCKV0aI0vce+2aU69JgyvxdXpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyg8RjUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D646C4CED1;
	Wed,  4 Dec 2024 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733297978;
	bh=OZXyxFp5uWXU4+gtNDcxN94xsKibQqokm4SOMt4Xt5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyg8RjUGEl2gykO3cMw2tW7YE9qGqj3QwcLCyiSYGF8nZakDz4PXSmeILOTBxhian
	 nTYR9rhzSDSt5uTlCPM/pP6n2XiPQMn8tB3oPMAZic+P4gyILBUzUZHMElyT9qmUUW
	 hJr8S2Twk6DORz+F+XqCe3Tf3OvXY0txcULPWNW/vANxL5EnEg/d07W2hGt3b860ID
	 VqFKGOqt+kTmlRbvkxxdBmdzlG3YNEEW72B/Rj9oU5lb5apCGLOAsLqMLZhyOiggX0
	 w050em0y8RPkWSFtU6v/tfkAD5eG2er6wPX5c5Q1agAQ7GVKYLrt951bkKGLd7WSQZ
	 3fEA8Rr7Rvpqg==
Date: Wed, 4 Dec 2024 08:39:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, 
	sebastian.reichel@collabora.com, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY
 schema
Message-ID: <mdlcm57lway2wqwh7tp6bj6mi3nlwuaeadbsmgx3h6kcfdisq5@76ikce4yqfs4>
References: <20241203164934.1500616-1-heiko@sntech.de>
 <20241203164934.1500616-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203164934.1500616-2-heiko@sntech.de>

On Tue, Dec 03, 2024 at 05:49:31PM +0100, Heiko Stuebner wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3576-mipi-dcphy
> +      - rockchip,rk3588-mipi-dcphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 1
> +    description: |
> +      Argument is mode to operate in. Supported modes are:
> +        - PHY_TYPE_DPHY
> +        - PHY_TYPE_CPHY
> +      See include/dt-bindings/phy/phy.h for constants.


That's the only difference from version I gave review. It is approved
style of passing phy type/mode, so adding this is not valid reason to
drop my review tag and request re-review.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


