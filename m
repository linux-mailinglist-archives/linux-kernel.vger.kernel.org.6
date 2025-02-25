Return-Path: <linux-kernel+bounces-531668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C2A44378
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEE01886372
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFF26FD92;
	Tue, 25 Feb 2025 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kr2oUmfc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE726E14A;
	Tue, 25 Feb 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494518; cv=none; b=Fb0OJLIml8SjinFw8hJV3PZ6sAtyxfL+aiM0CC/8xFY3F0bJBJri964JhBaoxjtJn/ax6R/s4ZFyDQU6UKH6fqaLS+MlYyKbUR6/Xnwo7pLpubdi9WJAJk+mKVVKXWwlk88iVCk8hvO+0v2lBbbRRClsrpNZUc6VKMcWpGzM7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494518; c=relaxed/simple;
	bh=XGd1XNQmqCz8KaVN0OhhQX9JZety99RRX4T3g5Moydo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzX9wlr/eG3vgtAMRHX/tSx9afhDG6oX5mScMzpWqFFs1XbDOG1PE8CsYTSlCBxpXGP+ya8ahLw6O+dbDcB5XH6l/lvTNJvwsI6dWCeeAxXxOmSKql2XoeKlxFbdNtLBOaJNN8L+q8D1REVJUoHKf01zc6cscki5IDauD9gg70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kr2oUmfc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494515;
	bh=XGd1XNQmqCz8KaVN0OhhQX9JZety99RRX4T3g5Moydo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kr2oUmfcJQuKh8aILaNXIdCk1gSqWLuexXQKP5GEN6nIHKFq188/m0uvAxW/kwaEL
	 BcewF+ymErrazigNMoAwodNtf56IjFDJQZuuIr+zpzzBPfKYUBz2V11BhYWsPYZV24
	 rPSymGxo2avto4L43NxPAKZf1/BuJJbHx4lsNJGF+67u7gCM2pcXJlpzMSXWIEIioC
	 5DRWAeVnH/tnCPT4RTKex9V6MykG2hjKoQaTPhBECZyUG/MCZBNP5YaEgBE5sTJ/hj
	 D/QfV/e0loBOt5//Fe5eOCwsyLaBFnUo4PczRljtEWv/mqUaMz8Kiv7+P/9AlCMXv2
	 Y8RJGKDAeTfRw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2693717E1016;
	Tue, 25 Feb 2025 15:41:54 +0100 (CET)
Message-ID: <173e41bd-4fa0-4b54-8739-546536ad7c3b@collabora.com>
Date: Tue, 25 Feb 2025 15:41:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] ASoC: mediatek: mt8188: Treat DMIC_GAINx_CUR as
 non-volatile
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-3-3076f5b50ef7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-genio700-dmic-v2-3-3076f5b50ef7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/02/25 15:33, Nícolas F. R. A. Prado ha scritto:
> The DMIC_GAINx_CUR registers contain the current (as in present) gain of
> each DMIC. During capture, this gain will ramp up until a target value
> is reached, and therefore the register is volatile since it is updated
> automatically by hardware.
> 
> However, after capture the register's value returns to the value that
> was written to it. So reading these registers returns the current gain,
> and writing configures the initial gain for every capture.
> 
>  From an audio configuration perspective, reading the instantaneous gain
> is not really useful. Instead, reading back the initial gain that was
> configured is the desired behavior. For that reason, consider the
> DMIC_GAINx_CUR registers as non-volatile, so the regmap's cache can be
> used to retrieve the values, rather than requiring pm runtime resuming
> the device.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



