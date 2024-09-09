Return-Path: <linux-kernel+bounces-321298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37B971875
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3371F2366B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D41B6534;
	Mon,  9 Sep 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iNlzqMNY";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Hnhzb93u"
Received: from a7-28.smtp-out.eu-west-1.amazonses.com (a7-28.smtp-out.eu-west-1.amazonses.com [54.240.7.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8261B5820;
	Mon,  9 Sep 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882121; cv=none; b=nkLLeXMaHFVZtUuvWzvSEQBXkIHrUAVUasUN5mrVfK8XzMdF0DwgqJ52+JGFTS+fPpZxac9DNhfbEzYTpFRjwAYnWkWwNJK0nwgY4ynrFDZbbweLpfOkuGGLS49DBqQxyBPmevtMgmrq5pL5s/5wd2riT0EDNLzOUgVxXCxT080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882121; c=relaxed/simple;
	bh=IdCditF+fELDvgkw3sLyWuY+BayYAd5MhQ9wNy2likg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/+tvlfQjk0uMTtOkDja4zM6uIzCFHRB5Kx399CFipVVCnG5BZRaC8eseRflT+HcEKkseBh7wh9VyYSAFlv+7tMwfmCyXXijrvzhKcY7XWK3ExfSIuS8PFEZ7qXq/ubv8L526pYBM8zZ3KMEzjckW8qKhqU0zN9sHQPecYIMgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iNlzqMNY; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Hnhzb93u; arc=none smtp.client-ip=54.240.7.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882118;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IdCditF+fELDvgkw3sLyWuY+BayYAd5MhQ9wNy2likg=;
	b=iNlzqMNY5cQLCUq8TLpzo5/xO0wavPYhqY5RrJfvfuwqMbTpBulL1G27JgpwAni/
	nvTAQ2yOF0DOkmje4jUdV2Hv8FlXPnxPxdrthAKqi/ylPAXtAdWGmqQHERHSBb2B2rG
	fLnzfujdWZyskTmQoROXIq74AvyWiJavEZsDmLi0wQl/ybJ9CY/wxAqrlaJEPBnTS4F
	NDxE4LBcj7pUoQkPRwVq3HWQsFpYX7jfRf2Tq4BiZYRnaBAL3Wxk8DeQVBqtgk91Lew
	d7kk8ytiH2tkxdv715+Gt1nMrKPR7YGletn8s03uji0gtespcfWIe8g1ZD6rRRls/5J
	cJ/WDSk5tA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882118;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=IdCditF+fELDvgkw3sLyWuY+BayYAd5MhQ9wNy2likg=;
	b=Hnhzb93uKSHuxIhrpy369Cfvcy/yYiBONNWt3VYf0DZxuzPPn8DA5jtOd17Pz0Ni
	LcC1ftENJSwtIf4b1aq9Q/P8BH+CbYwIqNS7qsubFnDNnT+9d7BGzyRwWexxrAv+u1T
	K34VKI+5E4fkLkC+nKo/0mxyrv5oiXl8btWUOgPw=
Message-ID: <01020191d6972ef5-12c59f31-ae58-4aad-b33e-5b7618c0443d-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:41:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: mt8183: krane: Fix the address of eeprom
 at i2c4
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ben Ho <Ben.Ho@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Nicolas Boichat <drinkcat@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
 <20240909-eeprom-v1-1-1ed2bc5064f4@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240909-eeprom-v1-1-1ed2bc5064f4@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.28

Il 09/09/24 10:33, Hsin-Te Yuan ha scritto:
> The address of eeprom should be 50.
> 
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



