Return-Path: <linux-kernel+bounces-321297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57276971873
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEECF1F23148
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4A1B5ECA;
	Mon,  9 Sep 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sota0Eil";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Lc5n2Byv"
Received: from a7-32.smtp-out.eu-west-1.amazonses.com (a7-32.smtp-out.eu-west-1.amazonses.com [54.240.7.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D661B2ED5;
	Mon,  9 Sep 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882120; cv=none; b=mH8NWqkJDmO2kOtpCIQC2bqR9d3HQhi6RWHuIaUP78dkraSgjk1tqUeGn1KPqe6ALqmY49TLfOWfqSmNenKNQ12ubx8B1BdmXH9tdnF6/velNzPqBJYJouxfVNKyQLGQWIAX9bMGCsHauC6V2OkSRXKprop4kmxiL5bswurLnSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882120; c=relaxed/simple;
	bh=Ml/mIm3gRIw15q1Itl7+m1Kixv7uWMwrk1Hqf7EoDrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcHN4a8XfMQc4EOwhRdqi8bh+POFthx/PIM/kRo2igGTxwqLzBdmTrr8eU9OxWCjk9XDy7em1goWq89fbtCyzjcxrcx4NzkOt0DnXYfVWQLXAmD/trPMIXvj70jqZ22eJejkQuC7UMzyZHDkdvbtHgEs0FjKHFobPTjTIepC3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sota0Eil; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Lc5n2Byv; arc=none smtp.client-ip=54.240.7.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725882117;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ml/mIm3gRIw15q1Itl7+m1Kixv7uWMwrk1Hqf7EoDrY=;
	b=Sota0Eil7m42EC7RtPEQwmpjOCaZ6CKqZYH+nBc97vO0VmV+bfWFjJO5E9KiIICs
	5NCxSQZ5oFQIfdsVM0UimOiaKh9xdVnGS4CF2YX0kymfipW38FjF5LCVybahhn9iZYl
	CC/gs8qq2bJXvIFGaaSWXmIup+kOaGh2otuKK7UH1Sa8LBZ6KiS+blVQIsHL31KmflO
	eu1QqM1oTOdjrBJzA41VD/RN6uOyWXUetA/3ZOUa03QBAtXXHshXuZiJLizskVNtAVe
	IMdRqKbBhIjNCdHMT5XtRyAwv57cpd8DrsQgWjOarqf8uIWFM8eBcirDtJWegBZ81nL
	ba8N0rhBxQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725882117;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=Ml/mIm3gRIw15q1Itl7+m1Kixv7uWMwrk1Hqf7EoDrY=;
	b=Lc5n2ByvwtE5MiE5EKUoQ9N30WZvSXPIe30t+n61DTwPnjzntm2bW38BXgW6mE9s
	/Qjb07PlLf2AuPNVydu4J2fpsw1FTiWNu/SjHVskaDfmm2hEyT/MoqpaC0SMDH2TGs4
	YetkHxM+2iJsUpstSPIwMQYFY4BMk5uQmKAmnGoA=
Message-ID: <01020191d6972b34-b6f0e6f8-bc74-4360-ba9e-d934b2baac16-000000@eu-west-1.amazonses.com>
Date: Mon, 9 Sep 2024 11:41:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: kukui: Fix the address of eeprom
 at i2c4
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ben Ho <Ben.Ho@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Nicolas Boichat <drinkcat@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
 <20240909-eeprom-v1-2-1ed2bc5064f4@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240909-eeprom-v1-2-1ed2bc5064f4@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.09-54.240.7.32

Il 09/09/24 10:33, Hsin-Te Yuan ha scritto:
> The address of eeprom should be 50.
> 
> Fixes: ff33d889567e ("arm64: dts: mt8183: Add kukui kodama board")
> Fixes: d1eaf77f2c66 ("arm64: dts: mt8183: Add kukui kakadu board")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



