Return-Path: <linux-kernel+bounces-199838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B408FA68A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C9C283DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F9A13CABC;
	Mon,  3 Jun 2024 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoD3XhQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086A8BFD;
	Mon,  3 Jun 2024 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457530; cv=none; b=S6CxXL5lprDu1EIhp2XrEOgJgj3peh+xtXKQN+teYV6h+F3zTO1hUgTrs2gGLzN9WCJ4AGDa91WLzoK8icoDpUcK0hWx7uM51sQYm3eshq5Z4v7oaEbflDXfuyFDwHoWeuHMUh/XnFKhbO0BPyzBjw2L7XE5T1zM4rzBJ4mMayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457530; c=relaxed/simple;
	bh=C9/b3v+iQM6ptoygrYk9aICPX+fjJ6hghC75IEZA4as=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mIdsEoOcrbsQBX9/7QRLEKNvDY/yAxemQbT9oTA70Rp43QqUa3nY6w9jOX/MS/RhPU6HMMVp31t30oI3He4qqBalygQ+TjZoRyLyUxbfx6+j+COXRjJP0rbUi2TBT8twMEorqQFH3/5moRtKCgKlmnpodSRKbGitPbZNzu+PlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoD3XhQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173B6C2BD10;
	Mon,  3 Jun 2024 23:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717457530;
	bh=C9/b3v+iQM6ptoygrYk9aICPX+fjJ6hghC75IEZA4as=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MoD3XhQPNrbVQpvZ9FRX8/9wMre/Q3XSo+or52yzGTV3AtfPHXB+SFVCnFgHcOJBV
	 0mK3Wy+ipJIJbLQ3/nwVtLoM1Uer2Fe3HvOLmLM66kpFJq/jG/MgEgwRGX3x+FFnoL
	 HJHmDY16iaZ2qSlvEQAhZyREQ2z9Vdg/NZDIrOivKYqksotgVBcBW1rKHwxX2Ff24q
	 V8B9URNEE5SAta23Dq69zxqfYwuHcjnCejV5qRcLeQ3ilI1iJ7PH+YiHtxw8jjxxPZ
	 LqVBreT9KSX/mkP/TVgn6mMVwO2aMN4eExaUPCkjGkAftIMzuhiSJQaxaEXyksbEwQ
	 7UMQzTAylKcnw==
Message-ID: <2f9c1628cb01727e2df49287c445190d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240520222646.1741958-1-robh@kernel.org>
References: <20240520222646.1741958-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: milbeaut: Drop providers and consumers from example
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring (Arm) <robh@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>
Date: Mon, 03 Jun 2024 16:32:07 -0700
User-Agent: alot/0.10

Quoting Rob Herring (Arm) (2024-05-20 15:26:45)
> Convention for examples is to only show what's covered by the binding,
> so drop the consumer "socionext,milbeaut-usio-uart" and input clock
> provider "fixed-clock" from the example. "socionext,milbeaut-usio-uart"
> is also not documented by a schema which caused a warning.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

