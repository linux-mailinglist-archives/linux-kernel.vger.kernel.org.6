Return-Path: <linux-kernel+bounces-518932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE5A3966A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBC83A4953
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EFE22E015;
	Tue, 18 Feb 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UBX60/LO"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412281B6D11;
	Tue, 18 Feb 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869034; cv=none; b=mcptmT6MHm+9l1YwPdSFagtdK0fhWoSQ54+PZwlpNWWx6gLAXN3ZbSjtmGfFB/ZtsNSp0KTGlGsXPsCjvpU6YtSpPKZ5duhDE5SOsEaxrrFvxqdUsSB1TWQMM9KbJPflmDSL+LbP+GE4SmnpKALDiBZSZQ1/Qj+06kZmizjVJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869034; c=relaxed/simple;
	bh=FAM8Q0Vg3RX0znVoiEabsoyA+LQWwAU+aFTdXsSmpow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPcLpkcDM67Zav02PZPLxRWxAym1lQ2A7VNgEMzcxTswjh7BMUVSeZPRlU+05WeFnmYlc7Klq/uHxzc1eBD1xuut9SVnxZ4n6ovs9loB7BnS6HBizAvhgisYoHK3X4a1besyLNxLrHNetGrRROSSBAN7KWDZXMkmGjbu3yQixq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UBX60/LO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739869031;
	bh=FAM8Q0Vg3RX0znVoiEabsoyA+LQWwAU+aFTdXsSmpow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UBX60/LOc8k0z48ex/gZNuGCt+3MgHPT4Ntt6Ib695Yai7diMjadnHACYzrE34M8U
	 eKjp9cws36qoco5fX9OsbLiQchRN3lp3whUNZ0SUoR5+e1KIv761G40lwnYzmSxMOu
	 nQPjdFpYJk7pKfvsIJlcgaZEAumEs/JouVKY29Z7cqHQ2rhFltEk67r2/BlWcS+JNv
	 wt6xF8W98DVB5rTsuF/szJYDf2K4bDd3UhI0co5z2kNk+VZRv7I5BJEY/QPhC8Cpbv
	 lMm6wszrA4QtfcQe50eT0C2bFhYtksAF12QZTix1aTdMs2X6rtc3GqTO9EyTiAP++l
	 shVCBOK08qg1w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D2D1F17E0CA0;
	Tue, 18 Feb 2025 09:57:10 +0100 (CET)
Message-ID: <eb9d0d76-f366-43c3-8c41-baf588ce6ccb@collabora.com>
Date: Tue, 18 Feb 2025 09:57:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: usb: mtu3: add support mt8196
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20250215100615.808-1-chunfeng.yun@mediatek.com>
 <20250215100615.808-2-chunfeng.yun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250215100615.808-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/25 11:06, Chunfeng Yun ha scritto:
> There are three USB controllers on mt8196, each controller's wakeup
> control is different, add some specific versions for them, and add
> compatilbe for mt8196.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



