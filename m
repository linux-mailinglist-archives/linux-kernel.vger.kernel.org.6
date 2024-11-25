Return-Path: <linux-kernel+bounces-420662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616AB9D811C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263F7281B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BC18FDAA;
	Mon, 25 Nov 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QeN1hjPz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6518F2D8;
	Mon, 25 Nov 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525643; cv=none; b=oErOx3DTqQY2gFE52nINdW+y/J4aVyFspnK/ddH72ISx75/q19xUfRJNRXLx27CWVBjAd+B2NoEeLdcNbTfBZy9wlRue2VUcIxbCG+td6zy9SDuU/WYGXA0qOzvJXYlLMJ68yXR/ZuGd0ZTj8ES8hhGyT8PxBHv5rfNtY0PAqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525643; c=relaxed/simple;
	bh=EWvGbl7jxkC5nJhjdRHyih0oNCIT/8717SCJPMoO/Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lZ4xiiSS90lWIFYmwIafwMtB2qeIHwnURg1UGmblXi9cq5t7LD8jZ2eNvDPB8jWYOcyaRWyueQGNMPMO2IWuzXoEcL/0JBjh/kU3il38H45VjQ+saqFFqdaKJ0EWN4Yise22cHSE350emuGFS1vbMy8jQX5y/VmWI0qzA/DCEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QeN1hjPz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732525640;
	bh=EWvGbl7jxkC5nJhjdRHyih0oNCIT/8717SCJPMoO/Ic=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=QeN1hjPzd5WO3CzmPM9z0SMKXcK4PzvkANBjUmwzZ6drNaAHrVjrzcfQWQ9cWP5Oc
	 xhZQbD6BqciFI+G3ZhG2Mnyk9vAxTPGjdHiLvrBb45YOEm4J5oeeR4laxicIm9qIDN
	 N3IUABVsyH1sV37JLpSQ7OhU6X/xlwPXWWnXqI9jWhiq1rPOM7vdfCuuHce9GSN+jo
	 JQxSbN1IFM+9a4C9ZgAdpW3eUiGftYbx0GzLjgee0uLPCbZXy0makkfQpYetpmzcVb
	 SCzpJNdCz9dwXnzjdwAAlsgrkO6Yfb8ZK7tsHyvC87eH3vtDS41skGSLEYsBpZGmqF
	 i2Yv2imf0KsIg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6460117E1323;
	Mon, 25 Nov 2024 10:07:19 +0100 (CET)
Message-ID: <91b8d700-218b-4d94-98e7-7c32452efff6@collabora.com>
Date: Mon, 25 Nov 2024 10:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie
 Chromebooks
To: Wojciech Macek <wmacek@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Rafal Milecki <rafal@milecki.pl>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241125082130.2390310-1-wmacek@chromium.org>
 <20241125082130.2390310-2-wmacek@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241125082130.2390310-2-wmacek@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/11/24 09:21, Wojciech Macek ha scritto:
> Add an entry for the MT8186 based Starmie Chromebooks, also known as the
> ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
> a tablet style chromebook.
> 
> Signed-off-by: Wojciech Macek <wmacek@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



