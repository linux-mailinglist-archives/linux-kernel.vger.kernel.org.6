Return-Path: <linux-kernel+bounces-321318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE169718A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0408C1C22C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86C11B9B2A;
	Mon,  9 Sep 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vi4bPpVG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hS+O7T9w"
Received: from a7-31.smtp-out.eu-west-1.amazonses.com (a7-31.smtp-out.eu-west-1.amazonses.com [54.240.7.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA01B78F6;
	Mon,  9 Sep 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882606; cv=none; b=NCAkCg23ogOmBZGDo1axufvdGswMYOTHTfTbd4s9k9WQr6egqtP/PgwRd8fpe17FJfYRQo3uqTJbD/21nJfu8icHKIP8YQ3kKgOlwfr0FHBtmdjdgRCfC7mI3howWCOngzIZEzeegb0XmxaW7GbfXLnoT54R6NNNWEoR0Ael/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882606; c=relaxed/simple;
	bh=v1HhRq7gXv9e6Ou37iAaZkAGoGCYjQzYexGBG0WM8sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjF8zZZSBRFw1b7BwYCGQaCMWghW5EXgl4oqizBa4ZrkKS5xo2tTlmY85FxWzs0EugWsQEcvL+W/2X9gB82AkT5pB8jivECpYohXmMUOaX+LhMrunKuT+gIL0FWrlAPLYGP1tBXIoozgKPKaRCNLUUR4Ivn855gyYXCjmPGDmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vi4bPpVG; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=hS+O7T9w; arc=none smtp.client-ip=54.240.7.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882603;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=v1HhRq7gXv9e6Ou37iAaZkAGoGCYjQzYexGBG0WM8sY=;
	b=Vi4bPpVGjThhSBWLruOFwYIMx9IV2cjoo7stT/ceW7NCgJ2jnosrLuu8BL733U+m
	+x7uuvOGSkUJy1w4CX4wI3DgVSk9kG5TtECl+xm8CZZRHDzioSNyp9Rii0KqPl01SqG
	+o+BK8cUYySasTB5kk2Bv2byjIBXVNDj8EDaEMTGfxGbArOVbc1O4x9Urg+Jnt2EPY4
	xR+iZdxjv7N0uw0IAAMQy18uZf11bbKOOf81QnZEqjgsAmQ55MgPtMwGgagvAboS7Wp
	Rr0C7iqmwa8NXea57VNhhjIAm4tP30PP3imSJ0GmspJHBzi4PJECqOScfJgRxw+wH6+
	6/Z5q7e5ww==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882603;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=v1HhRq7gXv9e6Ou37iAaZkAGoGCYjQzYexGBG0WM8sY=;
	b=hS+O7T9weNO+RnK5HRVHtT1TrMq580Ush7bTjdBbmisSwFmKraVlVZdQN4BmuUed
	rkGtpK3ydyK2PGbGO5/XJHjuY1QmIwdWQDiQ6LNr9e6B/u67lrYPOK7eycKokzu3Zka
	fYSH1BtnSDY57b2OazIPyjKqrE2sx6emhuJA1caA=
Message-ID: <01020191d69e9539-c581e25a-4379-46cb-8bdd-d186ec99f6e9-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:50:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] ASoC: mt8365: Remove unused prototype for
 mt8365_afe_clk_group_48k()
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-3-7ad0bac20161@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-3-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.31

Il 07/09/24 02:53, Mark Brown ha scritto:
> The function is not used outside of the file it is defined and the
> equivalent function for 44.1kHz is not prototyped so remove the prototype
> for this function.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



