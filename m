Return-Path: <linux-kernel+bounces-409929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685C9C9384
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65435281E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E21AC8B9;
	Thu, 14 Nov 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqTZ4yZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AF18DF89;
	Thu, 14 Nov 2024 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617641; cv=none; b=ipm9lKSuLA/UiVKRai8vYyqJUOmBf3nE6azMSjznFiEI4iwLZVG+Oxt6tJ2Sh3q5oc/H8RIh2AoJB3w2BJHxaLKIGvqWgeKgaUOQyPVBNcxTUmnD5NBKKpto9+GkUfxIHUAgxNsQeZIJE+3kI7BEMKOvAbrymwyKjWkhTGZksFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617641; c=relaxed/simple;
	bh=9mjzFkEkJtHnZspQgtsajvCHGdLxhnmxNqfgsXx/HVQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=VA9KNQY1drOdZhrxXtSUZ+lMujUVK+ZmKOCeAM5ZG8+B9v2rTnCfOIdmvm2tQiLyzi4H6eS/12n4GNqhKauVPri+0JgdJxiIBlc6Bkls8rFkv+qnv68Cf3XGJaixw/OcVVWwSVHgsU4PYvXJTLUo0di5QEDkEXXJhqcEOvrutwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqTZ4yZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23696C4CECD;
	Thu, 14 Nov 2024 20:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731617641;
	bh=9mjzFkEkJtHnZspQgtsajvCHGdLxhnmxNqfgsXx/HVQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bqTZ4yZkew2pOSJLPov0I4RZaLSSs/zjoDpjcca4j9xbfcBP/HPQ7R50GlHchaPrp
	 YA7p2/n1oakh92qUR80wtiZB/UAcb3DVP9F5Y/ARKhkEQrMeq2WPDU1Zd5A/7uTF3n
	 tHAAgnNeBthI21C+WuYXpw419UZkO+kMupR7RI8tmgO6SNoQLG63MaJh9YScbzlrWs
	 klFg8RWKUlhyrj3Pf/bvs/kAgTYLmEf4NtgH8qNVfmxLqnAuYrMbJ4NSHnm2dNQKlK
	 z+klvgeexwyR9rvwqq8o305QZO/KizN+S+jYS7ZamPuzl+F+YPpeoT3FYDQmg/L3ld
	 FuIFxwwq15tkQ==
Message-ID: <d716d4e685cc4a88203ee25de3865de1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241106111402.200940-3-y.oudjana@protonmail.com>
References: <20241106111402.200940-1-y.oudjana@protonmail.com> <20241106111402.200940-3-y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 2/2] clk: mediatek: Add drivers for MT6735 syscon clock and reset controllers
From: Stephen Boyd <sboyd@kernel.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sam Shih <sam.shih@mediatek.com>, Yassine Oudjana <y.oudjana@protonmail.com>
Date: Thu, 14 Nov 2024 12:53:58 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Yassine Oudjana (2024-11-06 03:14:37)
> Add drivers for IMGSYS, MFGCFG, VDECSYS and VENCSYS clocks and resets
> on MT6735.
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---

Applied to clk-next

