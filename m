Return-Path: <linux-kernel+bounces-519481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E90A39D66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8283B1CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A432690C2;
	Tue, 18 Feb 2025 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="abA8pKcg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE532676F0;
	Tue, 18 Feb 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884950; cv=none; b=uFafWCh2xluYcHPF0UUR0psyAE/Re3ojQJH4XD44ppVy/Uz5iz4DfsVNLGQLNRzYZRldTY/FoHFr5Br2RJOwjlEmSdMLzmwtlINjAj/qf0jR1j2c8l+KoWYt9urweAOhiHcD6/n4D/8A0+hBijRrRsKQzEueLPoyEYfuSO6zTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884950; c=relaxed/simple;
	bh=ZDfqbmocK+423Jahwe7zgbMnj1LWV19yQk0w9+HSXIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZS5jJ87Zeoqs8ZaexbXT/Czs+8fdtQlOMLp3XyQYKCZpPQHivLccrWvkjgEEIGzlUqU/4uu9562IwXHIRGK3CGFg8u8cDwIzpD0Xp9k+76tNxVG3wN3Jv4KEYSr12V5wDToM2FrUz4Mi9CbRgGcU3YSGU52Khxlc1AAW0ownGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=abA8pKcg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739884947;
	bh=ZDfqbmocK+423Jahwe7zgbMnj1LWV19yQk0w9+HSXIk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=abA8pKcguLXGqpD8h2qV0xFL5ZHPK3oa0OpuBiAN60c5jK7mDFobcGInl23OnZ0TX
	 bro4OW8UmLxEovUcqpsoeART8iEfUp5lLDe9rZrXGOz0fhPWyVDFoh506x0SIcBtMc
	 vrVQ3/4b5VDXniuBluN/mt1BvKR65Ow+sTpa/fxe2aVG/q/F7p6P8uTmEq77MEF+IF
	 h0eX5pBjALlYhUtp7PHhNfwo/OK2Sh/DG1N7CX5o5Uort0b06Kaf0NwDv06okPIR9C
	 OzubKP1dIXeMcBR5KOCYfZt0ffLMjpwvi2fLo251wpAEUzPqZNJ+Q3y0vAAYy3BdOg
	 t/+vbzQ8mXfRQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 176C317E0657;
	Tue, 18 Feb 2025 14:22:26 +0100 (CET)
Message-ID: <906ed1df-3c63-4028-ae7d-97e086acca32@collabora.com>
Date: Tue, 18 Feb 2025 14:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek,mt8188: Add
 VDO1_DPI1_HDMI clock
To: Conor Dooley <conor@kernel.org>
Cc: sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, u.kleine-koenig@baylibre.com,
 amergnat@baylibre.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, macpaul.lin@mediatek.com, pablo.sun@mediatek.com
References: <20250212100342.33618-1-angelogioacchino.delregno@collabora.com>
 <20250212-arming-gyration-103e42b94ed6@spud>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250212-arming-gyration-103e42b94ed6@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 12/02/25 20:17, Conor Dooley ha scritto:
> On Wed, Feb 12, 2025 at 11:03:41AM +0100, AngeloGioacchino Del Regno wrote:
>> Add binding for the HDMI TX clock found in the VDO1 controller.
>> While at it, also remove the unused CLK_VDO1_NR_CLK.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   include/dt-bindings/clock/mediatek,mt8188-clk.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/clock/mediatek,mt8188-clk.h b/include/dt-bindings/clock/mediatek,mt8188-clk.h
>> index bd5cd100b796..0e87f61c90f4 100644
>> --- a/include/dt-bindings/clock/mediatek,mt8188-clk.h
>> +++ b/include/dt-bindings/clock/mediatek,mt8188-clk.h
>> @@ -721,6 +721,6 @@
>>   #define CLK_VDO1_DPINTF				58
>>   #define CLK_VDO1_DISP_MONITOR_DPINTF		59
>>   #define CLK_VDO1_26M_SLOW			60
>> -#define CLK_VDO1_NR_CLK				61
>> +#define CLK_VDO1_DPI1_HDMI			61
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> btw, I see the mt8195 has this same CLK_VDO1_NR_CLK define in it, if you
> fancy getting rid of that too.

Thanks Conor, yeah I'll do that asap... one commit for each NR_CLK is a bit
too much... I should just clean them all up :-)

That requires a bit of work though, so it's not something that I can do in
a few minutes; let's see if I can make it for this cycle, but no promises.

Cheers,
Angelo

