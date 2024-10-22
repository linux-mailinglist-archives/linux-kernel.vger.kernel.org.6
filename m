Return-Path: <linux-kernel+bounces-375961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655089A9DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D868BB23933
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4F194C96;
	Tue, 22 Oct 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RrPFZbvg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758C22083;
	Tue, 22 Oct 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587905; cv=none; b=iJ3O7xQIoal+7wde7fwN8vO5i/n0Hf+4FQwX/ElL04iXYms5IjGu9CR87hnnKBc82DzelrPxsU29N/E1jkZrutER/RLjj/8lFxvZ7Bw3hxVNoEMBvmZltsG50uLx7m05uRpb3aIiJzUHgIITexgv2dj7L+1vEEyQA1Em2BKXlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587905; c=relaxed/simple;
	bh=5iu6JqvvAtNgyBgmiOLgxENxQr9OSKzp8LjyujT2ZTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB+r3oUfyo3ZXBKXlBFqlV/lXFXH3CmlNds9lwvMszZApB9ZCN3pcjLVumN9tyUsr/tFXxL4uCswQL/fj0Fa2zUd4yaInfzJNI6xg0iUcn7aiass1Lbacd/48ILHGu4p59RKsXuPUeji2nrmzyfrw7fDb3gPGG3f0x9uapDp+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RrPFZbvg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729587901;
	bh=5iu6JqvvAtNgyBgmiOLgxENxQr9OSKzp8LjyujT2ZTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RrPFZbvgm/IfWOJmUOAv8ZJB4bNUTP+Tfu7cUrikht4HUak/YTmWQ/P09iheSjDQQ
	 lPyiywZQZCdzbBHILAEWKTyYuLsN1AJcb3fWTN6b9KzZaXYTnSZB83mMGCY/ximD3N
	 oaxSRnNdrZAqQGJoA3Fah5xgEUlafcxPzQc2QDRVTQc4O3JGA9Qsh6x5ZiZ27jadkh
	 lF9t+MmbLjO15+ONNL7ZRlLF2nU2KSik8NfZl7pZzAYScTGdmbN15z40r7xMzyXv8G
	 gkzpwGu6Dbb2bN+OysdBltqDNn3DyPzY98+uVvJ9tLr1ezFo3cV6TVsTpLTY5LMu6v
	 dabizLxHPp6BQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 53F3417E124E;
	Tue, 22 Oct 2024 11:05:00 +0200 (CEST)
Message-ID: <3a550c82-7099-4544-bdff-e1ea411b1636@collabora.com>
Date: Tue, 22 Oct 2024 11:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clock: mediatek: Add bindings for MT6735
 syscon clock and reset controllers
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Daniel Golle <daniel@makrotopia.org>, Sam Shih <sam.shih@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20241021121618.151079-1-y.oudjana@protonmail.com>
 <20241021121618.151079-2-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241021121618.151079-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/10/24 14:16, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add device tree bindings for syscon clock and reset controllers (IMGSYS,
> MFGCFG, VDECSYS and VENCSYS).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   .../bindings/clock/mediatek,syscon.yaml           |  4 ++++
>   MAINTAINERS                                       |  6 ++++++
>   .../dt-bindings/clock/mediatek,mt6735-imgsys.h    | 15 +++++++++++++++
>   .../dt-bindings/clock/mediatek,mt6735-mfgcfg.h    |  8 ++++++++
>   .../dt-bindings/clock/mediatek,mt6735-vdecsys.h   |  9 +++++++++
>   .../dt-bindings/clock/mediatek,mt6735-vencsys.h   | 11 +++++++++++
>   .../dt-bindings/reset/mediatek,mt6735-mfgcfg.h    |  9 +++++++++
>   .../dt-bindings/reset/mediatek,mt6735-vdecsys.h   | 10 ++++++++++
>   8 files changed, 72 insertions(+)
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-imgsys.h
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6735-vencsys.h
>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
> 

..snip..

> diff --git a/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h b/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
> new file mode 100644
> index 0000000000000..90ad73af50a3f
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6735-vdecsys.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_RESET_MT6735_VDECSYS_H
> +#define _DT_BINDINGS_RESET_MT6735_VDECSYS_H
> +
> +#define MT6735_VDEC_RST0_VDEC			0
> +

Since you anyway have to send a new version, please remove this extra and
unneeded blank line for v2.

Anyway...

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



