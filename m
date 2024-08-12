Return-Path: <linux-kernel+bounces-283772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7D494F88E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5125F1C20D61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654D61991DF;
	Mon, 12 Aug 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUdVZaN7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2B19F47E;
	Mon, 12 Aug 2024 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495761; cv=none; b=e+1hwlbLIbGtnOwnQaxWz8DlLo8xPre2JeYBi6DOwuzvuykxJqsHV5j+18wNP3L1PLB/JBCo189PvG6uUa0kzRoJyUqqu0VXR3DD3YEJkoWACIaGPGmDcTul6Q/OQE/lfvGDlBev3grAQ+q73c5zITqJidwtas4UUmFLBKrzZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495761; c=relaxed/simple;
	bh=u2HZKyQIlRWTm/LdwqubpDUwV197NKUKNRzzO+49+WA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FCnUMpSlYN1Vppu4lP2a5g4+4XlB0umKuWZaPHfnuNquAWmK2imvy0qHsvMPnyZbPq93+ExMKevv3Inenoc1HLtf88hjuvsQu7URyeBjZXE2eX/8h5u5CcNGtIjrt29WTxwowKIVSvsBrxsXc4DYzGoTgDCpw+x1KTekIfR5mFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUdVZaN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32008C4AF12;
	Mon, 12 Aug 2024 20:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723495761;
	bh=u2HZKyQIlRWTm/LdwqubpDUwV197NKUKNRzzO+49+WA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WUdVZaN77H8UjrVyJ5W/Co9aB1M42l0It5ciH8J8rlYMUUI/pG71qmaMndv49E6C9
	 lvY7LMqIgiARqs0sGcJIh8wfrCHD+eZttZMrUWwcb8vO+Yps/70Zw+PJdvgFOuNQyd
	 X6fy2EegfDuMh3ZGNvIYkAwMBufhu/Lf9E4wbu+kvUYw1FmW3zcR7x80KtTCSo6Pd0
	 htTrGaaSUO/lPYMnqpHea1fwRmt3w9YACEZENO1xqKrWEuUQdk0JRQkps17s3Amy8E
	 b+Nc7ZRfxQ3LdU9gL2mrJ41D6k+K5i3NoQbLAU+lOqL2DonJpF+7aMWN7qBMRjtEO5
	 5iHfjG1D3W1lQ==
Message-ID: <c71cbc08ad285cd494742cd735e1e3fb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240807-dt-mediatek-clk-v1-3-e8d568abfd48@kernel.org>
References: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org> <20240807-dt-mediatek-clk-v1-3-e8d568abfd48@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: clock: mediatek: Convert MediaTek clock syscons to schema
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Chun-Jie Chen <chun-jie.chen@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Mon, 12 Aug 2024 13:49:19 -0700
User-Agent: alot/0.10

Quoting Rob Herring (Arm) (2024-08-07 09:58:55)
> Convert the various MediaTek syscon bindings which are a clock provider
> into DT schema format. As they are all the same other than compatible
> string, combine them into a single schema file.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

