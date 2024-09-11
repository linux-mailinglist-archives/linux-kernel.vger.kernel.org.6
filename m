Return-Path: <linux-kernel+bounces-324777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE29750B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3F71F231C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C5187338;
	Wed, 11 Sep 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NC4kYUPC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="F+LbNxgl"
Received: from a7-45.smtp-out.eu-west-1.amazonses.com (a7-45.smtp-out.eu-west-1.amazonses.com [54.240.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB19186E52;
	Wed, 11 Sep 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053902; cv=none; b=o2aO7KPJubURtZoDhTHhC6eNYJ480j0bPwK63SpmaO6aKkGw8YUEJSfzkNHJKqkAIe705q7TwNaU5u5FvnGLASNj2fiHTc9Uv+0oGBE24BHqU3xTWnW/bn+mW9cOyezdfKzUhOPnil1IqV/+AnL2i3GAcfsRwNECHOFNwN5PKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053902; c=relaxed/simple;
	bh=0OC+2f4WWQUaEAQekYa+3Ctje3AZxE3EHaRKKI/Ddfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbhPPMCGJsVCKYYxXct2LZVF61U8jRqvSaeSbvS/V4om0at8XGX7dmjPBsJDrEAx3HuOGDSwzasNcgf/57G6hF+YnS+chllbwQX4NSfFXfgTzKLXxxCrvBdjB562od93GwRom1/xZkfqnEecDwjqlSepkjkidowJYkFsQVzvfIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NC4kYUPC; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=F+LbNxgl; arc=none smtp.client-ip=54.240.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726053898;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0OC+2f4WWQUaEAQekYa+3Ctje3AZxE3EHaRKKI/Ddfg=;
	b=NC4kYUPCo/weRsJso17p/pDwyMJ6kGym9YUyk1miZC4vUaGcRpQTflLBSUG48O10
	27lodhusyHxd4MWVOKr/0nB0iEVS7k/zh6VzNv8D9sdasrCuae1I3gVEeyi3FtJQtE3
	gq7hlF2OcxUs2i6R2vYszPqPlbrMw/bxzFw0mZlRamrNR13iTellRCbWuwnT0rh8nDT
	cIyG4o7b8Di0q6xIecjGTpTq36Pu+YBBKjnuXWE2ckW4Sn66u7tHhArqtaZ/kKgcSI4
	TAjbG8/LN2LA9w2NCk6JWcroMQytcANmvxg1v4y/cA4Qaz5dN0yfH9e3ddSRVWbSMN4
	jWkq+FpxOA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726053898;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=0OC+2f4WWQUaEAQekYa+3Ctje3AZxE3EHaRKKI/Ddfg=;
	b=F+LbNxgli/3i8+Mjnnavv3bhnZDNlPAYplFiCntaHPYtOHrYuMeBoRLP5In7gH97
	JKqqRNpsmqIV0fNU0+y2hPmUq/CpFkT59mc1JTYyomsvi3XUkdaayGJcCisCgRCgB2x
	efRqmRE8iG18hI30aTkCBHNCO1by1ylyu/qYKTw0=
Message-ID: <01020191e0d4570b-2178f43c-6912-4722-a0c4-41560dd73643-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:24:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: mailbox: mtk,adsp-mbox: Add
 compatible for MT8188
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240911105131.4094027-1-fshao@chromium.org>
 <20240911105131.4094027-3-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911105131.4094027-3-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.45

Il 11/09/24 12:51, Fei Shao ha scritto:
> Add compatible string for ADSP mailbox on MT8188 SoC, which is
> compatible with the one used on MT8186.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



