Return-Path: <linux-kernel+bounces-324778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A292F9750B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E4B1C22926
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57495186E52;
	Wed, 11 Sep 2024 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ODdPJDx/";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="k16cWy3X"
Received: from a7-33.smtp-out.eu-west-1.amazonses.com (a7-33.smtp-out.eu-west-1.amazonses.com [54.240.7.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02F17C21B;
	Wed, 11 Sep 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053946; cv=none; b=NuL4YSeLrZOa4HDX2v4AVCDHysDxv1tIZ2mkYxKeY4Uuupf5kojdj8j0gFH6e8wYAixC6mQnee31nS2aPY/9+zCH4UZYds40haRJNOI8qCmQka0OorCDDqj8cfQOIBIuhEJxczLu7Mz/XFSuog4kV04bimKdpwHhiIEL875Dgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053946; c=relaxed/simple;
	bh=ClJQQmMllX6exPeX1+6DYsZvUq0xm7fA8sKPr1Vr3Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHE+AH3EBCwBZ7uL0Lf7iIxa8KJISTL3SS5ozTO866BWbCZ/h7zmQ/pbgqMEoF7Sxa/19YOx4OruhqWQtRDhHEcJewtp00oASC5KS3KgdBcsVgG8qwcHj8KCqLDXFnAH69079JZAFlXkwNnNqNckqfX9/Y5Hzs9R3YodD8T4X+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ODdPJDx/; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=k16cWy3X; arc=none smtp.client-ip=54.240.7.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726053943;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ClJQQmMllX6exPeX1+6DYsZvUq0xm7fA8sKPr1Vr3Nc=;
	b=ODdPJDx/jLT17tOcmTCDctsItStRbKWp8X3MSQU7oVrdu7YFJ7prdqiVu7WAId1b
	xVtH+o4qIjOb/c67yc2G/aSvF+7nZIQcIE+Koc8n7boutJUqpzyDhNLNsJprKleQuVs
	DVQ9Pxy6/FUv4CpZ+spFIi/H22qlhrsKfCa7XTjRWFYq7dQRugRPYpQFPX0oBA8owYN
	Aaj2Oj5gXArb4fYtjykCFcksA9sZpEb95lCXI/4kMxk3ocRjuzuVq6bX+Fzq5gOzLY0
	fZJxj0j0ITXZ9xKCzMts7d9qMXepO2xhNJkKw5zFk28VxsiCkuVZBRIPFd2+HjUwjQT
	ul/1oabzOg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726053943;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=ClJQQmMllX6exPeX1+6DYsZvUq0xm7fA8sKPr1Vr3Nc=;
	b=k16cWy3X0L74jRDviwtgOVzvQsoPOP/SaGOHvWUu5MalRuJIoWjykKtaRJWPas0z
	4P9KBjl4JPNaNIVbs4tI9zpqB8WUgc2IraFXjIvyramjpddD1zLIFwscREfE3g5gQxE
	LVZat2W0hO5XuksMn6raClR2wZtZtIol3A7V77WI=
Message-ID: <01020191e0d508d9-18f9aef4-fecc-4486-a8c8-f41bd4784e13-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 11:25:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: dts: mediatek: mt8188: Add socinfo nodes
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
References: <20240911105131.4094027-1-fshao@chromium.org>
 <20240911105131.4094027-9-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911105131.4094027-9-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.33

Il 11/09/24 12:51, Fei Shao ha scritto:
> Add two socinfo efuse data nodes for the SoC information probing on
> MT8188.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


