Return-Path: <linux-kernel+bounces-535257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E1A470A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06363AC495
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB220DF4;
	Thu, 27 Feb 2025 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSUlTSt1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47878C11;
	Thu, 27 Feb 2025 01:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618203; cv=none; b=Pgsxt/IGjQyP6Oq40ljO18t4Qg5Fis60L0aHUwvvQaSeI0t650qXvUUk/fdoSHU3fviGqdOYVKEupheZnDONMSvSFUfrExal5lijb63vbgZX43Nyg0/eoJK4sKhhOLirX68I1l3tCQMLFBlphEkWj3GU16gaUrjz+OwzGgkTSe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618203; c=relaxed/simple;
	bh=UmvSJoA4V9widGtTEXST3uDxkbKiOKmRYCx2G+QD7wc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=OLl/hETOjsfqDLhGfda9BhDqoqKhnAus6xeFItySAL8ix756fMJ/PppgXgUiNqz3D/8IOhfhUE7q9sIAqTby+BVGEHEM43iN8Lw3tFEHh8EAqwpsVxujRFM3HeeULhc2J/vNCvczY0TmyJFlg4aTfwwgpIHmJyKSl9RkWOreYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSUlTSt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6D4C4CED6;
	Thu, 27 Feb 2025 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740618203;
	bh=UmvSJoA4V9widGtTEXST3uDxkbKiOKmRYCx2G+QD7wc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sSUlTSt1fdw9WDJk1UX25ffpH2sRCJeklA71dTRCMs7h07iGQ8N/dSx5B42GmA5Kr
	 orkaTDL3g8nJWkp8W5eaCBKh1vrDWfv6I9o3ODk88d2gCrEaKQUYRxoI6hRxXM5NdG
	 zBMP6U7mU+C4Kd0nnlky6+HJu6J+mU/NsLfx7vfQOBFgnbHL2BrXKgbl7SGWJ1GKOh
	 SyvzT1zLSiQzR9Kl2KMA1dfCV/3HkiscWmy2Q/lwETVD8tc6xkxQakfFGI0C8w+qEc
	 TRk7+mr3NWbm+xD/gA28rgZ8fcHVoNCGFNmlEcbIQbZeS54ltjSvjgP/PPTar+EE0g
	 0IZl2YcueDiwQ==
Message-ID: <714808f633d097b96082e1e418ad2205.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
References: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek,mt8188: Add VDO1_DPI1_HDMI clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, u.kleine-koenig@baylibre.com, amergnat@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, kernel@collabora.com, macpaul.lin@mediatek.com, pablo.sun@mediatek.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Wed, 26 Feb 2025 17:03:21 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting AngeloGioacchino Del Regno (2025-02-12 02:03:41)
> Add binding for the HDMI TX clock found in the VDO1 controller.
> While at it, also remove the unused CLK_VDO1_NR_CLK.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

