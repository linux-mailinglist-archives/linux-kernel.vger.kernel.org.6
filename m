Return-Path: <linux-kernel+bounces-370675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7C9A3092
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3C11F23542
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707081D79B7;
	Thu, 17 Oct 2024 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdV1IPcM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEC1D54E9;
	Thu, 17 Oct 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203770; cv=none; b=sUDxN3sLUUr4z76UldUqfT8ZXAKy2ihtr5SpASL4vSATgINqSLNGGLGT+FOZfUILOmteggOBI0ltFTZ0g2bd8JOaMMp0bT/BOy3N6v+sFL8JShBxr3srmPDN+p7a1NjWlzcJM6q1QVQkeXoMJvHcJmLR49akeOMGqSyQEPrRs1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203770; c=relaxed/simple;
	bh=nwZJpFaMGkIfJiwNAu/kb2SQ2syXsOgdOQCJzbi6/fE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=nqb5d1xG6QQWL08gChZtYM1iC+BJjhQL+d5SaNg/yQ15lJ5Dqcj3PGGNUHGidYwyldybhOjTG6+DT+rRnhhkvO5FLoXQMjYTuT3HCB3J2I86RzuPn0bSVD2iC6Sa4sRTBkbx8LpBgxUHqLx7RKMAjCRBA/+f0gWqCPNW3Ovh7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdV1IPcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5D0C4CEC3;
	Thu, 17 Oct 2024 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729203770;
	bh=nwZJpFaMGkIfJiwNAu/kb2SQ2syXsOgdOQCJzbi6/fE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GdV1IPcM10+H6sFnd8NYu7K0PWRGUbsmZFp8bicC/7fby30Z9/6vC7j+rcnYeXb/p
	 2ptfEOMuDuTjjimma2lFuqBT9zx2hlEGQsMwVpG39ubat7p1iPtL9dUSv8ViCoVjSX
	 G6Hz01Ikw7KVE9xpAgqpn3dbCnOT8bsvHEWJiKXMJr+IokT/OaSWLaPmivNyn/0LOS
	 CArW+2A3T/pt6Nq8iYKFHXLzh6jiZxrAaf9bgXSp5vXoRZW9EfO4tzXwAHKnPGf+w/
	 S/aJXr748ckabDH7O9tpjV7e8Eagaud1OGAqHjVK+7AE0UqVh/okEmK4dmNWZwTDjL
	 /ySNsSsmYrkjA==
Message-ID: <46ce613f0e6e5c656f943f5572e95d45.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240912191038.981105-2-tmaimon77@gmail.com>
References: <20240912191038.981105-1-tmaimon77@gmail.com> <20240912191038.981105-2-tmaimon77@gmail.com>
Subject: Re: [PATCH v28 1/3] dt-bindings: reset: npcm: add clock properties
From: Stephen Boyd <sboyd@kernel.org>
Cc: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>, benjaminfair@google.com, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh+dt@kernel.org, tali.perry1@gmail.com, venture@google.com, yuenn@google.com
Date: Thu, 17 Oct 2024 15:22:48 -0700
User-Agent: alot/0.10

Quoting Tomer Maimon (2024-09-12 12:10:36)
> This commit adds a 25MHz reference clock and clock-cell properties to
> the NPCM reset document. The addition is necessitated by the integration
> of the NPCM8xx clock auxiliary bus device into the NPCM reset driver.
>=20
> The inclusion of the NPCM8xx clock properties in the reset document is
> crucial as the reset block also serves as a clock provider for the
> NPCM8xx clock. This enhancement is intended to facilitate the use of the
> NPCM8xx clock driver.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

