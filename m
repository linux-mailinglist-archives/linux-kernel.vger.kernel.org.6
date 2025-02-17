Return-Path: <linux-kernel+bounces-517484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1737A3816E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429A71888550
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7067F216E3E;
	Mon, 17 Feb 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZXNW6ax"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACD16EB4C;
	Mon, 17 Feb 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791003; cv=none; b=pRAn+LJOgyrZkEs1wmWi5URE9pLm3y1Qc2XvNxYD3BM0jsWC1GsPjpgdxHIU2ZyiyN4WUDcq1EY2z8YY9jxPTgzk271++292tYKM05sYRAs7k8kmtUiYMjiLM1SENn+LHhwCUJsTRdGtIVLJ+FUCG3iVcaVsgYbGZYq6bceO91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791003; c=relaxed/simple;
	bh=CL9XSY6r7Zy0wqJ75RbqlmMGJNMYhkebdRP30ma/Mzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfYgkAPtm7fa/7kr2MF9dvW47V3ib1KDg3QfSTET4OteD8k5IKD+Kp6dvw/PdBJvOs21OTaCJa+hIKmA0iac3GyAdajVkva2p7bTo+v45sA1UALj/3tlhkL0EnW9/usTSw4NGAc3+0lQRM6Po0pisRqDrNfsyhUYYXaOkO/nWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZXNW6ax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796B8C4CED1;
	Mon, 17 Feb 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739791003;
	bh=CL9XSY6r7Zy0wqJ75RbqlmMGJNMYhkebdRP30ma/Mzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZXNW6axDfcUBEU2xJrwuhEi0fe+GSnoRgyeXmKzdqiZ324URoo9FFHAo1qg2wYty
	 0h/g24/H4qrFulhCvhmrq6w/0e+zcOeXdaCUIB6lobdBeFXuY+lTzrUhjGhk+zVh7Y
	 o4xFLlCXSaQQmRUI4Z22vRDqxFXFlowZAGWQGEvBSCzEJdvu/PhMdF4fD+1U4ZbFlD
	 D8u1mdi62vwxJzpRRB+sPNVAtq1kiqPcuXWJ90yxN5tc9TxXMial3DYb9kUe/pmjcd
	 so453RpVFmYe1B/FfoRzB7Ieuo+5yvzGDeZP9SLRUk6z5XnJFu1zhBlTFL7CKC2PkR
	 0witQxfiOIQHA==
Date: Mon, 17 Feb 2025 12:16:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Document clock and reset unit
 of RK3528
Message-ID: <20250217-cyan-toad-of-focus-0cfc2b@krzk-bin>
References: <20250217061142.38480-5-ziyao@disroot.org>
 <20250217061142.38480-6-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217061142.38480-6-ziyao@disroot.org>

On Mon, Feb 17, 2025 at 06:11:42AM +0000, Yao Zi wrote:
> There are two types of clocks in RK3528 SoC, CRU-managed and
> SCMI-managed. Independent IDs are assigned to them.
> 
> For the reset part, differing from previous Rockchip SoCs and
> downstream bindings which embeds register offsets into the IDs, gapless
> numbers starting from zero are used.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/clock/rockchip,rk3528-cru.yaml   |  64 +++
>  .../dt-bindings/clock/rockchip,rk3528-cru.h   | 453 ++++++++++++++++++
>  .../dt-bindings/reset/rockchip,rk3528-cru.h   | 241 ++++++++++
>  3 files changed, 758 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3528-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


