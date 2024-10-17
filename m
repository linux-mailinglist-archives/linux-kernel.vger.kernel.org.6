Return-Path: <linux-kernel+bounces-370710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38A9A311A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108B21F22A42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB91DE4D3;
	Thu, 17 Oct 2024 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUoIZcpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F271D86C9;
	Thu, 17 Oct 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205950; cv=none; b=owjuymRHbLGL9OYPOpyJGPIgaHn4cC1vwRBXZcpaBuzRYgNDL0kr2xMWGLjEpH12hlWnkfdZhj43CGLiiOr8l4bJbEhs+k/nvxX+fdtkx7xUuYntTuJ3IcbTsNBwlvH2obcFD6A5mVf0trJ/mwveugBKrX6Ye1uLg7rysCEWcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205950; c=relaxed/simple;
	bh=DUm1+ScrbfU24VeHu0z6wgDupthU46KiwzyCK69LbIg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=e3sO/1RCKKEIGP5aNaO3Pp54/9w4Ham/aTGf3t/62dgD+sSBST3E9tzoCVkEN3dZnACtRFpi47BoqRYxQbmow0ClRpdirYFSjOQuXrVY7Yr3Bn23NkJli5moKmwwmxdJ/ryeAkPZocnzSBKPE1wQWkSXd/NtSqBy1GxM379k/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUoIZcpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F47AC4CEC3;
	Thu, 17 Oct 2024 22:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729205950;
	bh=DUm1+ScrbfU24VeHu0z6wgDupthU46KiwzyCK69LbIg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BUoIZcpFp+u7BVejOn9jlF3LjKlb26uKwYcPXPkyn3oznt3qOFOY8yITI/hCN8LR4
	 mR+rxQJzwpDo083TRg51dGge33V/kWJNNwAU2efTyROh71tv7Yrps8SOgBI8cqqPQp
	 FFWhQkXrotgZiRlaIixwizpQoOizLls40t8PVaso570Igp1Uj18Z0Em9D0ZBUNYUbe
	 3OiON24Gsz1vLH/mB0c3feKs6B2O0kpjVfWUQ/bzRN8VxLpKkS08aQFARh5gOEwsLy
	 yOeqi3asGMuiuAMh8/EwcNtKey0Xep+EMdxB3A1BJAZyv4lTaUxgFWn+RSwisKplt9
	 okFUxbp2aF1UQ==
Message-ID: <a20e6927d38aed4e5b1cb1f49346ca29.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
References: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
Subject: Re: [PATCH 0/4] clk: lan966x: add support for lan969x SoC clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Daniel Machon <daniel.machon@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>
Date: Thu, 17 Oct 2024 15:59:08 -0700
User-Agent: alot/0.10

Quoting Daniel Machon (2024-09-16 02:49:18)
> Add support for the lan969x SoC clock driver in the existing lan966x
> driver. The lan969x clock controller contains 3 PLLs - cpu_clk, ddr_clk
> and sys_clk which generates and supplies the clock to various
> peripherals within the SoC.
>=20
> Patch #1 adds compatible strings for lan969x SKU's in the dt-bindings
>=20
> Patch #2 makes the clk_names var const char * const
>=20
> Patch #3 prepares the lan966x driver for lan969x, by adding private
>          match data.
>=20
> Patch #4 adds support for lan969x
>=20
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
>=20
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Am I supposed to pick up microchip clk patches myself this time?

