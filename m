Return-Path: <linux-kernel+bounces-324775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCC19750B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431AD1F236A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC51885BE;
	Wed, 11 Sep 2024 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LRLf2EKP";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="REU56YHk"
Received: from a7-48.smtp-out.eu-west-1.amazonses.com (a7-48.smtp-out.eu-west-1.amazonses.com [54.240.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5B187547;
	Wed, 11 Sep 2024 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053861; cv=none; b=UbQ55GfSoYnUxNkKaxoqjeqJ7NcKJyIssrKZIqQfbaRZ9FUf5XUcvTP6WesVTjeM4eBxNmzI/r8nS7yEGppaD5un7xMsXu9HDbXAprWIB+oFjpC1dEdLE73pcv6JGscVUO4F1amkvGS3flhX9y4YFtZne4d6KMLQwGHRKHG5lkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053861; c=relaxed/simple;
	bh=RMpu566YYspzP9NcOkcHAFQ/BsitzMN8+Vu1+ORfENY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkEjra96jV8wGCER6laBBoorRmzzHkB9sXtQ+sHDzaUdmI0tWRRmDBt7Hvhz1KcdMCjbF0Mdz1a6VX/OLbUs6PGOd37uK1vz5qn54vXj7Au/aDtM/0ywX8nu+Vj2HEGBpWkVlyJEqr3cSp9TSYXjsSty/z/M/zBooty5EekjPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LRLf2EKP; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=REU56YHk; arc=none smtp.client-ip=54.240.7.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726053857;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RMpu566YYspzP9NcOkcHAFQ/BsitzMN8+Vu1+ORfENY=;
	b=LRLf2EKPY8/zZATtOTbG4Yryele6y6nUp8cTng1kY16vrISF0Yhrr6NTVtK+Vgdm
	R9RNRxPr4OzzjvVa2koxj5Jjsk59ALqR2yaGFmHyy5qpT0TiVHDwWTvR9D1d+ieWZjZ
	hTFyiRx+ScdhinW0uaTL2K3tM0bxHpktQ7qcbImz98wH8rCL7aWecdzFICwvMIP6Upy
	5dznvwVkWDUzMlvBcDZbVkxssWZCzLGhhOb6vac6AHV5ttKMackeOjsaXHdleq50WxB
	8j8liImGQmqaO9hq1+RjYpVr0WMnfJPn1QjJnKIavNqUj/cws48SreJbJ790lh7GDha
	IMWPCUHiRQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726053857;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=RMpu566YYspzP9NcOkcHAFQ/BsitzMN8+Vu1+ORfENY=;
	b=REU56YHkf3SsQya5foYO2CxYuo7HgLZ9gvwqbqwP2Cja2SLQ3cR/c6A6DoG1ubG0
	ZnSNMqNXm5ue/JIcV9wp9pPBFC1GdV1eXPuQDvhp5QAmBNWAhX3126vW3LpBgzCrGKl
	f1et3Rj2cP6svl3MFVZL8/XPCXhgrcxtty7dGwrY=
Message-ID: <01020191e0d3b9ef-b15d5d4b-c167-48ff-b34d-ed3cc10b3555-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:24:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] arm64: dts: mediatek: mt8188: Add CPU performance
 controller for CPUFreq
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240911105131.4094027-1-fshao@chromium.org>
 <20240911105131.4094027-4-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911105131.4094027-4-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.48

Il 11/09/24 12:51, Fei Shao ha scritto:
> Add performance controller node and performance-domains properties for
> CPUFreq support on MT8188 SoC.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



