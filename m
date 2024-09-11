Return-Path: <linux-kernel+bounces-324366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2928974BAB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584F4B21ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BBC137772;
	Wed, 11 Sep 2024 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GTLqK+Zx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hbJ7HBdK"
Received: from a7-46.smtp-out.eu-west-1.amazonses.com (a7-46.smtp-out.eu-west-1.amazonses.com [54.240.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502141AAC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040557; cv=none; b=XNXK1krMnJ9a/CehH2lRZYTeaT2eIEDcX6qEAowDA8JeLE60IA6YI1ppC/O/wpUzQrefrPTQY8Q2xFO2+CkslVc4VZsnm/eqHGHKL3onXA5kb6fTOWYnVIyPv/z3+OJqs9bbqIoWkmLC+nIJ6r5rYjPm0MgaJB6Q6rRsumfoFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040557; c=relaxed/simple;
	bh=+z0iaYPRF8aOAeyudpMIOAITImEM365oGsItYDeMrNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEyIr50F97shNbtp8KThBTl5W5GvbZ7jFDgnpCpaM8a44qoVPtM6KIiY9H1crmHhwjH67OIl4Y6J43O4vfaD0LC5g5x8adLoeW97pGKAcQlD5euaEhiFPr4P5CECGHRigA1y+40wjQEJX/nlYq9nIxXrqpIZOGTBt0iJDf25dRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GTLqK+Zx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=hbJ7HBdK; arc=none smtp.client-ip=54.240.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726040554;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+z0iaYPRF8aOAeyudpMIOAITImEM365oGsItYDeMrNE=;
	b=GTLqK+Zxla3s5iAGSe/h9kxrPUSF87jCwiNhqceQcGgcSXvpl305psrUwII5SwKf
	b24gxrEovDeflPUEpV1YVET4Ls0IBxHJo9ORtqxk838sOZrsK8AjSL9R0opIdKx1WMB
	iTZBAayeKXwiqbZulfTtXKoqKahSzJPCaUNf0JUmhB7TQdTIQ+BpLOOHVu9/33/gsKK
	Ez6U4I0w0VT/1uxv8DxSjCNzUmUNX0gPWCuFTVq0WIRgu0QoD/0q1NoSBvmocQJVQz3
	8NE4JiZY1u9uci+sixDZINIEYt5O/OIK4XsrDtZpT8PqMNtlwFldLbtaouHBn8MCfFm
	qu6rNL65gw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726040554;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=+z0iaYPRF8aOAeyudpMIOAITImEM365oGsItYDeMrNE=;
	b=hbJ7HBdKOzai+xLjoaWwAVtHEd+Wao7fakZkcpV33sHkzS3JaM6vVCgzN6mD97Jm
	mVWtXv8wZyidNiSvh8UfItBq/8gnlS5oNFp+6HrWeDzrhpuz8oEzuBE9Fesx608DK1K
	CYAuH00qqq+JkPU+I7knFpOtsiuJmnPf0dwiuxaU=
Message-ID: <01020191e008baec-ca547413-aeba-4508-8a05-2c35b06150c2-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 07:42:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/mediatek: dp: constify regmap_config
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
 <20240908-regmap-config-const-v1-4-28f349004811@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240908-regmap-config-const-v1-4-28f349004811@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.46

Il 08/09/24 16:21, Krzysztof Kozlowski ha scritto:
> Mark local static 'struct regmap_config' as const for safer and more
> obvious code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


