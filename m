Return-Path: <linux-kernel+bounces-429641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D1F9E2771
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC270B28CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2131EF0BC;
	Tue,  3 Dec 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HDHGIQr4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86D1DE2DE;
	Tue,  3 Dec 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235830; cv=none; b=QqPELJ6Y/hdYbaTkHUnKxM9EDI2v/DxoG//evTGXLONrPiJLrZO0eDUdkQTrFlSLgmyi1T137tiraQo6gWUeoubRt3CZRio94vLUUh4lQ2v5Jh27X78Y3mA85scdAnA/Vd39OBnNBVfx+YLgyH7fzCc4gUI/r87LVeqVUTsBJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235830; c=relaxed/simple;
	bh=iUYCthuBSmOjrDmuj+W4FEtenoQajCGj/nGcHrCp+Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvSueQxQMN3g+S3TkYVNshyyo562wksYAbspKdTaPL44R77UHUTcM2TA54FNlIlFyQUH8abkgWSYsX0mvy1xyeQu1OecsxMPyC295YVVJ3HU8+VduFJIw0yQpvXv1lF191JxwdTpQY/y8/Wr2SaAH2s0D4uBcl7tk13CFKJVTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HDHGIQr4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733235826;
	bh=iUYCthuBSmOjrDmuj+W4FEtenoQajCGj/nGcHrCp+Y4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HDHGIQr4ZOP+6nOkv9NiLDKRLFN6dAlvE+LiEiArCuc2pwc4PJxfifRwd/H0l+aOp
	 xl3UdXx7s/BRwqRPH+fZUkxHhYyBqHjVgvVAzjKJXfdsnb/8z+FMvCbT7BvLsOsCiN
	 fnScm7AdEeAZN1lRaZN/YdWTd/ozIK2qmRU8wsHvQyevysrNgS1UftlaLrJc8WxO0D
	 5JfSWj27FNx88mUwpo2OdvlQZo4rwBxtU0jdhkqJuFDsmRF7ojCgkp6sGUyT6Gezk1
	 uiXAf8CEm/u7wKYtiGtYlPlU13NFbP8WMGNsCCciKdZj4xQH3inLfGbNIjlIjh258Q
	 1hKZ/TuOSSCKg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2536517E0E37;
	Tue,  3 Dec 2024 15:23:46 +0100 (CET)
Message-ID: <fea3783a-0ca2-4a46-8b82-ef1156dc8f3c@collabora.com>
Date: Tue, 3 Dec 2024 15:23:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] arm64: dts: mediatek: mt7988: enable serial0 on
 bpi-r4
To: frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-11-linux@fw-web.de>
 <32ef5ab8-a163-4fdc-8603-f5a6f0e8526b@collabora.com>
 <6964E096-7C19-450C-8434-6A4456AFDD55@public-files.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <6964E096-7C19-450C-8434-6A4456AFDD55@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/12/24 12:27, Frank Wunderlich ha scritto:
> Am 3. Dezember 2024 10:40:45 MEZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>
>> arm64: dts: mediatek: mt7988a-bpi-r4: Enable serial0 debug uart
> 
> You want new prefix here? That will change all r4 commits,right?
> 

Yeah - that prefix should be shortening the commit titles but mainly will
make it more straightforward when reading the commit history with --oneline.

Thanks,
Angelo

>>> Enable the debug uart on Bananapi R4 board.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
> 
> 
> regards Frank




