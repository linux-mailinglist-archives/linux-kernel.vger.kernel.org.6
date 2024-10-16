Return-Path: <linux-kernel+bounces-368569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B989A1177
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15E92882CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692BC212F13;
	Wed, 16 Oct 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0jq/SX0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF4290F;
	Wed, 16 Oct 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103167; cv=none; b=D2FwIaA+ULz5gNUAhVfYHD87ij/Vq9Z57CEfYdOETKfK+BtkBA4+WGS4pPaiEjfBCaEStM9uaJKTzxCbG/0UnlCJdlj5hRZGimifH99/hYS6w+6IzycjDfzlKz6GsfC61xWP0Tcx/WRDCDjF4j1AVkTkPQDLXr9AAtl4tz4Z9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103167; c=relaxed/simple;
	bh=udgXEr4tRU9cVriPhW81FOJfeK1qkSca62T20Hg7T6Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rd6XuuAMbSQyHLmliOt5n819Qp640nzgJ07y1oNwRtg8rjDKY2rvHCGFUL1p3CMwLUhtqNfoze9CjuW5MKOToR9+uluT/VMJGa1iGwwxeLjOer31GN+3Wt42T6N/3DDcW7GKq1Az7ecozkVb4KvAe+kJ+U9bLRGlf9EyvKztmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0jq/SX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFB1C4CEC5;
	Wed, 16 Oct 2024 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729103167;
	bh=udgXEr4tRU9cVriPhW81FOJfeK1qkSca62T20Hg7T6Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=T0jq/SX0o8AUhSM4NRdgUcMgLodf0NzQgJgR2ysxpZxg52SZGuv2AqGGwd2DEOwra
	 YfnqXOFOZ5gs1vrGOKcBMYAAP8RI0iVh3gdbNV4QwqVGlpwduBrE9aOpVMLYI1xs4/
	 8yTfZ6ktovPOgBeYIs23DA0n+MWxDaJYq4xtT4XI0u3yVOnPA7bT72tw8HueJxHIoh
	 irWVqGMs99OUeuRRGFnBZvvhaAUl6u2qqcJn21xTnI5a5V5OjubOh/XHDm2hwWcE22
	 WEnhj45sLhTS1QOeu9vTMVp6H2eln0m8IJOq9hqLO/yzbHmDLJz9sWDAdW2FxIyLWk
	 s7hEg2jJBclGQ==
Message-ID: <87ffdca4bc85313270ae2b109cc4039b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240906082511.2963890-2-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de> <20240906082511.2963890-2-heiko@sntech.de>
Subject: Re: [PATCH v4 1/5] dt-bindings: clocks: add binding for gated-fixed-clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
To: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com
Date: Wed, 16 Oct 2024 11:26:05 -0700
User-Agent: alot/0.10

Quoting Heiko Stuebner (2024-09-06 01:25:07)
> In contrast to fixed clocks that are described as ungateable, boards
> sometimes use additional oscillators for things like PCIe reference
> clocks, that need actual supplies to get enabled and enable-gpios to be
> toggled for them to work.
>=20
> This adds a binding for such oscillators that are not configurable
> themself, but need to handle supplies for them to work.
>=20
> In schematics they often can be seen as
>=20
>          ----------------

Applied to clk-next

