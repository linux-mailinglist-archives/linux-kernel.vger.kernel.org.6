Return-Path: <linux-kernel+bounces-370505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD59A2DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95A31C245DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593EF227397;
	Thu, 17 Oct 2024 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdVfDNpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390A22737E;
	Thu, 17 Oct 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193106; cv=none; b=iqyjXJqKlGXt9hPS2fJoTCSiPioiDaNtFCjXKAdSv3eXYEwDwITSFF+/Nu+cMuSk56XVrG4yu+y+eWa2GQVHX5z0sfpwJ7e6s4cKyQRK5O1EEF2xHnXUulG8gItEQhd7z8d8Qmv0sUbl7hI8hNkjm6sxVX1f+sujopoo6rO2p6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193106; c=relaxed/simple;
	bh=E89hryLxgKiF/GmdeFH0jIvDQbgZ8NL6L5dKM51hM+E=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=anYiWVFSazgrZlYDjVL/QL/hgQg9RSmrAQkiBXhlgqUgpxKitFHSSX3ZfRAGBRG7DcwKvsfUtYfkR63+rYx8ESJHFmxuOFb/vuMWOsBlEIAAILEsEo3+ecNA/GSIQIKK9s5RJljrT821CFFw4M3hFUJk4Qb2R4KKEo9rnsOpNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdVfDNpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F66FC4CEC3;
	Thu, 17 Oct 2024 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729193106;
	bh=E89hryLxgKiF/GmdeFH0jIvDQbgZ8NL6L5dKM51hM+E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tdVfDNpI9yLmY7DxePm14sqBwMo5ii05QPABekiRvSI+nObMfBPAUUubx78jTxvuS
	 gmzdn0VjgdJDAz1bcfFdPy8DWMfhzViV06rQYw5+ii1OujVrlA9oVj7EZ1kLaL6oLg
	 arSXURs+JG8aBP4I5xpuTL6EvLXqG3NwsJWiz4vq1QM524fDyKaGWyzGglDq57VLTO
	 Zy5UvHuOzQAVU+h5HQJtS+QIBMsiwPbGLUi5JQX4Pp8PA3+yoZvaghoyLvJHfXapZN
	 swh24zJetDqkNslAKHJrfU/RGkPmE38AF/Cq+DhoVr1EjRVexqbdPmGA6PklzxsVC+
	 D5Nc+EXSudn7g==
Message-ID: <d1b1c3cfb6b97c32aa63a07d3468a1f7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241017071708.38663-2-y.oudjana@protonmail.com>
References: <20241017071708.38663-1-y.oudjana@protonmail.com> <20241017071708.38663-2-y.oudjana@protonmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: clock: Add MediaTek MT6735 clock and reset bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Yassine Oudjana <y.oudjana@protonmail.com>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sam Shih <sam.shih@mediatek.com>, Yassine Oudjana <yassine.oudjana@gmail.com>
Date: Thu, 17 Oct 2024 12:25:04 -0700
User-Agent: alot/0.10

Quoting Yassine Oudjana (2024-10-17 00:17:05)
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> Add clock definitions for the main clock and reset controllers of MT6735
> (apmixedsys, topckgen, infracfg and pericfg).
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---

Applied to clk-next

