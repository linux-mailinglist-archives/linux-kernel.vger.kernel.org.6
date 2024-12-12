Return-Path: <linux-kernel+bounces-442891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935559EE387
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9111889296
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F99210F45;
	Thu, 12 Dec 2024 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bPLGh9Gv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534D20FABF;
	Thu, 12 Dec 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997445; cv=none; b=ZwAHpilaCj2TqQKSoHMZss5PG3Riw8Xflt3v7AVSNbuHBcvzQW/79oysBqSkDgWBJwiXHojVN/tabmy55mLAJIPrCASvrmHRWbH0arVPsiKBp+UNEbLTkr7NE7PN7v4EMsoHALzCo/nz5YfMErMqqy2DbqVdD4+JfihWWJX9BFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997445; c=relaxed/simple;
	bh=jgNmKoBjTrYcC0lC0JbKpXcDmXqGerA6jmuEIOLfzzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9kiQ+YfaQ2VpebtLKau+hU+V66bQf0Aw+KE55ACyAkTpowwqUKsDNSlf15XfX3fmvEg+oGUn8flGj1gX8B2fYSaqoX0H4h5mGSGWdg3P1g5Le0Kux1KDMzjI0VBXDxLbJpxxmXIY9qRs7OHosH9bg/CSEprMOsMwmd4Zh1/0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bPLGh9Gv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733997441;
	bh=jgNmKoBjTrYcC0lC0JbKpXcDmXqGerA6jmuEIOLfzzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bPLGh9GvJ4KdKt2xWeUL6EPjJlJAwUaiDg0gNo3w6R9Z7pq9GQOTdEPGFdZScntVr
	 TCO6IBuQ0BbQiDLZ1U0zyeVxHrJS5XqGogFXZ1e5TYXDh9sClAALz1Vd4HwZjpf6bK
	 xGApa+l62/VmLqAF75bezZyfh2avOowupF3i2M7RhalAMTMYnrUspR3chn+uqQqIWS
	 tsxUs9O/1k4fR4H6s4Cr49uLOke3kix20KxqDNLd8nmwZUpT/YkY3eEG72r81HrtnL
	 OmUJTrv3RwUmSdzLxilj+yblAJx70arRm9QfPu93QTXPn60yqeWY5FAHeTVqKa/7qA
	 phqglwm+fI3Nw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7A3217E35F0;
	Thu, 12 Dec 2024 10:57:20 +0100 (CET)
Message-ID: <b75520cf-1377-4436-9ad4-ef5be4b372e7@collabora.com>
Date: Thu, 12 Dec 2024 10:57:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] regulator: dt-bindings: mt6315: Drop
 regulator-compatible property
To: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241211052427.4178367-1-wenst@chromium.org>
 <20241211052427.4178367-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241211052427.4178367-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/12/24 06:24, Chen-Yu Tsai ha scritto:
> The "regulator-compatible" property has been deprecated since 2012 in
> commit 13511def87b9 ("regulator: deprecate regulator-compatible DT
> property"), which is so old it's not even mentioned in the converted
> regulator bindings YAML file. It should not have been used for new
> submissions such as the MT6315.
> 
> Drop the property from the MT6315 regulator binding and its examples.
> 
> Fixes: 977fb5b58469 ("regulator: document binding for MT6315 regulator")
> Fixes: 6d435a94ba5b ("regulator: mt6315: Enforce regulator-compatible, not name")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


