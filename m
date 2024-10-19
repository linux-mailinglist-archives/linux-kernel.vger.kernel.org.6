Return-Path: <linux-kernel+bounces-372740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97F9A4C84
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 11:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DDBFB22ACF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB8D1DED65;
	Sat, 19 Oct 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mBfmEjwe"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB41DD0FE;
	Sat, 19 Oct 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729329730; cv=none; b=ige37uFADqCyJlDLIY2f5Xelvwlu//Gbu333Uu3I+fXhZwhbsVo4W8/Gx5CIQZV2WNT3kKx530fv4H9gFY5L1p3rO6BfP6auN63NfKhY8/eXFmYo/qifLp1UsNzr3z7MhHlqKZticjHa9rW8NKuRSFN6dudoJdRro/D6ER7TUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729329730; c=relaxed/simple;
	bh=ddx/wzHX3BBS9AnzKxxwJZVSrSQneUJZVZUhyLhbx0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMuwL/aoz30x+AaWf4fAx1qnLt0Z/yU5/Pp9117vdDfjMIu537X7p7HnHraD2INiNgMWRJKOMxmp/ZnEP8R0iDg5QqKISLliYok3STEAZuxY52Gf3LsNW++feQv30kmDxCAcjSTdok5OVo1se5t2m1VJOEYd/Bth4wiGV4tifS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mBfmEjwe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729329726;
	bh=ddx/wzHX3BBS9AnzKxxwJZVSrSQneUJZVZUhyLhbx0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mBfmEjweJWeFSDGFz/tgFi9f2CaY0gRzttWfGLKQgxZG4VTqT+oRrU2FHkhaSnyAa
	 gbmk5TyxCgOX0EvKZIGstgBKwYYzq41EvofkiE/9oEeEYuUJuHtOEcwcTcaqrA6Q7O
	 afPN8Iqu2TVOvE5/b+5JNQdgrwu8/MDvuxKUoB7zHPQ3A79X8h39AtHXvEeoWZVdVy
	 qyH0uYbsa5ch18ur18X5xkmV+v6JiXm/GBWCvHw7LmbPo/2mmyOWf2VXOgaiOLZlnD
	 r202+GUiCqAw8GM+3NHd1/sYbVbMCLhTuZ2H43/cCD6fgGX97FY9cyrlYd2KRdN2W+
	 q4/EQX2Qob5zg==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 014F817E11E2;
	Sat, 19 Oct 2024 11:22:05 +0200 (CEST)
Message-ID: <1313314d-5398-4ed1-ab54-f0dadc638103@collabora.com>
Date: Sat, 19 Oct 2024 12:22:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Enable HDMI0 on rock-5b
To: FUKAUMI Naoki <naoki@radxa.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
 <20241019-rk3588-hdmi0-dt-v1-2-bd8f299feacd@collabora.com>
 <5E49B36195743C7C+3eb032f1-fda6-4a61-bcaa-8ce34256cb51@radxa.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <5E49B36195743C7C+3eb032f1-fda6-4a61-bcaa-8ce34256cb51@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 4:41 AM, FUKAUMI Naoki wrote:
> Hi,
> 
> thank you very much for your work!
> 
> On 10/19/24 06:39, Cristian Ciocaltea wrote:
>> Add the necessary DT changes to enable HDMI0 on Rock 5B.
> 
> Rock 5B -> (Radxa) ROCK 5B
> 
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Thanks for testing! Will send v2 with updated description.

