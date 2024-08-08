Return-Path: <linux-kernel+bounces-280083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665694C57A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9EF287ED3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892C415687C;
	Thu,  8 Aug 2024 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQG9Chvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943C2F23;
	Thu,  8 Aug 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723146793; cv=none; b=WmKyvlULcBxLSwF8u4lIUB+weur9Dk2ZVrUJxd3jytK6mUQXp+j501A6ptQZ0m5hTLzkwKOBV13O5q118emzWI68XXu75GB7FY24gtp2PM+nkwh5ZFaWWAf9rixnRKViwzYNVKJBp1JIzeBUxCT1Fl8p44HuO16lHyvl4E89Gjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723146793; c=relaxed/simple;
	bh=xpJ0dd8VMGGYHW/zJxoX/HZgvtfA8IkXsj+iL2ZUP1w=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Fz9w1fNF3+uxp4jViYsLRjajWVmVlJHNLyKwvxMgjjYz2zn63d9IjF5mtyziGlSu6lTAEq2o4ZEj5aEOfUXUJPYUtReSy6OWuTxSs3YUiZ52C4OzVOLm+UwRs+Fw/puKwlPFtZPkXl2BoMA9Kij42KN8j+8et/+wqDZMKXxBjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQG9Chvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38077C32782;
	Thu,  8 Aug 2024 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723146793;
	bh=xpJ0dd8VMGGYHW/zJxoX/HZgvtfA8IkXsj+iL2ZUP1w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sQG9Chvg6YPJEuw7/GdzpZ6T9BAHhBuBqUeA8zBbYW4V4MGTLn7BaysNKMCUoVpNa
	 eU1MkfW6wkfGDhcvPI7xF8zY057h9Cb117VSaXVXiQrNbmXjAsdqcsQS38vibYvAmi
	 lY+uEVGJMn2KIEpNr1KJmdOYjWEHmxK2tQpmdo9mt+i04IQoFrs8xK1+mjem9LEs3f
	 LBP0yxa45dpug2BErzfoFwJdOMHgaZtgiL8kKsZjKOQ9B20T4VhEDwG8yZ9/utcfH+
	 uc6W7McXIVKKaf1nbeo6qyJgY9Th1s1RHB+cLujov1l38k8h+b/qPIV5LPDYAQFKEv
	 L7zu7EiIo4iXQ==
Message-ID: <8cfb858e91af19734c675d85af5a9043.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240801103616.20430-1-thorsten.blum@toblux.com>
References: <20240801103616.20430-1-thorsten.blum@toblux.com>
Subject: Re: [PATCH v2] clk: hisilicon: Remove unnecessary local variable
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, christophe.jaillet@wanadoo.fr, erick.archer@gmx.com, gustavoars@kernel.org, mturquette@baylibre.com, u.kleine-koenig@pengutronix.de
Date: Thu, 08 Aug 2024 12:53:11 -0700
User-Agent: alot/0.10

Quoting Thorsten Blum (2024-08-01 03:36:16)
> The local u64 variable refdiv_val has the same value as the local u32
> variable val and can be removed. Remove it and use val directly as the
> divisor to also remove the following Coccinelle/coccicheck warning
> reported by do_div.cocci:
>=20
>   WARNING: do_div() does a 64-by-32 division, please consider using div64=
_u64 instead
>=20
> Use the preferred div_u64() function instead of the do_div() macro.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---

Applied to clk-next

