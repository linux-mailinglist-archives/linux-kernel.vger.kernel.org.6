Return-Path: <linux-kernel+bounces-324774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3299750B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB081C22A00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4018785F;
	Wed, 11 Sep 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Nks8Aqe4";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="UWA2pUsI"
Received: from a7-31.smtp-out.eu-west-1.amazonses.com (a7-31.smtp-out.eu-west-1.amazonses.com [54.240.7.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2A185B65;
	Wed, 11 Sep 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053859; cv=none; b=O5nrEFM9Jy1PhGqxP5dKbjIuPQG5cWFRFVezG6CqiZ0pDuSZDQtXoAfU30NqL1XNRg8XTvfadl0W1EhE1HsCbLjSQ2UrDtNar6DFbW/wMmJEMQvCuJ0g+teA6h5qO0z85NuHNatkvRyvPwbo+BpLQpK42/c+EH0N/6jywht5KPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053859; c=relaxed/simple;
	bh=mqYi342WHEdDf+HDPe90o07Mgff6F0tXVtleQjq7ybM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeZDFT/HayuXXb6CTDvXuFBEzM/npGvw9/eDoaWEISCSU1OprES8q1eD5d4A51zeS5w5W3DDU2PU5YfxSg5pg4eBELswlclWzOkijZ61y4lPHfWxkPrUJhwIIVcxe5PtGw8m4NW4qSU86TpdJSHE+44KqdNcEgGm/yOZtffQ4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Nks8Aqe4; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=UWA2pUsI; arc=none smtp.client-ip=54.240.7.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726053855;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mqYi342WHEdDf+HDPe90o07Mgff6F0tXVtleQjq7ybM=;
	b=Nks8Aqe4s6qQBLPrIVWYyte/c5ASGpSzE8nUKBX3ind0WcjOZ6GirmgsqcJzR+Gf
	pEyfV/ItgN2DE/dMbbC9Dr8S6V/w7cHGbf5pQu1IW3i3EgZ9cIaOeJIMvutMKuzpG8v
	tkmc2/o1DuW9EHgT58o0BmIrp898Sd3Pj1EJR6EpJ66aAcOR2mlGgvqMj2hMYm594Eq
	g52GyExcPgwx5Uj8MVHwvbDtFUCuPZOFjinbexkcNR0sKyKEjRBc+86t/8DmzMAowEs
	XqBSHaZyc5cjh4QWuHo94fUYDnCDi8XUXza66EEgN4a4jmwTJbmb5B1OAhsIKm4U3Kq
	BdNwXJgDrw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726053855;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=mqYi342WHEdDf+HDPe90o07Mgff6F0tXVtleQjq7ybM=;
	b=UWA2pUsIGq+V6/WzlOopiOOkZJ7SfCVozcaygBOON517GwOV4RQMgrqSUDpSFum5
	WhsuhSMcQUE++3fUp/3NyLzUrzWNpamsv6/j+JeUa3+M5ucGfgiw/Z3hl9nQIk8rXHw
	qFlYiz9pW0tlMw06pPLlL17lta82osqy1Jq/R0KI=
Message-ID: <01020191e0d3b260-aab4dc96-e245-49b8-8b77-494823ddce5e-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:24:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: mediatek: mt8188: Add PWM nodes for
 display backlight
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240911105131.4094027-1-fshao@chromium.org>
 <20240911105131.4094027-6-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911105131.4094027-6-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.31

Il 11/09/24 12:51, Fei Shao ha scritto:
> Add two hardware PWM nodes for display backlight usage on MT8188 SoC,
> and mark them as disabled by default.
> Boards can enable the necessary PWM node as needed.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


