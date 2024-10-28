Return-Path: <linux-kernel+bounces-386052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0539B3E90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00502834F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F41FAC33;
	Mon, 28 Oct 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1ujTSIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5171925B3;
	Mon, 28 Oct 2024 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158683; cv=none; b=DiD4H/oxOYl4B0TUEfL7nQu3SHibeJcqHoDeGvNNXuL6pfL5h+51W2cqY9a7Orh3Y4/hd2RTSlCoPTdHqb9YmqG5uWqthtVqZ4GhoPW3OkyFFlZLGbqnXmHUALqwExte2fBq3KD8qbO8Am1UZAeN5/BZY+AQreardH3iwGh4MWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158683; c=relaxed/simple;
	bh=ZGY1bK+sHnLUkH88C1pwQz0YVPZ7fB5D5JiY1sN7onk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=GzZvgjqC8HZqmzdKXWX7l67j1MwiEXXHjOXcX04AxRyU1+qv8QGrGT+WsVJHIVMPcgGYjz1jaKRraV4ue3zMZSUfOs44JnOlhK42vE4y3SB3Gu46L/Vil4zHwcrWWZEF8dOnRGOQHYSI16XiQG+o1jrpME90Utleq1JZnElYBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1ujTSIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1727C4CEC3;
	Mon, 28 Oct 2024 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158682;
	bh=ZGY1bK+sHnLUkH88C1pwQz0YVPZ7fB5D5JiY1sN7onk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=V1ujTSIob5uW9cDHujdRroOfNOniLOotz92izX4K8tlhoo7+sT37Gy3U1zrpZ6sGA
	 cbbg8TXfJlUBW0tocfmsacMZHx7yb3jC1mgVyKr06wnBJrJfimqiQu31z9kTBHv6HK
	 cEm/l6Fk8qXm+RBg6m/rVV0T8AMlJJEwyNEBOolO36o8Hh6BDUSmkgydPIlSiKzQ9d
	 zmrHbgEjVi5P4rsc5Pevi29ybB6gwqAhksHF0OkVaA6QL4yVhlS61KIKWrrbPdLJYx
	 hBT03MW7Ahlsr01yYkMfTwYBaNwnpbmciLjYWvih2sHmDb2iBMguhLSoktZn4zDN+8
	 OVPVcsuwiKJew==
Message-ID: <1be883e74445353163ed94f273aa4a0d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241023-mbly-clk-v6-1-ca83e43daf93@bootlin.com>
References: <20241023-mbly-clk-v6-1-ca83e43daf93@bootlin.com>
Subject: Re: [PATCH v6] clk: eyeq: add driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mips@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Mon, 28 Oct 2024 16:38:00 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-23 03:58:40)
> Add Mobileye EyeQ5, EyeQ6L and EyeQ6H clock controller driver. It is
> both a platform driver and a hook onto of_clk_init() used for clocks
> required early (GIC timer, UARTs).
>=20
> For some compatible, it is both at the same time. eqc_early_init()
> initialises early PLLs and exposes its own clock provider. It marks
> other clocks as deferred. eqc_probe() adds all remaining clocks using
> another clock provider.
>=20
> It exposes read-only PLLs derived from the main crystal on board.
> It also exposes another type of clocks: divider clocks.
> They always have even divisors and have one PLL as parent.
>=20
> This driver also bears the responsability for optional reset and pinctrl
> auxiliary devices. The match data attached to the devicetree node
> compatible indicate if such devices should be created. They all get
> passed a pointer to the start of the OLB region.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

