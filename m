Return-Path: <linux-kernel+bounces-410443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A19CDBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1294B22F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD7818FDAE;
	Fri, 15 Nov 2024 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XljWqPfu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA2189F39;
	Fri, 15 Nov 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663468; cv=none; b=QF02qZTtssB7XbO81SpsJ7ObUlhBhpKBhRqYgb8QaZQ4+jQSfaZzogLTejBeMs5KvcrMp+IIwCd55uTgJf2Gt31Lbr51ClfSeA//mHh4nwk7czAcz73gB1RDM7CJZryJXALtEzcfWWWk9kkcg2k/qujj6FPy77D/nui6NSN3woQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663468; c=relaxed/simple;
	bh=+xNK8TNGFAMAR16Vqo8z38gow29xtTPT2/t8VQXloz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwi/EGyYP4WVq3OBe1W0PqBRwbuQgax74DpsNAU7HMqxnaLEtfUEB1Nh6WVR10EmV8kxaJUfS3vOFZaHfWz7675k8hRlXQRWlB5UYkZMfCPIV7XWRFRvkCzeox+jGRwXASFACGwRTXaK8x3wP62oOmHQJxD+/CJarXZFDveNpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XljWqPfu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731663464;
	bh=+xNK8TNGFAMAR16Vqo8z38gow29xtTPT2/t8VQXloz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XljWqPfu5ux7IXHlV8basHYOCWkP/L5ylGzWWvnlYIOAFXmfkQpP/Gjvsz/K1bACV
	 0PnWq/jKHRnG6YwL7azT8CI3L2wz1CJnjckxvP2Z0pDeelEp3xAaLhWY5Ha165Zg/5
	 MvqjokjTF9slJsHbqJsayXjFmEqo2TxgclbxCuv+j9Ir5kyuXNQUbc84vNZq+e0cad
	 YFVxIAis5FTGauXaWXnsYbWJFamR9yGmaGTUbQSzg//OZs2N6V9Xy4OKGcTRkb/ogF
	 77aFgOkWSeloZN7gNBnU7XCVxhiWoQtzAXshmnyXwZOU5DSj96dDCJkUxP9vPquyB/
	 P0WPmuQsbM53g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B81A917E35D8;
	Fri, 15 Nov 2024 10:37:43 +0100 (CET)
Message-ID: <191cf67b-8a47-4dd7-a96f-640bf8155d9c@collabora.com>
Date: Fri, 15 Nov 2024 10:37:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/4] Using i2c-hid-of-elan driver instead of
 i2c-hid-of driver
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241105-post-reset-v2-0-c1dc94b65017@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/11/24 04:08, Hsin-Te Yuan ha scritto:
> After commit 2be404486c05 ("HID: i2c-hid-of: Add reset GPIO support to
> i2c-hid-of"), i2c-hid-of driver resets the touchscreen without having
> proper post-reset delay on OF platform.  From the commit message of that
> commit, not to decribe poset-reset delay in device tree is intended.
> Instead, describing the delay in platform data and changing to use
> specialized driver is more preferable solution.
> 
> Also workaround the race condition of pinctrl used by touchscreen and
> trackpad in this series to avoid merge conflict.
> 
> Adding other second source touchscreen used by some mt8183 devices in
> this series since this should be based on the workaround of pinctrl
> issue.
> 
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

The switch to i2c-hid-of-elan is okay, but the pinctrl hack is not necessary
anymore, as it does get resolved with the hwprober from Chen-Yu

https://lore.kernel.org/all/20241106093335.1582205-1-wenst@chromium.org/

Please redo the second source TS addition based on that series instead.

Thanks,
Angelo

> ---
> Changes in v2:
> - Add second source touchscreen patches since they should based on the
>    first patch of this series.
> - Link to v1: https://lore.kernel.org/r/20241018-post-reset-v1-0-5aadb7550037@chromium.org
> 
> ---
> Hsin-Te Yuan (4):
>        arm64: dts: mediatek: mt8183: Fix race condition of pinctrl
>        arm64: dts: mediatek: mt8183: Switch to Elan touchscreen driver
>        arm64: dts: mediatek: mt8183: kenzo: Support second source touchscreen
>        arm64: dts: mediatek: mt8183: willow: Support second source touchscreen
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dts |  2 --
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts  |  3 ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dts   | 12 +++---------
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts   | 11 ++---------
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts   | 11 ++---------
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts   | 11 ++---------
>   .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi |  3 ---
>   .../boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper.dtsi      |  3 ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico.dts   |  3 ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-pico6.dts  |  3 ---
>   .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow.dtsi |  3 ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi       | 10 +++-------
>   12 files changed, 12 insertions(+), 63 deletions(-)
> ---
> base-commit: eca631b8fe808748d7585059c4307005ca5c5820
> change-id: 20241018-post-reset-ac66b0351613
> 
> Best regards,



