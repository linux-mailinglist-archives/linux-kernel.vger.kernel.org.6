Return-Path: <linux-kernel+bounces-544761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF25A4E4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9309119C4926
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499D255221;
	Tue,  4 Mar 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bwh7dnkL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BC2BF3EA;
	Tue,  4 Mar 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102775; cv=none; b=Bkhe3YJAXmyxS52eaRHDOu6Sy6iUjnIL80fyulvRRpQnKZP2oIn6oZhwFkeTGnqKDKBJua7szZuG2jszOQZlpwXxgKLI5ruEfFp5MSsCqgWETzom2v4TCWCmYYQUc3Ta425uLLcRfnzyKIYF0GC0TXDzqnNphjnBANk6FXoHPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102775; c=relaxed/simple;
	bh=XNKd2v8uqp65o4eYPqd9/AkIaqBZJDW9VbNhjyKEd4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dS9MMk0AQ4BuwKgXpeqUThjzWB0oB12R5eyAjmtENhUbphzaYVEu+FUDz1dyTTEigB6BwfG5VeUBJhLy/QsjANn2EJH+OxmMKwgOM6O089+Vo24zJjDUdren+Wwr0vGd/fPTeVX74D+uG7gbc2xdgguXmDHY/ThVC6gYurkgeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bwh7dnkL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741102772;
	bh=XNKd2v8uqp65o4eYPqd9/AkIaqBZJDW9VbNhjyKEd4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bwh7dnkLm7MO6OafSvzsFiVy1bkg1q11osdsYvIx/R2c9QisLMpNjeKJQz3c1CMh+
	 LQxOqkVARMetyl/yi3R3jzABP47rrqw7R590i+0v0z6iQJHxEAvHmszfrCtc9c0Z1e
	 JzRPZbHdr1OUMI7u2CRovmjg4sQ+BoEIEs8fIzW1JLyFw3jXG4LmMz3qjDkV4GK+Rf
	 RyoffepXt8+VvCyNiT273FV79ZzVgebr6yt9sgvMoeQ4iXPc0A75BRF7xBhZdFf4iI
	 fU0IsjE+yHleu7G2j/PmRDWwK5PbSyuv2BRpq4FQMvxJzQDYv4BBDxtmvRpqXyMs06
	 spG755+hprhBg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 189FE17E086B;
	Tue,  4 Mar 2025 16:39:31 +0100 (CET)
Message-ID: <a955f2cc-16a8-48dd-958f-2f2f2a3cc58e@collabora.com>
Date: Tue, 4 Mar 2025 16:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: mediatek: common: Handle mediatek,accdet
 property
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Trevor Wu <trevor.wu@mediatek.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
 <20250214-mt8188-accdet-v1-2-6bbd5483855b@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250214-mt8188-accdet-v1-2-6bbd5483855b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 14/02/25 16:14, Nícolas F. R. A. Prado ha scritto:
> Handle the optional mediatek,accdet property. When present, retrieve the
> sound component from its phandle, so the machine sound driver can use it
> to register the audio jack and initialize the MT6359 ACCDET for jack
> detection.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



