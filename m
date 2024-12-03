Return-Path: <linux-kernel+bounces-429149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F489E1A47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40A2B3A1F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F91E0092;
	Tue,  3 Dec 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lUWe4m+t"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0918859F;
	Tue,  3 Dec 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218842; cv=none; b=F8CRUTV03LSUNcLinkW/dQpekJmeKgcJEvUNHTjJ5xNrrTRO8OiWMvUMCI+FkRNssDSaF/jt1i3KmY7PMPm4n7Q2a4gSpZ/lRcsAhPUapU8adoKlToWlUzGnAlhsV2nMihxpYeeTHSAb1R6goHs9xVmJaQF5QMLH0iVGz8pHmPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218842; c=relaxed/simple;
	bh=5gmTp1cyr0lrzH/E7sGr4jjHaM1uKkn2Md8Q4cRF9/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMY3gpQlSvdeJT3yiTP5Elhy2gbqGCj3xWUBWpj7V5Giy0CihDVPq0G3GtsGGIT44rPW0Vax1npUna9EvINnR4cLE3JJqOhBuCXgDvp+2dKY3Ww3AVO0APw96pgKVLHxEPiNeyKimaXZoR/25EbrJfBf5b0CKjl2WZIN+gmO73o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lUWe4m+t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218832;
	bh=5gmTp1cyr0lrzH/E7sGr4jjHaM1uKkn2Md8Q4cRF9/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lUWe4m+teu0trGQ/WXQGJiM4RCP7U7uD1pF+/wVvZL4f6H123vkTywTUW37pmaOPf
	 ttj71aknIYBqnmtHqZDh4Q+3MUs8ClxmOaZwJfdOd8lEuOYLn8tG4lzxFcuTVTGwrk
	 T2orAVxHF/KprPG6CDwzy9ZRWA1IjrOW26Okx7s/XcOUJEvSwTwlnjYt/F8sUhjQj2
	 brgzk6n8KKw75PGCzrgOlKgMVn7/8HmyuPqTCvCwBtMSXpuuhPAYC314BZrA/cPtEX
	 Y+Ti3Bvyzlo7Rqm9Deh/UZdZFnBrWjdy7UDRanBOchAubj3JtKVJ86I/ORxL2/Zo28
	 GcOkIH5HvHGig==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 406B217E35D8;
	Tue,  3 Dec 2024 10:40:32 +0100 (CET)
Message-ID: <79ac6523-b002-4e10-95ac-3df378f4f3f5@collabora.com>
Date: Tue, 3 Dec 2024 10:40:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/18] arm64: dts: mediatek: mt7988: enable ssusb1 on
 bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-18-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-18-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Enable front-usb on Bananapi R4 board.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


