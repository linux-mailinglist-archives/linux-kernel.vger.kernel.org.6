Return-Path: <linux-kernel+bounces-531669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3CA44362
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E8C179D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE00270EA5;
	Tue, 25 Feb 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RW2DRtOd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6BF272907;
	Tue, 25 Feb 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494523; cv=none; b=WItHWpLBI61KJMWb2Jbsb95rdE+/77Bd91e8ByKl04wb4A9NWL6v7/4cEE3GQROPHyR8ByVQ8f6MyFboj81svbZA/1OITeAfvwEYH37SElXam+6k2QOlX5HdfF26Nrrc3P1QpJKgULLUprVHsfYVwMaZsxz3LDB5iloEq0M2jRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494523; c=relaxed/simple;
	bh=gcaPxx33gCvP/niJ4vOPIJNgvIWqs9IFDJHcrkQd1pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNHvcSHD3uyp+eblg16n1PBamuBvrtD30Bu/Z5SLKEr9JMrSK/rF9Qznu2QdX1NoffvgSFk9e6m9PBs9FjJbEpT7+HBKuGm+P3aYlsh8SEQOpCxo8ry9sXvqvONR+OqEPr694Tr2vpXXENARm3q/7SgcKeQ7kod2pYwFn/NVvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RW2DRtOd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740494519;
	bh=gcaPxx33gCvP/niJ4vOPIJNgvIWqs9IFDJHcrkQd1pw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RW2DRtOdTVCrz6ss+KWXSej8BuwzJTpnr1kKFUJg531mER4IkAC+rN5natOMumAJI
	 wszSuut2qmdtZl5ACJI5EKhL2EzFPOS4bA3MOEXlSI3TJkjCO/RPQFGsvtBfGeBwYa
	 e2qGLe0JFvGavlL27lHsUNLS4Tpv/OZEu493hJ0YezJ5Vyn6dA5e6HvGJHCI3EXKk9
	 HEQVa6dYGRFSqpdZaAVc4FSa6Ukf45YuWxUF7RSLbGUYY+e+/DgU+We3CQwKvv0woO
	 LV2LiL0fZxb5C0SxlbgIKakauIOpAlwHxqBWys+5S3kVA4JQpwzwONLNWOFsjTnJUS
	 ezH5rF09l+npw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D81BA17E0DD7;
	Tue, 25 Feb 2025 15:41:58 +0100 (CET)
Message-ID: <21647057-8b08-4111-956c-4719d8002b0c@collabora.com>
Date: Tue, 25 Feb 2025 15:41:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ASoC: mediatek: mt8188: Add reference for dmic
 clocks
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20250225-genio700-dmic-v2-0-3076f5b50ef7@collabora.com>
 <20250225-genio700-dmic-v2-2-3076f5b50ef7@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250225-genio700-dmic-v2-2-3076f5b50ef7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/02/25 15:33, Nícolas F. R. A. Prado ha scritto:
> Add the names for the dmic clocks, aud_afe_dmic* and aud_dmic_hires*, so
> they can be acquired and enabled by the platform driver.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


