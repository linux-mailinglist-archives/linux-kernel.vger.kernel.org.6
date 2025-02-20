Return-Path: <linux-kernel+bounces-523506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 886D8A3D7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003567A26C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E5A1F03E6;
	Thu, 20 Feb 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NrTkn4C1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921A2862BD;
	Thu, 20 Feb 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049324; cv=none; b=MA/RofPL3rpO5jKw2ULLJiL2wULLz4If0Lcu4JWBCd4Eo9vHU+o/H1m+GDYAr0Q6q0i6E4R3LUlMO/7N0TOYSDiavSH+pXVdOMU+RCT0fTTwiV6Rbz8vCm8N1OiaETHOTy0zjdurP7dIEtnDxFWcGg+HwU68MGvOZ6s7AtsmYhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049324; c=relaxed/simple;
	bh=9ASkIEzS+6XMgMIawHaWqrHsCYwuVwK6odSFxevMpFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrXVr2hztSPZYaD5nUF4ZKdFTEHEM3vJVcnUm9fxHVI3cUWcO5+IbwcyEpiNEeAIIXAuUlRAjeA6N2Dmti0vdTSbberUUTpVmp5nYYDWtIVzmEPJaVHfA4v+jo55OODBSubu5AcA1JlEaLbZllGI/iZ1eef/rhWzB+vKqDbuVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NrTkn4C1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740049321;
	bh=9ASkIEzS+6XMgMIawHaWqrHsCYwuVwK6odSFxevMpFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NrTkn4C1My6ql2JSSgUKNTpsKonypHW/rh1EN8tqXylBFSd+0pQhJNtbK0UvDPPYp
	 KLIYunu1n3s1FYSU9Wdo173rtn2zjJCWnCADGvfzDFLsN4v712RUpMcdwHQtDkqFAu
	 rkC9MwlFA+thadeUIghQshp4KnZEf01INDT+UsxgeyvcvBtXpGB9xyoVDZqhvHJRmr
	 RCEiobnxn2lWWgx4/bf7iKMQ0cpokEUsnI06J1tDQa0bxIxQiGoW6przJqwOYHahcm
	 iH9rMEcqtZ+OpYmZiWBhciqklYq1vYUG5ttORkC/agYKpRo2E1xM8tX1KRz3NVn0I1
	 rVSagHCoYLaPQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57C6917E1247;
	Thu, 20 Feb 2025 12:02:00 +0100 (CET)
Message-ID: <fa07a088-2ba2-4475-89b4-5104db2a28ae@collabora.com>
Date: Thu, 20 Feb 2025 12:01:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] MediaTek MT8188 MTU3 USB and Genio 510/700 TypeC
To: chunfeng.yun@mediatek.com
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, pablo.sun@mediatek.com
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/02/25 11:55, AngeloGioacchino Del Regno ha scritto:
> This series adds MTU3 nodes to the MT8188 base devicetree, fixes the
> Geralt Chromebooks to use it, and adds support for all of the USB
> ports, including TypeC Power Delivery, Alternate Modes, etc, found
> on the MediaTek Genio 510 and Genio 700 Evaluation Kits.
> 
> This also adds the missing SuperSpeed port to the mtk-xhci binding.

Forgot to add....

Changes in v3:
  - Added a commit to allow the SuperSpeed port in mtk-xhci, resolving
    dtbs_check failures
  - Removed useless vdd-supply from xhci1 in mt8390-genio-common.dtsi
  - Removed useless interrupts-extended, as the wakeup interrupt cannot
    be found anywhere in the schematics; the wakeup anyway works because
    of the pericfg's syscon-wakeup doing the same job.

Cheers!

> 
> AngeloGioacchino Del Regno (3):
>    dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP
>    arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe
>      USB
>    arm64: dts: mediatek: mt8390-genio-700: Add USB, TypeC Controller, MUX
> 
>   .../bindings/usb/mediatek,mtk-xhci.yaml       |   4 +
>   .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 +++
>   arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 +++++++++-----
>   .../dts/mediatek/mt8390-genio-common.dtsi     | 151 +++++++++++++++++-
>   4 files changed, 251 insertions(+), 43 deletions(-)
> 




