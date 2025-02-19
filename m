Return-Path: <linux-kernel+bounces-521409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E01EA3BCD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050473B275A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906501DF25D;
	Wed, 19 Feb 2025 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jLm6FONH"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B81E009F;
	Wed, 19 Feb 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964579; cv=none; b=p02c9pZot85svVfWHnCnN53EyEDCUb9PUKf5ttj2iyQwtR/UbQZwj0NkpXssXJeqLF1zeAImPLgvZRe5ZgbhQlfBJMj3UXaAvUQ2io7JdmEpPMyZ/yWxrCk+VHo5v1r5ye08YE9vC4s3vzxkjFeLKEypUbs0a8LMVPrgZ3S0UGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964579; c=relaxed/simple;
	bh=fLHhSMY8IxHecTeaQUcHlc18bPsMku9zr3x/eSmTnW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI3mDY/mgYIj6xKuEcUxFTSlswo10c8OqkLA8Atr3AInbifpVRSOCcWBqVLO6ztq1hK2VnGlh/N9b62u+hZLEFUt7vKg752PGsBa58+/ttow3MHKMR3hq+gKTb4AET2+XbaCSXVbdk2eJWdFkp1jQ3NXyiTtDo4nrvN1AW/BHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jLm6FONH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739964575;
	bh=fLHhSMY8IxHecTeaQUcHlc18bPsMku9zr3x/eSmTnW0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jLm6FONHH0WpJHdbkHANqFxBABrZT6hs8sd7lukpE18QIcsNUOZxsI16oMi84mYj4
	 RVg4j/POgbHqZGbj30EsNVpmUePSkMgwsIvxlgzjWhMVZl+a8yK8cwalo7zyb+XuNi
	 fV/2vr1T2KSdN7619ma7rT36NNUvaS+Aing51hB56OlYYQtqbJusBJpqO72CGgxMWZ
	 t8BZJ3B3G3Idkp+XALtAHMROqeoV2slFsVOaKiofiBvmPnaPwSfwVscJwj7EbI20o0
	 poYIFG8YmD3TkJFiwp+6nlJ/1YIGGjcnkXl8dc3BzXTxRQ6ERKl/QDQ3kXWueZaVjC
	 AhsPielz1Zdag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 041BC17E0E92;
	Wed, 19 Feb 2025 12:29:34 +0100 (CET)
Message-ID: <ef5b7292-5036-41f5-9410-5e7394a1f583@collabora.com>
Date: Wed, 19 Feb 2025 12:29:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] ASoC: mediatek: mt8188-mt6359: Add DMIC
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 parkeryang <Parker.Yang@mediatek.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
 <20250218-genio700-dmic-v1-5-6bc653da60f7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250218-genio700-dmic-v1-5-6bc653da60f7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/25 21:52, Nícolas F. R. A. Prado ha scritto:
> Add the DMIC backend, which connects to the DMIC DAI in the platform
> driver, as well as a "AP DMIC" mic widget. On the Genio 700 EVK board
> the dual DMIC on-board are wired through that DMIC DAI.
> 
> Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Since you have to send a v2, perhaps you can also change the title to read

ASoC: mediatek: mt8188-mt6359: Add DMIC support

After which

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

