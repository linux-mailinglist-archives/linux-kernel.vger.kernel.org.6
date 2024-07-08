Return-Path: <linux-kernel+bounces-244778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF092A960
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EEFB21B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE214BF8A;
	Mon,  8 Jul 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaVPYfZW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532717C9E;
	Mon,  8 Jul 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465103; cv=none; b=RpW24MjBaTHeKj+1Ph4+AzeGmLaaco0rvIDVBG24ISVXIb6LVcnZK0OkZsNIo57bdFwJBtANYb28Yydtob/Z1VFaU1YAAfbkHmanXAva1FkR5nVFadEdvM6pGZeAVNF+9Vy9BsPGv4FrXGk7vjAcxo8KSbZU2dtRwEelZ7r8oYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465103; c=relaxed/simple;
	bh=yDOevjl9/3Scra8njCk7go9N9fHFm7QgYzrojjkktOE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ixQxgZEni3ajOYo5zeBzftt2xZCkk2CLAD2D5Qrv0wWQCLHy2cRi0TPyfCJVyuTDAieUIQlDq+V0gvH1naj94T9vOLhFFa/eb1IwmmvlEBtLECSScKassvkq0T7t/UDXfnAtEfkLTCN25VhM6K3XNMU/Cz3vpLa2HWUmFvA3lQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaVPYfZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71E2C116B1;
	Mon,  8 Jul 2024 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720465103;
	bh=yDOevjl9/3Scra8njCk7go9N9fHFm7QgYzrojjkktOE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZaVPYfZWSlJqTSqII31rl/oKcbzNPFVfwkUHPNbXeF/lYHw7y3Jh2Ggnx6ypfA09x
	 RAA5LLL37h4tzCd5cSzC1fYt6UiHdshAhTQ9zNoaRsViDz8RKzGrwS+erMgzKK5BYH
	 1A8YCeEI/P9rjDOqvJIR0fTTOCQyvWOgsM2eo9X7cRLT86epvSeupKXky42nR3UGmB
	 zkCopa1K29YmC1M7HH1G6O+ML/lY/s3vnzxPN+llMos6E6994dt5SjYicD+Fahx53k
	 OTjmMR7/2uIDs71U4KqYGgs2IhEbzrf61L4VVDFD86YmuoV1aqZHVCp1hAIzA8bccg
	 /hy7EtCdYWf/g==
Message-ID: <e00b0f47acb3aefd9c936189d9442008.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240701205809.1978389-1-Frank.Li@nxp.com>
References: <20240701205809.1978389-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: clock: qoriq-clock: convert to yaml format
From: Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev
To: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 08 Jul 2024 11:58:20 -0700
User-Agent: alot/0.10

Quoting Frank Li (2024-07-01 13:58:08)
> Convert qoria-clock DT binding to yaml format. Split to two files
> qoriq-clock.yaml and qoriq-clock-legancy.yaml.
>=20
> Addtional change:
> - Remove clock consumer part in example
> - Fixed example dts error
> - Deprecated legancy node
> - fsl,b4420-clockgen and fsl,b4860-clockgen fallback to fsl,b4-clockgen.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Applied to clk-next

