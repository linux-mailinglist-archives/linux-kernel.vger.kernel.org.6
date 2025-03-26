Return-Path: <linux-kernel+bounces-576796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2080BA71492
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F44E7A2FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E251B653C;
	Wed, 26 Mar 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yv5bD2lP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E51A8404;
	Wed, 26 Mar 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984276; cv=none; b=D9LuC37+h8RUpKCydobBMUArOjnhVKP7R/H0NIAOHPaPI+qieogMLlY5Fjp0Rhz4LQCaZU1LCJuWyKYNSg3B+gFrUrtgPTZOvGSDHB4Lv9X3EYIjRsiL60AzHGdAA1rLJt99Z83csKIWfFLXAnDCFWicbnIb80ZKQd1qhLuIKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984276; c=relaxed/simple;
	bh=HpBiFIVpWXiykM13dQ/yHPEonhKPXJCHKDyxubErAAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zzlq42lysC7ch6o+M2iosD/aSiswp44lJNIecYFqrbSVtLdMX4yud4RUMFfoSz8g1u3I6gRZ6XOQ/TDjgTu7nxazkXMaF56HXs0uxx+5MiQ8Si7NWFSPzKx17aFDg2z5BoT8qWwFgVLcE9Nt+se3ODEX9fjoIDY6q0N00o8Js+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Yv5bD2lP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984272;
	bh=HpBiFIVpWXiykM13dQ/yHPEonhKPXJCHKDyxubErAAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yv5bD2lPXSKwUy1+SERNNdlr/RzEvR8PspwtvDjs+Uxv8RssIK88D0SpbEW2RQfM0
	 OiCCbAoqHOShARwed4QF+NEEG47DjoTjhP1D/RDuHg2HiPL05RycooONUTF5IDuINu
	 j8FFUR6ZiWu5Dyk1Ldkue0yY5c9liU9juyOgdYL31oXfgLFGqg7rhlqZaV2SFmdFpt
	 VKfSfdrvE7cVjrJ/FNlk9f1o1CNaS4cfJzDSgfRsikzLM7fuvkBKT12vvWt3Xzv3sf
	 BxGTPNRp9tB+7CpMWTYO4/tkw6HNAVofvlY7E2vvVULi43e5ov+vgqzut5XrZra/S7
	 +FkYBCoe3+s3Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9590417E0E8F;
	Wed, 26 Mar 2025 11:17:51 +0100 (CET)
Message-ID: <6e7ad33d-c0e3-4160-81c3-93f6c88976ae@collabora.com>
Date: Wed, 26 Mar 2025 11:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3,1/2] dt-bindings: memory-controllers: Add MediaTek DRAM
 controller interface
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Crystal Guo <crystal.guo@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250326063041.7126-1-crystal.guo@mediatek.com>
 <20250326063041.7126-2-crystal.guo@mediatek.com>
 <20250326-courageous-cobra-of-promise-2c839e@krzk-bin>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250326-courageous-cobra-of-promise-2c839e@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/03/25 08:56, Krzysztof Kozlowski ha scritto:
> On Wed, Mar 26, 2025 at 02:30:31PM +0800, Crystal Guo wrote:
>> A MediaTek DRAM controller interface to provide the current DDR
>> data rate.
>>
>> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
>> ---
>>   .../memory-controllers/mediatek,dramc.yaml    | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
> 
> Where is the rest of the patchset in DT patchwork? Where is any
> changelog? Cover letter? What changed here?
> 
> I receive dozen or hundreds of emails, so if you want to make
> it difficult for me to review, I will just ignore the patch.
> 
> I mark it as changes requested.
> 

Krzysztof, I do see that devicetree cc'ed in all of the patches that Crystal
sent - including the cover letter... and the cover letter has a changelog... :-)

Was there any temporary issue with the DT patchwork or something, maybe?

I anyway had to request some changes so no worries.

Cheers,
Angelo

