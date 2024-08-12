Return-Path: <linux-kernel+bounces-283769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E3E94F886
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C641F211EC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAAB1990D3;
	Mon, 12 Aug 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyOcnWJB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84219149E;
	Mon, 12 Aug 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495746; cv=none; b=E1HVkPB68JdmhjCRVMw6U11EKkl6h8di68NkY3ntJYnYN6y8U9lkk/rfgR0WUcRs52mp/NqFoz2JILlIlnMZhE5yDnPXYnkOjoJR+XATs08+fjt6OZI5nejldTAyE/olm7unrBditZQ9MtQvFZ5TgusorlFVaZDAdsjAPDZxxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495746; c=relaxed/simple;
	bh=WQ8usZ1RlfOYVFOCxfGa2d4cHIAOC6KI4xcce7W4NzE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=UBg9tui+HAmsjuTkYGkwZW86U1DvqBjuTp/qIZmdJvzE7ysPq0OFrANGG4GbXVsysDXKrzEv9HVYG1o7rUxWxukSteF6VwG1GxqizPpmyPHhEeXg4fRwrp+nOFzZTyKqYuLVooze+qrrCdzu7KlCDlID0PDavTVoJef9fIs4W3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyOcnWJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393C1C4AF0D;
	Mon, 12 Aug 2024 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723495745;
	bh=WQ8usZ1RlfOYVFOCxfGa2d4cHIAOC6KI4xcce7W4NzE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KyOcnWJBCgaVHvDkK3BaWnxUfRhGPpSLq0zb+KQfru8ZxaE9JzBvf8NC+ujsnEZlN
	 veAPZRaIAQ3WYO2tu+qQHgUn3zYIgvf0/j0h6EirItVppuXugUV8yWPJVWMLTMeQFJ
	 x3dRwX2FxsddRCEIxRgzJr2KofduqW4lDLskPcMfj3w1LBHt3twAv4Djm9BzNuuysQ
	 mLU/LKU3P058xOsG95kPeSa68IpkcD1pLwCr1Jet0ar/+CSzxaxBCTPw5NNGvN9TJ/
	 ZrDupOUjaypDnFCJD/iWGD5CqTTafHLX/EA1p52Q18/hNmNZjPsg3RWW2fRs6GeamK
	 y1dz7GhePXRug==
Message-ID: <02d5ecf54338564b8ea4b59fe39af395.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240807-dt-mediatek-clk-v1-1-e8d568abfd48@kernel.org>
References: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org> <20240807-dt-mediatek-clk-v1-1-e8d568abfd48@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: mediatek,apmixedsys: Fix "mediatek,mt6779-apmixed" compatible
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Chun-Jie Chen <chun-jie.chen@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Mon, 12 Aug 2024 13:49:03 -0700
User-Agent: alot/0.10

Quoting Rob Herring (Arm) (2024-08-07 09:58:53)
> "mediatek,mt6779-apmixed" is the compatible string in use already, not
> "mediatek,mt6779-apmixedsys".
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

