Return-Path: <linux-kernel+bounces-449891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636309F577A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D25169741
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211561F9AAE;
	Tue, 17 Dec 2024 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAMdd9LQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FA170822;
	Tue, 17 Dec 2024 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466609; cv=none; b=JZ2CCSU+L5rreIRj9zqIclDr9NJ9pTRASAby4/X5uUEZbf/x8i88h3azjTuEBlxN4otroCmAQX8Yds2M+XMWK2LlaWgcavvklHDgvzXz+lzAWBDSkZLK5d8BJjQ7ye9g2gWLOt8TUR1X7VFGL8QlS6aGv4Y5XMvDELRR+ZWQvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466609; c=relaxed/simple;
	bh=yixcSNWS2aBo36Xmnl/o1huimUZFWZVKA3OcNsvF0Cs=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=LjqrQ0pdAT/gDq8AEnuQ36rlXUC/8gPuN8xQTo7X+00uM7VSoQK6TIiXUfbSVr9OosXytyzO+ffgdgkF8h2W7KBKOAMKRnD6dpTc1COMwm6ecbkB3a00+gg6KXERUXwdwfQ0CxflzHGqni5dqqZW52qK467FC9nYnRy50fqe/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAMdd9LQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E1FC4CED3;
	Tue, 17 Dec 2024 20:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734466609;
	bh=yixcSNWS2aBo36Xmnl/o1huimUZFWZVKA3OcNsvF0Cs=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=WAMdd9LQsfnz9/vyEja4yJloAFGc52bQ/F69m1gk1MPhD//5uhhNSCb7guTyBLKBx
	 jn5bF9ciDbf6XDNwAskJmAPDrt/WqRELGrv8hj9RLmE3pM1mY1OdDWxq8DmUSfEhup
	 IPsb1ha8YP6IR97oL6/xSNlb84OvXaJoClafsO+6IMOHQabhsFS49jZCL6GGbw7HQA
	 Jx8ebFfgvVynhOMFym/IM64Vs/Ir/53xme43Gex/Ils144NKo25pg5HkVBGn3oxejA
	 0TJoK9FbDmD8mcohw+NLno0BwFCu0TFtqj9uvxojFSpfPBDOSe3SK2Urxa9IWHCHhB
	 82b6ivbv1rsnA==
Message-ID: <0c57146b35f7f15510220ca25ebf565c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9de23440fcba1ffef9e77d58c9f505105e57a250.1734300668.git.daniel@makrotopia.org>
References: <b126a5577f3667ef19b1b5feea5e70174084fb03.1734300668.git.daniel@makrotopia.org> <9de23440fcba1ffef9e77d58c9f505105e57a250.1734300668.git.daniel@makrotopia.org>
Subject: Re: [PATCH 4/5] clk: mediatek: mt2701-mm: add missing dummy clk
From: Stephen Boyd <sboyd@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Geert Uytterhoeven <geert+renesas@glider.be>, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Miles Chen <miles.chen@mediatek.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Date: Tue, 17 Dec 2024 12:16:46 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Daniel Golle (2024-12-15 14:14:34)
> Add dummy clk which was missed during the conversion to
> mtk_clk_pdev_probe() and is required for the existing DT bindings to
> keep working.
>=20
> Fixes: 65c10c50c9c7 ("clk: mediatek: Migrate to mtk_clk_pdev_probe() for =
multimedia clocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next

