Return-Path: <linux-kernel+bounces-429163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C099E1AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F25B4648F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D01DFE3F;
	Tue,  3 Dec 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZThBMsGs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962F41E231B;
	Tue,  3 Dec 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218852; cv=none; b=rAY2mAKxHsrjZOvwDVYETYnhi43FfHtl7DTYFmuy/Miio2DdXF1CQ+HRLarnXdJIC0zYWKDEk8RdLP4FhL0Wwuhmwpdo48WwkJpVIBHS4oNJcd059JUpgptSenjSDBUXDRB+ISmj7Lt4P1lVWzUTxD7XBYWZnDtjVSB1blY+42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218852; c=relaxed/simple;
	bh=9j29nIP5bBYYpfp20Whc9MrJ5ZV5di69JLNeENIyw/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0+f9iNK+TtIvl5mOZR4bGOq25MPqLEBGQw4yMITQ8WDuVvrca71JAN5JbKVKF4DxKcrxkvnULhmE4mpQMp0AIlC6JqaLGPKq4lafSuFBdcCVSeUxRkM383xRJk05mwWnpPcK5EHYE0K7Odk9yfEqRg4nFZE8RhONIPpvyfjGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZThBMsGs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218849;
	bh=9j29nIP5bBYYpfp20Whc9MrJ5ZV5di69JLNeENIyw/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZThBMsGsz3yuY5RwxxgrNaL0wlbtT0fAz1Mqfv24h1iwGPtwVKqRZsqVibhMVdeVc
	 sCeepv5W816bbp6LHM8eXnCYWwI+GLltnwYmkJ+ImSmdiT2WY7l3FotCS/62DroDmn
	 SNL6oKW7/FQXIGv0YokgrrUafaISmw+NKmmJz0PD1C/yE4wJS9lUjG1JLLmW0yPdAZ
	 sN6h3W9jJ3V7hQa+z8dM/6FDmBDInN1W/XwZE8ngGMXh1FrpkLRFd0WMtWlbvsb7bA
	 AzYuugpebUV/+l9IP6+stI4OFAZpfFXfz0x9dqc67HqaBq9rt/oD3m4WxmJKnUl4GA
	 pCJLAUmF1dMKg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A386D17E35D8;
	Tue,  3 Dec 2024 10:40:48 +0100 (CET)
Message-ID: <4ad16e9a-15ae-4b2f-964e-ea6d7981f49d@collabora.com>
Date: Tue, 3 Dec 2024 10:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/18] arm64: dts: mediatek: mt7988: add mcu-sys node
 for cpu
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-9-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-9-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add mcu-sys node which is used later as clock-controller for cpus.

In preparation for adding support for CPU DVFS and clock tables for it,
add the MCUSYS clock controller node.

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



