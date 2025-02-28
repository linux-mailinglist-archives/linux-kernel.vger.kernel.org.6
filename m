Return-Path: <linux-kernel+bounces-539432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD253A4A427
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678AF164437
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8942777FA;
	Fri, 28 Feb 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXoaFVsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798E202972;
	Fri, 28 Feb 2025 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773957; cv=none; b=XlnmbsPP/KUhXIpvRHr7yGodngCar3/S5BUX0zNKjb6HuQjWDtytOFJBnnyOsdTD9CescZWD1ptAYVkcQyK57CTEL0awx4wPXgDmgmlvIkFuOJizqjKHighTI/9jnrO4L39LpmkMQ+JVgZoWrmsg7dWX6umSreLW8uxzp62H/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773957; c=relaxed/simple;
	bh=Fu7VUqbWek0xFIvF5VwKiqUP47YqKbMOQ2CxOz+pi2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfa6EDViSRVJzA+vXpiPge1EtCPUXahJsWyAIyO3CA4GzbKb7oNhqBgbRaclqob3SBepSfRBO09wUZQXL97A3VToj5Odc1IAHLNB0Y7xEEnsoRtcB7MzMmzgYbR1WOylkLXbP5J47VvuCUhUvtTL9t2gaiIvUbeezUC4U8t4n7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXoaFVsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DE8C4CED6;
	Fri, 28 Feb 2025 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773955;
	bh=Fu7VUqbWek0xFIvF5VwKiqUP47YqKbMOQ2CxOz+pi2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FXoaFVsp2V5IOYcc5hyR5NeXNciwKRyigEjZt7DoL+WNuGY04iXiVGlh3M1rffC93
	 FARIu8H/YxwQgnVzIbfqYxJtpGWnsknMG4ukgVwP0tPzmGpUy/qXnsXdePogMO7QDl
	 d5Pdg0hcTeZ3ud8AlG+gnf97ZpOUYYevLh8budL76pFsmohTH6G5TXCxx309oBSp0K
	 j0RmM00bWeJKlQ3lbqvtlz8KUZmclKYWOLf8gCMHIBupy+5ROtv9ZVukaBoRrp3LcC
	 L01ck3B2ieAzRJP5mGIPNWMCEGsIPhKDm9ql+ICQIPwAC8ncD0qhhwdpY7JLWHPo+5
	 d3bd86uj2P4Dg==
Date: Fri, 28 Feb 2025 14:19:13 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org,
	Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
	heiko@sntech.de, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/15] dt-bindings: rockchip: pmu: Add rk3562
 compatible
Message-ID: <174077395277.3611819.7689063628418129415.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-12-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-12-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:09 +0800, Kever Yang wrote:
> Add the compatible for the pmu mfd on rk3562.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/arm/rockchip/pmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


