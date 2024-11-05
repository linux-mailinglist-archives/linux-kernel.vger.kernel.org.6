Return-Path: <linux-kernel+bounces-396145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DA9BC87E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F62C282E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2F11CF5EE;
	Tue,  5 Nov 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQm1pmYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347911CDA26;
	Tue,  5 Nov 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797158; cv=none; b=iWlNmV9gQnVQ7P61cijG9u9AWaQoH5q+6P+XTqscHc2hL1yDKrTmzp3pqRLFg7NAA82IzZy5qL6OdTIjlZPYXEWGr8bi0aRvvOlsqQubdNvYoQH+8/eQBhw8RphE7Y937wWEyx/4NtS5svWcdvA8ALNQVXWBoFrB1EsHmExr7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797158; c=relaxed/simple;
	bh=TecRWxjXwpw+WuZHTWmU9Bxq+5QkmQfUlgtvuq7O5Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyFZcMgtnJT04J/QOWeskbFRvLwx2C8dy7IFp3q5e+dJ3vyIIBbizxhlRCT6OZViR7rJl/AM87EunYzSabZ3ddIz6qsDAq2EO/V0EhNCn2xwaZd2H7SzkeRbZkh4ge41+WvF7jW/0xtAMn6ZzkAIuUE6tcSf61JWoADfEjDhFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQm1pmYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3467CC4CECF;
	Tue,  5 Nov 2024 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730797157;
	bh=TecRWxjXwpw+WuZHTWmU9Bxq+5QkmQfUlgtvuq7O5Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQm1pmYSOtMNp6aenuGRhpWvJqfuQF0lADrkq201hEFT59oGJ5VarcTEh3wr3p9Em
	 QTFuyDShhq06TAfmpJyGvVl8MLHC5mYn3ZjFravzRU9aJ6amJ88DonE9Ryxhznh+IG
	 ePeJpN8TQY0Cx7xwVfTstShHujYw35N46eCPwSizfagfyzv2Gt4lRHpi1NsOAEpuqV
	 CYwdqTSL7uo3JTgF4dbTcLnytnU8ZT5GsfDXCj3nDkpIpREj018CkYfDXKU92gkl+r
	 JPSD3pQvXdwiNEpAlMPyhlkwl29K+ea/ZHeUkYRcvy471X3cJtnxuRxOkSM3TwDXHI
	 kaef2ALee8Qgg==
Date: Tue, 5 Nov 2024 09:59:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY
 schema
Message-ID: <hyzfluc2v7j7zog5okgpf7eeramndrnb6nzdenpamwrf5gzdf3@kfx452yx7ryz>
References: <20241104111121.99274-1-heiko@sntech.de>
 <20241104111121.99274-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104111121.99274-2-heiko@sntech.de>

On Mon, Nov 04, 2024 at 12:11:15PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Add dt-binding schema for the MIPI CSI/DSI PHY found on
> Rockchip RK3588 SoCs.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


