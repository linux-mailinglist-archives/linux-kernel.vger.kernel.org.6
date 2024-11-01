Return-Path: <linux-kernel+bounces-392509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52C9B9502
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED597B216A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38BE1C9DD8;
	Fri,  1 Nov 2024 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmaX2Npl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A11C8FD3;
	Fri,  1 Nov 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477548; cv=none; b=caH/Nxuro0ZMWHCkmB29WViDa5+CVPYf3hitYiBBkxOGVOSI3vyh7IoiQga8Qzk87bNkvYaPpjJyJf3PhBr2T9JmeO04he2pr0xSVxXBDFXhnKAKFkbR/EOqSnxgD1fc9sAoMNguEpjRNoHkj/NXoYA3WT7Ft38G02Z9sSxDWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477548; c=relaxed/simple;
	bh=uwXUT5FtHSsLYjY23SN+coyvRK2O8i6XV0K5dlhp3Qs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eps+//TasPW3etgKf3zTRufax7eYPZ37aUJbkQwkZ6BfcN5eb+mAyoCg3Fxhloruro54O0gVi/aWNxQ+ruLZhEZsyIZyMwKtKeQ2VMXBhdLVlhrlpXi6sHTYHQExn8GPaSSEkg3RRS5ndC3g4sU9n0QE41lUC6OXOz6Qmd0zhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmaX2Npl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6598C4CECD;
	Fri,  1 Nov 2024 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730477547;
	bh=uwXUT5FtHSsLYjY23SN+coyvRK2O8i6XV0K5dlhp3Qs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dmaX2Nplc9QxCZRRY5Fbnq/PxjXcgLVPzmYLgxlaDO4rna64XDtqCOrxVYr0J5szB
	 Npqtvz8dRNAd7ViCuk2MLHkGA7eTvnXYkKUaQlwl3qlrx76/ULmaSEoLyntGzpWWPC
	 KJ7D4NrcX42+sZjs9FbV9YsttI11hzwmwuIP24o8vvdU2uO/EfBI5jRrX0ShKM6SfL
	 6aEYFNomlrRPUn5PkorX0hSmyFwwDwTPvpOTSbTPA6cUxo7FZT0hr8efh/D4opvx+F
	 XyqwQvcAxFIennJEMO7aC8eKS25RdXOLLlevMAiDhz7zVQbNc5xd/+eliz609Z2B19
	 Y2V5d07aSa/Kw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org, 
 Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20241023090153.1395220-2-ryan_chen@aspeedtech.com>
References: <20241023090153.1395220-1-ryan_chen@aspeedtech.com>
 <20241023090153.1395220-2-ryan_chen@aspeedtech.com>
Subject: Re: (subset) [PATCH v6 1/3] dt-bindings: mfd: aspeed: support for
 AST2700
Message-Id: <173047754439.1930424.6922132618537420144.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 16:12:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 23 Oct 2024 17:01:51 +0800, Ryan Chen wrote:
> Add reset, clk dt bindings headers, and update compatible
> support for AST2700 clk, silicon-id in yaml.
> 
> 

Applied, thanks!

[1/3] dt-bindings: mfd: aspeed: support for AST2700
      commit: 76c6217c31266e800b67a476bba59dfeb9858a90

--
Lee Jones [李琼斯]


