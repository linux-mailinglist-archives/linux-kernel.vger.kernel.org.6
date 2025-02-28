Return-Path: <linux-kernel+bounces-539387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B715FA4A3A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E38189EA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CCA202981;
	Fri, 28 Feb 2025 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umF7mFGl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF2C202975;
	Fri, 28 Feb 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773106; cv=none; b=hooUBjpB06eUg7q8u+2gIltOqZt/ivX13lq/0Nu6YkYGchhPykAufExAIhaPsUIbnImKJRUR7idPsuiXUltRW1dLyhIkptWLNSeBsETX2aBkKfiR/8P9XZ8YyuliSNEqn4OnoC9XoLAxggsASMjZESLJms/YgujmQcnrSHEK0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773106; c=relaxed/simple;
	bh=HDPVRdH19vPfCCs97GSQak1exPAHADd+I22PDOk9eb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QruF+HCCoVevuhCW6+OS0ygHWY1cgCysvn0ura5asHiBYgbwDF8yJ7AHMed/GwiFjgQBPfCfQVINrA9GPyFHT710oWGv74p1wj+Ow5pRaxPnlUfiYs1qgfulKV6ZX12Iem8HY2rd48Z8GH6J3GZDr8NOlgZE1UutqpUo+eeVyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umF7mFGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429ABC4CED6;
	Fri, 28 Feb 2025 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773105;
	bh=HDPVRdH19vPfCCs97GSQak1exPAHADd+I22PDOk9eb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umF7mFGl1Mo44g7j0rA6LTCTSCSWwgpr/Z6ciUI9f49V1ESicqnt1UEtjQTudAmDc
	 kOglbAmBebRqtFHsa9L4L3DXWfj96AWd1yarvOAGoIM0soehAInAn1aPvS+tVrxtOD
	 tFauEBXxgDDMRI8zVHAwN9pfb+e8ZcRdkrVXY00zwdnjTRWs2mZgWeTsvxl4Gbnk4I
	 18ITn0CC/ONbUlcxwNtT1/SSds7c7zXpx4LxCzcKkZu8Bciez0yaXaM93NzUHhXPgY
	 LfXk/o3J6eaqM3YynhfFVAtMHvka+RFlYljNHtMLDCvdWZ4YYElPAi+MDUVqtQQiiO
	 iFg8lWwv0zq5w==
Date: Fri, 28 Feb 2025 14:05:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
	Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Add RK3562 cru
Message-ID: <174077310259.3472233.9078765224911917357.robh@kernel.org>
References: <20250227105916.2340856-1-kever.yang@rock-chips.com>
 <20250227105916.2340856-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227105916.2340856-2-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 18:59:14 +0800, Kever Yang wrote:
> Document the device tree bindings of the rockchip rk3562 SoC
> clock and reset unit.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - remove rockchip,grf info
> - Update file license
> 
>  .../bindings/clock/rockchip,rk3562-cru.yaml   |  55 +++
>  .../dt-bindings/clock/rockchip,rk3562-cru.h   | 379 ++++++++++++++++++
>  .../dt-bindings/reset/rockchip,rk3562-cru.h   | 358 +++++++++++++++++
>  3 files changed, 792 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3562-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3562-cru.h
>  create mode 100644 include/dt-bindings/reset/rockchip,rk3562-cru.h
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


