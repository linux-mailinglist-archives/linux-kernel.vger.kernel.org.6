Return-Path: <linux-kernel+bounces-324773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED029750B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4965B283B92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D9187845;
	Wed, 11 Sep 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W2+nlYL6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="NNZM1fd+"
Received: from a7-51.smtp-out.eu-west-1.amazonses.com (a7-51.smtp-out.eu-west-1.amazonses.com [54.240.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C0D185B47;
	Wed, 11 Sep 2024 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053859; cv=none; b=eb4uJEnQUAg/oEf2J4eY2YZ0CN2INOAp9Cii7wLEy1dfiHBuwQYqLsS8vpOVS6qKAA1B3Kj9Y8wt9H/gvtf5okY+HOmQdkWoLKNJrNAmCAjwlGbMMNalH+8wiENsucCLHXh68P9zZMW8MMP7VnRM0iYm0KNdfjk5mqTWuHAurnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053859; c=relaxed/simple;
	bh=hHJ57GhW0AFY9cSfQETXEPzqEG5qaB2u3OM/P4qkqdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8K0NNfGQdB2BpI4KZY3zwquFCw0kxIyt3XTvRZeZ10LzWSdmg2FbzB6M0PnOT6qB2ljcFo/7rckICb4Z+QHxmj9Mh5dAoNxdrlnGQbxRETC8mFDbC9YD39rE1dJnS35z8NJllMYyqj0hOD5RkykD2vB21rfwn2W9W3R7aQniwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W2+nlYL6; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=NNZM1fd+; arc=none smtp.client-ip=54.240.7.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726053855;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hHJ57GhW0AFY9cSfQETXEPzqEG5qaB2u3OM/P4qkqdw=;
	b=W2+nlYL6l3Ifay5LfDY2VcUxw8euLV6Shr/V13oKkRK2wAR2Cyk/g65qu+pqzhpM
	siGXPa7dBKQGuE3j2niVBhE2noVC0bNmUXj8eUexPwIR1Oh6mcMmM8ZhEQ3TVuAW5k6
	Gg3YNFXiTj5psn9xeuKjZZPA2Ljdw+Nj826XLHgZiVOux0Ri90k8aQYIfzoMjKPSDK7
	+jIFcAPTFMv0DVGOA9hHeDITCbMzGGicUKDxjA4AwcusTaJr54ioGO1Q6L2p0XGBbgr
	OsJJJ9IMrDjH6yg+pwHhpPsqekMHu/HPjyselVlTLXVdyEi+hw5lOmkMtaNilpyi63A
	Oh4vEa8Xww==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726053855;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=hHJ57GhW0AFY9cSfQETXEPzqEG5qaB2u3OM/P4qkqdw=;
	b=NNZM1fd+JQfraNqX4sU6XTxUxLO9givFV134ofEjiyX5N67Qo1FuiQN4LIVwH6hl
	YwgagntumKK7dSRxBFB0GFMpnDUuVJQiF0NXFO/DzRdHqq9Qm33K62SOvoRzEd4Bwr0
	SvsyKRiDDt3QY1TyAO57cMBC6lqHDshLMfOmI3fs=
Message-ID: <01020191e0d3af7a-8a1d9882-90d0-4def-a05f-c29e7c479dff-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:24:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] arm64: dts: mediatek: mt8188: Add SPMI support for
 PMIC control
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240911105131.4094027-1-fshao@chromium.org>
 <20240911105131.4094027-7-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911105131.4094027-7-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.51

Il 11/09/24 12:51, Fei Shao ha scritto:
> Add SPMI node for PMIC control on MT8188 SoC.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 61530f8c5599..32e5b7108f6a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1306,6 +1306,18 @@ pwrap: pwrap@10024000 {
>   			clock-names = "spi", "wrap";
>   		};
>   
> +		spmi: spmi@10027000 {
> +			compatible = "mediatek,mt8188-spmi", "mediatek,mt8195-spmi";
> +			reg = <0 0x10027000 0 0x000e00>, <0 0x10029000 0 0x000100>;

Please drop leading zeroes on iospace sizes 0xe00 and 0x100, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



