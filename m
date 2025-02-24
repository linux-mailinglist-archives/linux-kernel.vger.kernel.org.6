Return-Path: <linux-kernel+bounces-528435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44AA417AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B36A173656
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B021B9D3;
	Mon, 24 Feb 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LkrNPd3P"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E1D21A424;
	Mon, 24 Feb 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386538; cv=none; b=RXM0E2XCu5R826gEOb9TG9dJ7gBQF7LaxVJzYK++cWR5EH6Ot2beRiCyEfPdt0ccY3wGuAo8rJ6QF8ykCBOCS2vvUym45jX/DqvAfPYElb6ylWFAl7xJgyH7I9F4aIkyj3AIQarxGRaqJPP/RzW0X2HWyRg0RicCO8Y/22wdD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386538; c=relaxed/simple;
	bh=9X/bnnLfLCtEqjesJ0RZJAqSE1C/0Bz3YFO70PNFU1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMpvDg9v3+mm1XpTokcFvl9KYhb3oRAIFqPaEbFAyPvgT8yuRiYGVDt46v5jSz632nt3iyb2t2l22Jclj9nxRhsQ104iyFIlCT0znM4vMtojQDSc8KmiT5dTc58CKuQqXHZM+rwR9ygPb5qP4wVPL93tnWGHJe1ly0joj7wXKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LkrNPd3P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740386535;
	bh=9X/bnnLfLCtEqjesJ0RZJAqSE1C/0Bz3YFO70PNFU1Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LkrNPd3Pu8wqr3G74Z1FTKI+FIM1md4HzmySQQfWtKl4XcyKCVbgnN1Hn4BrRrMSN
	 qmOYmBHwZ2dSBrpZ/reWn9yGiLTexKaQzqiX9L669o2p/tVMVFRZaJXD91r3VB07K4
	 XI7EhGQbF0Lb0gooQu3IWMpARvnNSUSoEPVGuQj3yAZCDqcUWXGaF02EPqW8qk2HIz
	 z31QNMbzT9mxYKVbngel1/mZHIR+COZkwu0DrrBEULDG23J2PTJPsvOSQgWghAenGy
	 CAugEFjPQadAX2ADWep+L1deKikRZggMC8g/1VTltpq6Cm67oHWLBSAJcJGWMsNXq+
	 3cdlFB/etlPtA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A1AB117E0187;
	Mon, 24 Feb 2025 09:42:14 +0100 (CET)
Message-ID: <acd15979-f9f8-4695-bd6c-9eb57a056c8f@collabora.com>
Date: Mon, 24 Feb 2025 09:42:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] clk: mediatek: Add SMI LARBs reset for MT8188
To: Friday Yang <friday.yang@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Garmin Chang <garmin.chang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250221075058.14180-1-friday.yang@mediatek.com>
 <20250221075058.14180-3-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250221075058.14180-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/02/25 08:50, Friday Yang ha scritto:
> SMI LARBs require reset functions when MTCMOS powers on or off.
> Add reset platform data for SMI LARBs in the image, camera and IPE
> subsystems.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



