Return-Path: <linux-kernel+bounces-370446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3099A2CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE071C2120E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396AB219C8A;
	Thu, 17 Oct 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw4VCFng"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF91E231F;
	Thu, 17 Oct 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191127; cv=none; b=Q2i7bh3AtTtbpvW+t6qk/9SNTy+uHtcwJXs49heWBMM9lhodVhq+ksFeWvBWl21zpRaB0cyv/2rMGZAaEzhwZ8kqqYISJuWurT1YQ9Q6SgjezQPfZQlLsYXcpM1ELnWSuyPhayilSw1gEAm/2kZAO4QnJ6HkZGhzchdcwHatafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191127; c=relaxed/simple;
	bh=jfcKj5PtbYJUV8eDzntzTE8yyWQoJ/z/kx1SoY2DXKg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=BWx847g6VqOZNx4WIp/V0s/bl/mff/tJCmfBS9JxHEjzCl3Qz5zT/xmKBhSP6ZgNm8/RWlPEnJZQym4HBr9uD9Hd8E8YBsra5eP+ewNIY/TPj4ULbUH5I5klB7AWVx/BWxE1pBJy3Y9Jc3AoSHqrmQSY16TX6yTLAvT6MLXgLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw4VCFng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2120FC4CEC3;
	Thu, 17 Oct 2024 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729191127;
	bh=jfcKj5PtbYJUV8eDzntzTE8yyWQoJ/z/kx1SoY2DXKg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Vw4VCFnghRZYT4L1007ruO86KPHlZ7p0q0jpjlHUNDsLewEOk9QPkRNtkih6B0ONl
	 OuAC+pRFISNZrtF77tJ91+kbDj39MNEJ828F62gTITXhCEMuy1dfbJBRX1ySGSpDGd
	 nfItq4yUnaJpP+tqID+oIj+Af9VlISTR0UXJd098miROZFNIMY10YMTvV0qUP0RDZb
	 rDLu/htBnsYr+T4gZM+wsrgD6wgaqwdFktrEt1berj8sGhYO2jptWj99GBYUisXHXX
	 WIaVLA2HV+8T5coQCgKXInBiOCgKWTUvvKuU7MGQyQ3727KoVr95p6xYsfpU/LCf2v
	 J7ZxR4ZINkSbA==
Message-ID: <d72e2f6a6dd05dd13b09c6983bc5cefa.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241007-mbly-clk-v5-1-e9d8994269cb@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com> <20241007-mbly-clk-v5-1-e9d8994269cb@bootlin.com>
Subject: Re: [PATCH v5 1/4] Revert "dt-bindings: clock: mobileye,eyeq5-clk: add bindings"
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 17 Oct 2024 11:52:05 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-07 06:49:16)
> Switch from one sub-node per functionality in the system-controller to a
> single node representing the entire OLB instance. This is the
> recommended approach for controllers handling many different
> functionalities; it is a single controller and should be represented by
> a single devicetree node.
>=20
> The clock bindings is removed and all properties will be described by:
> soc/mobileye/mobileye,eyeq5-olb.yaml
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

