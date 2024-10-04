Return-Path: <linux-kernel+bounces-350105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21698FFD1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7AC1C22FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A67147C86;
	Fri,  4 Oct 2024 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l0j2Sq28"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C31465AC;
	Fri,  4 Oct 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034419; cv=none; b=sILOiqyoNWlpNCcg3uDKiJ8oajXywhp3z6KVIQ/Gn8KLEdtiQRfte9jfXTp41iLTZj742ZQ5XqZkhhWK5welRaiXttKNNXA9BPhQRyrPc0ylFQMD0GURjzXQ9Um/jwT7qhWcwpuk5wPC+aUxRiepIiqXgY0dO7si82ivMg0AjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034419; c=relaxed/simple;
	bh=lYH7i3scXm5wsbzJSm6pT1NMbSAV+hb2CZmSFlix9O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dp4c4LGfdnEXyrtswoMcldGZ20lK1bTfWKMedH8UdERA27CLm89fSqV/8813XoLzON4QTSkqj35zXY7hJo8xsRG/wj/XHZufzvL1+UAimGa0KyH8rbZxyOFVL59jqi2uETiB0fWLemRT0+Ac+Z1/MyO3uZWmPukQq3YxRUabP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l0j2Sq28; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728034409;
	bh=lYH7i3scXm5wsbzJSm6pT1NMbSAV+hb2CZmSFlix9O8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l0j2Sq28nEGkc3kbl2+ymSu1dWRJRUaI7SQjjUIv4zVsDu9n5BSeb6Waf2XnQEpVu
	 MGFHJjEtOHr6AzzAMshKfzTVbkp1MoWmwzugnOE3krEP+qQDgVdTWQ+EPkTHYtAFwA
	 6KEL4X+pHawTQc5BPEFGFOi0EgZSvbgQtNT1aduKFhh1w8WurPUH0xXj0LDy5AljwG
	 atLMS1VBgwBO7QTzeZ2Ftn/pAbO6deZh54O9b/1RARLlSBRSpL672jk7vbTkZAovbC
	 xx45WXl9T6rJ++94fYT3zx44rlLWx/NJrPiw56bxDKw7JJan4ZhVJjQxhnICuxxzho
	 BJRvI5q8VFc8g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8995817E1147;
	Fri,  4 Oct 2024 11:33:29 +0200 (CEST)
Message-ID: <1432ee2c-ef74-41ba-a9ea-6a70943a929c@collabora.com>
Date: Fri, 4 Oct 2024 11:33:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] Add platform supports to MediaTek MT8188 SoC (part
 2)
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241004081218.55962-1-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241004081218.55962-1-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/10/24 10:11, Fei Shao ha scritto:
> Hi all,
> 
> This series is based on top of my previous "Add platform supports to
> MediaTek MT8188 SoC" v3 series[*].
> 
> There's nothing to change or address in that series at the point of
> writing, so I decided not to resend it and start this new "part 2"
> series instead.
> (if I need to update both series next time I might consider merging them
> into one)
> 
> Specifically, this continues to introduce the following platform supports
> in MediaTek MT8188 SoC to lay the groundwork for the board device trees:
> - PCIe
> - MIPI DSI
> - video decoder and encoder
> - JPEG decoder and encoder
> - vdosys0 and vdosys1 display pipelines
> - DP-INTF
> - eDP and DP TX
> - aliases
> 
> Please have a look and feedback are welcome, thanks.
> 
> [*]: https://lore.kernel.org/all/20240911143429.850071-1-fshao@chromium.org/
> [v1]: https://lore.kernel.org/all/20241002114614.847553-1-fshao@chromium.org/
> [v2]: https://lore.kernel.org/all/20241003070139.1461472-1-fshao@chromium.org/
> 
> Regards,
> Fei
> 
> Changes in v3:
> - add the secondary MIPI DSI
> 
> Changes in v2:
> - add linux,pci-domain to PCIe node
> - add power domain to PCIe PHY node
> 
> Fei Shao (9):
>    arm64: dts: mediatek: mt8188: Assign GCE aliases
>    arm64: dts: mediatek: mt8188: Add PCIe nodes
>    arm64: dts: mediatek: mt8188: Add MIPI DSI nodes
>    arm64: dts: mediatek: mt8188: Add video decoder and encoder nodes
>    arm64: dts: mediatek: mt8188: Add JPEG decoder and encoder nodes
>    arm64: dts: mediatek: mt8188: Add display nodes for vdosys0
>    arm64: dts: mediatek: mt8188: Add display nodes for vdosys1
>    arm64: dts: mediatek: mt8188: Add DP-INTF nodes
>    arm64: dts: mediatek: mt8188: Add eDP and DP TX nodes
> 
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 668 +++++++++++++++++++++++
>   1 file changed, 668 insertions(+)
> 

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

