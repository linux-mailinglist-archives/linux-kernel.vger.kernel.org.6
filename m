Return-Path: <linux-kernel+bounces-175019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898408C1926
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB821C21988
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EE5129A74;
	Thu,  9 May 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjBWtkbQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA13770E1;
	Thu,  9 May 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715292280; cv=none; b=ifF9ppNiaiKjzSzq0SR7XwhSqW09CJRMXi7BkD1dtOkXmkfWC7HceLDjr4RonsfexaEajCIyOTxv48UVQd3UF9WOXr3RPy9J+y/6wydjc/EefbGCaw2yZjFn+O7NVNIA1Bw91letgL6gDoZcKTyCDDNzje/tHV4IMATZ9XZQXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715292280; c=relaxed/simple;
	bh=7gPgGGhzqbWeWTGTGS5DOD8uP4T4s0EMtmjOqfp966o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XS4PXbeCXqNe+yf0PmsxE14a6otpzrfOyZ5Nsftr/t7CVN0XJ2j/eHgKmakev4pJYJDCAH8L+rE7f27KyqPpgqLJxmSsdFYrahW9aDXHtboDh+eiit0mCrB1vlu6Rx/U8Nd8+ZRjQw2EZy1YtUXpmjDp8Z4zHaVi7GeddHx0vjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjBWtkbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B3C116B1;
	Thu,  9 May 2024 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715292279;
	bh=7gPgGGhzqbWeWTGTGS5DOD8uP4T4s0EMtmjOqfp966o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=BjBWtkbQkejiBzPjRfA7YpEimCD6+Ur9ISPPqYPMI9TlRb9d1GmT7LGSEucFx4se2
	 lZvS9ifFbqkc7WTPvcqTJxaXYBiphrLUs9tyskUJydO5mfYywZnK6DNxwyQFBoPsnL
	 UQmBHj606z/IXKC1iATEEeLgn27SDD4Ky/m9xuiNLTWJXQrEO9upY5gAlBx1pk1tZ3
	 PWLENqqSlJVhH5gX3LqnGGUJ+X0J8+PoD8qcRzbyJAFKoT3AKC1jaWr4RPxVxcjjdf
	 /Dmc04fSsExWXkds9khAAaoljxixOsQw/s9lvrGUg/ribn+HsqISuZSvcvFnaaxWuP
	 jdlj93MDfbnHw==
Message-ID: <0d10a689504be61c50b186d89ddbf9d1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1715219038-32453-3-git-send-email-shengjiu.wang@nxp.com>
References: <1715219038-32453-1-git-send-email-shengjiu.wang@nxp.com> <1715219038-32453-3-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/4] clk: imx: clk-audiomix: Add reset controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, conor+dt@kernel.org, festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, krzk+dt@kernel.org, marex@denx.de, mturquette@baylibre.com, peng.fan@nxp.com, robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, shengjiu.wang@gmail.com
Date: Thu, 09 May 2024 15:04:37 -0700
User-Agent: alot/0.10

Quoting Shengjiu Wang (2024-05-08 18:43:56)
> Audiomix block control can be a reset controller for
> Enhanced Audio Return Channel (EARC), which is one of
> modules in this audiomix subsystem.
>=20
> The EARC PHY software reset and EARC controller software
> reset need to be supported.

Can you move this to drivers/reset and use auxiliary device APIs to do
that? The idea would be to have reset maintainers review reset code.

