Return-Path: <linux-kernel+bounces-429159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107C9E1803
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAFE283E80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A01DFE1A;
	Tue,  3 Dec 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EReIGTd7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3611E1A2F;
	Tue,  3 Dec 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218849; cv=none; b=Ye4vGEZWk4GjRuP64roaF/PfuX3HCA+c1P55DmuQaV1RUxr6u//b1qocayYk7nSiPJdYvxNJ6/u+lQ+JsQX38CplAE39ygQrjeCe0hBaGbCvC0MzJ23w5Nkxo36b3zuc18HJjT0+jodptM8hqX5d4H5D5I2FhhKgAnBpPl5RBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218849; c=relaxed/simple;
	bh=6WuAClq8M68owHut10bo/Y4zfAyMTKIxsgOOv/8ymMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDUs5tvfTYVZ69pG8tRWAmHF1uz+nYqk+xoqa5jhIugpgOKa1I0BxZcc4COPeFJREsUyrXD/AxotomO1OdWKWueZvIaVZ+/u1C0yxRHV1sNELRbkqVpZquOnSFrd5k0rNUVS6fJAmksAkyVeHi2sutkNBsWXWhbgRchMZVXBcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EReIGTd7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218846;
	bh=6WuAClq8M68owHut10bo/Y4zfAyMTKIxsgOOv/8ymMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EReIGTd7WIAMBf3p4YP7I5bDNR2b7UoNya5BSCY+hTD2abhrmLQvUQptTG8QxeKND
	 teMXfHbIRttBh6Qg09bPckAvQO2odtMNE4/MabDLAbdqFhFfAKe61bQ74Kg3RLEGtz
	 YyDEYfu54ZD1p4OffiNi/eoOqS4yvEecm/Pmrs5EltpD0xPQufofi/ZsGEd5dEiLRM
	 o9CRp3CeicuXVl/kw7VIZB1Dx1hXo7lqsbyRlfEjc8IL5dQg1F9klhqewQmXIOrMBF
	 ILbD1q3ko1XS+rtEAnm+gcmf5SvLk9DSxoIbinN8sNV/YmBwHdl+ullx4wnJ96n8dU
	 b25xGEieFUY5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9CD1317E35E0;
	Tue,  3 Dec 2024 10:40:45 +0100 (CET)
Message-ID: <6a547915-4a20-427c-ab91-9e64d3afeb67@collabora.com>
Date: Tue, 3 Dec 2024 10:40:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/18] arm64: dts: mediatek: mt7988: add missing
 clock-div property for i2c
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-13-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-13-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> I2C binding requires clock-div property.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Can you please group all of the DTSI commits at the beginning, and all of the
BPI-R4 commits after?
Of course, do that *only* where possible - like, this one can be moved as it
is only touching the dtsi and *nothing else*.

...Besides, this commit also needs a Fixes tag ;-)

After adding the relevant Fixes tag:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



