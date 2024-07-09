Return-Path: <linux-kernel+bounces-246440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDBB92C1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AE9B2A444
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9461BE24C;
	Tue,  9 Jul 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gx7b8Yho"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFDF1B86C1;
	Tue,  9 Jul 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543009; cv=none; b=q6DXzt/PvzLBXdCyDAPJRZpRijuNCDRdA1PfmPmzPc1hlwT2htg/MvSQgNpbv1nwnmspl/aTlqafy42ntTHLR9HPTReVWSgCOAP+SD6e439bXtBbDzRmiXj1RE1aKMpvPGZggw+m3WyPY8NldFihqq8NFRmMFjrZ4gKGVK2ZnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543009; c=relaxed/simple;
	bh=Xm0jLxOV5AS4adQ8afcNWBAcHbM8cexbgfkySU4Qvhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvt2tvyHzcEnVL5j6frwjOJWvaQXqxwz93lWtP1uIJntprRkbo2IZZ5bmmCeh/w8313NKzmMDaOB0o2BoFuyQpHdhoByys/f3SKjfwWD7CyRtb+LMcbtCQXR4Vl/LoMnt0wZBrlUE4yIa6BwiEBtOPt79931pfqm2dRsQ+6SVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gx7b8Yho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0066C3277B;
	Tue,  9 Jul 2024 16:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720543009;
	bh=Xm0jLxOV5AS4adQ8afcNWBAcHbM8cexbgfkySU4Qvhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gx7b8YhoNWlAfOoatGt0D7lWiBVhtxGbLyztdK6/RoGFIwTVpULGdD0wHVtoEOfc/
	 cQwskmuub3iIYlj6cjl7OkZltkIqeJ3NqNljA0Rq3wiNzOZeaI6gd8r8plYm8B0s8b
	 J6bWMH+jXSHwCuMo+6t7NDmsLrLEdqZCKgap2Hvfh+6pVNx+dLx/fGWNLiV08qwf0v
	 K3+QhYfGzaHQcC2JByEMhHpGnkbokE1fBR5YUVmD3sGLqzWegdDlk9aT0KV86c0SM1
	 ovvuK/q8NCvE19XCf19jwyLEBKBKjD3Nh8gAxEHkMr4DrqrSb0uY5/ysCJ39z1gRHi
	 5fjlRl6joQRnA==
Date: Tue, 9 Jul 2024 10:36:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: conor+dt@kernel.org, abelvesa@kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	shawnguo@kernel.org, imx@lists.linux.dev, mturquette@baylibre.com,
	peng.fan@nxp.com, s.hauer@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, sboyd@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: add i.MX95 NETCMIX block control
Message-ID: <172054300658.3802919.17171827507020232458.robh@kernel.org>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
 <20240709073603.1967609-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709073603.1967609-2-wei.fang@nxp.com>


On Tue, 09 Jul 2024 15:36:02 +0800, Wei Fang wrote:
> Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


