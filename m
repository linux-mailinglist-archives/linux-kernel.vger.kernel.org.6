Return-Path: <linux-kernel+bounces-357985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AA9978C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D737A1F229AB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DE1E2839;
	Wed,  9 Oct 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/Llr7Om"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A34190499;
	Wed,  9 Oct 2024 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514762; cv=none; b=ryE/zbwMaeXm+wEJFECMJYppeA/u2e7+YyJezgINhIyPYgXoTaWMOBqB1WnLoAl1y5LbnVaeLbdsF3umVmjrvaAqYGXYBbyYCAHsZ5XwdUhiRYfM9ZCVnNrLwWymLSVptKqNJ1sprBfL2mnQ4Qom5E8oKNdmUSHwjAXzkU5SD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514762; c=relaxed/simple;
	bh=+hV9ctvyE/5w7nQBVOLafrusMSwAuRpOy+IJ31YSq6o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=glW/rL2rfjGpUdjhPhVB9FLmBHS0yAu+40lMSzVa/v8NnNLFzGTmRp7k/FphnAKBt9ePS+vwHG5VMcOquuo5zoOMpN5bCp5BiMYsZSR8QTZlOxyXhhy50ZJUnZbUDhKUlgbPwRQCh9DnJRtk6xlHUmBDqsDVNItI0lxU/G/0iuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/Llr7Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48232C4CEC3;
	Wed,  9 Oct 2024 22:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728514762;
	bh=+hV9ctvyE/5w7nQBVOLafrusMSwAuRpOy+IJ31YSq6o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=j/Llr7Om47okBfrDjzOJvoH2+dab946xBe1qYAGDdj6+CoSsyeJ4yoSsUa3jPl0Rd
	 mUmVOdIjQeRt5Z+Cpm+eZVUOtOP4itHJijvlihxYM1XP6vGjPvBQrqNvXOvkuBlt90
	 Yh/7vWMyTL0N4ekz9RVRmgZz+AdCx2BnqWeaG9ftiOfptNSsJiZcn87Qm1pYdpcVqs
	 Shgun+9xNCkabBmLqq7DepYB7UNlQWN9otwaeHQ3kkna7A7hjAzMLV9DUSlvHuIdrc
	 7BOU//xDSeeu93meZrXBrIOwEZtoVt2QjdNuMPeXkNOyJINpZri8X3J/OYktkQWM/P
	 LwQqWgK/iolng==
Message-ID: <8e4d80ebeb8400d27f1ccd88716bc99a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240911143429.850071-2-fshao@chromium.org>
References: <20240911143429.850071-1-fshao@chromium.org> <20240911143429.850071-2-fshao@chromium.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: spmi: spmi-mtk-pmif: Add compatible for MT8188
From: Stephen Boyd <sboyd@kernel.org>
Cc: Fei Shao <fshao@chromium.org>, Rob Herring (Arm) <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Date: Wed, 09 Oct 2024 15:59:20 -0700
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Fei Shao (2024-09-11 07:33:54)
> Add compatible string for the SPMI block on MT8188 SoC, which is
> compatible with the one used on MT8195.
>=20
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---

Applied to spmi-next

