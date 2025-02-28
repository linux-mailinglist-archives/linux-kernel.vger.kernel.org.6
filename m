Return-Path: <linux-kernel+bounces-539433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9C6A4A42B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2166F1655FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFBB1F4CA5;
	Fri, 28 Feb 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0vOO0mO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA4202972;
	Fri, 28 Feb 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773995; cv=none; b=Jy3Hgb8FRKhqeqqFltSnnksBUCfqiw/3t40V2J/wFKF4YyXoGr/bJfPommG6ymPKUF23brSoyJfBCATS8sJ/j4QW4f+DkGQKxU9iabxmGsAo0O1zFKhJ3bAKDTVGeIUD2hIYWInorsS+kMP5T5kqRG98nxf6hDwShGqra5A61eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773995; c=relaxed/simple;
	bh=cx6KMGBCYq6n3t5dzNY2lWOPSoiqWzxG3JY9eJ4yn6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3EVZX8NhIFv89qxgVhdatR4OSQvV3xGQwk1mvDku6WPAse9BAjth3b0Wtl829X0M06yFwp0SlScRm/q3gRavhzAmL8g+8MEhpeLc4VS0Nut/GPvPt1q1//GmorD+/dF12O9C+Z8bSzlcvywmC+aN473jHrZJQRaiJPOmZ6X+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0vOO0mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B943C4CEE2;
	Fri, 28 Feb 2025 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773994;
	bh=cx6KMGBCYq6n3t5dzNY2lWOPSoiqWzxG3JY9eJ4yn6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0vOO0mOJdgxtFSleXuCWPKumz/sdC+rgI02yMpGAqO1S/cCrsP7wlw1W/Uf/w2ch
	 CzHhIzKiNhZdiUr0O8Xcfc8G0h2Iy9I7BYbr+RXHCfWyGYr+m81yzFC29DvAZghKaY
	 xT7TDVqaZsGBM7XwDL5hUhnlNst7SQPGuEv2qrwVoW1eo8g6PSW2HGx/5wTHBTUu40
	 aOpg80BuowOCcRG7FMMagG4UqpSVsLjhttAuG7DdWrkn9/4BAVZzCrQFJIWncO1zlT
	 oZJrNh1KCG4P7sC0Ooh2vR715dV93+qtW6p+jz48nEgC5b0SScmut7QxX5pGtByY3X
	 HCUvVa51IRC1g==
Date: Fri, 28 Feb 2025 14:19:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, devicetree@vger.kernel.org,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Frank Wang <frank.wang@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH v3 12/15] dt-bindings: soc: rockchip: Add rk3562 syscon
 compatibles
Message-ID: <174077399176.3618688.11759633731165710590.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-13-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-13-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:10 +0800, Kever Yang wrote:
> Add all syscon compatibles for rk3562.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


