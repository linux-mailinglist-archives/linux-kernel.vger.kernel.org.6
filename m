Return-Path: <linux-kernel+bounces-398959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FE9BF87A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC973284574
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C31320C02A;
	Wed,  6 Nov 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p8odjkDj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7B20CCF0;
	Wed,  6 Nov 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928419; cv=none; b=iChWrwUBuTaiiujARwNGBgwnuS4lflLTQDWtQnoTqYbUSNV55ufddh4Wr3vS0aQq5siyWKwfEr/UFB7xESgM0G7f9Efj/934INk+EKP1g2UC3anwS7KXrcae/QsbPKhCqYo8zndy+v+HAHXs/Wk9VpMEYjjzJ17m/BHXLUMyiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928419; c=relaxed/simple;
	bh=9g6T+MOclTYUgXeTrv5olCKGPoeDF0LBKeyubV2+kU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to3BdxYLEYui7xdb4TPyF/aJFYtdyM1OcZlOq1fWoS88uWKt5iTiCkRSzgylyp9CHAyDP5r4U0MyiMhb00AEdRCMc+DZ4RImhCCoSnegJlWfAD6G8MI7xl1MOj+h1xdo9kjtcE4LITgzrFdn2UcXfNpt+B1xxBYbigICPaEJIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p8odjkDj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730928415;
	bh=9g6T+MOclTYUgXeTrv5olCKGPoeDF0LBKeyubV2+kU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p8odjkDjQKL3CjEB/U5VkLC45YeQPK/nzseNlKYeMx/qPq5SV6KHAHgzMCMUmCZvq
	 dinnaISVyg5W2Jtn2s1stbJMk99KBvFAEkmME+h5xntihSxKWEPtmxwDEuUGunRJli
	 N9kjW44AeijTORTCNHmlkCepVttOKe+zT/tNSFPQ6QqcaS5NUu9bptnTKA6jupTCZy
	 xUMUJvpvQZFCA5QQgJQVzZNRxfl2kHw74HaxI2qSimdhvOsOq6r8K0ow6WAnh5Mpii
	 qrDf0I/Z5Q2XTPo1cepsm2CSXswdidZu2XlBZyZ9ajp9mvTw9JcNYXIG5lhnJLg/Hs
	 yJZ3xSWjJbCaQ==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6926717E378F;
	Wed,  6 Nov 2024 22:26:55 +0100 (CET)
Message-ID: <fd2d2d7e-67ae-43a1-81ef-91e2852edcb6@collabora.com>
Date: Wed, 6 Nov 2024 23:26:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Enable HDMI0 on rock-5b
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
 <20241019-rk3588-hdmi0-dt-v2-2-466cd80e8ff9@collabora.com>
 <ZyvUsdc8ZhiD8-DY@desktop>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ZyvUsdc8ZhiD8-DY@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/24 10:42 PM, Link Mauve wrote:
> Hi,
> 
> I’ve tested this series on a Radxa Rock 5B using Weston, and thus
> patches 1 and 2 are:
> Tested-by: Link Mauve <linkmauve@linkmauve.fr>
> 
> On a TV which erroneously reports 1360×768 as its preferred mode,
> nothing gets displayed.  Only setting a 1920×1080 mode will display
> things correctly, every other mode stays black.

I'd suggest to try the following patches from [1], they should improve the
display modes support:

94b5c31f969d ("[WIP] drm/rockchip: vop2: Improve display modes handling on rk3588")
c33c23053987 ("[WIP] arm64: dts: rockchip: Enable HDMI0 PHY clk provider on rk3588")
6059245635c0 ("[WIP] arm64: dts: rockchip: Make use of HDMI0 PHY PLL on rock-5b")

I'm currently cleaning this up and submit upstream when ready.

Thanks for testing,
Cristian

[1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588


