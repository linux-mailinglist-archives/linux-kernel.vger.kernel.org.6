Return-Path: <linux-kernel+bounces-433261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9B9E55B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F12188373D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C607A218ABC;
	Thu,  5 Dec 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SZClk9lK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8B218AA2;
	Thu,  5 Dec 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402480; cv=none; b=FZszcOgsfHtkQEy8GVHN5VDSGhJ7UX3PfY6HF3khc/Q+matF5PlKigWfc6ZVWaMgiDZ8G83j0ZaXs9IJlaaEgXjhHE7qCJiM2dJUTZg/RRXi4E3ulxPH9GqmrotF/glFW6BIniWTJnY5qd4rLMcIC5vDOQ8LBv1maK+o1Dl6a6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402480; c=relaxed/simple;
	bh=TIUfoiuf+uk9O/2fQ/WEL3uhx1zcvF/y1gFWOs4F7Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVqjoFpMO7zIKT7puvRiFNnKgsN6fvgBhtgHq8xBkZnndssFTjdZ+ODem6YXENm4PfcMnH/0IXEHnG8J9j+bdLz7XltvA2GFBcV5stClz5uC7UO3726KEXb5q2ajCUbNaZ7a3UtQW0rmnKGykHZ5BsqT5zLdfqeF68Tq18RPy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SZClk9lK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733402476;
	bh=TIUfoiuf+uk9O/2fQ/WEL3uhx1zcvF/y1gFWOs4F7Lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZClk9lKWFlqBzcgV7HZWrf9ptMFSkIisSZ9pw7Sz5PwO6SQRrDuNw6FJqe78t8YW
	 sIXBsr3hrVCkiOGW79y0gVN4SLsR1SQBPsQIVL7mMSbK8H1Omwb9LOvAidJFnnvV4g
	 NV4/ISnWgOLPPRRHU+DjBv2FVQMaXy4R3kFDkiM7rVU27tlJIu83KoW5xBRcSaV9B2
	 /ynOd+5zttIF38yEsWM9NCXQogZx9gxnAohu+DbxiaXmRpqG3SdwObpa1DNhJRZxKS
	 0CI1kCtumK+R6qJdPFP22CqPnXtsc4MEF2vdv+nOMU+lZsyFZ1AMCXjmtRc929UWcb
	 UvesEUB+deD9Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0928A17E369C;
	Thu,  5 Dec 2024 13:41:15 +0100 (CET)
Message-ID: <8290aaee-4ee6-43ec-9555-9a746e0db3a9@collabora.com>
Date: Thu, 5 Dec 2024 13:41:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 compatible for mt8390 evk
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
 <20241205-genio700-audio-output-v1-2-0e955c78c29e@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241205-genio700-audio-output-v1-2-0e955c78c29e@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/12/24 13:13, Nícolas F. R. A. Prado ha scritto:
> Add a compatible for the MT8390 EVK. It is compatible with
> mediatek,mt8188-mt6359-evb so make that the fallback compatible.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



