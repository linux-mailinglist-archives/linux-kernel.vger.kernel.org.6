Return-Path: <linux-kernel+bounces-326135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E5976385
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82ACE1C22FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CCB18E052;
	Thu, 12 Sep 2024 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PMu5AuMg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JfCd1nda"
Received: from a7-30.smtp-out.eu-west-1.amazonses.com (a7-30.smtp-out.eu-west-1.amazonses.com [54.240.7.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484136124;
	Thu, 12 Sep 2024 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127643; cv=none; b=ZYIk9Q0BXaSxLu8h3bo0mtPNGukrVC4SElvIj+H7beLrOMotKwkgjy49lMQSht9b15DYGGaVFZDajbKsZsEqhOHTcGzHm0WFfrVo8A4UAWkl4n/y/HKBtf5E3jTTbxygHC+ZiXxmvXJI+PBzN3AES6VJZA6bDrDad/oLdWLujRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127643; c=relaxed/simple;
	bh=pogyvsxw4IYYoxXgtC4BvI/p9pjJQOo8Pjtgwx2Z4U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZH+b0s6j1vt75rT1hGovyb0nukJdw0sveeZXD3O16ArQLqDzzn0F3xSYJTglXt3oqQkz5fLU+Ah+EOQANOT1jpyS5HRq4ZaG8W3IjzpEVRauzfbAAeDK0teZz/eIJbHHUiMnLVd5kLdEHKsBo/kim+/wJiUAJ2lej/Yr508dvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PMu5AuMg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=JfCd1nda; arc=none smtp.client-ip=54.240.7.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726127640;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pogyvsxw4IYYoxXgtC4BvI/p9pjJQOo8Pjtgwx2Z4U8=;
	b=PMu5AuMghOGx5tX6Bc6Nuri7xEnLG2vCW8ooVCbXi+DMvYmhKE908t+7jit+cgIR
	Zlkf+yBI9ZYHcdu2EKHC/QW3a/3cfCyynZ+ilf6w8EiYZ9IUMLHyMtbt8KZCuKGnImE
	ep5WsCPbD85es53zoXsQNJ9KWzp9YZUQ+6A8dIjf319RZ9D+juvLRN/Mlw6ugiOJ6Lv
	Khm7huPPYGZpsr04uO/5dVs9DUPaN7m+Jnb7COF7srtRBEr/CJOTDNkjB3RLEiRXqBW
	e70JShRRLoI/eFzjnjvdDpRc2H2rMuJmQToeHepCQIgQtl+ucDBaNB2qNVksU/YKOjC
	1rRtyuEb8g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726127640;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=pogyvsxw4IYYoxXgtC4BvI/p9pjJQOo8Pjtgwx2Z4U8=;
	b=JfCd1ndadNBFwZXAaf71Mu7FWesOQd3NqJjZaub8NK/yMLm0GPv0KfoBoRWIJt2b
	f8sXHEbqfGDqWFJM+bElLpdLOzXnj65HRlMMV11qA4wnejkHHepXejfCOGIufNUdb5A
	pAIVmuaOkZwEHDPG8Vhjju1m1QHDASocMy1nyD4E=
Message-ID: <01020191e5398d69-e1c1cbbf-1617-4df9-bbff-2e728d8e04b2-000000@eu-west-1.amazonses.com>
Date: Thu, 12 Sep 2024 07:53:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoc: mediatek: mt8365: Remove unneeded assignment
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Nicolas Belin <nbelin@baylibre.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240911123629.125686-1-usama.anjum@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911123629.125686-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.12-54.240.7.30

Il 11/09/24 14:36, Muhammad Usama Anjum ha scritto:
> The ret is being assigned, but not being used. Remove the assignment.
> One of the reviewer mentioned that dev_warn should be replaced with
> dev_info. Make this change as well.
> 
> Fixes: 1bf6dbd75f76 ("ASoc: mediatek: mt8365: Add a specific soundcard for EVK")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



