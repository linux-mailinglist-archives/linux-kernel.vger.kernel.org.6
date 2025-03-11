Return-Path: <linux-kernel+bounces-556916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCAFA5D09B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E25E17A00A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48178264631;
	Tue, 11 Mar 2025 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiEYtc1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8F01DEFF3;
	Tue, 11 Mar 2025 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724110; cv=none; b=ZbTHSs87Omm5TlP9GCaNHpBUR+C2VUfN0yzXft4Ynkf03tbnHsQgaBNOazQ2DU0zb7tsR+At1yafhTTEGsEbZmxcaOB/X0IR7thdpZgzfC0YfPiBZSIGtPrehky2e+Vmvczy2g/xHNRMHbfr9WL2UyULBsWPrws6LvFRw0F2qH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724110; c=relaxed/simple;
	bh=xr7Mg3apWFhagDi7Tib6C8T7NatN1ptZtdreOZYK0TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeowMOlKD65ya/nKPgG3EVGS79oWACthrIDVpgU/xaSwQUPcm+rAlXNyV+m+afteEhuCTXXU3zGiyJ9Y+Ef3Ky8PjUuVXjlq2NU3ON4E9dpkEdJqgmaJ6fVsE8U39fHqkGfKG47d3hAoJ9jSlYUJ7Ouy80ZhxC+bbZjgqJb1cKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiEYtc1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9362C4CEE9;
	Tue, 11 Mar 2025 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741724110;
	bh=xr7Mg3apWFhagDi7Tib6C8T7NatN1ptZtdreOZYK0TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiEYtc1trjLrbmlCBKKDFUoON0GHTHA4+DmiWZr5YPhgEahVhpNr/TQnwuhW8IfbN
	 Mu4+NAr4jEORUO8OnZLR0WJsfsHp9tfGGOTRdYfcE4mydal+tGECQSnUKJuAlpx9C4
	 lmIz6c8SO5kCPW8zfBr+K1xoUeF+HPx1/KJhsXPiD3PZ5erNo1+V+HIOSIl4Kt7tYd
	 zcKoits/AYHu2bXnVxQxsvGZ4pBQUkBfVYTQxc6A11dSxswAUMk425sJSFZqrPvnz4
	 j/L04Geea2ph+M1kmLrHN+kvmK/GzGo7NWMf7/G+zsw08CW46lXq08Qrh8M3grjO6o
	 p6tVU+SFmYPGw==
Date: Tue, 11 Mar 2025 15:15:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: linux-kernel@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
	tony@atomide.com, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: clock: ti: Convert ti-clkctrl.txt to
 json-schema
Message-ID: <174172410753.54630.13201931794020216053.robh@kernel.org>
References: <20250311180215.173634-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311180215.173634-1-andreas@kemnade.info>


On Tue, 11 Mar 2025 19:02:15 +0100, Andreas Kemnade wrote:
> Convert the TI clkctrl clock device tree binding to json-schema.
> Specify the creator of the original binding as a maintainer.
> 
> reg property is used mostly with one item, in am3xxx also with
> an arbitrary number of items, so divert from the original binding
> specifying two (probably meaning one address and one size).
> The consumer part of the example is left out because the full consumer
> node would be needed.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in V2:
> - additional maintainer
> - remove txt binding
> - dual licensing
> 
>  .../devicetree/bindings/clock/ti,clkctrl.yaml | 65 +++++++++++++++++++
>  .../devicetree/bindings/clock/ti-clkctrl.txt  | 63 ------------------
>  2 files changed, 65 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,clkctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


