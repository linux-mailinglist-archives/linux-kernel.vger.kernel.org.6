Return-Path: <linux-kernel+bounces-543508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05385A4D68A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE446188EAD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC71FAC25;
	Tue,  4 Mar 2025 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mptd97tV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931191DFD8B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077215; cv=none; b=Z48n0J1jS4frK8fpcLYf7vvQGPkVVx/iy/q9vNR2ZRjw44wVhi7RplPE1gCVg6OhXOCOb5J0OmU0ElEQ78mbJdQir57g/njGL7MBrRivbIaakr+b3aEqM9sk/bFvGlO2o8QSRsmNhtZYNJhnxnROKPISLIO9qnqEU4I5cDAJhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077215; c=relaxed/simple;
	bh=D//EKwE3vi7nckqhjOFnJzSwtXNgoivMFlQTKbprxrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8jrZ2jeuG6AUUZnS7x2VM7BpIfxPT1l0+bdqRucbEhgArYl2xfapF5GwypGpl2G8uQllXleBE84ITmkBd3OXbXNvZX0uldKRPJgI6VhQEvgP32kkQNXW0132BgBg2w+tDkQVTEWW3jss2j2gF1Hkqi20uImvmcQO3oOa24n94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mptd97tV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741077211;
	bh=D//EKwE3vi7nckqhjOFnJzSwtXNgoivMFlQTKbprxrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mptd97tVcVMH7lz6HXvTpKpGWx2ewfwF7dfyrS0ie0PZWEy17pXk+58Hq0tOUHT7q
	 i1semtKIiFJ79X8yRy9uIbg2eYzW93VftX6hhQ1oClURlgK+hquFeaHzQ1JuLufRuv
	 hBPV/rLobz985oewby20c+HWhCNkD7ZtD5+h1UKjt0VHt9bRQ8OSILOZ1QRQzEXwyu
	 GvJlyH6Ypxzj2PT6vLOcTRLMZKjkeBCliWw1ayUHWMpJI+xgVT3dMQ4t4daq0vPQe8
	 bSnl+2PdaA7mgkjz9Jl6164KuY2JJ8VDhVUUxF8xfl14K+O9kfwApIs4cNyizgEtSd
	 m+ELW4hUZAGIQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4C51417E087E;
	Tue,  4 Mar 2025 09:33:31 +0100 (CET)
Message-ID: <7aa89f17-c2d4-4143-a84d-4e736fdc6c27@collabora.com>
Date: Tue, 4 Mar 2025 09:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: mt6397: drop unused defines
To: alexandre.belloni@bootlin.com, Lee Jones <lee@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250303223637.1135362-1-alexandre.belloni@bootlin.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250303223637.1135362-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/03/25 23:36, alexandre.belloni@bootlin.com ha scritto:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> RTC_NUM_YEARS has never been used, the other defines are not used since
> commit 34bbdc12d04e ("rtc: mt6359: Add RTC hardware range and add support
> for start-year")
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



