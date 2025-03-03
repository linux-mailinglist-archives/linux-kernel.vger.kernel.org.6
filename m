Return-Path: <linux-kernel+bounces-541572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7F4A4BE95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5D5881596
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD271F4161;
	Mon,  3 Mar 2025 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EShFM9A4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ACB1F0E44;
	Mon,  3 Mar 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001045; cv=none; b=Av2TPdc9d+NGbhX2/m5jv5YcWASVufEyohkq2GzuLx/DeMECO18r0wrUlFuWj8iyJFCIVP4M+GExPCMUVwDW+Hvk+pSbjr3cVBGWGj3ckdtA8XF6OkpTqX6fb5I/Dcu9GEx1s6oxRpjj7AyCu9/7CVxWF2Z1P7qdS2erpgi4dSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001045; c=relaxed/simple;
	bh=b11YAUOR3ELvh8yV5kuXlG74Flyo1oLkSgGTNOWxpHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SACaGDeRvS6iyRCDoU82/qYFPQLZyH6YnU/S6OYX7SP4Bx6OAY4PEftN7twLcsXBAPtbVV+sc4c/7wgkTcOpxGnAya+t9DowTC02dCY+I5plroAR3GasiPQeM2JBTdahktUBFGMi6YAZG67dfUqjMJateS4BKsQlJAOIM1S8Dy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EShFM9A4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741001041;
	bh=b11YAUOR3ELvh8yV5kuXlG74Flyo1oLkSgGTNOWxpHM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EShFM9A42uZ7Vz4T9j3Jmo+iyh7kxW7mRYbjM75c6oD5HNR3/XHMP7w/mYWLe0+DT
	 XmVdN2tHNPxPv35oenT/KsaJsRZObXeKzFOm3+DHYfUIyz3aAKdZYjM41iaAr5hw7M
	 Ykffl/Fz0cKV8LmmrurltgAzNnq6IiYG/VqBGPwEOMKf6H5XGFvpC+2Y0TEVrGTY0g
	 vOESWMMWGajsI34F5l3GwXU5nOTgurpPYU0+mR8lbkA+WwT60rr67pT3SgU2O3DSBx
	 9lpAsGY+Tu4NgwP/PfgVIjPltJxCp73P2AwuQfBFYSq7Wa9c+kTNNbmbn/jYWIFXYd
	 yaYJj+E5qmhYA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 85B9817E0881;
	Mon,  3 Mar 2025 12:24:00 +0100 (CET)
Message-ID: <c48b28a3-3277-475a-aca2-c55b9b67e4f5@collabora.com>
Date: Mon, 3 Mar 2025 12:24:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add driver for Himax HX8279 DriverIC panels
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, pablo.sun@mediatek.com,
 christophe.jaillet@wanadoo.fr
References: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/02/25 15:39, AngeloGioacchino Del Regno ha scritto:
> Changes in v2:
>   - Removed unneeded mipi_dsi_device_unregister() call for secondary
>     DSI: as the driver is using devm, that's not necessary (CJ)
>   - Removed superfluous if branch as pointed out by CJ
> 
> This series adds a driver for DSI panels using the Himax HX8279 and
> HX8279-D DriverICs, and introduces one panel using such a configuration,
> the Startek KX070FHFID078.
> 

Hello,

friendly ping for this series - need to know if this gets pulled in for this
merge cycle as to understand if I can take devicetree commits enabling display
on MediaTek Genio boards.

Thanks!
Angelo

> This panel is found on the latest hardware revisions of some MediaTek
> Genio Evaluation Kits, and specifically, at least:
>   - Genio 510 EVK
>   - Genio 700 EVK
>   - Genio 1200 EVK
> 
> This driver was tested on all of the aforementioned boards.
> 
> AngeloGioacchino Del Regno (2):
>    dt-bindings: display: panel: Add Himax HX8279/HX8279-D
>    drm: panel: Add driver for Himax HX8279 and Startek KD070FHFID078
> 
>   .../bindings/display/panel/himax,hx8279.yaml  |  74 ++
>   drivers/gpu/drm/panel/Kconfig                 |  11 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-himax-hx8279.c    | 905 ++++++++++++++++++
>   4 files changed, 991 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
>   create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8279.c
> 




