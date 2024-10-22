Return-Path: <linux-kernel+bounces-376653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A779AB479
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9702285BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D21BC9E2;
	Tue, 22 Oct 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ckht6IRY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF62256D;
	Tue, 22 Oct 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616138; cv=none; b=b1j1Yrj7wLv22yD9K1FX2MDpiRpXU+Bo6MtIh90Y9OwOnPavIdy+p/lZIEsK4uZeK3xvI4S1zJnxEp7fosZZOyzGTwdLTMFrhovoGm62y7TukcoKNbZ4Chm5xSVWsK1Zp5ylmYVwwiGkL+jhgSMxvx3VI1urbvc2OIOKiViYfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616138; c=relaxed/simple;
	bh=l/4GnR/AR1YjPA5kz8XCl4dXCERTTJHmi26HUzyauoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpP0MWGye7jZPAwQQmgaWoyXPFDqtJvHbU6Sn/4QBFkIUxyUDhcqLdWmQTodyP+7mKrkqslEzuu1a2r1fAs00g1KqMEMxrqxXYwWeMzHvAejL4VJFBrbz96V6R+Gf+diO/nyN7wBNjw56i3eGcYYF0tA4npYxIbGPra7wjHlocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ckht6IRY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729616134;
	bh=l/4GnR/AR1YjPA5kz8XCl4dXCERTTJHmi26HUzyauoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ckht6IRY4a08YCQR0i3IzQJYDMsYMppPznoonp+YNRAj2HFCf97fzEXlkKK0AoqtR
	 C0MdlEPO5RTWzxW1Dj/jLmpTmeG/yxQLBRBn4Ya92b/YcoaI3m0ssLt4dHB7bIiFtl
	 jtP8KMvEpEePmSoXynROEbfYeQ0DoPKFZ8jttozZgtbu1fx1VOW8I815mJIBUV6xwh
	 R85GmBRnSDbdEkoP0ofQ6ZrI0okq4+R2detGbt8obt8HVKfOEgZbU0HDw80CLd0hjT
	 xIq7Cly4k9AwwrLSZNK6IGzKwtA+MWO31p5Jzbk867x7ohHDxBQOOssfmZdC4dvT8h
	 4+RHhbsoYCscA==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 617DA17E3693;
	Tue, 22 Oct 2024 18:55:34 +0200 (CEST)
Message-ID: <a928726e-c0c5-46f5-8ac6-323c8d16ea54@collabora.com>
Date: Tue, 22 Oct 2024 19:55:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Enable HDMI0 on several RK3588 based boards
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
 <2a27ed62-305d-4d41-a43f-02f58bc22e2d@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <2a27ed62-305d-4d41-a43f-02f58bc22e2d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 7:29 PM, Marcin Juszkiewicz wrote:
> W dniu 19.10.2024 o 12:12, Cristian Ciocaltea pisze:
>> Since the initial support for the RK3588 HDMI TX Controller [1] has been
>> merged as of next-20241018, let's enable the HDMI0 output port for the
>> following boards: Radxa ROCK 5A & 5B, Rockchip RK3588 EVB1 V10, Xunlong
>> Orange Pi 5+.
> 
> I copied changes to FriendlyELEC NanoPC-T6 DT and booted 6.12-rc3 with
> your changes on LTS variant of the board.
> 
> With my SBC monitor it complained about resolution (10.5" 1366x768px):
> 
> rockchip-drm display-subsystem: [drm] *ERROR* vp0 Cluster0-win0
> actual_w[1366] not 4 pixel aligned
> 
> And monitor told me "no signal".
> 
> /sys/devices/platform/display-subsystem/drm/card1/card1-HDMI-A-1/modes
> lists all resolutions available.
> 
> Would be nice to see system going to next EDID resolution in such case.
> 1280x720px is 4px aligned.
> 
> 
> With my 34" 3440x1440px monitor it shown some output once. In resolution
> close to original one but 16:9 instead of 21:9 one. Anyway monitor
> behaved in "I do not like that signal" way - started blinking, had
> problems with displaying even from my desktop after.
> 
> 
> I got a feeling that 1920x1080px monitor landed on my "need to buy" list.

I'd suggest giving [1] or [2] a try and see if it fixes your display
issues.

The VOP2 support for rk3588 in mainline is not able to properly handle all
display modes advertised by the connected displays. We have a workaround
and I'm currently working on an upstreamable solution.

[1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux
[2] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/tree/rk3588-hdmi-bridge-v6.12-rc2


