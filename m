Return-Path: <linux-kernel+bounces-321316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747E9718A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EA9B25D04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567F1B86E1;
	Mon,  9 Sep 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dB3QDbBx";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cFvmiErL"
Received: from a7-33.smtp-out.eu-west-1.amazonses.com (a7-33.smtp-out.eu-west-1.amazonses.com [54.240.7.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25691B652E;
	Mon,  9 Sep 2024 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882604; cv=none; b=K04XnOJmqidNcnNQV5IeBXfrIf+7hjBg0ne2WSq1W8w9LZ7/+5WWzCGQan+nzrtYrJtRefz4vSevq7Ull/gb6LTPBtKlG07G2yHicLSZtNDfvR53Mp7uvWmOpSrJn0+ys15vi0zI1BtYDL4/UrqE2g3n6YEEKF9Liscr/Ex6Ypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882604; c=relaxed/simple;
	bh=v/IlO7buH1ErWcikn3NzRShGgbRBBdXuxB2vIRUpab0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mX2QVVeltGn7HH2WvdceifP9dWWQOLQzfxi/sl1QPvEJfJsH/WZa+lfE4V3vqtCoETtVq8zrBxDfhLKhNwgWRPl9xdqQk6pcaRIAjdPEwZj3r6L3DfssZiF+H+/IK72T3ccEOZMfb7hblhH+16dMVGAp1F7yLGj5iPR01ZFM1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dB3QDbBx; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=cFvmiErL; arc=none smtp.client-ip=54.240.7.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882601;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=v/IlO7buH1ErWcikn3NzRShGgbRBBdXuxB2vIRUpab0=;
	b=dB3QDbBx5LGH4dsM3OCqbEvSk0rYk6gX2e/smKUyxqPYGNrT9zD9cnDsIK2mUvhX
	ya/71CU6fOivd8YrTx2gFq4Nz3F7tixOz/6OyswOsU75MkPLLNh69354ZwwdFCq/51r
	qERMHV7gnBshX8pztSm0tlCZq9FnNTB8/706k30dfP0miUqgrniSnVM8wgi0+OIpdb6
	Gtguew29SUFdFRnWSX19BL+8PbjBEoRM9mcaDy++lIkuVFXwyPsaQFr6cBCbXU5Lxnc
	ka1CnVKlut5gyuNCsUlBZd7d4tOZeMZvvb6Y1vTeTGROfJ132OmBva48TqDBQfn5f/x
	LeTnw5By3g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882601;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=v/IlO7buH1ErWcikn3NzRShGgbRBBdXuxB2vIRUpab0=;
	b=cFvmiErLoSEDoGKVd9c1jsFG0MYbYQHMV46dqzDw/JwUrXrKrJfAsC2waEXVmpim
	lRk9mvHuq9LKucCE4qDNtD2m0jGK1bNZahxA59N9VPRsRoxz61Sg6QVpJlGv/zG9vOL
	cXyk6zIhwzopb5bfkDULjQMAUF3RU5TbFGRdrhw0=
Message-ID: <01020191d69e8e04-38cc173b-c8e2-4da3-99ba-c5598e90dea4-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:50:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ASoC: mt8365: Remove unused variables
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-5-7ad0bac20161@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-5-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.33

Il 07/09/24 02:53, Mark Brown ha scritto:
> Silence compiler warnings by removing unused variables.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



