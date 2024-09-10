Return-Path: <linux-kernel+bounces-322674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79870972C20
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F482835E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD0184522;
	Tue, 10 Sep 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="alAdWhC5";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HatTb9Vq"
Received: from a7-40.smtp-out.eu-west-1.amazonses.com (a7-40.smtp-out.eu-west-1.amazonses.com [54.240.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF2E17D35C;
	Tue, 10 Sep 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956914; cv=none; b=NzzN15owIEFkCl/iRyNZOskwPHLP+c+VXma2E+iBgWL0iKwmqvmMZ9gbVOLh/r2MhnEQvvn5I7Ga967xmqJizcY3sHE3nRJwlqKDcV4UNN9AKJodArt9tzss9fxhHPwS2WWiV3g9lkjFexYwhOlluIRLiC7qIBx7F90uNGiQ4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956914; c=relaxed/simple;
	bh=hlHx2tkxJmJVKOYtsBb2FRbgi+CEkoEUjUh4lVTrpBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQIqwE9fvR/pYeEWC45Oikpf40fs2g4xKnEFs9/3veMjMVUsan8bWDNjxzNiixGncyF/Qv08O/ZQdXSQGZ2WZ+WIKZqbuZnHrB1CvIiArpKKG98Jwk9yoMVraCiGg8BcvMrWLkdo9xAq0VnvzUl52itGeNEW7tMIgsvOl5a3W9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=alAdWhC5; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=HatTb9Vq; arc=none smtp.client-ip=54.240.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725956910;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hlHx2tkxJmJVKOYtsBb2FRbgi+CEkoEUjUh4lVTrpBM=;
	b=alAdWhC5X8+zfLdVTCk+QCYsyHg5+zm68bg+jy+x7vOoDAecCcVd+RQuz4v3a2g2
	xv8k+cBg9eWYEWShSR96ay+spnU6JQIR5jfaSWw5aknkSDXOsJAWvUtZXq+ngFk06J+
	S3kH8gqhJbTcGi5yo3Uxy2ejDlx6+xI1S4aW8nfpnol3SF0EdIIZzL5OJAT75B0VPf6
	hwwSR97mnjVxL4vmd+KkXmqrYRrh3hf26I2wnSXzWqTQF2HYb/AXSrplL+9v7Zg7Utw
	h6V4vX7MnkJGUBitPN1Ph6c1KTpkCVZQFDhy/LYI3Vz+oWhLr1bHcS5BGpwDnTN8g9/
	5pBm+4xmBA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725956910;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=hlHx2tkxJmJVKOYtsBb2FRbgi+CEkoEUjUh4lVTrpBM=;
	b=HatTb9VqE8+wHu/NSH8zD95azyzpeetDjAmLVjhbSL6Py46DAxdSYsgRqxtV3zlf
	Xt2ozlYzQxdJT/GLoJZpRVJMEQuoKrvOWHCiQE6RWiK11RL9s2v5URcRgX2VMxr2Xj/
	XUNY/d2sVwfLEZ1XDetUQ67S8nYJXeRZIRdxXqxw=
Message-ID: <01020191db0c6d91-0c23da5b-eb4d-4869-a27b-d1d3b14afb3b-000000@eu-west-1.amazonses.com>
Date: Tue, 10 Sep 2024 08:28:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt8183: set DMIC one-wire mode on Damu
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Hsin-Yi Wang <hsinyi@chromium.org>
References: <20240910-one-wire-v1-1-d25486a6ba6d@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240910-one-wire-v1-1-d25486a6ba6d@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.10-54.240.7.40

Il 10/09/24 08:33, Hsin-Te Yuan ha scritto:
> From: Hsin-Yi Wang <hsinyi@chromium.org>
> 
> Sets DMIC one-wire mode on Damu.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Isn't this a fix? (fixes tag!)

Cheers,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> index 0b45aee2e29953b6117b462034a00dff2596b9ff..06a689feff52945d141d196d439cba034f25fdf6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts
> @@ -26,6 +26,10 @@ &touchscreen {
>   	hid-descr-addr = <0x0001>;
>   };
>   
> +&mt6358codec {
> +	mediatek,dmic-mode = <1>; /* one-wire */
> +};
> +
>   &qca_wifi {
>   	qcom,ath10k-calibration-variant = "GO_DAMU";
>   };
> 
> ---
> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> change-id: 20240910-one-wire-2d0f7113dc8b
> 
> Best regards,


