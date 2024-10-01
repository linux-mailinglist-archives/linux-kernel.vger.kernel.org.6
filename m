Return-Path: <linux-kernel+bounces-345426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C803E98B636
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E511C21E37
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194811BDA9E;
	Tue,  1 Oct 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="otXwunuT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC5199253;
	Tue,  1 Oct 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769270; cv=none; b=Mccdb+XvZKgXy7KlCuneCUgYNpSSUZpQjW9OZ1ui6DtpDFvbPpKUz5bkhrBIFJRzDgeswFLu6YGoxq0ptNzBD6wSaDFVQPUkj+B/V33rWE5UJXgyxqAhg2HrtL40mYjpKCEsFzccPa7CC2kFq3zU+bGe5XV8DNcEPfEmgb7ohHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769270; c=relaxed/simple;
	bh=5ZET3p3zVrRIMFCDf6Lv+QwoHRWZt3Lu5WSpJmGz8ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ezjw65AyTXDW40iQ4C5krYj0lP2qkWI72pYo715337j9oVKSb0MMgVkKA9G4tvsw90lzLUkSYGocxBFyhaJrhF1ZLCzpxFY13VjrIrgyIm5ugW40HwzKJbO8oKHUYe3JjSvgqC/BZTfpnCAinCoOva0Nmt9KL/PiwACrFqyBDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=otXwunuT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727769267;
	bh=5ZET3p3zVrRIMFCDf6Lv+QwoHRWZt3Lu5WSpJmGz8ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=otXwunuT1IegLikwxC0vMY3+wyvoMJuEKtQyMTT11BZPbOCOdiQjUJagKlUN6cQFq
	 j2prA5Fcpx6SJ1zrfCcVr/IoAAs/ckdHFzt1UftpbS7B2St8ceKyrSM79gph/qR3Go
	 nJgD/24Uz8gZOw2ZWmq/GdPT5BSrYTnuurDp5TB7S+I0L8UcOVeqyKF/EAYnLf8Lse
	 FPWRExN20Q7kPscV+SdC9eY7l8rEhNCiz6wwF/DxbTmXG6oLQOoRRyd26HLIQifejC
	 SrwE2Xbh6Fi/FInNlX5ismRjNkAY3zAvLX6lPNrYCNwKN9u2E2G7LVzQO7MQfU3LFx
	 20lBp+O15L+qQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C58F017E0E01;
	Tue,  1 Oct 2024 09:54:26 +0200 (CEST)
Message-ID: <b414e84d-0b1c-4ae9-8172-dfb33448a513@collabora.com>
Date: Tue, 1 Oct 2024 09:54:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: drop two dead config options
To: Lukas Bulwahn <lbulwahn@redhat.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20240927092232.386511-1-lukas.bulwahn@redhat.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240927092232.386511-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/09/24 11:22, Lukas Bulwahn ha scritto:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 0f471d31e5e8 ("clk: mediatek: Split MT8195 clock drivers and allow
> module build") adds a number of new COMMON_CLK_MT8195_* config options.
> Among those, the config options COMMON_CLK_MT8195_AUDSYS and
> COMMON_CLK_MT8195_MSDC have no reference in the source tree and are not
> used in the Makefile to include a specific file.
> 
> Drop the dead config options COMMON_CLK_MT8195_AUDSYS and
> COMMON_CLK_MT8195_MSDC.
> 
> Fixes: 0f471d31e5e8 ("clk: mediatek: Split MT8195 clock drivers and allow module build")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



