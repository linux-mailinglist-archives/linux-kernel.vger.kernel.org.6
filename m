Return-Path: <linux-kernel+bounces-321319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3809718A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948351C222C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E691B9B51;
	Mon,  9 Sep 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hF6rdhod";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PSqJvddW"
Received: from a7-46.smtp-out.eu-west-1.amazonses.com (a7-46.smtp-out.eu-west-1.amazonses.com [54.240.7.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27121B86EC;
	Mon,  9 Sep 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882607; cv=none; b=e5PovAcXcNE/TzaTxa3x4etpLVG+ha6CGLIyU9RhFdsgzxwb5VVZjWX2WtS3jPXc1sONtwpTwL+gwkO/Iql+YxclyIkBMtV7N8Ti+ESuXFiw+apcOuAncgg1Znb4g1UGwy3xVmwMLwnEA9xC0XxjINCpgNJi2EAGy/heMRA+7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882607; c=relaxed/simple;
	bh=iC5xb1PCE21Z7wSb3P7L24hbphA9tazfjRfLi+Ga2RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAnB5A9nqgvKP0dIWRcJz1n1A7jI65r1jGeTv+6gE28Sd1UJ/oIB68hTs4c3dDzClfpHCT/urub35u2YcBl0j5ICIBWi9FedvAZ7W3JhfPuWvl6/qc9xDz1+Ievz0Q7Gbn+8DBu6Kub2vhxvNzPSnGW2Af5o1K08W+AVwW5AHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hF6rdhod; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=PSqJvddW; arc=none smtp.client-ip=54.240.7.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882604;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iC5xb1PCE21Z7wSb3P7L24hbphA9tazfjRfLi+Ga2RI=;
	b=hF6rdhodKUpjwjqrGNlJq/+zbsISP2G6hO8HhBBVVBjPLlAIsYPqUG4YUCLijr1S
	ZixMbAg/CPn80DSC8oCVwIk75Evigo3zSSzLq5fWLW4pEMH4QowbLeHHvVMlYQdfQPL
	2yUpWaMnsMfQ2WV2W/CZ3cZiU9pS3xqTgcC9PZVKt9CHsRtafbEQhlMJtYkWwKzM61G
	VIR7aZZoHD5UuXd1c9MSBEIP0L+QM7EZAqvbUq8IpcoMAu9bCMN5sxz6+IjJe3ediNk
	Iw4OIEoWaJe56I8Fz4VGD59C0YPhh8y2PIWlCQbyvqaNj9ErO+xxSeAJF9ZPHSSZvN2
	hDxyE8FfWQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882604;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=iC5xb1PCE21Z7wSb3P7L24hbphA9tazfjRfLi+Ga2RI=;
	b=PSqJvddWZ7Ot+/bl75lVBuZu+RhtTNZJFa86SAqRcNDKkgsYYyIhXTi2GmqBempg
	8fBolcO5ez8Ogl45TD9c9Ebu1oq+iH9yQoYsvPEvqs9gXEyXd4ObP3D8TEpdmZYrQqm
	4nJIoghaFYZWv7q0Ms6dfgD1swNenKCrra+0Vv6s=
Message-ID: <01020191d69e9a85-63fc522f-fb6d-4379-9ee6-5165a820991f-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:50:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] ASoC: mt8365: Remove spurious unsigned long casts
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Alexandre Mergnat <amergnat@baylibre.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-2-7ad0bac20161@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-2-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.46

Il 07/09/24 02:53, Mark Brown ha scritto:
> The regmap APIs take unsigned ints not unsigned longs so casting their
> arguments to unsigned longs is not a good choice, the constants being
> cast here are all unsigned ints anyway.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



