Return-Path: <linux-kernel+bounces-429148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC59E17EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B139280C88
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3A1DFDBB;
	Tue,  3 Dec 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jNP3uz9X"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB564317C;
	Tue,  3 Dec 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218841; cv=none; b=D+jQaKqmHTKkiEqVm4RvrdBPvcHeQiEmOKZt47wxzE9CjHYUDvASa2AxlHqf88mFqhE0He8UkNomh/C5vEkfkMUlAYAYSTP5Qc6vauEApyPhRk45Dn4QUld7fs8dVXmBazdU35O9+SC51EOUNLk0k1QJWtcGeVt+vF187rK6IHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218841; c=relaxed/simple;
	bh=wkD5ZG0b5Saq9pX6c33R8kg0GEShIHTUFOKG19yOu1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uhh3I+ZhKH1KXlwP64rpwd1OIQj5ToPnqhVEfNPDDOfvxjmAUI2NY5MpiULMuq/vEocP4QtDEnunw9XuEJLs5bIV6xaoV1Jx7x2twBO6leYaPdLk1JnF0hdoBxq+h/W3F7iANeogHatzGZ3ukONC7Mka4EUa8e4TYR1BAsD8bCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jNP3uz9X; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218832;
	bh=wkD5ZG0b5Saq9pX6c33R8kg0GEShIHTUFOKG19yOu1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jNP3uz9XNK7fEx4lT6DwfIANO0jhE77WW89/iGPKIJncfQhE5pCDHYp84sW3Rg5mO
	 YoZyuO4bpY1QnomLTM8cDWAgdw3EGGRK+flPCEaYCAuxUYrWctGEtsqo7HjpOzrQL/
	 Z5h81p6oRlRzkoplzQ9Mx38wEP49TC8oHK9pcYGmUuqh0PR5i3yItFuRYwnEhpNWNR
	 0KAueuldIlzgNqlicmV08rx+9EYG+InTyTbBY+udrE6+OL0n90M2d6d1PXPG0DLS5O
	 k6enp4yTVI0+v9Qzwa6Yy/qD4gat9UIYcUsgIk7cNCN4Zj46u79pX2+e1hJgAObLr2
	 +emi3+hD5NpcA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 88E8417E35D0;
	Tue,  3 Dec 2024 10:40:31 +0100 (CET)
Message-ID: <754b7179-a3b9-48b9-90eb-cb6d6754edf6@collabora.com>
Date: Tue, 3 Dec 2024 10:40:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] arm64: dts: mediatek: mt7988: enable pwm on
 bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-19-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-19-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Enable pwm on Bananapi R4 board.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


