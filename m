Return-Path: <linux-kernel+bounces-324713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A694975005
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74DC1C216BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FA185B4A;
	Wed, 11 Sep 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gdCzt6ct";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Mrwby2Xn"
Received: from a7-45.smtp-out.eu-west-1.amazonses.com (a7-45.smtp-out.eu-west-1.amazonses.com [54.240.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962439FE5;
	Wed, 11 Sep 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051586; cv=none; b=qso9PhDV7hofJEJYpTj/mG6jh+1ox/O/LbGIz00aSmCycubUytzeSnYDlHMs0yEUaTIAF7CwFPldZyE3kMkWPJh35JqgPsnae41YnsbjgoomV7/xi5hr8LTfeHWYVC0GxtI7rdYkMec7gI0ztvSSTx9periiN69tI9+T2P9WqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051586; c=relaxed/simple;
	bh=zaEEDAHRbtRTZKTSPKKof3QCdZ3ptIytzTpSz+i25aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9lEQe8ku8dQtol9S1n/bng+y5niknw2omtfs3ZDBmpwfpeNw958LdZGqOZ6uZC8bJU/LFMCn6FY5lm/ormH6LwNSpU8HyPjv9QpyVxbnOHV+F8YT3Ats9SndDhtDy32F8+0QlH5LkwCHVThA+v52ejMzTtjsNMbRQXTbqqFRP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gdCzt6ct; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Mrwby2Xn; arc=none smtp.client-ip=54.240.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726051583;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zaEEDAHRbtRTZKTSPKKof3QCdZ3ptIytzTpSz+i25aw=;
	b=gdCzt6ctTxu1pBI6S44bZ+GPVF5BgnhIDWemAvKqe358hnJLPrNv5nWoCq1K6PNJ
	zBWZPUDM+bivqP91mI6HG33QhjRWmqkUJt6ySJXZwWJAr2I1ecbqttsDxTbwSphk96W
	x9lcsOIDHBFD2nHsdwMIDmX55bN0MY26xoykm4lvK8cswTnzFwzAnxTVJJPdS4U09c8
	KyBNA448Xsojnt4aTG3cK5uH2ZcXz6IoJfeOPKII48njqpW7CZYQBf1o9zFn79TnVkX
	DKNQwucLe2p8k4E/38BXf/CyJO21SzkSFP9hT4OivOhjZiw4MLetKQq35O7gPO08fKh
	mpLu1RDawQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726051583;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=zaEEDAHRbtRTZKTSPKKof3QCdZ3ptIytzTpSz+i25aw=;
	b=Mrwby2XnraJoo6GZb4q0tGVgPI1+fNDZSNK44heftrf/pDZgV4Htmt8mdWWeqEwH
	3nRxpoTRKi+eccLvjAVtfLHiPwKH5ps8RSsW3QW9baW8OBStZq4yYOLlDh2N9Qyg3Av
	G8ea7L34EhDzTk2wMciEumTluSlKdEU97xFbK+qQ=
Message-ID: <01020191e0b103c3-00fad6e7-f81f-4a76-a75f-1420574f71df-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 10:46:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] arm64: dts: mediatek: mt8188: Add missing GCE clock
 names
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240909111535.528624-1-fshao@chromium.org>
 <20240909111535.528624-6-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240909111535.528624-6-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.45

Il 09/09/24 13:14, Fei Shao ha scritto:
> Add the missing clock-names property for GCE nodes to fix errors from
> `make CHECK_DTBS=y mediatek/mt8188-evb.dtb`.

I've sent a patch [1] relaxing the requirement for clock-names in the binding.
There's no reason to make clock-names mandatory, as there is and there always
will be one single clock for each GCE mailbox - and also the driver is not
trying to get the clock by name, but rather gets the clock at index 0 anyway.

Please drop this patch.

Cheers,
Angelo

[1]: 
https://lore.kernel.org/all/20240911104327.123602-1-angelogioacchino.delregno@collabora.com/

> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> index 445d30eee2a1..2900d78b7ceb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1316,6 +1316,7 @@ gce0: mailbox@10320000 {
>   			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;
>   			#mbox-cells = <2>;
>   			clocks = <&infracfg_ao CLK_INFRA_AO_GCE>;
> +			clock-names = "gce";
>   		};
>   
>   		gce1: mailbox@10330000 {
> @@ -1324,6 +1325,7 @@ gce1: mailbox@10330000 {
>   			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH 0>;
>   			#mbox-cells = <2>;
>   			clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
> +			clock-names = "gce";
>   		};
>   
>   		scp: scp@10500000 {


