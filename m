Return-Path: <linux-kernel+bounces-196913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181C98D6381
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD76B23661
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E115AAD6;
	Fri, 31 May 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwEGLc+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E81422DC;
	Fri, 31 May 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163518; cv=none; b=HHkXZOP5PYFImLr4SGtHrwLTUdRHlpwGyzCwO7ReVUF04jS4PhLpWqZUF2L6Pp5NlKFZJEONq583JiZrLX3vmd2i70mHp5Lr2oP5C/FEIdmNqa0XsRyb7WFYiJqb5SI81lPRvNrSdaDcdKiGgeyKl129YULlj0HjnQo795UOkE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163518; c=relaxed/simple;
	bh=ZLFkgp0st89FLzWtvHCzJtpMDWqn9ddfK5U7FlGjMYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JRqY/UibeztDUYCZ3W8McSQYHKcs5JUFUu0s0osOdtw/IW5q/96E1lU2RioVvVPXXmVPfnfGgI2ZOcYtYR7tOYoCSNquMTsFgq760yzsoi69AmGA2ukRSUNNAQM5OEQLpqsgSK4lNNrJDkmKq+9rrtR1kea5baSqGZzxa7pkQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwEGLc+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAC6C116B1;
	Fri, 31 May 2024 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717163517;
	bh=ZLFkgp0st89FLzWtvHCzJtpMDWqn9ddfK5U7FlGjMYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TwEGLc+XlwUMXPYNsDsN6Ig+TdBfRDLS2l2cpDTAPxLfB7HfSvD/nJVkOds9Ryebt
	 gyFP0C3E9IXLijews69ycBXVATbbW2e9088KOLeDLB3nQdvlrBsxtlnfmdAoki6nfJ
	 r5KTONlV5h+k/E5PPaWH41J0A6cVYbOy9BA9JPawXz+Wn6fG5ojCH1tsXhdsvos5YD
	 jrssIPJG9mA56h9Vb3FYB+PksD89PahVtj352Rlfj6k/muKmbdE1hZvdXcnNzojuZZ
	 LkxoD6EA/eJSXuuGvR8Iq2bZ/Vzqm36ECAdVyC3zzJguGdh4XYDKLn2wFe/XaksUtW
	 h7ai04owVO5sg==
From: Lee Jones <lee@kernel.org>
To: linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, matthias.bgg@gmail.com, mandyjh.liu@mediatek.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 jpanis@baylibre.com
In-Reply-To: <20240527093908.97574-2-angelogioacchino.delregno@collabora.com>
References: <20240527093908.97574-1-angelogioacchino.delregno@collabora.com>
 <20240527093908.97574-2-angelogioacchino.delregno@collabora.com>
Subject: Re: (subset) [PATCH 1/5] dt-bindings: mfd: mediatek,mt8195-scpsys:
 Add support for MT8188
Message-Id: <171716351496.1109202.13130330673737183145.b4-ty@kernel.org>
Date: Fri, 31 May 2024 14:51:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 27 May 2024 11:39:04 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the scpsys block found in the MediaTek
> MT8188 SoC.
> 
> 

Applied, thanks!

[1/5] dt-bindings: mfd: mediatek,mt8195-scpsys: Add support for MT8188
      commit: 5b8d73b7e1ceb2578f74d0a119a4b4a4be690d2e

--
Lee Jones [李琼斯]


