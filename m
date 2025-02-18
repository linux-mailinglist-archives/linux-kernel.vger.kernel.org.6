Return-Path: <linux-kernel+bounces-518931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468AEA39668
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D53A4597
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E122DF9D;
	Tue, 18 Feb 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HTLwXxO+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95014A614;
	Tue, 18 Feb 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869034; cv=none; b=ZOwVq6pn1llofnaJishSzH8p8fKye32ep1qrpocbssPpeKQYHC5OQKClRbOvWO3CUk7XX9qU1eoCifJe/oq/VHIqh8E0aDSyp/njB8CvZrpxxmEf+MgD31tOUo1oYaq7bYJGBcPBLZSUsw7Cksx7L8ui8SVrYz6IEqwQG6mL0SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869034; c=relaxed/simple;
	bh=2vE8L5fJp+dtJyWdQbSVt0omOCEQO0xF00KJ3QonoKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKShPg/mfNy7ZFoCjVh2l/+xuGS2M+f4N/rxZVbuEZzlG0kuYSJQsB22JCxVoZzxSHBgsDuzIqRH09Mx4f/IGMEgGdeB5FJHYENuVVwA9dBXiLvBrUrjIHWLEm0fQ0YYeyBEiMGXK6PTE4wUYdiFpx+7PgkirP6n5rS+8yIEz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HTLwXxO+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739869030;
	bh=2vE8L5fJp+dtJyWdQbSVt0omOCEQO0xF00KJ3QonoKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HTLwXxO+GyF1AD8FucYG29B1fK/lOd5HKGq+eU7n3INbr/PXWBliw6JzFvF7421MN
	 hVl6i6IzO7bTIAGbQBFDLUT7fwRd+wMWhA/ik1ULEcoU3kUkh93PXjephjguDhySuM
	 CmC+GdxgZnokHX8UesfiDF5xgtbjPcm7Dj2nL+pPVXXNToAMwvbGnC/mHMXLUMjw8u
	 sVlYbD3RVIg1eNGMndq6XgRtwqk6xqPJRO1XiSfd4/M1Msj0oMhtB8QKotY/eBsEOs
	 cgA1/9SBpKX7ROGTANvw32SiSHRG3t7JX+9w7gTTqKUzm1M2HpOYcQxaYqZlbcmcX9
	 qN67gFS9gcYog==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E178217E0657;
	Tue, 18 Feb 2025 09:57:09 +0100 (CET)
Message-ID: <b26294cf-c751-4507-ae01-4f510cb4834a@collabora.com>
Date: Tue, 18 Feb 2025 09:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: mtk-xhci: add support mt8196
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250215100615.808-1-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/25 11:06, Chunfeng Yun ha scritto:
> There are three USB controllers on mt8196, each controller's wakeup
> control is different, add some specific versions for them, and add
> a new compatilbe for mt8196.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


