Return-Path: <linux-kernel+bounces-321301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D5097187E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724B028423E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E834A1B5ED0;
	Mon,  9 Sep 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WZEDz6fl";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aqfDUh0M"
Received: from a7-40.smtp-out.eu-west-1.amazonses.com (a7-40.smtp-out.eu-west-1.amazonses.com [54.240.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E41B5EA1;
	Mon,  9 Sep 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882249; cv=none; b=d4fk4XA5Ru3hiBIYPXGXW0m1GM2+pwU3vJOTsqqaiC3apkJ9EuPph/DF85AiRnXsmMnJRdWw/HuyunpoYAJ5qcHuKGo8pe+gB5gGzbbxX00nkW5TnksIlioafAK0P1urkzrXDOKuMIpMuvbRn6rAGpvFA+1xqqg+jo3VMNdRZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882249; c=relaxed/simple;
	bh=5h1cpryF4X32+0kSthzAIdsn9OIb6lI/YBijLBKiv84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cx8Flbw8Eg6AqI6HYTpYbCV9agQemkXhrGOw8VWpkdB0clZRh6EKpfwcBEFeqjhtNAQYyLYXfnJx4HPcu+RWu7pDUHBk5sD1PaQBizSEbm7yKtbm5nTafqvTNoh77T/QWqvfKIvO10U4SdUssbg2RrS/gjcN7v8WUZ/18k+1C1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WZEDz6fl; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=aqfDUh0M; arc=none smtp.client-ip=54.240.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882246;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5h1cpryF4X32+0kSthzAIdsn9OIb6lI/YBijLBKiv84=;
	b=WZEDz6flt5zc6e1H+MfzCf0VzfUJif6uzxLxPeAbEIqAoD2grIQzhl0k8zo9w+Su
	QjkUXA2ATRJSi27q24vxAfnyJdi2aoZ2SWsVSwySptjYOUgjAUO5fH4LDsYivk04B9h
	oeUfsiPqUOuHw7C+/OUMnPtR/oopWKjSIdbT8MuVGq1cIWLuj03zA4liqnOmqhu+iEd
	DUDVJDPXv/YqDO5IhF3uG4m1WwJ4Uk+lTYlMt0VumUVlR5JuNCnswgjwDGA/zj8/KgT
	xt9KNdelTtevLlrUo5DSXVoaE8ihyinqBvvUESl7Kh4IdVGikgTDlBU6kPDjl58xagx
	PQIT9E9IWg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882246;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=5h1cpryF4X32+0kSthzAIdsn9OIb6lI/YBijLBKiv84=;
	b=aqfDUh0MY3otv0eaAQ0v+Ci0rK15hWc+qXQ6RTFFOpOdDx+KnE8iqPkEL1532j4b
	b1hnb5MXs1Dzrgxu3c7iuKmxQDk93TsC2zuQtDQNq/QY/FO+NKESdJae48AhRMCPsFf
	4/gA67ah9EkB65H7z8cVeXjWGM7g8bR2EvfKXhYg=
Message-ID: <01020191d6992288-f834e61d-ad1d-4de7-90b4-77525530532c-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:44:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: dts: mt8183: Add i2c-scl-internal-delay-ns
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, 
	Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
References: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240909-i2c-delay-v1-0-4b406617a5f5@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.40

Il 09/09/24 09:29, Hsin-Te Yuan ha scritto:
> Add i2c-scl-internal-delay-ns for each device.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Daolong Zhu (4):
>        arm64: dts: mt8183: fennel: add i2c2's i2c-scl-internal-delay-ns
>        arm64: dts: mt8183: burnet: add i2c2's i2c-scl-internal-delay-ns
>        arm64: dts: mt8183: cozmo: add i2c2's i2c-scl-internal-delay-ns
>        arm64: dts: mt8183: Damu: add i2c2's i2c-scl-internal-delay-ns
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts  | 3 +++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts   | 2 ++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts    | 3 +++
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 3 +++
>   4 files changed, 11 insertions(+)
> ---
> base-commit: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
> change-id: 20240909-i2c-delay-6d202918ee0f
> 
> Best regards,


For the entire series:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

