Return-Path: <linux-kernel+bounces-324444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C932974C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF45C285000
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B414EC56;
	Wed, 11 Sep 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="adGKKc5N";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="U9Qi49xi"
Received: from a7-48.smtp-out.eu-west-1.amazonses.com (a7-48.smtp-out.eu-west-1.amazonses.com [54.240.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE3AD24;
	Wed, 11 Sep 2024 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043071; cv=none; b=BPzQUp38Aw4R+c4xiT8vxlK1Le4N8iXiA0Do4H5Mn3cHE59wPbR3zyx7VcJ5pKx91xV3DeD5Cg/p+IGOjj8yijYYj+Jt03+TpgU1Wu/mySCmzYTq3BlotO29yMUqIZ4OHKrAha50ijLgqk/JSGSaIHxFnXFMytKkJu8Oczr/ET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043071; c=relaxed/simple;
	bh=698wQpzFq84To+s/WCVIOmpSbbSmg4VSicihqf9qw34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTDJY3Jry3gJ1ZX1yDtXr5d5Frr5wXq+mPKQgnNpjqAUz70scZzprNKxmCfCg5g3nCmWYQHbHlAEF3lPrE6eGDxVTLbdWoM6h7jpbpmfX91IjIldBV9tFKKzjG6FgrTWDf/TmoC5qyK+Z2IThBNzgYwUin1/sVLP7+tmQCN/x/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=adGKKc5N; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=U9Qi49xi; arc=none smtp.client-ip=54.240.7.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726043067;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=698wQpzFq84To+s/WCVIOmpSbbSmg4VSicihqf9qw34=;
	b=adGKKc5NT2ZFSl95Fm2PZ6Z+//DbP/dttZO00kj4pks97lOTKrjysIAfeVjB0z/h
	nys7hYP1QKJeIcJXZIPtyA825I4f36sC3Rzmg6S+8cZnmd/gbiejjPRABEs7amxUoSC
	7cUrYC+dHyTFgIDHPnHmL7gt6BgThMdCapdaRKizjD92YeOpfeQump11KKcWh9DUZqi
	bSRDSvHJ+RHxIycBUyPpVtHbb+iX2PBGWG2+HbaDxI2O5NtEoe3rvFz9nUr0dQO5mNH
	shZcEDzJ0Smxa0DgKcLHNTjyRyokFp7lbltK25Bm/uoH01DRwFoG02p2jGP1gObbr50
	WIVAS5L32g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726043067;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=698wQpzFq84To+s/WCVIOmpSbbSmg4VSicihqf9qw34=;
	b=U9Qi49xifLwDGMtHMpHh2nQqpgp5SGgpN7gJmQ8YVGnWUcEoKm1ZpGPrQYfbgWYy
	eUQ37fgpjVj6Xg+k/agsrJXYVvIphsuPGMQiyPYJxOnEFYj004w0aGIaRp271uLAAD7
	/QLaO3RjCZ4qLnu6VrXrVHkY4lGTZJOUnGQHH4TM=
Message-ID: <01020191e02f1538-47c02c52-c508-4cf3-ba84-fc339b55047c-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 08:24:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: mediatek: Drop duplicate
 mediatek,mt6795-sys-clock.yaml
To: "Rob Herring (Arm)" <robh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240910234238.1028422-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240910234238.1028422-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.48

Il 11/09/24 01:42, Rob Herring (Arm) ha scritto:
> The compatible strings for mt6795 clocks are also documented in other
> schemas:
> 
> "mediatek,mt6795-apmixedsys" in clock/mediatek,apmixedsys.yaml
> "mediatek,mt6795-topckgen" in clock/mediatek,topckgen.yaml
> "mediatek,mt6795-pericfg" in clock/mediatek,pericfg.yaml
> "mediatek,mt6795-infracfg" in clock/mediatek,infracfg.yaml
> 
> The only difference is #reset-cells is not allowed in some of these,
> but that aligns with actual users in .dts files.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



