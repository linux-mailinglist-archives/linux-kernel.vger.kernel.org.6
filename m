Return-Path: <linux-kernel+bounces-259618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83793999C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2DD2826DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5213C9AF;
	Tue, 23 Jul 2024 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wkA35Y1+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA41BE6C;
	Tue, 23 Jul 2024 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715530; cv=none; b=IOlaMVScuMxkK4KjYr67YM98+GHuNXaFljnLnfOw59TcPjOVBfprCbQb8dFWJ/TiPnoY1631AGlRJgLpJ5PgmTOegFezgtuiCcr1D6C6N0W+Gv8MEghdyuXlZ9WhQr6+4iFq0mdVMtqUABbem+Xg/nAwmWcNkEUQFk436sB++O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715530; c=relaxed/simple;
	bh=QE4dg2+Rl4ZejmUZbofrCMODSEG0DXtYj15bYB8fnsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr4n6I6UEJga99wJzcOQ3KvizMuqVGwxCnmvxjFjGHysgtSJZAaTrM+L3VoWSS83aiLi3SCkrXR5jdbCKoP/KQkF+S0oejDiv6aUqHqa8yaT2f/SZp23i7wPIr4N5JyWB4mLNeblBJep8TK10q+KdhRthFSuOhybnNqYd991LTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wkA35Y1+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721715522;
	bh=QE4dg2+Rl4ZejmUZbofrCMODSEG0DXtYj15bYB8fnsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wkA35Y1+tzm5M3coifo1WOfsDxD2ADn3Xzl8ob0gx+ru0ApUHPpIiDYJ2IBp5tfQG
	 iFxffGj2kkwUiELJbKcOm2FgU+k1Jp/TXKhHmhv7Lqgegw2+0Gge0ew6xoctIK3QuU
	 nMq0uO9AAB5nJtVn8dMJUQjbOY5Zh/PjcnVZwxcqeLe1XNbGHcrWR0+Cvz2BTbn1GK
	 CVZNUVRn2x1AX9FNzxBKiuSH4K8nsvhRm0oGTyCJSzAr8Cc+rTtst3DVNcUr3tirWI
	 /X1du7VXHdD1Ysj/tI0CBeB+mPqWP+NmeCFiBqbA38PH7Nu6vhbMy7hQK8cO+1Yc8w
	 09v4Rrjf68teg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94862378001E;
	Tue, 23 Jul 2024 06:18:41 +0000 (UTC)
Message-ID: <89cac5d3-4ea9-4674-b8de-5fe2e5534bc0@collabora.com>
Date: Tue, 23 Jul 2024 08:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add missing clock for xhci1
 controller
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 22/07/24 17:26, Nícolas F. R. A. Prado ha scritto:
> Currently if the xhci1 controller happens to probe before the pcie1
> controller then it fails with the following errors:
> 
> xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> xhci-mtk 11290000.usb: can't setup: -110
> xhci-mtk: probe of 11290000.usb failed with error -110
> 
> The issue has been tracked down to the CLK_INFRA_AO_PCIE_P1_TL_96M
> clock, although exactly why this pcie clock is needed for the usb
> controller is still unknown. Add the clock to the xhci1 controller so it
> always probes successfully and use a placeholder clock name for it.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano/
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



